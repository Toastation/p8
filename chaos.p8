pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
points = {}
pi2=2*3.1415
cos1 = cos function cos(angle) return cos1(angle/(pi2)) end
sin1 = sin function sin(angle) return sin1(-angle/(pi2)) end
cx=64
cy=64
r=60
n=4
icur=-1
next={-1,-1}
pa={8,9,10,11}

function lerp(t,a,b)
	return a+t*(b-a)
end

function initpoints()
	points[0]={0,0}
	points[1]={128,0}
	points[2]={128,128}
	points[3]={0,128}
end

function _init()
	cls()
	initpoints()
	icur=flr(rnd(n))
	cur={points[icur][1],points[icur][2]}
end

function _draw()
	for i=0,5000 do
		icur+=flr(rnd(3))-1
		if icur<0 then icur=n-1
		elseif icur>=n then icur=0 end
		next=points[icur]
		cur[1]=lerp(0.5,cur[1],next[1])
		cur[2]=lerp(0.5,cur[2],next[2])
		pset(cur[1],cur[2],pa[icur+1])
	end
end
