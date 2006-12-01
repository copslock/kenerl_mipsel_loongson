Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 15:08:15 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:47586 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038324AbWLAPIJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2006 15:08:09 +0000
Received: from localhost (p7250-ipad213funabasi.chiba.ocn.ne.jp [124.85.72.250])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 4DC4AC15F; Sat,  2 Dec 2006 00:08:04 +0900 (JST)
Date:	Sat, 02 Dec 2006 00:08:03 +0900 (JST)
Message-Id: <20061202.000803.05599975.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] use generic_handle_irq, handle_level_irq,
 handle_percpu_irq
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061114.011318.99611303.anemo@mba.ocn.ne.jp>
References: <20061114.011318.99611303.anemo@mba.ocn.ne.jp>
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
X-archive-position: 13297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 14 Nov 2006 01:13:18 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> Further incorporation of generic irq framework.  Replacing __do_IRQ()
> by proper flow handler would make the irq handling path a bit simpler
> and faster.
> 
> * use generic_handle_irq() instead of __do_IRQ().
> * use handle_level_irq for obvious level-type irq chips.
> * use handle_percpu_irq for irqs marked as IRQ_PER_CPU.
> * setup .eoi routine for irq chips possibly used with handle_percpu_irq.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
>  arch/mips/dec/ioasic-irq.c                               |    6 ++++--

Does somebody tried this patch on decstation?  I'm afraid this patch
broke it.  While ioasic_dma_irq_type's .end routine
end_ioasic_dma_irq() is doing something special, it should not be
handled correctly by handle_level_irq.  Here is a patch revert that
part.


Subject: do not use handle_level_irq for ioasic_dma_irq_type.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/dec/ioasic-irq.c b/arch/mips/dec/ioasic-irq.c
index 269b22b..e21476d 100644
--- a/arch/mips/dec/ioasic-irq.c
+++ b/arch/mips/dec/ioasic-irq.c
@@ -106,8 +106,7 @@ void __init init_ioasic_irqs(int base)
 		set_irq_chip_and_handler(i, &ioasic_irq_type,
 					 handle_level_irq);
 	for (; i < base + IO_IRQ_LINES; i++)
-		set_irq_chip_and_handler(i, &ioasic_dma_irq_type,
-					 handle_level_irq);
+		set_irq_chip(i, &ioasic_dma_irq_type);
 
 	ioasic_irq_base = base;
 }
