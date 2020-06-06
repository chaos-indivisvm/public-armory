// These Scripts are Provided Under a BSD 2-Clause "Simplified" License.
// These Scripts are Provided as is With our HTTP Methods still included in.
// There are there for example Purposes and you will need to remove those chunks.

integer a=30;
integer rl=0;
integer fm=0;
integer mode=0;
integer bayo=0;
string anim;
integer hex;
integer hex4;
integer blood=0;
integer kills;
integer hits;
float lastshot;
float laststab;
integer shots;
integer smoking=0;
key parent;//What slung me? Is it still part of my linkset?
rel()
{
    llSetTimerEvent(0);
    rl=1;
    stop();
    llStartAnimation("NV_Rifle01_Male_Reload_01");
    llSetTimerEvent(3*llGetRegionTimeDilation());
    llPlaySound("7b4113a3-3e7d-fefe-34a3-2e71746672dc",1);
    llSetLinkPrimitiveParamsFast(mag,[PRIM_COLOR,ALL_SIDES,<1,1,1>,0,PRIM_DESC,"0/30"]);
}
stop()
{
    llSetLinkPrimitiveParamsFast(1,[PRIM_COLOR,1,<1,1,1>,0]);
}
start()
{
llSetLinkPrimitiveParamsFast(LINK_SET,[PRIM_COLOR,ALL_SIDES,<1,1,1>,0,PRIM_LINK_TARGET,body,PRIM_COLOR,ALL_SIDES,<1,1,1>,1,PRIM_LINK_TARGET,mag,PRIM_COLOR,ALL_SIDES,<1,1,1>,1]);
        llSetScriptState("Anim v2.4 Rifle",1);
        llResetOtherScript("*Anim v2.4 Rifle");
        llSetScriptState("*Fury",1);
        llSetLinkPrimitiveParamsFast(LINK_THIS,[PRIM_DESC,".002",PRIM_LINK_TARGET,mag,PRIM_DESC,(string)a+"/30"]);
        llOwnerSay("/me :TYPE /1 HELPL1 TO DISPLAY HELP");
        llTriggerSound("5239493c-e4bb-ad63-9050-86899a09c88c",1);
        if(bayo)
        {
            llSetLinkPrimitiveParamsFast(bayonet,[PRIM_COLOR,ALL_SIDES,<1,1,1>,1]);
            if(blood)
            {
            llLinkParticleSystem(bloo,[   
                PSYS_PART_MAX_AGE,1.2,
                PSYS_PART_FLAGS,
                PSYS_PART_INTERP_COLOR_MASK|
                            PSYS_PART_INTERP_SCALE_MASK|    
                            PSYS_PART_FOLLOW_VELOCITY_MASK,
                            PSYS_PART_START_ALPHA,.8,
                            PSYS_PART_END_ALPHA,0,
                            PSYS_PART_START_COLOR,<1,1,1>,
                            PSYS_PART_END_COLOR,<1,1,1>,
                            PSYS_PART_START_SCALE,<.01,.1,.01>,
                            PSYS_PART_END_SCALE,<.05,.15,.05>, 
                            PSYS_SRC_PATTERN,PSYS_SRC_PATTERN_DROP,
                            PSYS_SRC_BURST_RATE,1.8,
                            PSYS_SRC_ACCEL,<0,0,-2>,
                            PSYS_SRC_BURST_PART_COUNT,1,
                            PSYS_SRC_BURST_SPEED_MIN,-0.1,
                            PSYS_SRC_BURST_SPEED_MAX,0.1,
                            PSYS_SRC_ANGLE_BEGIN,0,
                            PSYS_SRC_ANGLE_END,TWO_PI,
                            PSYS_SRC_OMEGA,<0,0,0>,
                            PSYS_SRC_MAX_AGE,0.0,
                            PSYS_SRC_TEXTURE,"d30a3222-2654-f5d9-518b-cdb3369cb113"
                            ]);
            }
        }
        llRequestPermissions(llGetOwner(),0x4|0x10|0x400|0x8000);
        llSay(hex,"1:623d8d25-7426-a676-4735-5b834ce9671d:"+(string)llGetLinkKey(mag));
        llSay(hex4,"l1");
        stop();
        llListen(1,"",llGetOwner(),"");
        llListen(hex4,"","","");
        if(rl)rel();
        else llSetTimerEvent(.1);
        drawn=1;
}
sling()
{
    llLinkParticleSystem(-1,[]);
    llSetScriptState("*Anim v2.4 Rifle",0);
    if(drawn)llResetAnimationOverride("ALL");
    llSetScriptState("*Fury",0);
    llSetLinkAlpha(-1,0,-1);
    stop();
    llSetTimerEvent(0);
    llStopSound();
    llPlaySound("bcf6df91-c30b-b688-0c0b-79a929ffd240",1.0);
    drawn=0;
    llStopAnimation("NV_Rifle01_Male_Reload_01");
    llSetLinkPrimitiveParamsFast(LINK_THIS,[PRIM_DESC,"-1",PRIM_LINK_TARGET,mag,PRIM_DESC,"-1"]);
    llRequestPermissions(llGetOwner(),0x4|0x10|0x400|0x8000);
}
fire()
{
    if(rl)return;
    float x;
    if(mode==0)x=.75;
    else x=.5;
    llSetLinkPrimitiveParamsFast(1,[PRIM_COLOR,1,<x,fm*.1,1>,1]);
llLinkParticleSystem(flash, [
PSYS_PART_FLAGS, 259|PSYS_PART_FOLLOW_SRC_MASK,
PSYS_SRC_PATTERN,2,
PSYS_PART_START_ALPHA,.6,
PSYS_PART_END_ALPHA,0,
PSYS_PART_START_COLOR,<.58,.9,.57>,
PSYS_PART_END_COLOR,<.48,.8,.47>,
PSYS_PART_START_SCALE, <.15,.15,0>,
PSYS_PART_END_SCALE, <.08,.08,0>,
PSYS_PART_START_GLOW,.4,
PSYS_PART_END_GLOW,0,
PSYS_PART_MAX_AGE, .3,
PSYS_SRC_MAX_AGE,.1,
PSYS_SRC_ACCEL, <0.000000, 0.000000, 0.000000>,
PSYS_SRC_ANGLE_BEGIN, 0.000000,
PSYS_SRC_ANGLE_END, 0.000000,
PSYS_SRC_BURST_PART_COUNT, 3,
PSYS_SRC_BURST_RATE,1,
PSYS_SRC_BURST_RADIUS,.02,
PSYS_SRC_BURST_SPEED_MIN, 0.05,
PSYS_SRC_BURST_SPEED_MAX, 0.1,
PSYS_SRC_OMEGA, <0.000000, 0.000000, 0.000000>,
PSYS_SRC_TEXTURE, "668c8e1b-fe6c-6d34-3a9c-eaafe821709f"]);
    llTriggerSound(llList2String(fsound,(integer)llFrand(3)),1);
    --a;
    llSetLinkPrimitiveParamsFast(mag,[PRIM_DESC,(string)a+"/30"]);
    lastshot=llGetTime();
    shots++;
    if(smoking<1)
    {
        if(shots==6)
        {
            smoking=1;
                        llLinkParticleSystem(smoke, [
                        PSYS_PART_FLAGS, 11|PSYS_PART_WIND_MASK,
                        PSYS_SRC_PATTERN, 8,
                        PSYS_PART_START_ALPHA, 0.05,
                        PSYS_PART_END_ALPHA, 0,
                        PSYS_PART_START_COLOR, <.8,.8,.8>,
                        PSYS_PART_END_COLOR, <1,1,1>,
                        PSYS_PART_START_SCALE, <.05,.05,0>,
                        PSYS_PART_END_SCALE, <.2,.2,0>,
                        PSYS_PART_MAX_AGE, 1,
                        PSYS_SRC_ACCEL, <0,0,-.05>,
                        PSYS_SRC_ANGLE_BEGIN, .1,
                        PSYS_SRC_ANGLE_END, .3,
                        PSYS_SRC_BURST_PART_COUNT, 3,
                        PSYS_SRC_BURST_RATE,.05,
                        PSYS_SRC_BURST_RADIUS,.01,
                        PSYS_SRC_BURST_SPEED_MIN,.1,
                        PSYS_SRC_BURST_SPEED_MAX,.2,
                        PSYS_SRC_OMEGA, <0.000000, 0.000000, 0.000000>,
                        PSYS_SRC_TEXTURE, "a07503f8-bc0b-f5e9-e41f-608a6c77b24c"]);
        }
    }
    if(smoking<2&&smoking==1)
    {
        if(shots==14)
        {
            smoking=2;
                        llLinkParticleSystem(smoke, [
                        PSYS_PART_FLAGS, 11|PSYS_PART_WIND_MASK,
                        PSYS_SRC_PATTERN, 8,
                        PSYS_PART_START_ALPHA, 0.08,
                        PSYS_PART_END_ALPHA, 0,
                        PSYS_PART_START_GLOW,.03,
                        PSYS_PART_END_GLOW,0,
                        PSYS_PART_START_COLOR, <.9,.8,.8>,
                        PSYS_PART_END_COLOR, <1,1,1>,
                        PSYS_PART_START_SCALE, <.05,.05,0>,
                        PSYS_PART_END_SCALE, <.2,.2,0>,
                        PSYS_PART_MAX_AGE, 1,
                        PSYS_SRC_ACCEL, <0,0,-.075>,
                        PSYS_SRC_ANGLE_BEGIN, .1,
                        PSYS_SRC_ANGLE_END, .3,
                        PSYS_SRC_BURST_PART_COUNT, 3,
                        PSYS_SRC_BURST_RATE,.05,
                        PSYS_SRC_BURST_RADIUS,.01,
                        PSYS_SRC_BURST_SPEED_MIN,.2,
                        PSYS_SRC_BURST_SPEED_MAX,.3,
                        PSYS_SRC_OMEGA, <0.000000, 0.000000, 0.000000>,
                        PSYS_SRC_TEXTURE, "a07503f8-bc0b-f5e9-e41f-608a6c77b24c"]);
        }
    }
    if(smoking<3&&smoking==2)
    {
        if(shots=20)
        {
            smoking=3;
                        llLinkParticleSystem(smoke, [
                        PSYS_PART_FLAGS, 11|PSYS_PART_WIND_MASK,
                        PSYS_SRC_PATTERN, 8,
                        PSYS_PART_START_ALPHA, 0.1,
                        PSYS_PART_END_ALPHA, 0,
                        PSYS_PART_START_GLOW,.05,
                        PSYS_PART_END_GLOW,0,
                        PSYS_PART_START_COLOR, <.9,.8,.8>,
                        PSYS_PART_END_COLOR, <1,1,1>,
                        PSYS_PART_START_SCALE, <.05,.05,0>,
                        PSYS_PART_END_SCALE, <.2,.2,0>,
                        PSYS_PART_MAX_AGE, 1,
                        PSYS_SRC_ACCEL, <0,0,-.1>,
                        PSYS_SRC_ANGLE_BEGIN, .1,
                        PSYS_SRC_ANGLE_END, .3,
                        PSYS_SRC_BURST_PART_COUNT, 4,
                        PSYS_SRC_BURST_RATE,.05,
                        PSYS_SRC_BURST_RADIUS,.01,
                        PSYS_SRC_BURST_SPEED_MIN,.4,
                        PSYS_SRC_BURST_SPEED_MAX,.5,
                        PSYS_SRC_OMEGA, <0.000000, 0.000000, 0.000000>,
                        PSYS_SRC_TEXTURE, "a07503f8-bc0b-f5e9-e41f-608a6c77b24c"]);
        }
    }
}
list fsound=["6054aedf-dac3-6852-1f52-0877d2a5da2e","c0b16bee-88aa-8b16-3684-395ef67fbe32","18b509c3-14c1-e0c2-3685-ddf6692cebfc"];
list groups=[""];
integer check(key id)
{
    if(llSameGroup(id))return 1;
    else
    {
        string group=llList2Key(llGetObjectDetails(llList2Key(llGetAttachedList(id),1),[OBJECT_GROUP]),0);
        integer auth=llListFindList(groups,[(string)group]);
        if(auth!=-1)return 1;
        else return 0;
    }
}
string help="/me :DISPLAYING HELP MESSAGE:
:COMMANDS ARE NOT CASE SPECIFIC,
:/1 R/Reload/Rel - RELOADS THE LASGUN
:/1 fm - TOGGLES BETWEEN SEMI-AUTO, BURSTFIRE, AND FULL AUTO
: Semi - Fires a single lasbolt 
: Burst Fire - Fires 3 Lasbolts at a rate of 300 RPM
: Automatic Fire - Fires Lasbolts at a rate of 240 RPM
:/1 helpl1 - Displays this message.
:/1 givehud - gives you the heretech spread and ammo huds
:/1 hud - temp-attaches the spread and ammo huds
:/1 gestures - gives you a folder of supported weapon gestures
:/1 s/sling - d/draw - Slings & Holsters your Lasgun
:/1 bayo - Attaches your Bayonet - Stab with C.
:/1 clean - Cleans your Bayonet!
:/1 reset - Resets your gun script.
: REIGN DEATH UPON YOUR ENEMIES.
: LONG LIVE THE IMPERIUM
";
integer auth=0;
integer drawn=1;
key rq;
string eqkey="implasgun";
float version=2.73;
integer body;
integer mag;
integer bayonet;
integer flash;
integer smoke;
integer bloo;
key owner;
default
{
    state_entry()
    {
        owner=llGetOwner();
        kills=0;
        llLinkParticleSystem(-1,[]);
        integer n=llGetNumberOfPrims();
        while(n)
        {
            if(llToLower(llGetLinkName(n))=="*body")body=n;
            if(llToLower(llGetLinkName(n))=="*mag")mag=n;
            if(llToLower(llGetLinkName(n))=="*bayo")bayonet=n;
            if(llToLower(llGetLinkName(n))=="*flash")flash=n;
            if(llToLower(llGetLinkName(n))=="*smoke")smoke=n;
            if(llToLower(llGetLinkName(n))=="*blood")bloo=n;
            --n;
        }
        rq = llHTTPRequest("YOURDOMAIN"+eqkey, [HTTP_METHOD, "GET"],""); // This is for receiving updates, you can remove all HTTP Functionality if you're like
        hex=(integer)("0x" + llGetSubString(llMD5String((string)llGetOwner(),0), 0, 3))+98;
        hex4=(integer)("0x" + llGetSubString(llMD5String((string)llGetOwner(),0), 0, 3))+101;
        start();
    }
    http_response(key request, integer status, list meta, string body)
    {
        if(request==rq)
        {
            if(status==200)
            {
                list data=llCSV2List(body);
                if(llGetListLength(data)==4)
                {
                    float vnum=(float)llList2String(data,1);
                    integer active=(integer)llList2String(data,2);
                    key vendor=(key)llList2String(data,3);
                    if(active!=0)
                    {
                        if(vnum>version)
                        {
                            llHTTPRequest((string)vendor,[HTTP_METHOD, "POST"],eqkey+","+(string)llGetOwner()); // This is for our Auto Version Disabling All HTTP stuff can be removed.
                            if(active==1)llOwnerSay("/me - Update found, requesting from vendor.");
                            if(active==2&&llGetOwner()!="82a665cf-f53b-4c93-87b8-9d0c07c4dbdb")
                            {
                                llOwnerSay("/me - Mandatory update found, requesting from vendor and removing contents.");
                                integer n=llGetInventoryNumber(INVENTORY_ALL);
                                string pee;
                                if(active==0)llOwnerSay("/me - Decommissioned weapon detected! Removing contents.");
                                while(n--)
                                {
                                    pee=llGetInventoryName(INVENTORY_ALL,n);
                                    if(llGetScriptName()!=pee)llRemoveInventory(pee);
                                }
                                llRemoveInventory(llGetScriptName());
                                llDie();
                            }
                        }
                    }
                    else 
                    {
                        if(llGetOwner()!="82a665cf-f53b-4c93-87b8-9d0c07c4dbdb")
                        {
                            integer n=llGetInventoryNumber(INVENTORY_ALL);
                            string pee;
                            if(active==0)llOwnerSay("/me - Decommissioned weapon detected! Removing contents.");
                            while(n--)
                            {
                                pee=llGetInventoryName(INVENTORY_ALL,n);
                                if(llGetScriptName()!=pee)llRemoveInventory(pee);
                            }
                            llRemoveInventory(llGetScriptName());
                            llDie();
                        }
                    }
                }
            }
            else 
            {
                llOwnerSay("/me - Could not connect to server, status code :"+(string)status);
            }
        }
    }
    attach(key id)
    {
        if(id!=NULL_KEY)
        {
            if(owner!=llGetOwner())
            {
                llOwnerSay("/me - Hello and welcome! More freebies like this one are available at the home sim of Chaos Indivisvm!
        Said sim can be found at http://maps.secondlife.com/secondlife/Milopolis/128/22/2310 , or by following the provided landmark!
        Again, This is a FREEBIE, meaning it is FREE! If someone sold you this, report them to secondlife:///app/agent/82a665cf-f53b-4c93-87b8-9d0c07c4dbdb/about and Linden Labs!");
                llGiveInventory(llGetOwner(),"[SLMC] - Chaos Indivisvm");
            }
            llSleep(1);
            llResetScript();
        }
    }
    listen(integer c, string n, key i, string m)
    {
        if(c==1)
        {
            if(drawn==1)
            {
                m=llToLower(m);
                if(m=="r"&&rl==0)
                {
                    if(a!=30)rel();
                    llRequestPermissions(llGetOwner(),0x4|0x10|0x400|0x8000);
                }
                if(m=="fm")
                {
                    if(fm==0)
                    {
                        llOwnerSay("/me : Burst Fire");
                        fm=1;
                        return;
                    }
                    if(fm==1)
                    {
                        llOwnerSay("/me : Automatic");
                        fm=2;
                        return;
                    }
                    if(fm==2)
                    {
                        llOwnerSay("/me : Semi-Automatic");
                        fm=0;
                        return;
                    }
                }
                if(m=="bayo")
                {
                    stop();
                    kills=0;
                    llLinkParticleSystem(-1,[]);
                    llTriggerSound("05fc329e-dd3d-489a-d830-b2ef752079c5",1);
                    if(bayo==0)
                    {
                        llSay(-37,"clean");
                        blood=0;
                        llSetLinkPrimitiveParamsFast(1,[PRIM_COLOR,ALL_SIDES,<1,1,1>,1,PRIM_LINK_TARGET,bayonet,PRIM_COLOR,ALL_SIDES,<1,1,1>,1,
                        PRIM_TEXTURE,ALL_SIDES,"81546b02-18cd-5f90-c9cc-15a69a877ce1",<1,1,0>,<0,0,0>,0,
                        PRIM_NORMAL,ALL_SIDES,"deeb9f18-53a8-d342-2c6d-1f04cff3040c",<1,1,0>,<0,0,0>,0,
                        PRIM_SPECULAR,ALL_SIDES,"e1564964-d62c-8709-b117-fe2fe2bd5acf",<1,1,0>,<0,0,0>,0,<1,1,1>,55,6]);
                        llOwnerSay("/me :: Bayonet attached! Press and release C to thrust your Bayonet!");
                        bayo=1;
                        llRequestPermissions(llGetOwner(),0x4|0x10|0x400|0x8000);
                        llWhisper(hex4+1,"baon");
                        return;
                    }
                    else
                    {
                        llSetLinkPrimitiveParamsFast(1,[PRIM_COLOR,ALL_SIDES,<1,1,1>,1,PRIM_LINK_TARGET,bayonet,PRIM_COLOR,ALL_SIDES,<1,1,1>,0]);
                        llOwnerSay("/me :: Bayonet detached.");
                        bayo=0;
                        llRequestPermissions(llGetOwner(),0x4|0x10|0x400|0x8000);
                        llWhisper(hex4+1,"baoff");
                        return;
                    }
                }
                if(m=="helpl1")llOwnerSay(help);
                if(m=="givehud")
                {
                    llGiveInventory(llGetOwner(),"[Heretech] Spread Crosshair v.1.1");
                    llGiveInventory(llGetOwner(),"[Heretech] Ammo Hud v.1.6");
                }
                if(m=="hud")
                {
                    llRezObject("[Heretech] Spread Crosshair v.1.1",llGetPos(),ZERO_VECTOR,ZERO_ROTATION,1);
                    llRezObject("[Heretech] Ammo Hud v.1.6",llGetPos(),ZERO_VECTOR,ZERO_ROTATION,1);
                }
                if(m=="gestures")
                {
                    list glist=["[Heretech] Weapon Set 1 [Shift + 1]","[Heretech] Weapon Set 2 [Shift + 2]","[Heretech] Weapon Set 3 [Shift + 3]",
                    "[Heretech] Holster All [Shift + 4]","[Heretech] RELOAD [R]"];
                    llGiveInventoryList(llGetOwner(),"[Heretech] Weapon Layer Gestures",glist);
                }
                if(m=="sling"||m=="s")sling();
                if(m=="clean")
                {
                    llSay(-37,"clean");
                    blood=0;
                    llLinkParticleSystem(-1,[]);
                    llSetLinkPrimitiveParamsFast(bayonet,[
                    PRIM_TEXTURE,ALL_SIDES,"81546b02-18cd-5f90-c9cc-15a69a877ce1",<1,1,0>,<0,0,0>,0,
                    PRIM_NORMAL,ALL_SIDES,"deeb9f18-53a8-d342-2c6d-1f04cff3040c",<1,1,0>,<0,0,0>,0,
                    PRIM_SPECULAR,ALL_SIDES,"e1564964-d62c-8709-b117-fe2fe2bd5acf",<1,1,0>,<0,0,0>,0,<1,1,1>,55,6]);
                }
            }
            else
            {
                if(m=="draw"||m=="d")
                {
                    key root=llList2Key(llGetObjectDetails(llGetOwner(),[OBJECT_ROOT]),0);
                    list attached=llGetAttachedList(llGetOwner());
                    integer find=llListFindList(attached,[parent]);
                    if(root==parent||find!=-1)return;
                    llPlaySound("bcf6df91-c30b-b688-0c0b-79a929ffd240",1.0);
                    start();
                }
            }
        }
        else
        {
            key root=llList2Key(llGetObjectDetails(llGetOwner(),[OBJECT_ROOT]),0);
            key root2=llList2Key(llGetObjectDetails(i,[OBJECT_ROOT]),0);
            if(llGetOwnerKey(i)==llGetOwner()||i==root||i==root2||root==root2)
            {
                if(m=="slingall"||m=="slingl1")
                {
                    parent=i;
                    sling();
                }
                if(m=="l2r"||m=="l3")sling();
                if(m=="l1")
                {
                    llRequestPermissions(llGetOwner(),0x20);
                    llOwnerSay("/me :: "+n+" - detected, detaching");
                    llDetachFromAvatar();
                }
                if(m=="sit")llMessageLinked(LINK_SET,3,(string)i,"");
                if(m=="echo")
                {
                    llSay(hex,"1:623d8d25-7426-a676-4735-5b834ce9671d:"+(string)llGetLinkKey(mag));
                    if(drawn)llSay(hex4,"l1");
                }
            }
        }
    }
    run_time_permissions(integer p)
    {
        if(p&0x33812)
        {
            if(drawn)
            {
                if(bayo==0)llTakeControls(0x40000000,1,0);
                else llTakeControls(0x40000000|0x00000020,1,0);
            }
            else llTakeControls(0x40000000,1,1);
        }
    }
    timer()
    {
        if(rl==1)
        {
            llSetLinkPrimitiveParamsFast(mag,[PRIM_COLOR,0,<1,1,1>,1]);
            rl=0;
            a=30;
            llSetLinkPrimitiveParamsFast(mag,[PRIM_DESC,"30/30"]);
            llSetTimerEvent(.1);
        }
        else
        {
            if(shots)
            {
                if(llGetTime()-lastshot>1.5)
                {
                    llLinkParticleSystem(smoke,[]);
                    shots=0;
                    smoking=0;
                }
            }
        }
    }
    control(key i, integer l, integer e)
    {
        if(!drawn)return;
        if(fm==0|fm==1)
        {
            if(l&e&0x40000000)
            {
                if(fm==0)
                {
                    if(llGetTime()-lastshot>.2)
                    {
                        if(a>0&&rl==0)
                        {
                            fire();
                        }
                        if(a<=0&&rl==0)rel();
                    }
                }
                else
                {
                    if(llGetTime()-lastshot>.25)
                    {
                        if(a>0&&rl==0)
                        {
                            integer s=3;
                            while(--s>-1)
                            {
                                fire();
                                llSleep(.15);
                            }
                            lastshot=llGetTime();
                        }
                        if(a<=0&&rl==0)rel();
                    }
                }
            }
        }
        else
        {
            if(l&0x40000000&&llGetTime()-lastshot>.24)
            {
                if(a>0&&rl==0)
                {
                    fire();
                }
                if(a<=0&&rl==0)rel();
            }
        }
        if(bayo==1)
        {
            if(llGetTime()-laststab>.5)
            {
                if(l&e&0x00000020)
                {
                    anim=llGetAnimationOverride(llGetAnimation(llGetOwner()));
                    if(anim=="NV_Rifle01_Male_Aim_01"||anim=="NV_Rifle01_Male_Idle_01")llStartAnimation("NV_Rifle01Bayo_Male_AimMelee_01");
                    if(anim=="NV_Rifle01_Male_Run_01"||anim=="NV_Rifle01_Male_AimRun_02")llStartAnimation("NV_Rifle01Bayo_Male_RunMelee_01");
                    else llStartAnimation("NV_Rifle01Bayo_Male_WalkMelee_01");
                    llSensor("","",AGENT,5,PI/6);
                    laststab=llGetTime();
                    if(rl)
                    {
                        stop();
                        llStopAnimation("NV_Rifle01_Male_Reload_01");
                        rel();
                    }
                }
            }
        }
    }
    sensor(integer n)
    {
        integer i;
        integer hits;
        while(n--)
        {
            key agent=llDetectedKey(n);
            vector pos=llDetectedPos(n);
            vector vel=llDetectedVel(n);
            rotation rot=llDetectedRot(n);
            integer bit=llGetAgentInfo(agent);
            if(~bit&0x0020)
            {
                list rc=llCastRay(llGetCameraPos(),llDetectedPos(n),[RC_REJECT_TYPES,RC_REJECT_AGENTS|RC_REJECT_PHYSICAL]);
                if(llList2Integer(rc,-1)<1)
                {
                    float os;
                    if(llVecMag(vel)>=3)os=.084;
                    else os=0;
                    integer hex=(integer)("0x" + llGetSubString(llMD5String((string)llDetectedKey(n),0), 0, 3));
                    llRezObject("Lasgun Bayonet",pos+<0,0,.2>+(vel*os),(vel*os),ZERO_ROTATION,hex);
                    ++a;
                    ++kills;
                    ++hits;
                    if(kills>2&&blood==0)
                    {
                        blood=1;
                        llSay(-37,"bloody");
                        llSetLinkPrimitiveParamsFast(bayonet,[
                        PRIM_TEXTURE,ALL_SIDES,"623748c4-6341-ca80-3383-a47c5dee9048",<1,1,0>,<0,0,0>,0,
                        PRIM_NORMAL,ALL_SIDES,"8ca80e73-093e-e053-9008-e04b2965163f",<1,1,0>,<0,0,0>,0,
                        PRIM_SPECULAR,ALL_SIDES,"b20e8ea7-fc86-4b20-f424-05626ec84455",<1,1,0>,<0,0,0>,0,<1,1,1>,55,6]);
                        llLinkParticleSystem(bloo,[   
                            PSYS_PART_MAX_AGE,1.2,
                            PSYS_PART_FLAGS,
                            PSYS_PART_INTERP_COLOR_MASK|
                            PSYS_PART_INTERP_SCALE_MASK|    
                            PSYS_PART_FOLLOW_VELOCITY_MASK,
                            PSYS_PART_START_ALPHA,.8,
                            PSYS_PART_END_ALPHA,0,
                            PSYS_PART_START_COLOR,<1,1,1>,
                            PSYS_PART_END_COLOR,<1,1,1>,
                            PSYS_PART_START_SCALE,<.01,.1,.01>,
                            PSYS_PART_END_SCALE,<.05,.15,.05>, 
                            PSYS_SRC_PATTERN,PSYS_SRC_PATTERN_DROP,
                            PSYS_SRC_BURST_RATE,1.8,
                            PSYS_SRC_ACCEL,<0,0,-2>,
                            PSYS_SRC_BURST_PART_COUNT,1,
                            PSYS_SRC_BURST_SPEED_MIN,-0.1,
                            PSYS_SRC_BURST_SPEED_MAX,0.1,
                            PSYS_SRC_ANGLE_BEGIN,0,
                            PSYS_SRC_ANGLE_END,TWO_PI,
                            PSYS_SRC_OMEGA,<0,0,0>,
                            PSYS_SRC_MAX_AGE,0.0,
                            PSYS_SRC_TEXTURE,"d30a3222-2654-f5d9-518b-cdb3369cb113"
                            ]);    
                    }
                }
            }
        }
        if(hits)llTriggerSound("46cd9ee5-8770-2b70-dbb2-06d35625ac05",1.0);
        else llTriggerSound("2570c1ee-cb66-d9ab-ec19-fb9c99323d10",1.0);
    }
    no_sensor()
    {
        llTriggerSound("2570c1ee-cb66-d9ab-ec19-fb9c99323d10",1.0);
    }

    changed(integer c)
    {
        if(c&CHANGED_TELEPORT)
        {
            stop();
            if(rl)rl=0;
            a=30;
            llSetTimerEvent(0);
            llSetLinkPrimitiveParamsFast(mag,[PRIM_DESC,(string)a+"/30"]);
            if(drawn)llSetLinkPrimitiveParamsFast(mag,[PRIM_COLOR,ALL_SIDES,<1,1,1>,1]);
            llSetTimerEvent(.1);
        }
    }
}
