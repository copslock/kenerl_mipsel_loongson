Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 16:36:45 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:47840 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20026310AbXJDPgN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 16:36:13 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 44CD2400A8;
	Thu,  4 Oct 2007 17:35:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id VwSTIO4Kfaxq; Thu,  4 Oct 2007 17:35:40 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 30CFA40095;
	Thu,  4 Oct 2007 17:35:40 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l94FZiaG001655;
	Thu, 4 Oct 2007 17:35:44 +0200
Date:	Thu, 4 Oct 2007 16:35:39 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
In-Reply-To: <20071004153008.GE6897@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0710041631080.10573@blysk.ds.pg.gda.pl>
References: <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org>
 <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de>
 <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de>
 <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org>
 <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl>
 <20071004153008.GE6897@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4471/Thu Oct  4 15:22:27 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 4 Oct 2007, Ralf Baechle wrote:

> >  I agree the inclusion both R3k and R4k handlers at the same time even 
> > though any configuration predetermines which of the two is only going to 
> > be needed is a bit suboptimal indeed.
> 
> I guess one of the goals was to slowly clean up the stuff that forces us
> to have different kernels for R2000 and R4000 class TLBs.

 Well, we had a plan to support multiple systems with a "generic" kernel 
too; at least ones that have a compatible load address.  Which would help 
distributions create their bootstrap disks for example.  I have thought 
all of this got abandoned at one point, mostly due to the maintenance 
effort required to keep it going long-term.  The Alpha port did it many 
years ago, but they have a compatible bootstrap environment and their 
number of system variations is limited, especially as compared to ours.

  Maciej
