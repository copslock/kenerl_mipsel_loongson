Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 16:30:11 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:40934 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026288AbXJDPaJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 16:30:09 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l94FU8tr010473;
	Thu, 4 Oct 2007 16:30:08 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l94FU8ir010472;
	Thu, 4 Oct 2007 16:30:08 +0100
Date:	Thu, 4 Oct 2007 16:30:08 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
Message-ID: <20071004153008.GE6897@linux-mips.org>
References: <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 04, 2007 at 04:23:42PM +0100, Maciej W. Rozycki wrote:

>  The existence of the definitions in <asm/war.h> is there so that 
> workarounds for CPU bugs are optimised away at the kernel build time if 
> not activated.
> 
>  I agree the inclusion both R3k and R4k handlers at the same time even 
> though any configuration predetermines which of the two is only going to 
> be needed is a bit suboptimal indeed.

I guess one of the goals was to slowly clean up the stuff that forces us
to have different kernels for R2000 and R4000 class TLBs.

  Ralf
