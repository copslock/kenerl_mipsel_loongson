Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2016 02:47:24 +0100 (CET)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35955 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012038AbcBBBrHT4YAu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Feb 2016 02:47:07 +0100
Received: by mail-pf0-f196.google.com with SMTP id n128so8191042pfn.3;
        Mon, 01 Feb 2016 17:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lMe9SQzFuv6n6efxcXUHDPmI0mPq9Ek5LjUE/J/Wxq4=;
        b=iR79reShQ/X8joHL9k31NqKAnM/WH/buNoAjQMLPsb2rLXh9TS/RjyXjQBNZUaPT0K
         d5VqoG7umR0IeZ1erwr8fPpF1ax7Ltg4e+z9CYtq332lkCgU7+vwI2Rjcv6706cer0AD
         OtnmkqsodBDFRLSWzqMmDkZn2AICN4vKc1ziAzlkBbrwYwk+OIDalwae1sZoyQtpmGh5
         tpmwOqaFRGYmLCqq7zlRKFkearaU9F8BGPqng/29SXGr9zdAsp5EvEn0EssNazSLyJpo
         OtCNROQIyM80GeqwkmgaUpnnFfDU5Uay1luiVIRi3I9hdqLaecrXmPeUQu9cjuA/ndbu
         gWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lMe9SQzFuv6n6efxcXUHDPmI0mPq9Ek5LjUE/J/Wxq4=;
        b=js+3S0djTF3OCKtR/3WqDYQy4EhEoBoKeOL6WyTIW6BcuKEH/p6oLPpj317rGnAPRs
         LhPXnyxOtlfPb/31xJu+qP6GAiQZVJMdIZmnZkUdTKpKL7ruCZh38SF1xCFhJzGnNWSy
         2SwPd7A57nVFZra/VPOGPwoDdgsYTUYt0xQRoHzNaZl8jmt17RhTzlmAv7sAyBPlpNc0
         WOVUucs68Vgn63r0EEr2LkyKJgWbZnQ3kxIwAq/LiLl+H0htFoPHzSnk2lZVJ7uzVnls
         Q0Fj4pybS+a2VGYHm4VFHyJiFy9JhvuWtAQTqlFdKWHqiVgO3eEYWfWa/g1yIXFpn0tq
         EB7w==
X-Gm-Message-State: AG10YOQ4N647cfnCWlnglHzGlG9UhWCDzE0WvQbSkuzCgaTnhr9ECWzdV5PR6RLZEUPb8w==
X-Received: by 10.98.44.66 with SMTP id s63mr43539366pfs.2.1454377621293;
        Mon, 01 Feb 2016 17:47:01 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.gmail.com with ESMTPSA id xm10sm22162552pab.12.2016.02.01.17.46.58
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 01 Feb 2016 17:46:58 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id u121kv6p014955;
        Mon, 1 Feb 2016 17:46:57 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id u121kuXd014954;
        Mon, 1 Feb 2016 17:46:56 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 1/2] MIPS: OCTEON: Remove dead code from cvmx-sysinfo.
Date:   Mon,  1 Feb 2016 17:46:53 -0800
Message-Id: <1454377614-14915-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1454377614-14915-1-git-send-email-ddaney.cavm@gmail.com>
References: <1454377614-14915-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Get rid of the long unused code.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/executive/cvmx-sysinfo.c | 72 ++----------------------
 arch/mips/include/asm/octeon/cvmx-sysinfo.h      | 30 +---------
 2 files changed, 5 insertions(+), 97 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-sysinfo.c b/arch/mips/cavium-octeon/executive/cvmx-sysinfo.c
index 3d17fac..cc1b1d2 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-sysinfo.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-sysinfo.c
@@ -32,86 +32,22 @@
 #include <linux/module.h>
 
 #include <asm/octeon/cvmx.h>
-#include <asm/octeon/cvmx-spinlock.h>
 #include <asm/octeon/cvmx-sysinfo.h>
 
-/**
+/*
  * This structure defines the private state maintained by sysinfo module.
- *
  */
