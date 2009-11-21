Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2009 12:06:13 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:45955 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492253AbZKULFp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 21 Nov 2009 12:05:45 +0100
Received: by pzk35 with SMTP id 35so2966225pzk.22
        for <multiple recipients>; Sat, 21 Nov 2009 03:05:36 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=XB6K+50uqftNkFXGbsB32LHt5BwHdeCS4/DlLN3PpNY=;
        b=qt3KoMu2UkYmLrJmiw4hQqfHZbW4G18bsGr3YZBjC2WtHEl+umcA/oVKmoWuB2nuEI
         kKLhfCMUM5EOLWvRJxyPJNg1X8HtVTn1AetZWsqlU89PKxXYkea7nBw0Wh7miLIr2Hx6
         mlubk24F+YMs133l2YNJ/TPuuHvxCVnsZFbOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nqXSztnvG+eDYs5YttR74L4n+SlE0+oz9OQw7jE684xyl8hI3YD9Zg4bpDEaS2ejM+
         5pw6PUW5ChEjegllyE7Y3/85I2w/4jyStP9Wg0+hgaRe0wVwU9OU0OxpczNfbW+aHWjg
         xSI9JUWb5BY7ABsZXP+yfwbW2a5GrxHh4PYE4=
Received: by 10.114.253.23 with SMTP id a23mr3563567wai.155.1258801536620;
        Sat, 21 Nov 2009 03:05:36 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm1508374pxi.4.2009.11.21.03.05.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Nov 2009 03:05:36 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v1 1/4] [loongson] Remove the inline annotation of prom_init_uart_base()
Date:	Sat, 21 Nov 2009 19:05:22 +0800
Message-Id: <cd8541a74bab41734a44dfedcbc63688d165e35e.1258800842.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1258800842.git.wuzhangjin@gmail.com>
References: <cover.1258800842.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1258800842.git.wuzhangjin@gmail.com>
References: <cover.1258800842.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

gcc 3.4.6 complains about un-implemented prom_init_uart_base() if using
inline to annotate prom_init_uart_base(), so, remove the inline here.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    2 +-
 arch/mips/loongson/common/uart_base.c          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index daf7041..a7fa66e 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -33,7 +33,7 @@ extern void __init prom_init_machtype(void);
 extern void __init prom_init_env(void);
 extern unsigned long _loongson_uart_base;
 extern unsigned long uart8250_base[];
-extern inline void __maybe_unused prom_init_uart_base(void);
+extern void prom_init_uart_base(void);
 
 /* irq operation functions */
 extern void bonito_irqdispatch(void);
diff --git a/arch/mips/loongson/common/uart_base.c b/arch/mips/loongson/common/uart_base.c
index 275bed6..1d636f4 100644
--- a/arch/mips/loongson/common/uart_base.c
+++ b/arch/mips/loongson/common/uart_base.c
@@ -29,7 +29,7 @@ unsigned long __maybe_unused uart8250_base[] = {
 };
 EXPORT_SYMBOL(uart8250_base);
 
-inline void __maybe_unused prom_init_uart_base(void)
+void __maybe_unused prom_init_uart_base(void)
 {
 	_loongson_uart_base =
 		(unsigned long)ioremap_nocache(uart8250_base[mips_machtype], 8);
-- 
1.6.2.1
