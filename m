Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 23:10:31 +0100 (BST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:62245 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025219AbZETWKN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 23:10:13 +0100
Received: by mail-pz0-f202.google.com with SMTP id 40so631545pzk.22
        for <multiple recipients>; Wed, 20 May 2009 15:10:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=zt4M4T3vESa66wVv4n6kVXC7cq9CCKtA1BGaxQTkmNg=;
        b=lYUEuWG44HCH/u0O6jIzPYXS1+rWpAeuPvI9VDi8x/oYn2cuXWp4EMinf4zryvHLGV
         Fk+XrKoxFl1IW0zFR8FgoUqbWhQs+p1Aj7DVaqLT8nkYcGeqxIl8i2eYYI//SI1YBLfE
         IXLMrsz4r0XcB238Spz+3uqOqnkzy9jEbyQkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OAbOwj3G0bHOcvB/cosJjZnuTW/Ikomw7tTcSJtl0LrV5c2KSM53sE6fnUOkBGM0DV
         F+Q1w9yTYIi8d6TSNntFsGkEqCvXuMxW2lYGC+ESD6FlOYc9a929s/sMPiDQ06DNBSpq
         aDUdPSp0PqZfiaiS0f60fGS6ebOpUpO2Dwu8E=
Received: by 10.115.18.3 with SMTP id v3mr3611997wai.32.1242857412560;
        Wed, 20 May 2009 15:10:12 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id j31sm4028974waf.61.2009.05.20.15.10.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 15:10:11 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: [loongson-PATCH-v1 19/27] flush posted write to irq
Date:	Thu, 21 May 2009 06:10:01 +0800
Message-Id: <da0fbcca488267abcf5d83db1dd28adcb1f58260.1242855716.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1242855716.git.wuzhangjin@gmail.com>
References: <cover.1242855716.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

read back to flush the posted write, otherwise, there will be many
spurious irqs.

the previous talk: http://www.spinics.net/lists/mips/msg33749.html

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/i8259.c               |    2 ++
 arch/mips/loongson/common/bonito-irq.c |    4 ++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/i8259.c b/arch/mips/kernel/i8259.c
index 413bd1d..0f93ab1 100644
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
1.6.2.1
