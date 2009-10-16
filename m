Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Oct 2009 08:18:42 +0200 (CEST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:63187 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493012AbZJPGRt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Oct 2009 08:17:49 +0200
Received: by mail-px0-f187.google.com with SMTP id 17so681893pxi.21
        for <multiple recipients>; Thu, 15 Oct 2009 23:17:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=dUbJ02gLkbcjlVcK993GC354YDseF6CRQ6Gysy6Ib58=;
        b=L4xZqQQHbYjhGnm71KvjZqp3bsO0yr/rTBoXwYSnut/n5ammhNxUQhaaJvsi4uZ8xR
         lJMJxiEv9eTI/m5a54dcuaZI+BsCgtLTndMkWDyWKc8kmzic7841QYtwdAceQPEHAgA/
         2/B87X/59k7/PfOVxHTbBNM0jf3XRFGELb0Yg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UR6eQYdIRAkGOBSaUHK6NaLfMnkZW9gy8kH6glMTZHJqizKDLMhdwxFSkGlxNjdvgx
         z8tuXCEcjVM67IpFoNT4qLVdvpWnKvrq+7lsQ/VNOOJUx4Ba9Ct+OhQzyEDHH84rRahE
         ObpLogweitZ0H9llDPTfQibEXzZ+O1Ie/ExoI=
Received: by 10.114.30.7 with SMTP id d7mr1235729wad.30.1255673868283;
        Thu, 15 Oct 2009 23:17:48 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm591698pzk.3.2009.10.15.23.17.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Oct 2009 23:17:47 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, yanh@lemote.com,
	huhb@lemote.com, Zhang Le <r0bertz@gentoo.org>, zhangfx@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 3/7] [loongson] early_printk: fix the variable type of uart_base
Date:	Fri, 16 Oct 2009 14:17:16 +0800
Message-Id: <d771bbf1f97c456c8e845adfe2c0c05065f68d39.1255673756.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <c709487f102bcd028fd637f5692ff42d94c55b33.1255673756.git.wuzhangjin@gmail.com>
References: <cover.1255672832.git.wuzhangjin@gmail.com>
 <83f0ebe8e34e5da49d0cb3487a7ef53f4edd69af.1255673756.git.wuzhangjin@gmail.com>
 <c709487f102bcd028fd637f5692ff42d94c55b33.1255673756.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1255673756.git.wuzhangjin@gmail.com>
References: <cover.1255673756.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

The uart_base variable here is not a physical address, so, we replace it
by unsigned char *.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/common/early_printk.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/loongson/common/early_printk.c b/arch/mips/loongson/common/early_printk.c
index bc73edc..8ec4fb2 100644
--- a/arch/mips/loongson/common/early_printk.c
+++ b/arch/mips/loongson/common/early_printk.c
@@ -1,7 +1,7 @@
 /*  early printk support
  *
  *  Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
- *  Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+ *  Copyright (c) 2009 Lemote Inc.
  *  Author: Wu Zhangjin, wuzj@lemote.com
  *
  *  This program is free software; you can redistribute  it and/or modify it
@@ -16,20 +16,20 @@
 
 #define PORT(base, offset) (u8 *)(base + offset)
 
-static inline unsigned int serial_in(phys_addr_t base, int offset)
+static inline unsigned int serial_in(unsigned char *base, int offset)
 {
 	return readb(PORT(base, offset));
 }
 
-static inline void serial_out(phys_addr_t base, int offset, int value)
+static inline void serial_out(unsigned char *base, int offset, int value)
 {
 	writeb(value, PORT(base, offset));
 }
 
 void prom_putchar(char c)
 {
-	phys_addr_t uart_base =
-		(phys_addr_t) ioremap_nocache(LOONGSON_UART_BASE, 8);
+	unsigned char *uart_base =
+		(unsigned char *) ioremap_nocache(LOONGSON_UART_BASE, 8);
 
 	while ((serial_in(uart_base, UART_LSR) & UART_LSR_THRE) == 0)
 		;
-- 
1.6.2.1
