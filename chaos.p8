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
n=3
prev={-1,-1}
next={-1,-1}
pa={8,9,10}

function lerp(t,a,b)
	return a+t*(b-a)
end

function initpoints()
	local i,a
	for i=0,n-1 do 
		a=i*pi2/n
		points[i] = {cx+cos(a)*r,cy+sin(a)*r}
	end
end

function _init()
	cls()
	initpoints()
	cur={rnd(128),rnd(128)}
end

function _draw()
	if time()%2==0 then
		if n==6 then n=3 initpoints() cls() 
		else n+=1 initpoints() end
	end
	for i=0,5000 do
		next=points[flr(rnd(n))]
		if next[1]!=prev[1] or next[2]!=prev[2] then
			cur[1]=lerp(0.5,cur[1],next[1])
			cur[2]=lerp(0.5,cur[2],next[2])
			pset(cur[1],cur[2],pa[1+flr(rnd(3))])
		end
		prev=next
	end
end
