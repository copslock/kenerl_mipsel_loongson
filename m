Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 23:29:08 +0100 (BST)
Received: from mail-px0-f119.google.com ([209.85.216.119]:43899 "EHLO
	mail-px0-f119.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023409AbZEOW3C (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 23:29:02 +0100
Received: by pxi17 with SMTP id 17so1372762pxi.22
        for <multiple recipients>; Fri, 15 May 2009 15:28:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=/IoEoukheuTN36FCygDmSKFmxQ/PHlF7G4TzP+zLWtw=;
        b=Fv5rhgY0STPbp91pJEpknzbpv5TmSwhNMQfaEpBTmAezlS+UDoLSWkv2bSFcs2sLUn
         LbdW7UCAcLUzPH9jPNENQIReCnTJUCz9T0icOh9UbfL4KBqGNdqETknzGdlk+HqmolRP
         jif4OgHa+T5pKerMY5H5ukT24kKvWX0EsCN7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=UXrNSiJ2X/HwBb0tNgP4kYtcnYkd2YksGK0SR3H5Oz2B9MfZvSl06EqW8UokQo2a0c
         UMyfTB3a1AS0uUhgNyHbqFlaNmOkr2VqaRaDjxlfP3OHa5YpVW08QKU3e/zcN9y714vZ
         x+XtSak2FbCvTFfwpowQk9UNHhiurC/fUseio=
Received: by 10.114.89.1 with SMTP id m1mr5582707wab.188.1242426534506;
        Fri, 15 May 2009 15:28:54 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id j15sm1985385waf.64.2009.05.15.15.28.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 15:28:54 -0700 (PDT)
Subject: [PATCH 26/30] loongson: flush irq write operation
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 16 May 2009 06:28:47 +0800
Message-Id: <1242426527.10164.174.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

>From d0431e4d83ec7f852d631f80aaca4b66586b4db2 Mon Sep 17 00:00:00 2001
From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Sat, 16 May 2009 04:54:27 +0800
Subject: [PATCH 26/30] loongson: flush irq write operation

read back after write, otherwise, there will be many spurious irqs from
it
---
 arch/mips/kernel/i8259.c               |    5 +++++
 arch/mips/loongson/common/bonito-irq.c |    4 ++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/i8259.c b/arch/mips/kernel/i8259.c
index 413bd1d..f7c3a2b 100644
--- a/arch/mips/kernel/i8259.c
+++ b/arch/mips/kernel/i8259.c
@@ -175,12 +175,17 @@ handle_real_irq:
 	if (irq & 8) {
 		inb(PIC_SLAVE_IMR);	/* DUMMY - (do we need this?) */
 		outb(cached_slave_mask, PIC_SLAVE_IMR);
+		inb(PIC_SLAVE_IMR);
 		outb(0x60+(irq&7), PIC_SLAVE_CMD);/* 'Specific EOI' to slave */
+		inb(PIC_SLAVE_CMD);
 		outb(0x60+PIC_CASCADE_IR, PIC_MASTER_CMD); /* 'Specific EOI' to
master-IRQ2 */
+		inb(PIC_MASTER_CMD);
 	} else {
 		inb(PIC_MASTER_IMR);	/* DUMMY - (do we need this?) */
 		outb(cached_master_mask, PIC_MASTER_IMR);
+		inb(PIC_SLAVE_IMR);
 		outb(0x60+irq, PIC_MASTER_CMD);	/* 'Specific EOI to master */
+		inb(PIC_MASTER_CMD);
 	}
 	smtc_im_ack_irq(irq);
 	spin_unlock_irqrestore(&i8259A_lock, flags);
diff --git a/arch/mips/loongson/common/bonito-irq.c
b/arch/mips/loongson/common/bonito-irq.c
index d5a5ae8..cfbeaf5 100644
--- a/arch/mips/loongson/common/bonito-irq.c
+++ b/arch/mips/loongson/common/bonito-irq.c
@@ -36,12 +36,16 @@
 static inline void bonito_irq_enable(unsigned int irq)
 {
 	LOONGSON_INTENSET = (1 << (irq - LOONGSON_IRQ_BASE));
+	/* flush the write operation via a following read operation */
+	(void)LOONGSON_INTENSET;
 	mmiowb();
 }
 
 static inline void bonito_irq_disable(unsigned int irq)
 {
 	LOONGSON_INTENCLR = (1 << (irq - LOONGSON_IRQ_BASE));
+	/* flush the write operation via a following read operation */
+	(void)LOONGSON_INTENCLR;
 	mmiowb();
 }
 
-- 
1.6.2.1
