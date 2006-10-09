Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2006 15:38:17 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:23014 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039672AbWJIOiM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Oct 2006 15:38:12 +0100
Received: from localhost (p4240-ipad02funabasi.chiba.ocn.ne.jp [61.207.151.240])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8BF1CA68B; Mon,  9 Oct 2006 23:38:07 +0900 (JST)
Date:	Mon, 09 Oct 2006 23:40:22 +0900 (JST)
Message-Id: <20061009.234022.07643427.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	KevinK@mips.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] ret_from_irq adjustment
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061009135332.GA14048@linux-mips.org>
References: <20061009.012423.59032950.anemo@mba.ocn.ne.jp>
	<006501c6eb07$4fbf66c0$8003a8c0@Ulysses>
	<20061009135332.GA14048@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 9 Oct 2006 14:53:33 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> ipi_decode() has lost it's pt_regs argument like most of the interrupt
> related functions, so Atushi's patch was right.  Any interrupt handler
> that wants to get a pointer to the register frame can do so by calling
> get_irq_regs().

Yes, excuse me for a terse description.

> So with Atsushi's patch applied VSMP and SMTC with only two TCs activated
> are working again.  It still crashes with 5 TCs enabled:
> 
> Cpu 1
> $ 0   : 00000000 18102000 00000000 8041ed44
> $ 4   : 00000000 00000000 8041ec88 00000000
> $ 8   : 00000000 18001c00 8010de78 80430000
> $12   : 80420000 fffffffb ffffffff 0000000a
> $16   : 00000000 00000001 8041ec04 8041ec08
> $20   : 803b0000 8041ed40 80380000 18102000
> $24   : 00000000 810c3b11
> $28   : 810c2000 810c3b58 00000100 80108bdc
> Hi    : 00000009
> Lo    : fbe7d600
> epc   : 80132b74 profile_tick+0x20/0xb4     Not tainted
> ra    : 80108bdc local_timer_interrupt+0x10/0x30
> Status: 1100a603    KERNEL EXL IE

Hmm, this would be because local_timer_interrupt was called from
ipi_decode().  Is this a proper fix?

diff --git a/arch/mips/kernel/smtc-asm.S b/arch/mips/kernel/smtc-asm.S
index 1cb9441..20938a4 100644
--- a/arch/mips/kernel/smtc-asm.S
+++ b/arch/mips/kernel/smtc-asm.S
@@ -101,7 +101,9 @@ FEXPORT(__smtc_ipi_vector)
 	lw	t0,PT_PADSLOT5(sp)
 	/* Argument from sender passed in stack pad slot 4 */
 	lw	a0,PT_PADSLOT4(sp)
-	PTR_LA	ra, _ret_from_irq
+	LONG_L	s0, TI_REGS($28)
+	LONG_S	sp, TI_REGS($28)
+	PTR_LA	ra, ret_from_irq
 	jr	t0
 
 /*
