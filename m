Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Dec 2002 11:36:31 +0000 (GMT)
Received: from p508B51DF.dip.t-dialin.net ([IPv6:::ffff:80.139.81.223]:6295
	"EHLO p508B51DF.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225556AbSLWLed>; Mon, 23 Dec 2002 11:34:33 +0000
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:21388 "EHLO
	delta.ds2.pg.gda.pl") by ralf.linux-mips.org with ESMTP
	id <S868820AbSLUWwu>; Sat, 21 Dec 2002 23:52:50 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id XAA11210;
	Sat, 21 Dec 2002 23:49:43 +0100 (MET)
Date: Sat, 21 Dec 2002 23:49:43 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Juan Quintela <quintela@mandrakesoft.com>
cc: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: for poor sools with old I2 & 64 bits kernel
In-Reply-To: <m2fzsrdnpi.fsf@demo.mitica>
Message-ID: <Pine.GSO.3.96.1021221231334.7158H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 21 Dec 2002, Juan Quintela wrote:

> maciej> Yep, for quite some time now, running a DECstation 5000/260 with an
> maciej> R4400SC.  Yep, a few. 
> 
> Here it is bigendian (SGI Indigo 2).

 The endianness shouldn't matter, but who knows?

> ARCH: SGI-IP22                                                                  
> PROMLIB: ARC firmware Version 1 Revision 10                                     
> CPU: MIPS-R4400 FPU<MIPS-R4400FPC> ICACHE DCACHE SCACHE                         
> CPU revision is: 00000450                                                       
> FPU revision is: 00000500                                                       
> Primary instruction cache 16kb, linesize 16 bytes.                              
> Primary data cache 16kb, linesize 16 bytes.                                     
> Secondary cache sized at 1024K linesize 128 bytes.                              

 Please get: 
'ftp://ftp.ds2.pg.gda.pl/pub/macro/linux/patch-mips-2.4.20-pre6-20021212-mips-bugs-14mod.gz'
try it and send me the boot log, specifically the bug checks.  My PRId is
00000440 and that is definitely buggy revision 1.0.  Yours is probably
revision 2.0 and should work better, but it won't hurt checking.

 Note the patch is unfinished code; I had to modify it a bit for you to
make it work at all with standard tools.  It does not necessarily make
much sense. ;-) 

> I am using the egcs-1.1.2 from ralf for doing compiles, I think that
> you have a more modern compiler, if so, I will be happy to download.

 Indeed, I use heavily patched gcc 2.95.4.  It's available at my site,
too, as RPM packages.  For mips64 there are only source and i386 binary
packages of a bootstrap cross-compiler -- look for
mips64el-linux-boot-gcc.  It should be fairly easy to build big-endian
packages from the sources.

 But there is a drawback -- the packages have a patch to handle the daddiu
erratum and the workaround is unconditional now.  The result is somewhat
worse code is emitted.

> Corruption is that when I do a ssh to that host, I got parts of
> /proc/ksyms into the console.

 SSH works just fine for me.  I haven't tried connecting over IPv6 to
64-bit Linux, though (for 32-bit version it works).

> maciej> My system seems reasonably stable, but sometimes it crashes under a load.
> maciej> I have yet to get at tracking the problem down.
> 
> mine in 32bits is stable, don't crash under load (not very high load
> yet).  But in 64bits (with exactly the same userland) got losts of
> problems.

 Well, for me the 32-bit configuration is rock-solid.  It's the 64-bit one
that causes some problems, but it's stable enough for most of the recent
package builds to be done with it.  I debugged showstopper problems last
Summer.

> Already found a couple of problems in c-r4k.c send to the list, and

 I haven't seen any problems with caching recently.  I might have been
lucky.  But my cache configuration differs a bit:

CPU revision is: 00000440
FPU revision is: 00000500
Loading R4000 MMU routines.
Primary instruction cache 16kb, linesize 16 bytes.
Primary data cache 16kb, linesize 16 bytes.
Secondary cache sized at 1024K linesize 32 bytes.

> now a couple of problems in sgiseeq.c and sgiserial.c.  Notice that I

 That's driver-specific.  The declance.c and zs.c drivers work.

> am running that machine with nfsroot, i.e. I don't have basically more
> devices than the serial console and the network card.  No real console
> support and not harddisk support either.

 Ditto here.  Except a keyboard and a framebuffer also work; the latter
also under X11. 

> If you have any patches, I will like to take a look.

 Nothing ready for inclusion.  And probably nothing critical (except for
the DECstation), but please send me the report first. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
