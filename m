Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 May 2010 15:58:52 +0200 (CEST)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:43723 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491863Ab0EWN6Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 May 2010 15:58:25 +0200
Received: by mail-pz0-f197.google.com with SMTP id 35so1140918pzk.0
        for <multiple recipients>; Sun, 23 May 2010 06:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=ZCEy9RNM9RYqZ3Z0iNonrKIB1pFvXbi4LaqwqvmBgJk=;
        b=EGbzFEib3c0cIeC8hCpZRVfv72zFrOyunG5n8nNUqV6JbF8exZ23YvGCoq673FCq1S
         BIDCH1hBSCatCKc2S4AR9hjPmBykda1chMnCZ4byrU2GDWLCiR8SBVUAf9Yb9OIp4uSb
         LIGaX2Z+gJyG6jvIFEPvTEee1TgiFePnqFgVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=l1xKLJ9O2FUKSsNJpzoKom6JHhzI/kqNWFTlCPr3AQOT9G24+LNHbLIlzuWyzK8iOm
         rxI8n/9bIR8rrah4QrEQBxusmflWuZuvKoUDgd/+Mf39sHEALTVuBk1Dm5nfQxD7KpQb
         icUr/GCDbBmJK38QojNS+3eMvmVAKUxwskbjo=
Received: by 10.115.39.8 with SMTP id r8mr3661797waj.228.1274623105000;
        Sun, 23 May 2010 06:58:25 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id r20sm29067398wam.17.2010.05.23.06.58.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 06:58:23 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 1/9] MIPS: add subdirectory for platform extension drivers
Date:   Sun, 23 May 2010 21:57:57 +0800
Message-Id: <69926fc7ddb9b788e7dd490786a4e668562a0820.1274622624.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1274622624.git.wuzhangjin@gmail.com>
References: <cover.1274622624.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1274622624.git.wuzhangjin@gmail.com>
References: <cover.1274622624.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

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
1.7.0.4
