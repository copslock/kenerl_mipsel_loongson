Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2007 17:42:40 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:45003 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021563AbXJJQmi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Oct 2007 17:42:38 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9AGgbfn013007;
	Wed, 10 Oct 2007 17:42:37 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9AGgaTM013006;
	Wed, 10 Oct 2007 17:42:36 +0100
Date:	Wed, 10 Oct 2007 17:42:36 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Franck Bui-Huu <fbuihuu@gmail.com>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/6] tlbex.c: Remove relocs[] and labels[] from the
	init.data section
Message-ID: <20071010164236.GB10243@linux-mips.org>
References: <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <20071005115151.GA16145@linux-mips.org> <470BE58A.9070709@gmail.com> <470BE61F.5020108@gmail.com> <20071010142755.GA9325@linux-mips.org> <Pine.LNX.4.64N.0710101715380.9821@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710101715380.9821@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 10, 2007 at 05:17:24PM +0100, Maciej W. Rozycki wrote:

> > > It increases the stack pressure a lot (more than 2500 bytes) but
> > > at this stage in the boot process, it shouldn't matter.
> > 
> > Even more for 64-bit kernel - and I would really like to keep reduce
> > the kernel stack for 64-bit kernels, THREAD_SIZE_ORDER 2 is already
> > slightly painful when memory becomes fragmented.
> 
>  I think the right fix is to implement "__initbss" along the lines of 
> "__initdata".

Indeed.  Doesn't even look so hard and would likely generally be welcome.

  Ralf
