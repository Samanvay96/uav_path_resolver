# UAV Path Resolver
This project consists of two primary tasks. The ﬁrst is to use non-linear least squares (NLLS) analysis to ﬁnd a UAV trajectory given pseudorange data and validating this result by matching them to the true UAV trajectory (also given). The second is to calculate the dilution of precision (DOP) of the calculated UAV trajectory.

The DOP is a measure of the accuracy of any given GPS position data. Five diﬀerent types of

1 DOPs will be calculated: Geometric DOP, Position DOP, Horizontal DOP, Vertical DOP and time DOP. They are a function of the variances in x,y,z,t (clock bias) components: Vx , Vy , Vz & Vt .

Geometric DOP is the error due to the geometric orientation of the satellites in space. Position DOP is the error in the 3D position of the UAV. Horizontal DOP is the error in the horizontal position of the UAV while Vertical DOP is the error in the altitude of the UAV. Time DOP is the error due to the time accuracy.

The lower the DOP values, the better the instantaneous position measurement of the UAV. A good GDOP or PDOP is considered to be <5 while values >10 for PDOP are very poor. HDOP is expected to be between 2-3. VDOP is expected to be higher than HDOP as a result of all the satellites being above the receiver whereas for the horizontal coordinates, data is received from all sides of the UAV.

## GPS Positioning Problem

Suppose a receiver is located on a ﬂat 2D earth. Two GPS satellites can be used to pinpoint its location on earth, provided that if the range of the two satellites is represented by a circle there will be two intersections, of which only one will be located on earth. This is given no range error. Suppose there is a range error in GPS gps satellites, the intersection of the two range circles will now have shifted, resulting in an incorrect position estimation of the receiver on the earth.

This issue can be resolved by having a third GPS satellite resolve the location of the receiver. Provided that all GPS satellites have the same clock/range error, all three range circle will intersect at the receiver position. This can be used to calculate the clock bias, hence the range error. Similarly in 3D space, we need four satellites to pinpoint receiver location.

## Methodology

### UAV Trajectory Determination

Two given data ﬁles were used for this task. The ﬁrst was `GPS pseudorange F1.txt`. This ﬁle contained pseudoranges as calculated from the UAV to all visible satellites. The second was `UAVPostion F1.txt`. This ﬁle contained the true position of the UAV. The ﬂowchart in ﬁgure 2 describes the process of UAV trajectory determination from given pseudorange data. Non-Linear Least Squares regression was used for this process.

![flowchart](https://github.com/Samanvay96/uav_path_resolver/blob/master/imgs/flowchart.png)

The equations to ﬁnding f(x0) & H can be found in section A of the appendix. The ﬂowchart in the figure above. The vector X0 is in the form X0 = [x,y,z,cbU] where cb U is the clock bias. The latter is a measure of the time oﬀset in the GPS receiver on ground.

Ideally if the GPS receiver on earth and the GPS satellite both had synchronised atomic clocks, only three satellites would be needed to pinpoint receiver location. However an atomic clock cost up to $200000, making it too expensive to be used for wide-spread use in the civil market. Alternatively a cheap receiver can be used at a simple trade-oﬀ, this time four satellites are needed to pin-point receiver location. The additional satellite is used to obtain the clock bias, which is the oﬀset distance that is used to calculate the oﬀset time to correct the receiver clock.

### NLLS

NLLS stands for non-linear least squares. It is a method used to ﬁnd solutions to non-linear functions, for example the pseudorange equations listed in section A. Essentially, the non-linear problem is linearised and solved iteratively to obtain a valid solution [4]. The linearisation yields an overdetermined set of linear equations, in this case obtained due to multiple satellite observations. In some instances up to eight satellite observations are used for any given timestep.

### DOP Calculations

The equations used to ﬁnd the DOP values can be found using the Variances found by diagonalising (HTH)^(−1) where H is the Jacobian, the rate of change matrix shown in ﬁgure 2. As it was a M × 4 matrix, diagonalising led to [Vx, Vy, Vz, Vt] where V represents the variance and the subscript represents the relevant dataset. Equations listed in section A of the appendix were used to calculate the DOP values.

![flowchart](https://github.com/Samanvay96/uav_path_resolver/blob/master/imgs/bestNworst.png)
![flowchart](https://github.com/Samanvay96/uav_path_resolver/blob/master/imgs/uavAltitude.png)

|              | GDOP  | PDOP  | HDOP  | VDOP  | TDOP  |
| -----------  | ----- | ----- | ----- | ----- | ----- |
| Worst Conﬁg. |  76.4 |  57.3 |  47.9 |  31.5 |  50.5 |
| Best Conﬁg.  |  2.32 |  1.98 | 1.699 | 1.017 | 1.215 |

In ﬁgure 3a, visible Satellites in best and worst conﬁgurations are shown as red circles and blue crosses respectively. The best satellite conﬁguration was deemed to occur when the DOP values were at a minimum, consequently the worst conﬁguration occurred at a maximum. From ﬁgure 3a and table 1, it can be concluded that the DOP values collectively increase as the number of visible satellites decreases. Hence, the UAV position is most accurate when the maximum number of satellites are visible, in this case 9 from ﬁgure 3a.

The x,y coordinates obtained using NLLS were found to match almost exactly to the true coordinates. However, there was a discrepancy present between the true and calculated z coordinates as seen from ﬁgure 3b. This is due to the fact that all satellites are above the UAV, thus the DOP is higher and the error in calculated altitude is higher. The x,y coordinates are not as aﬀected as positional data is received both either side of the UAV. The clock bias were found to follow the same behaviour as the z coordinates as seen in ﬁgure 10. The discrepancy in the altitude calculations yield the non-uniform trend in the clock bias graph.

From table 1, The DOPs for the best conﬁguration are all less than 3, conﬁrming what was stated in the introduction. The GDOP was graphed vs. time along with no. of visible satellite in ﬁgure 11. The GDOP spikes whenever the number of visible satellites drops to 4. Even with 5 visible satellites, the DOP is 15-20. From ﬁgure 13 in the appendix, it is noticed that all the DOP graphs follow the same pattern, although the GDOP values attain the highest magnitude.
