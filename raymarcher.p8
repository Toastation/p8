pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

pi=3.14159265
max_marching_steps = 20
min_dist = 0
max_dist = 100
epsilon = 0.1
eye = {0, 0, 100}

function tan(a) 
    return sin(a)/cos(a) 
end

function torad(a)
    return a*pi/180
end

function length(v)
    return sqrt(v[1]*v[1]+v[2]*v[2]+v[3]*v[3])
end

function norm(v)
    local l=length(v)
    return {v[1]/l,v[2]/l,v[3]/l}
end

function add(v1,v2)
    return {v1[1]+v2[1],v1[2]+v2[2],v1[3]+v2[3]}
end


function sub(v1,v2)
    return {v1[1]-v2[1],v1[2]-v2[2],v1[3]-v2[3]}
end

function mul(v1,v2)
    return {v1[1]*v2[1],v1[2]*v2[2],v1[3]*v2[3]}
end

function addcst(v,c)
    return {v[1]+c,v[2]+c,v[3]+c}
end

function subcst(v,c)
    return {v[1]-c,v[2]-c,v[3]-c}
end

function mulcst(v,c)
    return {v[1]*c,v[2]*c,v[3]*c}
end

function spheresdf(p)
    return length(p)-1
end

function scenesdf(p)
    return spheresdf(p)
end

function shortestdist(eye,dir,s,e)
    local depth=s
    local dist=0
    for i=1,max_marching_steps do
        dist=scenesdf(add(eye, mulcst(dir, depth)))
        if dist<epsilon then return depth end
        depth+=dist
        if depth>=e then return e end
    end
    return e
end

function raydir(fov,x,y)
    local z=128/tan((fov*pi/180) / 2)
    return norm({x,y,z})
end

function _init()
    cls()
    local x,y,r,d,c
    for x=0,127 do
        for y=0,127 do
            r=raydir(45,x,y)
            d=shortestdist(eye,r,min_dist,max_dist)
            -- print("d="..d.." x="..x.." y="..y)
            if d>max_dist-epsilon then c=0
            else c=8 end
            pset(x,y,c)
            -- circfill(x,y,2,c)
        end
    end
end

function _draw()

end