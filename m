Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1JBlLE13877
	for linux-mips-outgoing; Tue, 19 Feb 2002 03:47:21 -0800
Received: from coplin19.mips.com ([80.63.7.130])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1JBl8913870
	for <linux-mips@oss.sgi.com>; Tue, 19 Feb 2002 03:47:08 -0800
Received: from localhost (kjelde@localhost)
	by coplin19.mips.com (8.11.6/8.11.6) with ESMTP id g1JAkSj26763;
	Tue, 19 Feb 2002 11:46:28 +0100
X-Authentication-Warning: coplin19.mips.com: kjelde owned process doing -bs
Date: Tue, 19 Feb 2002 11:46:28 +0100 (CET)
From: Kjeld Borch Egevang <kjelde@mips.com>
To: Zhang Fuxin <fxzhang@ict.ac.cn>
cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>,
   "libc-alpha@sources.redhat.com" <libc-alpha@sources.redhat.com>
Subject: Re: endless loop in remainder() on mips
In-Reply-To: <200202190323.g1J3Ne904847@oss.sgi.com>
Message-ID: <Pine.LNX.4.33.0202191136480.26727-100000@coplin19.mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 19 Feb 2002, Zhang Fuxin wrote:

...
> It is weird enough for me that u doesn't equal to tmp2,that is where x86 and mips differ. 
> 
> the output from my P4:
> rounding is TONEAREST
> x=(7fefffff,ffffffff),y=(00000000,00000001)
> x=(7fefffff,ffffffff),y=(04d00000,00000000)
> 1/y=7b100000,00000000
> n=04d00000,nn=06100000,ww=(00000000,00000000),w=(04d00000,00000000),l=79d00000
> u=(7fefffff,ffffffff),d=(41400000,00000000),w=(7ea00000,00000000)
> d*w=(7ff00000,00000000),u.x-d*w=(fff00000,00000000),u=(fca00000,00000000) <--notice this
> u=(fca00000,00000000),d=(c1300000,00000000),w=(7b600000,00000000)
> d*w=(fca00000,00000000),u.x-d*w=(00000000,00000000),u=(00000000,00000000)
> x=(00000000,00000000),y=(04d00000,00000000)
> 
> output from mipsel:
> rounding is TONEAREST
> x=(7fefffff,ffffffff),y=(00000000,00000001)
> x=(7fefffff,ffffffff),y=(04d00000,00000000)
> 1/y=7b100000,00000000
> n=04d00000,nn=06100000,ww=(00000000,00000000),w=(04d00000,00000000),l=79d00000
> u=(7fefffff,ffffffff),d=(41400000,00000000),w=(7ea00000,00000000)
> d*w=(7ff00000,00000000),u.x-d*w=(fff00000,00000000),u=(fff00000,00000000) <--notice this
> u=(fff00000,00000000),d=(fff00000,00000000),w=(7eb00000,00000000)
> d*w=(fff00000,00000000),u.x-d*w=(7ff7ffff,ffffffff),u=(7ff7ffff,ffffffff)
> u=(7ff7ffff,ffffffff),d=(7ff7ffff,ffffffff),w=(7eb00000,00000000)
> d*w=(7ff7ffff,ffffffff),u.x-d*w=(7ff7ffff,ffffffff),u=(7ff7ffff,ffffffff)
> u=(7ff7ffff,ffffffff),d=(7ff7ffff,ffffffff),w=(7eb00000,00000000)
> d*w=(7ff7ffff,ffffffff),u.x-d*w=(7ff7ffff,ffffffff),u=(7ff7ffff,ffffffff)
> u=(7ff7ffff,ffffffff),d=(7ff7ffff,ffffffff),w=(7eb00000,00000000)
> d*w=(7ff7ffff,ffffffff),u.x-d*w=(7ff7ffff,ffffffff),u=(7ff7ffff,ffffffff)

You're right. Not a bug. Internally your P4 uses more than 64 bits in its
calculations. Here's my test and output from my AMD, Sun and MIPS:

typedef union number_s {
    long long ll;
    double d;
} t_number;

#define P(x) printf(#x "=%e %016llx\n", x.d, x.ll)

int main()
{
    t_number u, d, w, t, r;

    u.ll = 0x7fefffffffffffff;
    d.ll = 0x4140000000000000;
    w.ll = 0x7ea0000000000000;
    t.d = d.d * w.d;
    t.d = u.d - t.d;
    r.d = (u.d - d.d * w.d);
    P(u);
    P(d);
    P(w);
    P(r);
    P(t);
}

AMD:
u=1.797693e+308 7fefffffffffffff
d=2.097152e+06 4140000000000000
w=8.572069e+301 7ea0000000000000
r=-1.995840e+292 fca0000000000000
t=-inf fff0000000000000

Sun:
u=1.797693e+308 7fefffffffffffff
d=2.097152e+06 4140000000000000
w=8.572069e+301 7ea0000000000000
r=-Inf fff0000000000000
t=-Inf fff0000000000000

MIPS:
u=1.797693e+308 7fefffffffffffff
d=2.097152e+06 4140000000000000
w=8.572069e+301 7ea0000000000000
r=-inf fff0000000000000
t=-inf fff0000000000000


/Kjeld

-- 
_    _ ____  ___                       Mailto:kjelde@mips.com
|\  /|||___)(___    MIPS Denmark       Direct: +45 44 86 55 85
| \/ |||    ____)   Lautrupvang 4 B    Switch: +45 44 86 55 55
  TECHNOLOGIES      DK-2750 Ballerup   Fax...: +45 44 86 55 56
                    Denmark            http://www.mips.com/
