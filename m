Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Dec 2002 11:36:11 +0000 (GMT)
Received: from p508B51DF.dip.t-dialin.net ([IPv6:::ffff:80.139.81.223]:6295
	"EHLO p508B51DF.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225296AbSLWLed>; Mon, 23 Dec 2002 11:34:33 +0000
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:12939 "EHLO
	demo.mitica") by ralf.linux-mips.org with ESMTP id <S868818AbSLUWLK>;
	Sat, 21 Dec 2002 23:11:10 +0100
Received: by demo.mitica (Postfix, from userid 501)
	id C286DD657; Sat, 21 Dec 2002 23:14:17 +0100 (CET)
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: for poor sools with old I2 & 64 bits kernel
References: <Pine.GSO.3.96.1021221221459.7158C-100000@delta.ds2.pg.gda.pl>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <Pine.GSO.3.96.1021221221459.7158C-100000@delta.ds2.pg.gda.pl>
Date: 21 Dec 2002 23:14:17 +0100
Message-ID: <m2fzsrdnpi.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "maciej" == Maciej W Rozycki <macro@ds2.pg.gda.pl> writes:

maciej> On 21 Dec 2002, Juan Quintela wrote:
>> BTW, are you using mips64 in a r4k? If so, do you need any additional
>> patches?

maciej> Yep, for quite some time now, running a DECstation 5000/260 with an
maciej> R4400SC.  Yep, a few. 

Here it is bigendian (SGI Indigo 2).

ARCH: SGI-IP22                                                                  
PROMLIB: ARC firmware Version 1 Revision 10                                     
CPU: MIPS-R4400 FPU<MIPS-R4400FPC> ICACHE DCACHE SCACHE                         
CPU revision is: 00000450                                                       
FPU revision is: 00000500                                                       
Primary instruction cache 16kb, linesize 16 bytes.                              
Primary data cache 16kb, linesize 16 bytes.                                     
Secondary cache sized at 1024K linesize 128 bytes.                              

I am using the egcs-1.1.2 from ralf for doing compiles, I think that
you have a more modern compiler, if so, I will be happy to download.

maciej> I'm merging the patches slowly, but it's not that easy.  Errata for the
maciej> R4000 and the R4400 require toolchain changes and bits in the patches
maciej> depend on fixed tools.  So chances are I won't merge everything until
maciej> changes are applied to tools. 

>> I am having some memory corruption :(

maciej> What kind of?  And what processor (PRId) have you got? 

PRid show before.

Corruption is that when I do a ssh to that host, I got parts of
/proc/ksyms into the console.


maciej> My system seems reasonably stable, but sometimes it crashes under a load.
maciej> I have yet to get at tracking the problem down.

mine in 32bits is stable, don't crash under load (not very high load
yet).  But in 64bits (with exactly the same userland) got losts of
problems.

Already found a couple of problems in c-r4k.c send to the list, and
now a couple of problems in sgiseeq.c and sgiserial.c.  Notice that I
am running that machine with nfsroot, i.e. I don't have basically more
devices than the serial console and the network card.  No real console
support and not harddisk support either.

If you have any patches, I will like to take a look.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
