Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 16:02:46 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:36080 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28574371AbYHSPCj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 16:02:39 +0100
Received: from localhost (p6195-ipad311funabasi.chiba.ocn.ne.jp [123.217.216.195])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 80BFCB6B9; Wed, 20 Aug 2008 00:02:32 +0900 (JST)
Date:	Wed, 20 Aug 2008 00:02:36 +0900 (JST)
Message-Id: <20080820.000236.93205674.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	ricmm@gentoo.org, yoichi_yuasa@tripeaks.co.jp,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] vr41xx: fix problem with vr41xx_cpu_wait
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080806171531.GA5848@linux-mips.org>
References: <20080806161710.GA22957@woodpecker.gentoo.org>
	<20080807.021057.59650770.anemo@mba.ocn.ne.jp>
	<20080806171531.GA5848@linux-mips.org>
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
X-archive-position: 20276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 6 Aug 2008 18:15:31 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > http://www.linux-mips.org/archives/linux-mips/2007-11/msg00123.html
> > 
> > To support vr41's standby instruction in same way, we might have to
> > synthesise rollback_handle_int, etc. or r4k_wait at runtime...
> 
> The infrastructure for that is now there :-)  Another question of course
> is if that stuff really deserve this ultimate degree of optimization.

Well, this patch on top of my patch might be enough.

--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -152,7 +152,7 @@ LEAF(r4k_wait)
 	.set	push
 	.set	noat
 	MFC0	k0, CP0_EPC
-	PTR_LA	k1, r4k_wait
+	PTR_L	k1, cpu_wait
 	ori	k0, 0x1f	/* 32 byte rollback region */
 	xori	k0, 0x1f
 	bne	k0, k1, 9f

Of course old_vr41xx_cpu_wait should be modified as like as r4k_wait
and "rollback = (cpu_wait == r4k_wait)" lines in traps.c should be
changed...

---
Atsushi Nemoto
