Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6V82MQ08763
	for linux-mips-outgoing; Tue, 31 Jul 2001 01:02:22 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6V82KV08754
	for <linux-mips@oss.sgi.com>; Tue, 31 Jul 2001 01:02:20 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA19555;
	Tue, 31 Jul 2001 01:02:11 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA22349;
	Tue, 31 Jul 2001 01:02:08 -0700 (PDT)
Message-ID: <001f01c11997$bf9a4880$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: <ppopov@pacbell.net>, "Ralf Baechle" <ralf@uni-koblenz.de>
Cc: <linux-mips@oss.sgi.com>
References: <3B664857.4040100@pacbell.net>
Subject: Re: r4600 flag
Date: Tue, 31 Jul 2001 10:06:35 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> in arch/mips/Makefile, we use the -mcpu=r4600 flag for MIPS32. What's 
> interesting is that the use of this flag can cause the toolchain to 
> generate incorrect code. For example:
> 
> la k0, 1f
> nop
> 1: nop
> 
> 
> The la macro is split into a lui and a daddiu. The daddiu is not correct 
> for a mips32 cpu.  Getting rid of the -mcpu=4600 fixes the problem and 
> the daddiu is then changed addiu.

Using mips-linux-gcc from egcs-2.91.66, I don't see exactly this
behavior in the test case above.  I *do* see that *if* I have -mcpu=4600
set *and* I have not otherwise set the ISA level to be MIPS I or
MIPS II (-mips1, -mips2), 64-bit instructions will be emitted.
But that's to be expected.  To generate 32-bit code for an
R4600-like platform, you need to specify both the ISA level
(to deal with issues like the above) and the R4600 pipeline
(to get the MAD instruction).  One place where care must
be exercised is in MIPS32 exception handlers, where eret 
must be used.  Prior to MIPS32, eret implied MIPS III which 
implied a 64-bit CPU, and the Linux compilers still see
things that way.  If the whole module is built with -mips3,
one does risk seeing some cursed macro expansions.
Until we get proper support for MIPS32 integrated into
the standard Linux tool chain (see below), the most 
correct option would be to build with -mips2 and to use
explicit ".set mips3/.set mips0" directives.

> Is there a truly correct -mcpu option for a mips32 cpu?

It's "-mips32", which is sort of a -mips option and a -mcpu
option rolled into one.  It's supported by several gnu distributions,
notably those of Algorithmics and Cygnus/Red Hat.  I believe
that someone at MIPS or Algorithmics succeeded in building
a Linux kernel of some description using the Algorithmics
SDE, but I don't know the details.

            Regards,

            Kevin K.
