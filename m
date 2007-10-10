Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2007 12:59:43 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:63375 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022032AbXJJL7f (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Oct 2007 12:59:35 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id C61304016A;
	Wed, 10 Oct 2007 13:59:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id 59WYxs-H6VI0; Wed, 10 Oct 2007 13:58:57 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 554AF400BA;
	Wed, 10 Oct 2007 13:58:57 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9ABwxod009526;
	Wed, 10 Oct 2007 13:58:59 +0200
Date:	Wed, 10 Oct 2007 12:58:56 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
In-Reply-To: <470BE1F4.3070800@gmail.com>
Message-ID: <Pine.LNX.4.64N.0710101231290.9821@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl>
 <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org>
 <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de>
 <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de>
 <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org>
 <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl>
 <4705EFE5.7090704@gmail.com> <Pine.LNX.4.64N.0710051312490.17849@blysk.ds.pg.gda.pl>
 <470A4349.9090301@gmail.com> <Pine.LNX.4.64N.0710081611460.8873@blysk.ds.pg.gda.pl>
 <470BE1F4.3070800@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4521/Wed Oct 10 09:58:01 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 9 Oct 2007, Franck Bui-Huu wrote:

> >  What would be the gain for the kernel from using "-march=4ksd" rather 
> > than "-march=mips32r2"?
> > 
> 
> It actually results in a kernel image ~30kbytes smaller for the former
> case. It has been discussed sometimes ago on this list. I'm sorry but
> I don't know why...

 Perhaps the pipeline description for the 4KSd CPU is different from the 
default for the MIPS32r2 ISA.  Barring a study of GCC sources, if that 
really troubles you, you could build the same version of the kernel with 
these options:

1. "-march=mips32r2"

2. "-march=4ksd"

3. "-march=mips32r2 -mtune=4ksd"

and compare the results.  I expect the results of #2 and #3 to be the same 
and it would just back up my suggestion about keeping CPU-specific 
optimisations separate from the CPU selection.  Please also note that our 
optimisation model is for speed (-O2) rather than size (-Os), so if 
"-mtune=4ksd" yields smaller code than "-mtune=mips32r2", it just means it 
is safe for this CPU to shrink code where appropriate without losing 
performance.  One obvious place for such a choice is the use of the 
hardware multiplier vs shifts and additions where one multiplicand is a 
constant.

> >  What if you want to run a single kernel image regardless of the CPU 
> > installed in the system.  Rebuilding the kernel (or having to keep a large 
> > collection of binaries) just because you want to swap the CPU does not 
> > seem like a terribly attractive idea.  Some systems come with their CPU(s) 
> > on a daughtercard (each), you know...
> > 
> 
> ok, I wasn't aware about this. You could have started by this point ;)

 Well, daughtercards for CPUs are so common for me -- the vast majority of 
MIPS-based systems I use have them -- that I have assumed, obviously 
incorrectly, that you see a benefit from such a rewrite of the TLB 
exception handlers which is large enough to justify the inconvenience of 
limiting the kernel to a given CPU card.

> So now I think the right direction is to stick with tlbex.c and
> make it smaller like Ralf did.

 That is certainly a good idea.

  Maciej
