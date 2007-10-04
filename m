Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 18:34:50 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:50567 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20026391AbXJDRel (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 18:34:41 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 2A67340111;
	Thu,  4 Oct 2007 19:34:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id t7JIx7N7wKfX; Thu,  4 Oct 2007 19:34:05 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id C384340095;
	Thu,  4 Oct 2007 19:34:05 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l94HYAxn026265;
	Thu, 4 Oct 2007 19:34:10 +0200
Date:	Thu, 4 Oct 2007 18:34:04 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
In-Reply-To: <20071004154215.GA10682@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0710041739400.10573@blysk.ds.pg.gda.pl>
References: <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de>
 <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de>
 <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org>
 <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl>
 <20071004153008.GE6897@linux-mips.org> <Pine.LNX.4.64N.0710041631080.10573@blysk.ds.pg.gda.pl>
 <20071004154215.GA10682@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4471/Thu Oct  4 15:22:27 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 4 Oct 2007, Ralf Baechle wrote:

> Anything in excessive amounts is toxic and that includes compatibility.
> A true MIPS generic kernel would be hard to do.  But we have kernels that
> can support all variants of the Malta even though Malta has more CPU options

 Have the issues been fixed?  I recall there was a problem with FPU 
context switching which would not let a MIPS IV Malta kernel (needed for 
all the old QED CPU core cards) run with a MIPS32r2 core.

> than any other system.  Or for your personal toy project, all DECs wouldn't
> be too hard either, or?

 The DECs should be reletively easy if we finally managed to get rid of 
all the 64-bit-isms in the 32-bit kernel even if built for MIPS III or 
above.  Which, given the recent commitment to 32-bit cores is what I would 
actually expect.

  Maciej
