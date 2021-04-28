r=18; // overall knob radius
h=25; // overall knob height
$fn=30;

top_radius=3; // radius on top edge
hole=2.7; // M6 tap drill is 5mm, but holes print slightly small
hole_depth=h-5; // stop 5mm from top face

taper=1; // top radius 1mm less than base
rib_size=1.5;

// sloped hex key
key_base=10; // fitting part is 9.5
key_slope=0.25; // r2 = r1 - slope * length
key_length=8; // fitting part is less

echo("Screw depth less than: ", hole_depth-key_length);

module ribs(nr=24, dia=r, height=h, size=3, offset=0) {
    for (a=[0:360/nr:360]) {
        translate([dia*sin(a),dia*cos(a),size+offset])
            union(){
                sphere(r=size);
                cylinder(r=size,h=height);
//                translate([0,0,height+size])
//                    sphere(r=size*2.5);
            }
    }
}


module knob(r1=1,r2=r,h=h,curve=2) {
    hull() {
        rotate_extrude(convexity = 10, $fn = 90)
            translate([r2-curve, h-curve, 0])
                circle(r = curve, $fn = 60);
        cylinder(r=r1,h=1, $fn=90);
    }
}


difference(){
//    cylinder(r1=r,r2=r-taper,h=h);
    knob(r1=r, r2=r-taper, curve=top_radius);
    translate([0,0,-0.1]) cylinder(r1=key_base, r2=key_base-key_slope*key_length, h=key_length, $fn=6);
    cylinder(r=hole,h=hole_depth,$fn=360);
    ribs(nr=24,size=rib_size,offset=1.5, height=h-1.5);
}
