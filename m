Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2005 16:25:43 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:6921 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225783AbVD1PZ2>; Thu, 28 Apr 2005 16:25:28 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 72F70F5B79; Thu, 28 Apr 2005 17:25:19 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 28336-02; Thu, 28 Apr 2005 17:25:19 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 0BB29F5B78; Thu, 28 Apr 2005 17:25:19 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j3SFPMNv015956;
	Thu, 28 Apr 2005 17:25:22 +0200
Date:	Thu, 28 Apr 2005 16:25:30 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	"Kevin D. Kissell" <KevinK@mips.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: preempt safe fpu-emulator
In-Reply-To: <20050428152123.GH1276@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0504281623160.31018@blysk.ds.pg.gda.pl>
References: <20050427.143622.77402407.nemoto@toshiba-tops.co.jp>
 <20050428134118.GC1276@linux-mips.org> <002d01c54bfa$5b913f80$0deca8c0@Ulysses>
 <20050428152123.GH1276@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.83/857/Thu Apr 28 08:30:10 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 28 Apr 2005, Ralf Baechle wrote:

> > When I first integrated the Algorithmics emulator with the Linux kernel
> > several years back, I tried doing something like this but ran into some
> > problem that I cannot recall exactly - there may have been some case
> > where the system expected threads to "inherit" FCSR changes.  I agree
> > that this is an obviously cleaner approach, but be careful.
> 
> The global variables definately won't fly anymore in preemptable and SMP
> kernels.  Or rather any attempt to get that to work would only make things
> worse, so they had to go.

 It depends on how they were actually used -- real FPU circuitry is 
"global", too, and somehow it works or at least it has to.

  Maciej
