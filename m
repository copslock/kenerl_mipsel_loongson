Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2008 14:30:41 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:55548 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28576009AbYHFNai (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Aug 2008 14:30:38 +0100
Received: from localhost (p7186-ipad213funabasi.chiba.ocn.ne.jp [124.85.72.186])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0074DADA6; Wed,  6 Aug 2008 22:30:32 +0900 (JST)
Date:	Wed, 06 Aug 2008 22:30:33 +0900 (JST)
Message-Id: <20080806.223033.128619389.anemo@mba.ocn.ne.jp>
To:	yoichi_yuasa@tripeaks.co.jp
Cc:	ricmm@gentoo.org, linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] vr41xx: fix problem with vr41xx_cpu_wait
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200808060440.m764eF9I021783@po-mbox303.hop.2iij.net>
References: <200808060147.m761l4Is022564@po-mbox303.hop.2iij.net>
	<20080806020818.GA10184@woodpecker.gentoo.org>
	<200808060440.m764eF9I021783@po-mbox303.hop.2iij.net>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 6 Aug 2008 13:42:13 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > Just now I got my hands on the manual, I can see that the standby
> > instruction sets IE bit to 1 but only on Vr4131 and Vr4181A cores, all
> > others (such as my Vr4121) need to have interrupts enabled before going
> > into standby.
> > 
> > The patch will make it work on all Vr4100 derivates, or we could also
> > add code to build the function depending on CPU type. What do you think?
> 
> local_irq_disable() is included in the sample code on the User's Manul. 
> I think the following patch is good way of this.
...
> +static void old_vr41xx_cpu_wait(void)
> +{
> +	__asm__("standby;\n");
> +}

Then, old vr41 CPUs have potential latency problem as like as other
CPUs with WAIT instruction.

Please refer "WAIT vs. tickless kernel" thread on linux-mips ML
archive for details.

I don't complain about this patch itself.
---
Atsushi Nemoto
