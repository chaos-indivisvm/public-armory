integer ml=0;
integer cml;
integer sit=0;
key hroot=NULL_KEY;
key rlkey;
AnimNML()
{
    llSetAnimationOverride("Standing","NV_Rifle01_Male_Idle_01");
    llSetAnimationOverride("Running","NV_Rifle01_Male_Run_01");
    llSetAnimationOverride("Walking","NV_Rifle01_Male_Walk_01");
    llSetAnimationOverride("Turning Left","NV_Rifle01_Male_Walk_01");
    llSetAnimationOverride("Turning Right","NV_Rifle01_Male_Walk_01");
    llSetAnimationOverride("Crouching","NV_Rifle01_Male_Crouch_01");
    if(!sit)
    {
        llSetAnimationOverride("Sitting","NV_Rifle01_Male_Crouch_01");
        llSetAnimationOverride("Sitting on Ground","NV_Rifle01_Male_Crouch_01");
    }
    else
    {
        llSetAnimationOverride("Sitting","NV_Rifle01_Male_Idle_01");
        llSetAnimationOverride("Sitting on Ground","NV_Rifle01_Male_Idle_01");
    }
    llSetAnimationOverride("CrouchWalking","NV_Rifle01_Male_AimCrouchWalk_01");
    llSetAnimationOverride("Jumping","NV_Rifle01_Male_Jump_01");
}
AnimCML()
{
    llSetAnimationOverride("Standing","NV_Rifle01_Male_Aim_01");
    llSetAnimationOverride("Running","NV_Rifle01_Male_AimRun_02");
    llSetAnimationOverride("Walking","NV_Rifle01_Male_AimWalk_01");
    llSetAnimationOverride("Turning Left","NV_Rifle01_Male_AimWalk_01");
    llSetAnimationOverride("Turning Right","NV_Rifle01_Male_AimWalk_01");
    llSetAnimationOverride("Crouching","NV_Rifle01_Male_AimCrouch_01");
    if(!sit)
    {
        llSetAnimationOverride("Sitting","NV_Rifle01_Male_AimCrouch_01");
        llSetAnimationOverride("Sitting on Ground","NV_Rifle01_Male_AimCrouch_01");
    }
    else
    {
        llSetAnimationOverride("Sitting","NV_Rifle01_Male_Aim_01");
        llSetAnimationOverride("Sitting on Ground","NV_Rifle01_Male_Aim_01");
    }
    llSetAnimationOverride("CrouchWalking","NV_Rifle01_Male_AimCrouchWalk_01");
    llSetAnimationOverride("Jumping","NV_Rifle01_Male_Jump_01");
}
default
{
    state_entry()
    {
        rlkey=llGetInventoryKey("NV_Rifle01_Male_Reload_01");
        llSleep(.25);
        llRequestPermissions(llGetOwner(),0x10|0x8000);
    }
    attach(key id)
    {
        if(id!=NULL_KEY)llResetScript();
        else llResetAnimationOverride("ALL");
    }
    run_time_permissions(integer p)
    {
        if(p!=0)
        {
            llResetAnimationOverride("ALL");
            llSetTimerEvent(.3);
            AnimNML();
        }
    }
    timer()
    {
        integer check=llListFindList(llGetAnimationList(llGetOwner()),[rlkey]);
        if(check==-1)
        {
            if(llGetAgentInfo(llGetOwner())&AGENT_ON_OBJECT)
            {
                if(sit!=1)
                {
                    key root=llList2Key(llGetObjectDetails(llGetOwner(),[OBJECT_ROOT]),0);
                    if(root!=llGetOwner())
                    {
                        string fuck=llList2String(llGetObjectDetails(root,[OBJECT_NAME]),0);
                        if(llToLower(llGetSubString(fuck,-3,-1))=="sit"||root==hroot)
                        {
                            sit=1;
                            ml=-1;
                        }
                    }
                }
            }
            else 
            {
                sit=0;
                if(hroot!=NULL_KEY)hroot=NULL_KEY;
            }
            cml=(llGetAgentInfo(llGetOwner())&0x0008);
            if(cml!=ml)
            {
                if(cml)
                {
                    AnimCML();
                }
                else
                {
                    AnimNML();
                }
            }
            ml=cml;
        }
    }
    link_message(integer sn, integer n, string m, key i)
    {
        if(n==3)
        {
            hroot=m;
            key rroot=llList2Key(llGetObjectDetails(hroot,[OBJECT_ROOT]),0);
            hroot=rroot;
        }
    }
}
