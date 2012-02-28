Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2012 20:27:08 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:64699 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903780Ab2B1TZI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Feb 2012 20:25:08 +0100
Received: from yow-lpgnfs-02.corp.ad.wrs.com (yow-lpgnfs-02.ottawa.windriver.com [128.224.149.8])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q1SJOuvW014095;
        Tue, 28 Feb 2012 11:25:01 -0800 (PST)
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 5/5] MIPS: dont use module.h just to export symbols in asm/uasm.h
Date:   Tue, 28 Feb 2012 14:24:48 -0500
Message-Id: <1330457088-14587-6-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1330457088-14587-1-git-send-email-paul.gortmaker@windriver.com>
References: <1330457088-14587-1-git-send-email-paul.gortmaker@windriver.com>
X-archive-position: 32576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Putting module.h into widely used headers just bogs cpp down
with reams of stuff that isn't needed.  Here, we only need
visibility to EXPORT_SYMBOL.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/mips/include/asm/uasm.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 504d40a..440a21d 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -11,7 +11,7 @@
 #include <linux/types.h>
 
 #ifdef CONFIG_EXPORT_UASM
-#include <linux/module.h>
+#include <linux/export.h>
 #define __uasminit
 #define __uasminitdata
 #define UASM_EXPORT_SYMBOL(sym) EXPORT_SYMBOL(sym)
-- 
1.7.9.1
