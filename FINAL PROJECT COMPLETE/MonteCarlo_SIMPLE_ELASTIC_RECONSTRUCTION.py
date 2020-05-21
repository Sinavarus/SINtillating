#Monte-Carlo Simulation Based on Code from http://oddelab.umn.edu/software.html
#Thanks to Benjamin Bangasser and Odde Lab at University of Minnesota

#Barituziga Banuna
#CHEME 7770 FINAL PROJECT: Project 4: Kinetic Monte Carlo Simulation of traction force dynamics

import numpy as np
import matplotlib.pyplot as plt
import time

#---------------------------------------------------------------------
def TicTocGenerator():
    # Generator that returns time differences
    ti = 0           # initial time
    tf = time.time() # final time
    while True:
        ti = tf
        tf = time.time()
        yield tf-ti # returns the time difference

TicToc = TicTocGenerator() # create an instance of the TicTocGen generator

# This will be the main function through which we define both tic() and toc()
def toc(tempBool=True):
    # Prints the time difference yielded by generator instance TicToc
    tempTimeInterval = next(TicToc)
    if tempBool:
        print( "Elapsed time: %f seconds.\n" %tempTimeInterval )

def tic():
    # Records a time in TicToc, marks the beginning of a time interval
    toc(False)
#-----------------------------------------------------------------------


tic()#TIME CODE START

# Parameters
nm = 50 #number of myosin motors
Fm = -2.0 #motor stall force in pN
vu = -120.0 #unloaded motor velocity in nm/s
nc = 50 #number of molecular clutches
kon = 0.3 #On rate constant in 1/s
koff = 0.1 #Off rate constant in 1/s
Fb = -2.0 #Bond rupture force in pN
Kc = 0.8 #Clutch spring constant in pN/nm
gain = 0 #gain of feedback loop


events = 100000 #number of events to simulate
stiffness = np.logspace(-2,2,num=10) #define stiffness vector

retro = np.zeros(len(stiffness)) #initialize retro flow vector
#failfreq = np.zeros(len(stiffness)) #initialize failure frequency vector
#avnumcon = np.zeros(len(stiffness)) #initialize average number of engaged clutches vector
#avcough = np.zeros(len(stiffness)) #initialize average koff vector
#avtime = np.zeros(len(stiffness)) #initialize average timestep vector
avtrac = np.zeros(len(stiffness)) #initialize average traction force vector
#avsubpos = np.zeros(len(stiffness)) #initialize average substrate position vector
#avFc = np.zeros(len(stiffness)) #initialize average clutch force vector
binds = np.zeros(len(stiffness)) #initialize number of binding events
#failures = np.zeros(len(stiffness)) #initialize number of failure events
#cyct = np.zeros(len(stiffness)) #initialize cycle time
#velcv = np.zeros(len(stiffness)) #initialize velocity cv
#rebcyc = np.zeros(len(stiffness)) #initialize rebinds per cycle

TIME = np.zeros(len(stiffness)) #Holds times for each stiffness level
XSUB = np.zeros(len(stiffness)) #Holde the substrate displacement
   

