Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 14:11:40 +0100 (WEST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:57979 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022624AbZFDNKZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 14:10:25 +0100
Received: by mail-pz0-f202.google.com with SMTP id 40so740737pzk.22
        for <multiple recipients>; Thu, 04 Jun 2009 06:10:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BgaXjyQIfdWxF+osDHoHrPrDO9/hWg0VMsjCAap6+6o=;
        b=DftIt6A3EkFxt2GTjGKZCro32JZwC4SaXeZ7oaVL4F7CDL3mhHJ2yB6F1sEUQNZpZE
         qZFocW6+A3XHe46ph4zHEnYGuPPGju9pwshN2cIZWIl0gz4SHJcNNgt559x9IYWdaab8
         Ih7xag82bexIhATIkobzdQJQl5fymEbbVIgvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MPfKFxGM2PnuxY+tWFwQHNDYpXRLEzsNdG5U6654JeKlNRNRi9aVjdz4n9eMONUmnh
         Y5lInR5esxMep+Wu62DgWUtlsPe9F1olKP/xH5LAYeg+GTwtYLlq6HRjF0BrkZc2ZYTV
         3QMWT0iWtpHZ0E8QxaEbYBWFBI+5pnXkt9BcE=
Received: by 10.114.211.2 with SMTP id j2mr3421946wag.74.1244121020945;
        Thu, 04 Jun 2009 06:10:20 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id f20sm11148736waf.52.2009.06.04.06.10.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 06:10:19 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [loongson-PATCH-v3 21/25] flush posted write to irq
Date:	Thu,  4 Jun 2009 21:10:07 +0800
Message-Id: <75d8105d78c23f620cee4490e3135e915b53b861.1244120575.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1244120575.git.wuzj@lemote.com>
References: <cover.1244120575.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

read back to flush the posted write, otherwise, there will be many
spurious irqs.

the previous talk: http://www.spinics.net/lists/mips/msg33749.html

Reviewed-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
Signed-off-by: Yan Hua <yanh@lemote.com>
---
 arch/mips/kernel/i8259.c               |    2 ++
 arch/mips/loongson/common/bonito-irq.c |    4 ++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/i8259.c b/arch/mips/kernel/i8259.c
index 01c0885..b0254c6 100644
--- a/arch/mips/kernel/i8259.c
+++ b/arch/mips/kernel/i8259.c
@@ -177,10 +177,12 @@ handle_real_irq:
 		outb(cached_slave_mask, PIC_SLAVE_IMR);
 		outb(0x60+(irq&7), PIC_SLAVE_CMD);/* 'Specific EOI' to slave */
 		outb(0x60+PIC_CASCADE_IR, PIC_MASTER_CMD); /* 'Specific EOI' to master-IRQ2 */
+		inb(PIC_MASTER_CMD);	/* flush posted write */
 	} else {
 		inb(PIC_MASTER_IMR);	/* DUMMY - (do we need this?) */
 		outb(cached_master_mask, PIC_MASTER_IMR);
 		outb(0x60+irq, PIC_MASTER_CMD);	/* 'Specific EOI to master */
+		inb(PIC_MASTER_CMD);	/* flush posted write */
 	}
 	smtc_im_ack_irq(irq);
 	spin_unlock_irqrestore(&i8259A_lock, flags);
diff --git a/arch/mips/loongson/common/bonito-irq.c b/arch/mips/loongson/common/bonito-irq.c
index 940c1f0..8f5a455 100644
--- a/arch/mips/loongson/common/bonito-irq.c
+++ b/arch/mips/loongson/common/bonito-irq.c
@@ -36,12 +36,16 @@
 static inline void bonito_irq_enable(unsigned int irq)
 {
 	LOONGSON_INTENSET = (1 << (irq - LOONGSON_IRQ_BASE));
+	/* flush posted write */
+	(void)LOONGSON_INTENSET;
 	mmiowb();
 }
 
 static inline void bonito_irq_disable(unsigned int irq)
 {
 	LOONGSON_INTENCLR = (1 << (irq - LOONGSON_IRQ_BASE));
+	/* flush posted write */
+	(void)LOONGSON_INTENCLR;
 	mmiowb();
 }
 
-- 
1.6.0.4
