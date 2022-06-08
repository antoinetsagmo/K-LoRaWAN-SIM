# K-LoRaWAN-SIM
A LoRaWAN simulator for confirmed/unconfirmed transmissions with multiple gateways and better distribution of gateways than LoRaWAN-SIM, the basic tool.

If you want to cite the LoRaWAN-SIM simulator, you can use the following bib entry:

@Article{zorbas2021optimal,  
  AUTHOR = {Zorbas, Dimitrios and Caillouet, Christelle and Abdelfadeel Hassan, Khaled and Pesch, Dirk},  
  TITLE = {Optimal Data Collection Time in LoRa Networks—A Time-Slotted Approach},  
  JOURNAL = {Sensors},  
  VOLUME = {21},  
  YEAR = {2021},  
  NUMBER = {4}  
}

## Features:
- Multiple half-duplex gateways
- 1% radio duty cycle for uplink transmissions
- 1 or 10% radio duty cycle for downlink transmissions
- Two receive windows (RX1, RX2) for ACKs and commands
- Non-orthogonal SF transmissions
- Capture effect
- Path-loss signal attenuation model
- Multiple channels
- Collision handling for both uplink+downlink transmissions
- Proper header overhead
- Node energy consumption calculation (uplink+downlink)
- ADR (Tx power adjustment)

## Dependencies:
- https://metacpan.org/pod/Math::Random
- https://metacpan.org/pod/Term::ProgressBar
- https://metacpan.org/pod/GD::SVG

## Usage:
```
perl generate_terrain.pl terrain_side_size_(m) num_of_nodes num_of_gateways > terrain.txt
perl LoRaWAN.pl packets_per_hour simulation_time(secs) ack_policy(1-3) terrain.txt
```

### Example with 1000x1000m terrain size, 1000 nodes, 10 gateways, 1pkt/5min, ~3h sim time:
```
perl generate_terrain.pl 1000 1000 10 > terrain.txt
perl LoRaWAN.pl 12 10000 2 terrain.txt
```

### Output sample:  
```
(base) tsagmo@tsagmo-Legion-Y540-15IRH:~/Documents/LoRaWAN-SIM_Kmeans/K-LoRaWAN-SIM$ perl generate_terrain.pl 1000 1000 10 > terrain.txt
(base) tsagmo@tsagmo-Legion-Y540-15IRH:~/Documents/LoRaWAN-SIM_Kmeans/K-LoRaWAN-SIM$ perl LoRaWAN.pl 12 10000 2 terrain.txt
Simulation time = 10000.302 secs
Avg node consumption = 9.97036 mJ
Min node consumption = 6.99126 mJ
Max node consumption = 28.59852 mJ
Total number of transmissions = 47769
Total number of re-transmissions = 13859
Total number of unique transmissions = 34027
Total packets delivered = 43779
Total packets acknowledged = 32910
Total confirmed dropped = 117
Total unconfirmed packets dropped = 0
Packet Delivery Ratio = 0.96717
Packet Reception Ratio = 0.91647
No GW available in RX1 = 33082 times
No GW available in RX1 or RX2 = 6183 times
Total downlink time = 5677.98246400372 sec
Script execution time = 10.2566 secs
-----
GW A sent out 3657 acks
GW B sent out 3925 acks
GW C sent out 3362 acks
GW D sent out 4126 acks
GW E sent out 3586 acks
GW F sent out 4060 acks
GW G sent out 3787 acks
GW H sent out 3271 acks
GW I sent out 3838 acks
GW J sent out 3984 acks
Mean downlink fairness = 0.905
Stdv of downlink fairness = 0.072
-----
# of nodes with SF7: 168
# of nodes with SF8: 92
# of nodes with SF9: 124
# of nodes with SF10: 233
# of nodes with SF11: 230
# of nodes with SF12: 153
Avg SF = 9.724

