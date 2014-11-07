Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 07:45:25 +0100 (CET)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:57784 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011935AbaKGGpIg7xsy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2014 07:45:08 +0100
Received: by mail-pa0-f43.google.com with SMTP id eu11so2925484pac.30
        for <multiple recipients>; Thu, 06 Nov 2014 22:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6lHdpW1eJLts2lC0YARFnRoqodKle9ttjwvWbuPUSDU=;
        b=wIBcNdtc11B+dytxx6HvPDvPD2vaYdq8K2LQ+n0Hu8Sc+bnHDsa87mwnvzGPYYsjg2
         YzhT79IpHxmkVSvBtBJnwSFtWfk2SAamcWj4xeaSS6t4LpxjwFG1m3sxPrD2ELIxh2PY
         7H7Nd6RiX0p6/d8vkjvKMwKYR9FzRMtLdUwLVBmnYOa/Ol3RenH6ORm6NmFarQiOqcS6
         PoCP+OpcHHJzOGrdWDhRIbwkIG224QkIgKwFT4/xmNyIctsHCEmWlrkqCklmKNLgEob8
         ash65qPcpjjgGFUciI1J3/jlsg/BPaRVrjBVSBxuXfEYHDt49qPciSe4EWJJ1/c9Yfic
         ZsGg==
X-Received: by 10.70.128.11 with SMTP id nk11mr9699752pdb.113.1415342702186;
        Thu, 06 Nov 2014 22:45:02 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id fy4sm7686827pbb.42.2014.11.06.22.45.00
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 06 Nov 2014 22:45:01 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, linux-sh@vger.kernel.org
Cc:     arnd@arndb.de, f.fainelli@gmail.com, ralf@linux-mips.org,
        sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org
Subject: [PATCH V4 01/14] sh: Eliminate unused irq_reg_{readl,writel} accessors
Date:   Thu,  6 Nov 2014 22:44:16 -0800
Message-Id: <1415342669-30640-2-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Defining these macros way down in arch/sh/.../irq.c doesn't cause
kernel/irq/generic-chip.c to use them.  As far as I can tell this code
has no effect.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/sh/boards/mach-se/7343/irq.c | 3 ---
 arch/sh/boards/mach-se/7722/irq.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/sh/boards/mach-se/7343/irq.c b/arch/sh/boards/mach-se/7343/irq.c
index 7646bf0..1087dba 100644
--- a/arch/sh/boards/mach-se/7343/irq.c
+++ b/arch/sh/boards/mach-se/7343/irq.c
@@ -14,9 +14,6 @@
 #define DRV_NAME "SE7343-FPGA"
 #define pr_fmt(fmt) DRV_NAME ": " fmt
 
-#define irq_reg_readl	ioread16
-#define irq_reg_writel	iowrite16
-
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
diff --git a/arch/sh/boards/mach-se/7722/irq.c b/arch/sh/boards/mach-se/7722/irq.c
index f5e2af1..00e6992 100644
--- a/arch/sh/boards/mach-se/7722/irq.c
+++ b/arch/sh/boards/mach-se/7722/irq.c
@@ -11,9 +11,6 @@
 #define DRV_NAME "SE7722-FPGA"
 #define pr_fmt(fmt) DRV_NAME ": " fmt
 
-#define irq_reg_readl	ioread16
-#define irq_reg_writel	iowrite16
-
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
-- 
2.1.1
