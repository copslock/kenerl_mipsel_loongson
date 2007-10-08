Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2007 16:39:55 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:48269 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022520AbXJHPjq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Oct 2007 16:39:46 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 60A0840252;
	Mon,  8 Oct 2007 17:39:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id xFTIAh8YG1wV; Mon,  8 Oct 2007 17:39:39 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id A22EB4024F;
	Mon,  8 Oct 2007 17:39:39 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l98Fdhwf016336;
	Mon, 8 Oct 2007 17:39:43 +0200
Date:	Mon, 8 Oct 2007 16:39:38 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
In-Reply-To: <470A4349.9090301@gmail.com>
Message-ID: <Pine.LNX.4.64N.0710081611460.8873@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl>
 <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org>
 <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de>
 <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de>
 <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org>
 <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl>
 <4705EFE5.7090704@gmail.com> <Pine.LNX.4.64N.0710051312490.17849@blysk.ds.pg.gda.pl>
 <470A4349.9090301@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4503/Mon Oct  8 15:16:03 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 8 Oct 2007, Franck Bui-Huu wrote:

> Well, having all cpu variations in Kconfig should be technically
> possible. The user needs to know what exact cpu is running on which
> doesn't sound impossible and we could add some sanity checkings to
> ensure he doesn't messed up its configuration.

 As long as the user is indeed capable of knowing what the exact CPU type 
is.  I have been told replacing R4X00 with a choice like R4000, R4400, 
R4600, R4700 may already be too much of a hassle.

 Frankly I am not entirely confident much choice beyond the ISA level is 
actually a good idea.  We do have it, because lots of bits depend on 
preprocessor conditionals even though they not necessarily should.  There 
are probably some historical reasons too.  But essentially we have about 
eight ISA variations (I - IV and four MIPS Architecture ISAs) and about 
four privileged resource architecture variations (R2000, R6000, R4000, 
R8000); not all combinations making sense and some of the choices actually 
not supported at all.

 CPU variations matter performance-wise, but the use of "-mtune=" is 
irrelevant in this context.

> BTW, we could pass more cpu compiler options for optimization this
> way. For example, when using a '4ksd' cpu, we currently can't pass
> '-march=4ksd' to gcc since the cpu type used for it is 'mips32r2'. And
> I guess it's true for all cpu types which cover a range of slightly
> different processors (r4x00 comes in mind).

 What would be the gain for the kernel from using "-march=4ksd" rather 
than "-march=mips32r2"?

> OTOH, I don't know if it can work on SMP: if the system needs 2
> different implementations of the handler (I don't know if it can
> happen though), we must be able to select 2 different cpu types in
> Kconfig...

 I do not think we happen to handle this scenario -- the more interesting 
configurations that could benefit do not support the cp0.ebase register 
making per-CPU handlers quite a challenge (i.e. the cost would exceed the 
benefit).

> Do you see any other points that we should consider before trying to
> use static handlers ? Some other cpu features influencing the tlb
> handler generations and that can be found only at runtime ?

 What if you want to run a single kernel image regardless of the CPU 
installed in the system.  Rebuilding the kernel (or having to keep a large 
collection of binaries) just because you want to swap the CPU does not 
seem like a terribly attractive idea.  Some systems come with their CPU(s) 
on a daughtercard (each), you know...

  Maciej
