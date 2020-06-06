vector clamp(vector start, vector dir)
{
    dir += <1E-6,1E-6,1E-6>;
    vector invDir = <1./dir.x, 1./dir.y, 1./dir.z>;
    vector max = <255.,255.,4095.> - start;
    vector X;
    
    if(dir.x < 0.){
        X = start - (start.x * invDir.x) * dir;
        if(X.y > 0. && X.y <= 256. && X.z <= 4096. && X.z >= 0.) return X;
    } else{
        X = start + (max.x * invDir.x) * dir;
        if(X.y > 0. && X.y <= 256. && X.z <= 4096. && X.z >= 0.) return X;
    }
    
    if(dir.y < 0.){
        X = start - (start.y * invDir.y) * dir;
        if(X.x > 0. && X.x <= 256. && X.z <= 4096. && X.z >= 0.) return X;
    } else{
        X = start + (max.y * invDir.y) * dir;
        if(X.x > 0. && X.x <= 256. && X.z <= 4096. && X.z >= 0.) return X;
    }
    
    if(dir.z < 0.){
        X = start - (start.z * invDir.z) * dir;
        if(X.x >= 0. && X.x <= 256. && X.y >= 0. && X.y <= 256.) return X;
    }
    return start + (max.z * invDir.z) * dir;
}
integer bound(vector input)
{
    integer oob;
    if(input.x>=256)oob=1;
    if(input.x<=0)oob=1;
    if(input.y>=256)oob=1;
    if(input.y<=0)oob=1;
    if(input.z>=4056)oob=1;
    if(input.z<=0)oob=1;
    return oob;
}
integer dmg;
integer at=1;
vector pos;
rotation rot;
float max=150;
float end=350;
float fo=.8;
float o=0;
float base=.002;
float mod=.0026;
float spr=0;
float cd=.3;
float rate=.15;
default
{
    state_entry()
    {
        llSetObjectDesc((string)base);
        llRequestPermissions(llGetOwner(),0x4|0x400);
    }
    run_time_permissions(integer p)
    {
        llTakeControls(0x40000000,1,1); 
    }
    attach(key id)
    {
        if(id!=NULL_KEY)llResetScript();
    }
    changed(integer c)
    {   
        if(c&CHANGED_COLOR)
        {
            vector color=llGetColor(1);
            if(color.x==.75)
            {
                integer mode=0;
                if(color.y==0)
                {
                    max=150;
                    fo=.5;
                    end=350;
                }
                else
                {
                    mode=1;
                    max=70;
                    fo=.8;
                    end=195;
                }
                float real=cd;
                llSetTimerEvent(0);
                float calc=base+spr;
                float hc=calc*.5;
                if(spr<.08)spr+=mod;
                pos=llGetCameraPos();
                rot=llGetCameraRot()*(llEuler2Rot(<llFrand(calc)-hc,llFrand(calc)-hc,llFrand(calc)-hc>));
                key tar;
                @phcheck;
                vector en=pos+<end,0,0>*rot;
                if(bound(en))en=clamp(pos,<1,0,0>*rot);
                list rc=llCastRay(pos,en,[RC_MAX_HITS,2,RC_DATA_FLAGS,2]);
                if(llList2Key(rc,0)==llGetOwner())rc=llListReplaceList(rc,[],0,1);
                list off=[<0,.125,0>,<0,-.125,0>,<0,0,-.125>,<0,0,.125>];
                integer n=llGetListLength(off);
                list butt;
                while(n--)
                {
                    vector pos2=pos+llList2Vector(off,n)*rot;
                    en=clamp(pos2,<1,0,0>*rot);
                    list rc2=llCastRay(pos2,en,[RC_MAX_HITS,2]);
                    if(llList2Integer(rc2,-1)>0)
                    {
                        if(llList2Key(rc2,0)==llGetOwner())rc2=llListReplaceList(rc2,[],0,1);
                        butt+=[llList2Key(rc2,0),llList2Vector(rc2,1)];
                    }
                }
                vector poshit=llList2Vector(rc,1);
                tar=llList2Key(rc,0);
                list data=llGetObjectDetails(tar,[OBJECT_DESC,OBJECT_PHANTOM]);
                integer phantom=llList2Integer(data,1);
                if(phantom)
                {
                    pos=poshit+<.15,0,0>*rot;
                    jump phcheck;
                }
                float dist;
                if(poshit == ZERO_VECTOR)poshit = pos+<end,0,0>*rot;
                dist=llVecDist(llGetCameraPos(),poshit);
                if(dist>end)dist=end;
                dist=dist*.98;
                integer pass=mode<<16|(integer)(dist*100);
                llRezAtRoot("Lasgun Trail",llGetCameraPos()+<1,0,0>*rot,ZERO_VECTOR,rot,pass);
                real-=.1;
                calc=base+spr;
                llSetObjectDesc((string)calc);
                if(llList2Integer(rc,-1)>0)
                {
                    string desc=llList2String(data,0);
                    if(desc)
                    {
                        string dookie=llList2String(llCSV2List(desc),1);
                        if((key)dookie)tar=dookie;
                    }
                    if(llGetAgentSize(tar))
                    {   
                        if(dist<=max)dmg=100;
                        else dmg=100-llRound(((dist-max)*fo));
                        if(dmg<0)dmg=0;
                        if(dmg>0)
                        {
                            integer pass=((integer)("0x" + llGetSubString(tar, 0, 3)) << 16) | dmg;
                            llRezAtRoot("Las-Bolt RC",llGetPos()+<2,0,0>*rot,<0,0,0>,ZERO_ROTATION,pass);
                            real-=.1;
                        }
                        llOwnerSay("Hit: secondlife:///app/agent/"+(string)tar+"/about @ "+(string)dist+" for "+(string)dmg+" dmg");
                    }
                    else
                    {
                        if(llVecDist(llGetPos(),poshit)<=max)
                        {
                            integer scripts=llList2Integer(llGetObjectDetails(tar,[OBJECT_TOTAL_SCRIPT_COUNT]),0);
                            if(scripts)
                            {
                                if(desc!=""&&(llGetSubString(desc,0,1)=="v."||llGetSubString(desc,0,5)=="LBA.v."))
                                {
                                    if(llGetSubString(desc,0,5)=="LBA.v.")
                                    {
                                        if(llGetSubString(desc,0,6)=="LBA.v.L"||llGetListLength(llCSV2List(desc))==1)
                                        {
                                            integer hex=(integer)("0x" + llGetSubString(llMD5String((string)tar,0), 0, 3));
                                            llRegionSayTo(tar,hex,(string)tar+","+(string)at);
                                        }
                                    }
                                    else llRegionSayTo(tar,-500,(string)tar+",damage,"+(string)at);
                                    //llOwnerSay("/me : Delivering "+(string)at+" AT to - "+llKey2Name(tar));
                                }
                                else
                                {
                                    llRezObject("[Chaos] AT Emitter",llGetPos(),ZERO_VECTOR,ZERO_ROTATION,3);
                                    //llOwnerSay("/me : Delivering "+(string)at+" LEGACY AT to - "+llKey2Name(tar));
                                    llSay(-111,(string)tar);
                                    real-=.1;
                                }
                            }
                        }
                    }
                }
                integer b=llGetListLength(butt);
                if(b)
                {
                    key tar1=tar;
                    list hit;
                    while(b)
                    {
                        tar=llList2Key(butt,b-2);
                        if(llListFindList(hit,[(string)tar])==-1)
                        {
                            if(llGetAgentSize(tar)!=ZERO_VECTOR&&tar1!=tar)
                            {
                                dist=llVecDist(pos,llList2Vector(butt,b-1));
                                if(dist<=(max-40))dmg=100;
                                else dmg=100-llRound(((dist-(max-40))*fo));
                                if(dmg<0)dmg=0;
                                if(dmg>0)
                                {
                                    integer pass=((integer)("0x" + llGetSubString(tar, 0, 3)) << 16) | dmg;
                                    llRezAtRoot("Las-Bolt RC Haze",llGetPos()+<2,0,0>*rot,<0,0,0>,ZERO_ROTATION,pass);
                                    real-=.1;
                                }
                                llOwnerSay("Haze Hit: secondlife:///app/agent/"+(string)tar+"/about @ "+(string)dist+" for "+(string)dmg+" dmg");
                            }
                        }
                        hit+=[(string)tar];
                        b-=2;
                    }
                }
                if(real<=0)real=.001;
                llSetTimerEvent(real);
            }
        }
    }
    timer()
    {
        spr-=mod;
        if(spr<=0)
        {
            spr=0;
            llSetTimerEvent(0);
        }
        else llSetTimerEvent(rate);
        float calc=base+spr;
        llSetObjectDesc((string)calc);
    }
}
