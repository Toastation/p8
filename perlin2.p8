pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
permutation={151,160,137,91,90,15,         
    131,13,201,95,96,53,194,233,7,225,140,36,103,30,69,142,8,99,37,240,21,10,23,    
    190, 6,148,247,120,234,75,0,26,197,62,94,252,219,203,117,35,11,32,57,177,33,
    88,237,149,56,87,174,20,125,136,171,168, 68,175,74,165,71,134,139,48,27,166,
    77,146,158,231,83,111,229,122,60,211,133,230,220,105,92,41,55,46,245,40,244,
    102,143,54, 65,25,63,161, 1,216,80,73,209,76,132,187,208, 89,18,169,200,196,
    135,130,116,188,159,86,164,100,109,198,173,186, 3,64,52,217,226,250,124,123,
    5,202,38,147,118,126,255,82,85,212,207,206,59,227,47,16,58,17,182,189,28,42,
    223,183,170,213,119,248,152, 2,44,154,163, 70,221,153,101,155,167, 43,172,9,
    129,22,39,253, 19,98,108,110,79,113,224,232,178,185, 112,104,218,246,97,228,
    251,34,242,193,238,210,144,12,191,179,162,241, 81,51,145,235,249,14,239,107,
    49,192,214, 31,181,199,106,157,184, 84,204,176,115,121,50,45,127, 4,150,254,
    138,236,205,93,222,114,67,29,24,72,243,141,128,195,78,66,215,61,156,180
}
p={}
fade={}
pa1={12,7}
pa2={7,8,9,10,}
pa3={0,1,13,6,7}
pa4={0,1,2,4,9}
pa={pa1}
pi=3.141592
pi2=2*pi
cx=64
cy=64
phase=0
zo=0
count=0
countt=0

function init()
 for i=0,255 do
 	local t=shr(i,8) --0...1
 	fade[t]=t*t*t*(t*(t*6-15)+10)
 	p[i]=permutation[i+1]
 	p[256+i]=permutation[i+1]
 end
end

function lerp(t,a,b)
	return a+t*(b-a)
end

function grad(hash,x,y,z)
	local h=band(hash,15)
	local u,v,d
	if h<8 then u=x else u=y end
	if h<4 then v=y elseif h==12 or h==14 then v=x else v=z end
	if band(h,1)==0 then d=u else d=-u end
	if band(h,2)==0 then d=d+v else d=d-v end
	return d
end

function perlin(x,y,z)
	local xi=band(x,255)
	local yi=band(y,255)
	local zi=band(z,255)
	local xf=band(x,0x0.ff)
	local yf=band(y,0x0.ff)
	local zf=band(z,0x0.ff)
	local u=fade[xf]
	local v=fade[yf]
	local w=fade[zf]
	local a=p[xi]+yi
	local aa=p[a]+zi
	local ab=p[a+1]+zi
	local b=p[xi+1]+yi
	local ba=p[b]+zi
	local bb=p[b+1]+zi
	return lerp(w,lerp(v,lerp(u,grad(p[aa],xf,yf,zf),
                              grad(p[ba],xf-1,yf,zf)),
                       lerp(u,grad(p[ab],xf,yf-1,zf),
                              grad(p[bb],xf-1,yf-1,zf))),
                lerp(v,lerp(u,grad(p[aa+1],xf,yf,zf-1),
                              grad(p[ba+1],xf-1,yf,zf-1)),
                       lerp(u,grad(p[ab+1],xf,yf-1,zf-1),
                              grad(p[bb+1],xf-1,yf-1,zf-1))))
end

function maprange(v,a,b,c,d)
	return c+((v-a)*(d-c))/(b-a)
end

function _init()
	init()

end

function _update()
  	countt+=0.05
	if countt>8 then countt=0 count+=1 end
end

function _draw() 
	--cls()
	-- water
	local x,y,n,c,s,t,pi,char
	t=time()
	pi=flr(count%(#pa)+1)
	for i=1,256 do
		x=rnd(128)
		y=rnd(128)
		n=perlin(x/60+t/60,y/50+t/60,t/4)
		n=(n+1)/2
		if n>0.75 then 
			c=7
			char="█"
		elseif n>0.7 then
			c=7
			char="ˇ"
		else
			c=12
			char="█" 
		end
		print(char,x,y,c)
	end
	
	-- rubber band
	local r,xo,yo,offx,offy
	offx=sin(t/5)
	offy=sin(t/3+0.2)
	--for i=0,pi2,0.015 do
		--xo=maprange(cos(i+phase),-1,1,0,5)
  --yo=maprange(sin(i+phase),-1,1,0,5)
		--r=maprange(perlin(xo,yo,zo),-1,1,25,35)
		--x=cx+r*cos(i)+offx
		--y=cy+r*sin(i)+offy
		--circfill(x,y,2,8)
	--end
	phase+=0.003
	zo+=0.08
end
