pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
pi=3.1415
r1=50
r2=50
m1=10
m2=10
a1=pi/2
a2=pi/2
v1=0
v2=0
ac1=0
ac2=0
g=0.05
pa1={10,9,8}
pa2={12,14,15}

cos1 = cos function cos(angle) return cos1(angle/(pi*2)) end
sin1 = sin function sin(angle) return sin1(-angle/(pi*2)) end

function _init()
	cls()
end

function _update()
    a = -g * (2 * m1 + m2) * sin(a1);
    b = -m2 * g * sin(a1 - 2 * a2);
    c = -2 * sin(a1 - a2) * m2;
    d = v2 * v2 * r2 + v1 * v1 * r1 * cos(a1 - a2);
    e = r1 * (2 * m1 + m2 - m2 * cos(2 * a1 - 2 * a2));
    ac1 = (a + b + c * d) / e;
    a = 2 * sin(a1 - a2);
    b = (v1 * v1 * r1 * (m1 + m2));
    c = g * (m1 + m2) * cos(a1);
    d = v2 * v2 * r2 * m2 * cos(a1 - a2);
    e = r2 * (2 * m1 + m2 - m2 * cos(2 * a1 - 2 * a2));
    ac2 = (a * (b + c + d)) / e;
    v1+=ac1
    v2+=ac2
    a1+=v1
    a2+=v2
end

function _draw()
    x1=64+r1*sin(a1)
    y1=20+r1*cos(a1)
    x2=x1+r2*sin(a2)
    y2=y1+r2*cos(a2)
    --line(64,20,x1,y1,0)
    print("♥",x1,y1,pa1[flr(rnd(#pa1)+1)])
    --circfill(x1,y1,2,pa[flr(rnd(#pa-1)+1)])
    --line(x1,y1,x2,y2,0)
    print("웃",x2,y2,pa2[flr(rnd(#pa2)+1)])
    --circfill(x2,y2,2,pa[flr(rnd(#pa-1)+1)])
end


