Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Nov 2007 15:39:36 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:10950 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20025821AbXKVPj1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Nov 2007 15:39:27 +0000
Received: from localhost (p8045-ipad307funabasi.chiba.ocn.ne.jp [123.217.186.45])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D7C889521; Fri, 23 Nov 2007 00:39:20 +0900 (JST)
Date:	Fri, 23 Nov 2007 00:41:32 +0900 (JST)
Message-Id: <20071123.004132.61510296.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [MIPS] irq_cpu: use handle_percpu_irq handler to avoid
 dropping interrupts.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S20032632AbXKOURg/20071115201736Z+24020@ftp.linux-mips.org>
References: <S20032632AbXKOURg/20071115201736Z+24020@ftp.linux-mips.org>
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
X-archive-position: 17560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 15 Nov 2007 20:17:31 +0000, linux-mips@linux-mips.org wrote:
> Subject: [MIPS] irq_cpu: use handle_percpu_irq handler to avoid dropping interrupts.
> Author: Ralf Baechle <ralf@linux-mips.org> Thu Nov 15 19:37:15 2007 +0000
> Commit: eebc88e5d2cffc07b969c8f426552a44e5ce51f8
> Gitweb: http://www.linux-mips.org/g/linux/eebc88e5
> Branch: master

This might broke probe_irq_on()/probe_irq_off(), since
handle_percpu_irq() does not check IRQ_WAITING bit.

This is a quick fix.  But I'm not sure where is the right place to fix...

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
index 0ee2567..9d97d4b 100644
--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -114,7 +114,9 @@ void __init mips_cpu_irq_init(void)
 		for (i = irq_base; i < irq_base + 2; i++)
 			set_irq_chip(i, &mips_mt_cpu_irq_controller);
 
-	for (i = irq_base + 2; i < irq_base + 8; i++)
+	for (i = irq_base + 2; i < irq_base + 8; i++) {
 		set_irq_chip_and_handler(i, &mips_cpu_irq_controller,
 					 handle_percpu_irq);
+		irq_desc[i].status |= IRQ_NOPROBE;
+	}
 }
