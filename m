Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2010 13:23:14 +0100 (CET)
Received: from mail-pz0-f203.google.com ([209.85.222.203]:41162 "EHLO
        mail-pz0-f203.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492207Ab0AaMWQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Jan 2010 13:22:16 +0100
Received: by pzk41 with SMTP id 41so5404501pzk.0
        for <multiple recipients>; Sun, 31 Jan 2010 04:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=jmib/etJzX+Qn8xwZuVRPOoJG0uwxGWATAFI+qqMD2k=;
        b=LcJ1/tXSTeGuNJg41AwyAuUedARoouJnwYYHbJBtRsHol4kbXm2hHHcMMG/usOPU5/
         u+Tg++X8YkObQIefZ7N2+Syp4jIEGnD0rFTdxK0EjSESotWCfPKKpXDbiLfnPhKeH7Tc
         9wllPg7Ge/GaXxGYHla32F5LpucM7IK8TazII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LSxF3GuuPZJiGZYvIElYjye+WRL4lRo1R2XGwXthgcYo55AxR/n+A7nhVVBYlNM6Du
         H4NOaarNEHdIuzrACm+f7ziYVFzSWUnIsrEWZyAVEGiaymHOTF70jbP8t01+LeE/WCed
         kNKRfybY8DW2TraKdFPjsIQzSWt5fufVWfGlk=
Received: by 10.114.165.4 with SMTP id n4mr2212297wae.81.1264940529035;
        Sun, 31 Jan 2010 04:22:09 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm3552209pzk.3.2010.01.31.04.22.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Jan 2010 04:22:08 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
        linux-mips@linux-mips.org, zhangfx@lemote.com
Subject: [PATCH v11 1/9] MIPS: add subdirectory for platform extension drivers
Date:   Sun, 31 Jan 2010 20:15:47 +0800
Message-Id: <b25d80b0d15f92b93fa3cb70c97c39cfb0d79c16.1264940063.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.6
In-Reply-To: <cover.1264940063.git.wuzhangjin@gmail.com>
References: <cover.1264940063.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1264940063.git.wuzhangjin@gmail.com>
References: <cover.1264940063.git.wuzhangjin@gmail.com>
X-archive-position: 25779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19718

From: Wu Zhangjin <wuzhangjin@gmail.com>

It is really hard to split the platform specific subdrivers into
different subsystems, which will generate lots of duplicated source
code, break the whole support into several pieces and also will make the
users be difficult to choose the suitable subdrivers in different
places.

So, I did like the forks have done under drivers/platform/x86, created
the drivers/platform/mips/ for putting the future MIPS netbook/laptop/pc
extension drivers in.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 drivers/platform/Kconfig      |    4 ++++
 drivers/platform/mips/Kconfig |   18 ++++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)
 create mode 100644 drivers/platform/mips/Kconfig

diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
index 8390dca..4fa78d5 100644
--- a/drivers/platform/Kconfig
+++ b/drivers/platform/Kconfig
@@ -1,3 +1,7 @@
 if X86
 source "drivers/platform/x86/Kconfig"
 endif
+
+if MIPS
+source "drivers/platform/mips/Kconfig"
+endif
diff --git a/drivers/platform/mips/Kconfig b/drivers/platform/mips/Kconfig
new file mode 100644
index 0000000..2f77693
--- /dev/null
+++ b/drivers/platform/mips/Kconfig
@@ -0,0 +1,18 @@
+#
+# MIPS Platform Specific Drivers
+#
+
+menuconfig MIPS_PLATFORM_DEVICES
+	bool "MIPS Platform Specific Device Drivers"
+	default y
+	help
+	  Say Y here to get to see options for device drivers of various
+	  MIPS platforms, including vendor-specific netbook/laptop/pc extension
+	  drivers.  This option alone does not add any kernel code.
+
+	  If you say N, all options in this submenu will be skipped and disabled.
+
+if MIPS_PLATFORM_DEVICES
+
+
+endif # MIPS_PLATFORM_DEVICES
-- 
1.6.6
