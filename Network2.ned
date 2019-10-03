
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.ethernet.EtherHost;
import inet.node.ethernet.EtherSwitch;
import inet.node.inet.StandardHost;
//import inet.node.inet.WirelessHost;
//import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
//import inet.physicallayer.unitdisk.UnitDiskRadioMedium;
//import inet.visualizer.integrated.IntegratedCanvasVisualizer;
import ned.DatarateChannel;


//
// TODO documentation
//
network WiredNetwork
{
    parameters:
        int numHosts = default(1);
        @display("bgb=600,600");



    types:
        channel Ether1000M extends DatarateChannel
        {
            delay = 0.1us;
            datarate = 1Gbps;
        }


    submodules:
        SwitchA: EtherSwitch {
            @display("p=234.35199,303.208");
            gates:
                ethg[numHosts + 3];
        }
        SwitchB: EtherSwitch {
            @display("p=362.4,253.68");
            gates:
                ethg[numHosts + 2];
        }
        SwitchC: EtherSwitch {
            @display("p=213.816,173.952");
            gates:
                ethg[numHosts + 2];
        }

        HostA[numHosts]: StandardHost {
          
        }
        HostB[numHosts]: StandardHost {
            
        }
        HostC[numHosts]: StandardHost {
           
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=45.904,54.36");
        }
        serverA: StandardHost {
            parameters:
                @display("p=234.35199,448.168;i=device/pc2");
        }
        serverB: StandardHost {
            parameters:
                @display("p=523.06396,112.344;i=device/pc2");
        }
        serverC: StandardHost {
            parameters:
                @display("p=281.464,73.687996;i=device/pc2");
        }
    connections allowunconnected:
        for i=0..numHosts-1 {
            SwitchA.ethg++ <--> Ether1000M <--> HostA[i].ethg++;
            SwitchB.ethg++ <--> Ether1000M <--> HostB[i].ethg++;
            SwitchC.ethg++ <--> Ether1000M <--> HostC[i].ethg++;
        }

        SwitchA.ethg[numHosts] <--> Ether1000M <--> SwitchB.ethg[numHosts];
        SwitchA.ethg[numHosts+1] <--> Ether1000M <--> SwitchC.ethg[numHosts];


        SwitchB.ethg[numHosts+1] <--> Ether1000M <--> serverB.pppg++;
        SwitchC.ethg[numHosts+1] <--> Ether1000M <--> serverC.pppg++;
        SwitchA.ethg[numHosts+2] <--> Ether1000M <--> serverA.pppg++;
}


