Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2007 17:17:44 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:33451 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021378AbXJJQRf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Oct 2007 17:17:35 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 8745F400BA;
	Wed, 10 Oct 2007 18:17:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id 5QaC4lV7Wgml; Wed, 10 Oct 2007 18:17:30 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 75322400D3;
	Wed, 10 Oct 2007 18:17:25 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9AGHTcn030980;
	Wed, 10 Oct 2007 18:17:29 +0200
Date:	Wed, 10 Oct 2007 17:17:24 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Franck Bui-Huu <fbuihuu@gmail.com>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/6] tlbex.c: Remove relocs[] and labels[] from the
 init.data section
In-Reply-To: <20071010142755.GA9325@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0710101715380.9821@blysk.ds.pg.gda.pl>
References: <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de>
 <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de>
 <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org>
 <4705004C.5000705@gmail.com> <20071005115151.GA16145@linux-mips.org>
 <470BE58A.9070709@gmail.com> <470BE61F.5020108@gmail.com>
 <20071010142755.GA9325@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4521/Wed Oct 10 09:58:01 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 10 Oct 2007, Ralf Baechle wrote:

> > It increases the stack pressure a lot (more than 2500 bytes) but
> > at this stage in the boot process, it shouldn't matter.
> 
> Even more for 64-bit kernel - and I would really like to keep reduce
> the kernel stack for 64-bit kernels, THREAD_SIZE_ORDER 2 is already
> slightly painful when memory becomes fragmented.

 I think the right fix is to implement "__initbss" along the lines of 
"__initdata".

  Maciej
