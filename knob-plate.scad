// (c)2021 by David Reader
//
// This work is licensed under a Creative Commons
// Attribution-ShareAlike 4.0 International License.
//
// You should have received a copy of the license along
// with this work.
// If not, see http://creativecommons.org/licenses/by-sa/4.0/


// hole to fit in
hole_r=13.7;
hole_d=2;

// backing plate
plate_r=18;
plate_d=3;

// sloped hex key
key_h=0.4; // raise base of key slightly
key_base=9.5; // receptacle is 10
key_slope=0.25; // r2 = r1 - slope * length
key_length=6.5; // receptacle is 8

// screw hole
fix_r=3.2; // clearance for M6, holes print slightly small
recess_r1=6.5; // clearance for countersunk screw face
recess_r2=0; // countersink=0 (for counterbore =recess_r1)
recess_d=recess_r1*tan(60); // 60 degree angle for countersink


over=0.1;
d_tot=plate_d+key_h+hole_d+8;
echo("Total Height (countersunk screw length more than): ", d_tot);
echo("(counterbore only) Screw Length more than: ", d_tot-recess_d);

difference() {
    union() {
        cylinder(r=plate_r,h=plate_d+over,$fn=90);
        translate([0,0,plate_d]) cylinder(r=hole_r,h=hole_d+over,$fn=90);
        translate([0,0,plate_d+hole_d]) cylinder(r=key_base, h=key_h+over, $fn=6);
        translate([0,0,plate_d+hole_d+key_h]) cylinder(r1=key_base, r2=key_base-key_slope*key_length, h=key_length, $fn=6);
    }
        translate([0,0,-over]) cylinder(r1=recess_r1, r2=recess_r2,h=recess_d+over,$fn=90);
        translate([0,0,-over]) cylinder(r=fix_r,h=d_tot+2*over,$fn=90);

}
