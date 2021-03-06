pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
width=128
fs=16 --feature size
size=width*width
screen={}
colors={1,13,12,11,10,9,8}
scolors=#colors

function sample(x,y)
	-- if a is a power of 2 then band(a,b-1) == mod(a,b) 
	return screen[band(x,width-1)+band(y, width-1)*width]
end

function set_sample(x,y,v)
	screen[band(x,width-1)+band(y, width-1)*width]=v
end

function get_color(v,ma,mi)
	d=(ma-mi)/scolors
	i=1+flr((v-mi)/d)
	return colors[i]
end

function diamond(x,y,s,v)
	hs=flr(s/2)
	a=sample(x,y-hs)
	b=sample(x+hs,y)
	c=sample(x,y+hs)
	d=sample(x-hs,y)
	set_sample(x,y,(a+b+c+d)/4+v)
end

function square(x,y,s,v)
	hs=flr(s/2)
	a=sample(x-hs,y-hs)
	b=sample(x+hs,y-hs)
	c=sample(x+hs,y+hs)
	d=sample(x-hs,y+hs)
	set_sample(x,y,(a+b+c+d)/4+v)
end

function diamond_square(s,sc)
	hs=flr(s/2)
	for x=hs,width-1+hs,s do
		for y=hs,width-1+hs,s do
			square(x,y,s,(rnd(2)-1)*sc)
		end
	end
	for x=0,width-1,s do
		for y=0,width-1,s do
			diamond(x+hs,y,s,(rnd(2)-1)*sc) 
			diamond(x,y+hs,s,(rnd(2)-1)*sc)
		end
	end
end

function init_screen()
 for x=0,width-1 do	
 	for y=0,width-1 do
 		if x%fs==0 and y%fs==0 then
 			set_sample(x,y,rnd(2)-1)
 		else
 			set_sample(x,y,0)
 		end
 	end
 end
end

function run_ds()
 s=fs
 sc=1.0
 while s>1 do
 	diamond_square(s,sc)
 	s=s/2
 	sc=sc/2
 end
 -- update min/max of the array
 for i in all(screen) do
 	ma=max(ma,i)
 	mi=min(mi,i)
 end
end

function render_screen()
 init_screen()
 run_ds()
 
 --draw
 cls()
 for x=0,width-1 do
 	for y=0,width-1 do
 		c=get_color(sample(x,y),ma,mi)
 		pset(x,y,c)
 	end
 end
end

function _init()
	render_screen()
end

function _update()
	if btnp(4) then 
		render_screen()
	end
end
