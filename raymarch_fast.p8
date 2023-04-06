pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
pi=3.14159265
max_marching_steps = 20
min_dist = 0
max_dist = 100
epsilon = 0.001
eye = {0, 0, -3}
nohit=-1
grad={[0]=0,1,5,13,6,7}
--
function lerp(t,a,b)
	return a+t*(b-a)
end

function tan(a) 
    return sin(a)/cos(a) 
end

function torad(a)
    return a*pi/180
end

function length(v)
    return sqrt(v[1]*v[1]+v[2]*v[2]+v[3]*v[3])
end

function normalize(v)
    local l=length(v)
    return {v[1]/l,v[2]/l,v[3]/l}
end

function addvec(v1,v2)
    return {v1[1]+v2[1],v1[2]+v2[2],v1[3]+v2[3]}
end

function subvec(v1,v2)
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

function leftmul(m,v)
    return {m[1][1]*v[1]+m[1][2]*v[2]+m[1][3]*v[3],m[2][1]*v[1]+m[2][2]*v[2]+m[2][3]*v[3],m[3][1]*v[1]+m[3][2]*v[2]+m[3][3]*v[3]}
end

function dot(v1,v2)
    return v1[1]*v2[1]+v1[2]*v2[2]+v1[3]*v2[3]
end

function cross(v1,v2)
    return {v1[2]*v2[3]-v1[3]*v2[2],v1[3]*v2[1]-v1[1]*v2[3],v1[1]*v2[2]-v1[2]*v2[1]}
end
 
function raydir(u,v,eye,target)
    f=normalize(subvec(target,eye))
    r=normalize(cross({0,1,0},f))
    up=normalize(cross(f,r))
    return normalize(addvec(addvec(mulcst(r,u),mulcst(up,v)),mulcst(f,2)))
end

function spheresdf(p)
    return length(p)-1
end

function scenesdf(p)
    return spheresdf(p)
end

function normal(p)
    local d=scenesdf(p)
    local a=scenesdf(addvec(p, {0.01,0.0,0.0}))
    local b=scenesdf(addvec(p, {0.0,0.01,0.0}))
    local c=scenesdf(addvec(p, {0.0,0.0,0.01}))
    return normalize({a-d,b-d,c-d})
end

function raymarch(eye,dirvec,s,e)
    local depth=s
    local dist=0
    for i=1,max_marching_steps do
        dist=scenesdf(addvec(eye,mulcst(dirvec,depth)))
        if dist<epsilon then return depth end
        depth+=dist
        if depth>=e then return nohit end
    end
    return nohit
end

function shading(eye,p,n,lp)
    local l=normalize(subvec(lp,p))
    i=max(dot(l,n),0)
    return grad[flr(i*#grad)] --flr(i*16)
end

--
function _init()
    cls()
end
function _draw()
    local x,y,u,v,r,d,c,p,n
    local lp={1.2,0,-2}
    for i=0,256 do
        x=flr(rnd(128))
        y=flr(rnd(128))
        u=2*(x/128-0.5)
        v=2*(y/128-0.5)
        r=raydir(u,v,eye,{0.0,0.0,0.0})
        d=raymarch(eye,r,min_dist,max_dist)
        if d==nohit then
            c=12
        else 
            p=addvec(eye,mulcst(r,d))
            n=normalize(normal(p))
            c=shading(eye,p,n,lp)
        end
        print("▒",x,y,c)
    end
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
