Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2012 20:26:46 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:64695 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903779Ab2B1TZH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Feb 2012 20:25:07 +0100
Received: from yow-lpgnfs-02.corp.ad.wrs.com (yow-lpgnfs-02.ottawa.windriver.com [128.224.149.8])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q1SJOuvV014095;
        Tue, 28 Feb 2012 11:25:00 -0800 (PST)
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 4/5] MIPS: delete bogus module.h usage in termios.h
Date:   Tue, 28 Feb 2012 14:24:47 -0500
Message-Id: <1330457088-14587-5-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1330457088-14587-1-git-send-email-paul.gortmaker@windriver.com>
References: <1330457088-14587-1-git-send-email-paul.gortmaker@windriver.com>
X-archive-position: 32575
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

There is no need for this.  Removing it causes a small amount
of fallout (shown below) due to a few implicit header presence
assumptions that are easily fixed.

arch/mips/include/asm/termios.h:103: error: implicit declaration of function 'access_ok'
arch/mips/include/asm/module.h:17: error: expected specifier-qualifier-list before 'Elf64_Addr'

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/mips/include/asm/module.h  |    1 +
 arch/mips/include/asm/termios.h |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/module.h b/arch/mips/include/asm/module.h
index 7467d1d..5300080 100644
--- a/arch/mips/include/asm/module.h
+++ b/arch/mips/include/asm/module.h
@@ -2,6 +2,7 @@
 #define _ASM_MODULE_H
 
 #include <linux/list.h>
+#include <linux/elf.h>
 #include <asm/uaccess.h>
 
 struct mod_arch_specific {
diff --git a/arch/mips/include/asm/termios.h b/arch/mips/include/asm/termios.h
index 8f77f77..abdd87a 100644
--- a/arch/mips/include/asm/termios.h
+++ b/arch/mips/include/asm/termios.h
@@ -60,7 +60,7 @@ struct termio {
 };
 
 #ifdef __KERNEL__
-#include <linux/module.h>
+#include <asm/uaccess.h>
 
 /*
  *	intr=^C		quit=^\		erase=del	kill=^U
-- 
1.7.9.1