for jj in range(len(stiffness)):
    print(jj)
    
    Ksub = stiffness[jj] #Substrate spring constant in pN/nm

    #initialize vectors for plots
    cstate = np.zeros(nc) #clutch state vector
    cunbind = np.zeros(nc) #clutch unbind state vector
    crebind = np.zeros(nc) #clutch rebind state vector
    xc = np.zeros(nc) #clutch position vector

    t = np.zeros(events+1) #time vector
    subpos = np.zeros(events+1) #substrate position vector
    numcon = np.zeros(events+1) #number of engaged clutches vector
    numcoff = np.zeros(events+1) #number of disengaged clutches vector
    vel = np.zeros(events+1) #velocity vector
    timestep = np.zeros(events+1) #vector of dt's
    cough = np.zeros(events+1) #koff vector
    Ft = np.zeros(events+1) #traction force vector
    totFc = np.zeros(events+1) #mean engaged clutch tension

    # Set inital state
    i=0
    ceng = (np.where(cstate==1)[0]) #find indices of engaged clutches
    cdisen = (np.where(cstate==0)[0]) #find indices of disengaged clutches

    vf = vu #claculate actin filament velocity

    xc[ceng] = xc[ceng] + (vf*0.005) #claculate positions of engaged clutches(dt=0.005)

    xsub = (Kc*np.sum(xc[ceng]))/(Ksub+len(ceng)*Kc) #calculate substrate posisiton


    #vf=vu*(1-((Ksub*xsub)/(nm*Fm))) #claculate actin filament velocity
    #xc(ceng)=xc(ceng)+vf*0.005 #claculate positions of engaged clutches (dt=0.005)
    xc[cdisen] = xsub #calculate posisiton of disengaged clutches

    Fc = Kc*(xc-xsub) #calculate force on each clutch

    t[i] = 0
    subpos[i] = xsub

    numcon[i] = len(ceng)

    numcoff[i] = len(cdisen)

    vel[i] = -vf

    timestep[i] = 0

    #Event stepping
    while i<=events-1:
        i=i+1
        

        if cdisen.size==0:
            tbind = np.inf

        else:
            tbind = -np.log(np.random.rand(len(cdisen)))/kon

        
        #calculate clutch unbinding times

        if ceng.size==0:
            
            tunbind = np.inf
            cough[i] = koff
            totFc[i] = 0
        else:
            tunbind=-np.log(np.random.rand(len(ceng)))/(koff*np.exp(Fc[ceng]/(Fb+gain*Fc[ceng])))

            cough[i]=np.mean(koff*np.exp(Fc[ceng]/(Fb+gain*Fc[ceng])))
            totFc[i]=np.mean(Fc[ceng])
        
        
        #find minimum time and execute that event
        dtbind  = np.min(tbind)

        indbind  = (np.where(tbind==dtbind)[0])
   
        dtunbind  = np.min(tunbind)

        indunbind  = (np.where(tunbind==dtunbind)[0])

        if dtbind<dtunbind: #free clutch bind to actin

            cstate[cdisen[indbind]]=1

            dt = dtbind
            binds[jj]=binds[jj]+1

            if cunbind[cdisen[indbind]]==1: #if clutch has already unbound during the cycle
                crebind[cdisen[indbind]]=crebind[cdisen[indbind]]+1
            
        else: #engaged clutch disengages from actin
            cstate[ceng[indunbind]]=0
            dt = dtunbind
            cunbind[ceng[indunbind]]=1
        
        
        ceng = (np.where(cstate==1)[0]) #find indices of engaged clutches
        cdisen = (np.where(cstate==0)[0]) #find indices of disengaged clutches
        Ftrac = Ksub*xsub #claculate traction force
        vf=vu*(1-((Ksub*xsub)/(nm*Fm))) #claculate actin filament velocity
        #vf=vu
        xc[ceng]=xc[ceng]+vf*dt #claculate positions of engaged clutches
        xsub=(Kc*sum(xc[ceng])/(Ksub+len(ceng)*Kc)) #calculate substrate posisiton
        #Ftrac=Ksub*xsub #claculate traction force - old
        #vf=vu*(1-((Ksub*xsub)/(nm*Fm))) #claculate actin filament - old
        #xc(ceng)=xc(ceng)+vf*dt #claculate positions of engaged clutches - old
        xc[cdisen]=xsub #calculate posisiton of disengaged clutches
        Fc=Kc*(xc-xsub) #calculate force on each clutch
        
        if xsub==0: #reset unbind vector at failure event
            cunbind=np.zeros(nc)
        
        
        t[i]=t[i-1]+dt
        subpos[i]=xsub
        numcon[i]=len(ceng)
        numcoff[i]=len(cdisen)
        vel[i]=-vf
        timestep[i]=dt
        Ft[i]=Ftrac    

    cyctime = np.diff(t[(np.where(subpos==0)[0])]) #cycle time
    
    retro[jj]=np.sum((vel*timestep)/t[events]) #weighted average retrograde flowrate
    
    #check1 = len(np.where(numcon==0)[0])


    #failfreq[jj]=(check1-1)/(t[events]) #failures/s
    #avnumcon[jj]=np.sum((numcon*timestep)/t[events]) #average number of engaged clutches
    #avcough[jj]=np.sum((cough*timestep)/t[events]) #average koff
    #avtime[jj]=np.mean(timestep) #average timestep
    avtrac[jj]=np.sum((Ft*timestep)/t[events]) #average traction force
    #avsubpos[jj]=np.sum((subpos*timestep)/t[events]) #average substrate position
    #avFc[jj]=np.sum((totFc*timestep)/t[events]) #average force
    #failures[jj]=(check1-1)
    #cyct[jj]=np.mean(cyctime) #mean cycle time
    #velcv[jj]=((np.sum(timestep*((vel-retro[jj])**2)/t[events]))**0.5)/retro[jj] #weighted actin flow coeffieicent of variation
    #rebcyc[jj]=np.sum(crebind)/failures[jj]

    plt.figure()
    plt.plot(t,subpos)
    plt.xlabel("time (s)")
    plt.ylabel("Substrate Position Xsub (nm)")
    plt.title(f"Stiffness = {stiffness[jj]} (pN/nm)")

toc()#TIME CODE END

plt.figure()
plt.subplot(121)
plt.plot(stiffness,retro)
plt.xscale('log')
plt.xlabel("Substrate stiffness (pN/nm)")
plt.ylabel("Mean retrograde flow (nm/s)")

plt.subplot(122)
plt.plot(stiffness,-avtrac)
plt.xscale('log')
plt.xlabel("Substrate stiffness (pN/nm)")
plt.ylabel("Mean traction force (pN)")
plt.show()
