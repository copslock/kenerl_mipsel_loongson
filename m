Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 12:07:48 +0100 (CET)
Received: from mail-px0-f188.google.com ([209.85.216.188]:52040 "EHLO
        mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492159AbZLALHp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Dec 2009 12:07:45 +0100
Received: by pxi26 with SMTP id 26so3678786pxi.21
        for <multiple recipients>; Tue, 01 Dec 2009 03:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=HFYSN0IXtJ50L6H3h1pPKd+UhjsWhfx1ZLTJaxlQp1s=;
        b=VeHT2WBHbnMIYahVSijcCv3VekQBp5WJN6T1ZUur6potoSMpM4yFJQ+80UCWK8KEIw
         /EW/5j+EEB3J+ryNG9ZLFm1ic+PkS7GGTUm0KWutlBLTT6o1ieP6KqEFtUBXunxCux3l
         f6iA7Ut24Hhys2kZUEN29VY+WGpP7/pEabqmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bNvdcMkN9+wG6bZp4yZudOZHA1fUplVt8I8DAAZKrNtvoQ8JK7UyRAv7j1WzaA1RAE
         m32tv0A7poOKlFWCF2ORAlhGYX46fVQ1otyhz25u14TJinQla3KC8yAU3QKaUwnjNGiV
         68Kao1R4qMRsxLCZN/J4+XUWnPVKRvnlO6iJE=
Received: by 10.115.26.7 with SMTP id d7mr10624519waj.12.1259665658014;
        Tue, 01 Dec 2009 03:07:38 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm474250pxi.3.2009.12.01.03.07.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 03:07:37 -0800 (PST)
From:   Wu Zhangin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, zhangfx@lemote.com,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v6 1/8] Loongson: Lemote-2F: add platform specific submenu
Date:   Tue,  1 Dec 2009 19:07:23 +0800
Message-Id: <a67a4a2ab32fc0e3281845479f07adf69dbf0bb2.1259664573.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1259660040.git.wuzhangjin@gmail.com>
References: <cover.1259660040.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1259664573.git.wuzhangjin@gmail.com>
References: <cover.1259664573.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/Kconfig |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 3df1967..a34dfcc 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -83,3 +83,23 @@ config LOONGSON_UART_BASE
 	bool
 	default y
 	depends on EARLY_PRINTK || SERIAL_8250
+
+#
+# Loongson Platform Specific Drivers
+#
+
+menuconfig LOONGSON_PLATFORM_DEVICES
+	bool "Loongson Platform Drivers"
+	default y
+	help
+	  Say Y here to get to see options for device drivers of various
+	  loongson platforms, including vendor-specific laptop/pc extension
+	  drivers.  This option alone does not add any kernel code.
+
+	  If you say N, all options in this submenu will be skipped and disabled.
+
+if LOONGSON_PLATFORM_DEVICES
+# Put platform specific stuff here
+
+
+endif # LOONGSON_PLATFORM_DEVICES
-- 
1.6.2.1