-static struct {
-	struct cvmx_sysinfo sysinfo;	   /* system information */
-	cvmx_spinlock_t lock;	   /* mutex spinlock */
-
-} state = {
-	.lock = CVMX_SPINLOCK_UNLOCKED_INITIALIZER
-};
-
+static struct cvmx_sysinfo sysinfo;	   /* system information */
 
 /*
- * Global variables that define the min/max of the memory region set
- * up for 32 bit userspace access.
- */
-uint64_t linux_mem32_min;
-uint64_t linux_mem32_max;
-uint64_t linux_mem32_wired;
-uint64_t linux_mem32_offset;
-
-/**
- * This function returns the application information as obtained
+ * Returns the application information as obtained
  * by the bootloader.  This provides the core mask of the cores
  * running the same application image, as well as the physical
  * memory regions available to the core.
- *
- * Returns  Pointer to the boot information structure
- *
  */
 struct cvmx_sysinfo *cvmx_sysinfo_get(void)
 {
-	return &(state.sysinfo);
+	return &sysinfo;
 }
 EXPORT_SYMBOL(cvmx_sysinfo_get);
 
-/**
- * This function is used in non-simple executive environments (such as
- * Linux kernel, u-boot, etc.)	to configure the minimal fields that
- * are required to use simple executive files directly.
- *
- * Locking (if required) must be handled outside of this
- * function
- *
- * @phy_mem_desc_ptr:
- *		     Pointer to global physical memory descriptor
- *		     (bootmem descriptor) @board_type: Octeon board
- *		     type enumeration
- *
- * @board_rev_major:
- *		     Board major revision
- * @board_rev_minor:
- *		     Board minor revision
- * @cpu_clock_hz:
- *		     CPU clock freqency in hertz
- *
- * Returns 0: Failure
- *	   1: success
- */
-int cvmx_sysinfo_minimal_initialize(void *phy_mem_desc_ptr,
-				    uint16_t board_type,
-				    uint8_t board_rev_major,
-				    uint8_t board_rev_minor,
-				    uint32_t cpu_clock_hz)
-{
-
-	/* The sysinfo structure was already initialized */
-	if (state.sysinfo.board_type)
-		return 0;
-
-	memset(&(state.sysinfo), 0x0, sizeof(state.sysinfo));
-	state.sysinfo.phy_mem_desc_ptr = phy_mem_desc_ptr;
-	state.sysinfo.board_type = board_type;
-	state.sysinfo.board_rev_major = board_rev_major;
-	state.sysinfo.board_rev_minor = board_rev_minor;
-	state.sysinfo.cpu_clock_hz = cpu_clock_hz;
-
-	return 1;
-}
diff --git a/arch/mips/include/asm/octeon/cvmx-sysinfo.h b/arch/mips/include/asm/octeon/cvmx-sysinfo.h
index 2131197..78cd64a 100644
--- a/arch/mips/include/asm/octeon/cvmx-sysinfo.h
+++ b/arch/mips/include/asm/octeon/cvmx-sysinfo.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2016 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -121,32 +121,4 @@ struct cvmx_sysinfo {
 
 extern struct cvmx_sysinfo *cvmx_sysinfo_get(void);
 
-/**
- * This function is used in non-simple executive environments (such as
- * Linux kernel, u-boot, etc.)	to configure the minimal fields that
- * are required to use simple executive files directly.
- *
- * Locking (if required) must be handled outside of this
- * function
- *
- * @phy_mem_desc_ptr: Pointer to global physical memory descriptor
- *		     (bootmem descriptor) @board_type: Octeon board
- *		     type enumeration
- *
- * @board_rev_major:
- *		     Board major revision
- * @board_rev_minor:
- *		     Board minor revision
- * @cpu_clock_hz:
- *		     CPU clock freqency in hertz
- *
- * Returns 0: Failure
- *	   1: success
- */
-extern int cvmx_sysinfo_minimal_initialize(void *phy_mem_desc_ptr,
-					   uint16_t board_type,
-					   uint8_t board_rev_major,
-					   uint8_t board_rev_minor,
-					   uint32_t cpu_clock_hz);
-
 #endif /* __CVMX_SYSINFO_H__ */
-- 
1.7.11.7
