Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78KDGJ07410
	for linux-mips-outgoing; Wed, 8 Aug 2001 13:13:16 -0700
Received: from thor ([207.246.91.243])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78KDDV07397
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 13:13:13 -0700
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id QAA24834; Wed, 8 Aug 2001 16:12:39 -0400
Date: Wed, 8 Aug 2001 16:12:39 -0400
From: "J. Scott Kasten" <jsk@tetracon-eng.net>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Indy 64 or 32 bit?
In-Reply-To: <20010808174142.F4452@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.SGI.4.33.0108081550070.24737-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Wed, 8 Aug 2001, Thiemo Seufer wrote:

> Ralf Baechle wrote:
> > On Wed, Aug 08, 2001 at 11:02:44AM -0400, J. Scott Kasten wrote:
> >
> > >    gcc -mips3 -mint64 test.c -o test
> > >
> > > The file command says:
> > >
> > >   test:           ELF N32 MSB mips-3 dynamic executable (not stripped) MIPS - version 1
>                           ^^^
> I don't know how file detects this, but at least current CVS gas
> does not set the appropriate flag in the object file header.

Gas does not apply here.  We're talking about gcc running under Irix with
the native as and ld tools.  I'm using gcc-2.91.66 (egcs-1.1.2),
gcc-2.95.2, MipsPro 7.30 as and ld.

> > >
> > > Run:
> > >
> > >   sizeof(int) = 8, sizeof(*) = 8
>                     ^              ^
> This should be both 4, I assume this happened due to -mint64.

Not totally.  -mips3 generates values of 4 and 8.  The -mint64 takes it to
8 and 8.  If I just invoke gcc with no -m flags, it does produce 4 and 4.

> > > If we look at the assembly, we see a sign extended 64 bit load, and a 64
> > > bit add.  So we are indeed generating 64 bit instructions, at least in
> > > some cases.
> > >
> > >         dli $3,0xa # 10
>
> To what does this dli get expanded? I'm interested in the output of
> objdump -d.


test.S

        sd      $2,40($fp)
        ld      $2,40($fp)
        dli     $3,0xa          # 10
        sd      $3,0($2)
        ld      $2,32($fp)
        daddu   $3,$2,1
        sd      $3,32($fp)
        ld      $2,40($fp)

objdump -d

    100012b0:   ffc20028        sd      $v0,40($s8)
    100012b4:   dfc20028        ld      $v0,40($s8)
    100012b8:   2403000a        li      $v1,10
    100012bc:   fc430000        sd      $v1,0($v0)
    100012c0:   dfc20020        ld      $v0,32($s8)
    100012c4:   64430001        daddiu  $v1,$v0,1
    100012c8:   ffc30020        sd      $v1,32($s8)
    100012cc:   dfc20028        ld      $v0,40($s8)


Just for kicks, instead of *j = 10, which is trivial, I picked a true 64
bit constant:

        sd      $2,40($fp)
        ld      $2,40($fp)
        dli     $3,0x807060504030201
        sd      $3,0($2)
        ld      $2,32($fp)
        daddu   $3,$2,1
        sd      $3,32($fp)
        ld      $2,40($fp)


    100012b0:   ffc20028        sd      $v0,40($s8)
    100012b4:   dfc20028        ld      $v0,40($s8)
    100012b8:   3c030807        lui     $v1,0x807
    100012bc:   34630605        ori     $v1,$v1,0x605
    100012c0:   00031c38        dsll    $v1,$v1,0x10
    100012c4:   34630403        ori     $v1,$v1,0x403
    100012c8:   00031c38        dsll    $v1,$v1,0x10
    100012cc:   34630201        ori     $v1,$v1,0x201
    100012d0:   fc430000        sd      $v1,0($v0)
    100012d4:   dfc20020        ld      $v0,32($s8)
    100012d8:   64430001        daddiu  $v1,$v0,1
    100012dc:   ffc30020        sd      $v1,32($s8)
    100012e0:   dfc20028        ld      $v0,40($s8)

Ouch that's a painfull load.  It's interesting that in both cases, it
effectively makes the constant load a 16 bit operation, does the math 64
bit, and stores 64 bit.
