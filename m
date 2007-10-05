Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Oct 2007 13:19:39 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:53945 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021874AbXJEMTa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 Oct 2007 13:19:30 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 51FE7400CD;
	Fri,  5 Oct 2007 14:19:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id rc5TSeooEPfI; Fri,  5 Oct 2007 14:19:24 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id E37B5400E7;
	Fri,  5 Oct 2007 14:19:17 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l95CJKHv006666;
	Fri, 5 Oct 2007 14:19:20 +0200
Date:	Fri, 5 Oct 2007 13:19:17 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
In-Reply-To: <4705EFE5.7090704@gmail.com>
Message-ID: <Pine.LNX.4.64N.0710051312490.17849@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl>
 <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org>
 <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de>
 <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de>
 <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org>
 <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl>
 <4705EFE5.7090704@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4475/Fri Oct  5 10:56:58 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 5 Oct 2007, Franck Bui-Huu wrote:

> Just to be sure I haven't missed anything, it seems that we _could_ generate
> the whole tlb handler at compile time since the CPU type is known at that
> time, no need to have any fixups at runtime, isn't it ?

 The exact CPU type is not known at the moment.  For example CPU_R4X00 and 
CPU_MIPS32_R1 cover whole ranges that have subtle differences.  It may be 
possible to provide all the variations as a selection to the user, but it 
may be unfeasible -- I don't know.  Compare what we have in 
arch/mips/Kconfig with <asm/cpu.h>.

  Maciej
