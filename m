Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2009 20:10:16 +0100 (BST)
Received: from mail-px0-f119.google.com ([209.85.216.119]:57793 "EHLO
	mail-px0-f119.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024671AbZEZTIf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 May 2009 20:08:35 +0100
Received: by mail-px0-f119.google.com with SMTP id 17so3790363pxi.22
        for <multiple recipients>; Tue, 26 May 2009 12:08:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=mMQAyl86COt/jTP+jBPOIeR1JVcXZUHTfBIteX5bXis=;
        b=Vi1YZytUwDumZU4c5PUokhIUpfUO1qvf2DrVdLGg3BB+sGeuys2fodnc0r8sS1kV52
         G9KX7JNQ30y+V4PMUIcP16XKaOATBcK0/rFb6np2Uo8D+uvnYh2Ub3o6YeYa8RtIvIXg
         euKujthxsVQkXGxywSzQp3ZMjufAaQmBKqU1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sbk0cKrS3c/qkyIraGsRqD3L66KLHs5JEJ/cT2VuMtJdlI9XZ3UwwQflPTj8Ysl9Dz
         CnsU41z5mhbWmFA54sGBTQWZXltqMdjgjoZmjYpNYbm6EgzaCClItHl8E4tsqyo5aPfG
         4dpk65hi0CoktMWHA0YGJg0BZ5U1EEomCH57Y=
Received: by 10.114.137.2 with SMTP id k2mr18284661wad.18.1243364914743;
        Tue, 26 May 2009 12:08:34 -0700 (PDT)
Received: from localhost.localdomain ([219.246.59.144])
        by mx.google.com with ESMTPS id d20sm16954035waa.47.2009.05.26.12.08.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 May 2009 12:08:33 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [loongson-PATCH-v2 17/23] flush posted write to irq
Date:	Wed, 27 May 2009 03:08:25 +0800
Message-Id: <5b310361ae2aa460ca551dd1c5d93c37302142d4.1243362545.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1243362545.git.wuzj@lemote.com>
References: <cover.1243362545.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22991
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

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
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
