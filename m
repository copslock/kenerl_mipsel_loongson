Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2008 18:11:09 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:31971 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28576014AbYHFRLD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Aug 2008 18:11:03 +0100
Received: from localhost (p7186-ipad213funabasi.chiba.ocn.ne.jp [124.85.72.186])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 85C55AC02; Thu,  7 Aug 2008 02:10:56 +0900 (JST)
Date:	Thu, 07 Aug 2008 02:10:57 +0900 (JST)
Message-Id: <20080807.021057.59650770.anemo@mba.ocn.ne.jp>
To:	ricmm@gentoo.org
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] vr41xx: fix problem with vr41xx_cpu_wait
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080806161710.GA22957@woodpecker.gentoo.org>
References: <200808060440.m764eF9I021783@po-mbox303.hop.2iij.net>
	<20080806.223033.128619389.anemo@mba.ocn.ne.jp>
	<20080806161710.GA22957@woodpecker.gentoo.org>
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
X-archive-position: 20128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 6 Aug 2008 16:17:10 +0000, Ricardo Mendoza <ricmm@gentoo.org> wrote:
> I see, I hadn't read that thread before. Yoichi's rev of the patch
> should go in but we should put some effort in finding a better route for
> CPUs that are not forcefully aware by hardware of interrupts in their
> wait call.
> 
> Was some work ever done on Ralf's idea in the "WAIT vs. tickless kernel"
> ML thread? Regarding patching the return from exception code to contain
> a check for this particular loop.

Yes.  My last proposal is:

http://www.linux-mips.org/archives/linux-mips/2007-11/msg00123.html

To support vr41's standby instruction in same way, we might have to
synthesise rollback_handle_int, etc. or r4k_wait at runtime...

---
Atsushi Nemoto
