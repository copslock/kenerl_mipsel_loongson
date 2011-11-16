Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 01:24:25 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:64684 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903752Ab1KPAYS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Nov 2011 01:24:18 +0100
Received: by ggnb1 with SMTP id b1so598312ggn.36
        for <multiple recipients>; Tue, 15 Nov 2011 16:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=j5w8UyZKH+shAJDYOuYzz+fXCZlEd7PIoXAJKyrS1Yg=;
        b=Rcl7v+jTn//WXOKJ5OnrzzWmG+75LbF8kh/SDFVgJXa9xKUQ68uUZmGFWjTL8vxMLh
         eEbLXFj16aVpEQC9P2tTLMxnjYblTinPH3Tm+E/BFQ+g/n2Y2q25VjxYSXU109cFmhsX
         Kmzte129RS+8xUr302zzkmkcXojDtEWKxywWA=
Received: by 10.101.94.15 with SMTP id w15mr8895876anl.117.1321403052607;
        Tue, 15 Nov 2011 16:24:12 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id 4sm79272831ano.9.2011.11.15.16.24.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Nov 2011 16:24:12 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAG0OA8E007118;
        Tue, 15 Nov 2011 16:24:10 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAG0O926007117;
        Tue, 15 Nov 2011 16:24:09 -0800
From:   ddaney.cavm@gmail.com
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Chandrakala Chavva <cchavva@caviumnetworks.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Octeon: Remove SYS_SUPPORTS_HIGHMEM.
Date:   Tue, 15 Nov 2011 16:24:08 -0800
Message-Id: <1321403048-7086-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 31622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12972

From: Chandrakala Chavva <cchavva@caviumnetworks.com>

Only 64-bit kernels are supported, no need for SYS_SUPPORTS_HIGHMEM

Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/Kconfig |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a29452b..e1e31a0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -638,7 +638,6 @@ config CAVIUM_OCTEON_SIMULATOR
 	select DMA_COHERENT
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
-	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_HOTPLUG_CPU
 	select SYS_HAS_CPU_CAVIUM_OCTEON
 	help
@@ -653,7 +652,6 @@ config CAVIUM_OCTEON_REFERENCE_BOARD
 	select DMA_COHERENT
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
-	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_HOTPLUG_CPU
 	select SYS_HAS_EARLY_PRINTK
 	select SYS_HAS_CPU_CAVIUM_OCTEON
-- 
1.7.2.3
