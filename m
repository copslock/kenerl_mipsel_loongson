Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2008 17:17:21 +0100 (BST)
Received: from smtp.gentoo.org ([140.211.166.183]:49340 "EHLO smtp.gentoo.org")
	by ftp.linux-mips.org with ESMTP id S28575897AbYHFQRO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Aug 2008 17:17:14 +0100
Received: by smtp.gentoo.org (Postfix, from userid 2204)
	id 3F91065879; Wed,  6 Aug 2008 16:17:10 +0000 (UTC)
Date:	Wed, 6 Aug 2008 16:17:10 +0000
From:	Ricardo Mendoza <ricmm@gentoo.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] vr41xx: fix problem with vr41xx_cpu_wait
Message-ID: <20080806161710.GA22957@woodpecker.gentoo.org>
References: <200808060147.m761l4Is022564@po-mbox303.hop.2iij.net> <20080806020818.GA10184@woodpecker.gentoo.org> <200808060440.m764eF9I021783@po-mbox303.hop.2iij.net> <20080806.223033.128619389.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080806.223033.128619389.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <ricmm@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ricmm@gentoo.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 06, 2008 at 10:30:33PM +0900, Atsushi Nemoto wrote:
 
> > local_irq_disable() is included in the sample code on the User's Manul. 
> > I think the following patch is good way of this.
> ...
> > +static void old_vr41xx_cpu_wait(void)
> > +{
> > +	__asm__("standby;\n");
> > +}
> 
> Then, old vr41 CPUs have potential latency problem as like as other
> CPUs with WAIT instruction.
> 
> Please refer "WAIT vs. tickless kernel" thread on linux-mips ML
> archive for details.
> 
> I don't complain about this patch itself.

I see, I hadn't read that thread before. Yoichi's rev of the patch
should go in but we should put some effort in finding a better route for
CPUs that are not forcefully aware by hardware of interrupts in their
wait call.

Was some work ever done on Ralf's idea in the "WAIT vs. tickless kernel"
ML thread? Regarding patching the return from exception code to contain
a check for this particular loop.


     Ricardo
