Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78LGQV17660
	for linux-mips-outgoing; Wed, 8 Aug 2001 14:16:26 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78LGNV17652
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 14:16:24 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id XAA190663
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 23:16:22 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 15Uagg-00036c-00
	for <linux-mips@oss.sgi.com>; Wed, 08 Aug 2001 23:16:22 +0200
Date: Wed, 8 Aug 2001 23:16:22 +0200
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Indy 64 or 32 bit?
Message-ID: <20010808231622.H4452@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.4.33.0108081550070.24737-100000@thor.tetracon-eng.net>
User-Agent: Mutt/1.3.18i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

J. Scott Kasten wrote:
[snip]
> > I don't know how file detects this, but at least current CVS gas
> > does not set the appropriate flag in the object file header.
> 
> Gas does not apply here.  We're talking about gcc running under Irix with
> the native as and ld tools.  I'm using gcc-2.91.66 (egcs-1.1.2),
> gcc-2.95.2, MipsPro 7.30 as and ld.

Sorry, I have missed this.

> > > >
> > > > Run:
> > > >
> > > >   sizeof(int) = 8, sizeof(*) = 8
> >                     ^              ^
> > This should be both 4, I assume this happened due to -mint64.
> 
> Not totally.  -mips3 generates values of 4 and 8.  The -mint64 takes it to
> 8 and 8.  If I just invoke gcc with no -m flags, it does produce 4 and 4.

n32 ABI uses sizeof(void *) == 4, so something went wrong here.

[snip]
> Just for kicks, instead of *j = 10, which is trivial, I picked a true 64
> bit constant:

Are you a telepathic? :-)

>         sd      $2,40($fp)
>         ld      $2,40($fp)
>         dli     $3,0x807060504030201
>         sd      $3,0($2)
>         ld      $2,32($fp)
>         daddu   $3,$2,1
>         sd      $3,32($fp)
>         ld      $2,40($fp)
> 
> 
>     100012b0:   ffc20028        sd      $v0,40($s8)
>     100012b4:   dfc20028        ld      $v0,40($s8)
>     100012b8:   3c030807        lui     $v1,0x807
>     100012bc:   34630605        ori     $v1,$v1,0x605
>     100012c0:   00031c38        dsll    $v1,$v1,0x10
>     100012c4:   34630403        ori     $v1,$v1,0x403
>     100012c8:   00031c38        dsll    $v1,$v1,0x10
>     100012cc:   34630201        ori     $v1,$v1,0x201
>     100012d0:   fc430000        sd      $v1,0($v0)
>     100012d4:   dfc20020        ld      $v0,32($s8)
>     100012d8:   64430001        daddiu  $v1,$v0,1
>     100012dc:   ffc30020        sd      $v1,32($s8)
>     100012e0:   dfc20028        ld      $v0,40($s8)
> 
> Ouch that's a painfull load.  It's interesting that in both cases, it
> effectively makes the constant load a 16 bit operation, does the math 64
> bit, and stores 64 bit.

Loading constants via 16bit immediates is normal and the fastest
way on MIPS. The really interesting part is that the load avoids
clobbering $at. For superscalar processors it's faster to do e.g.

        lui     $v1,0x807
        lui     $at,$at,0x403
        ori     $v1,$v1,0x605
        ori     $at,$at,0x201
        dsll32  $v1,$v1,0x0
        or      $v1,$v1,$at

with a critical path length of 4 instead of 6.


Thiemo
