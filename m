Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2015 07:11:13 +0200 (CEST)
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34530 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006916AbbFCFLJC90zH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2015 07:11:09 +0200
Received: by qkoo18 with SMTP id o18so113707403qko.1;
        Tue, 02 Jun 2015 22:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=iGPb0mk5+iNVCejaPxxxDJ+sMqEY3fadqBgDSTYlA9Q=;
        b=DHXMz+QBg7EZbmw1zI6nF90lOIwnnIMZEFhJUXVDWI+On6nlaxI03ExtkGOZNiICZW
         ifRKW2nqFVtg/jcCtZV3VGLctuwqLjOdqXkU7vMVeTYBiQOkC9i/vrTrQ1VUkz+QeJNs
         2tLGkP8R/Clky5TCBLvjuD1RxMBPk/PtykOUj8VlhTVLhllqUQ39oq6A6LePQP1M0Ub9
         hz7V8M6n2Eat/pVfeBUas5qkapGe9sy7a/n0QiWQQub3VYj2+YZpoX/p+LEB80mvZBzo
         WUOfjVku9RCTdtJQfYH6rOBoC4m6CG6pjkD2J+6GvQVRCSBI8z7eyooSIOov4VElIKfj
         xWuQ==
X-Received: by 10.55.41.157 with SMTP id p29mr54335836qkp.44.1433308263150;
        Tue, 02 Jun 2015 22:11:03 -0700 (PDT)
Received: from localhost.localdomain ([198.0.207.174])
        by mx.google.com with ESMTPSA id p36sm1780438qkp.11.2015.06.02.22.10.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 22:11:02 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Grant Likely <grant.likely@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] of: clean-up unnecessary libfdt include paths
Date:   Wed,  3 Jun 2015 00:10:25 -0500
Message-Id: <1433308225-13874-1-git-send-email-robh@kernel.org>
X-Mailer: git-send-email 2.1.0
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

With the latest dtc import include fixups, it is no longer necessary to
add explicit include paths to use libfdt. Remove these across the
kernel.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: linux-mips@linux-mips.org
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/mips/cavium-octeon/Makefile      | 3 ---
 arch/mips/mti-sead3/Makefile          | 2 --
 arch/powerpc/kernel/Makefile          | 1 -
 drivers/firmware/efi/libstub/Makefile | 2 --
 drivers/of/Makefile                   | 3 ---
 5 files changed, 11 deletions(-)

diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index 69a8a8d..2a59265 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -9,9 +9,6 @@
 # Copyright (C) 2005-2009 Cavium Networks
 #
 
-CFLAGS_octeon-platform.o = -I$(src)/../../../scripts/dtc/libfdt
-CFLAGS_setup.o = -I$(src)/../../../scripts/dtc/libfdt
-
 obj-y := cpu.o setup.o octeon-platform.o octeon-irq.o csrc-octeon.o
 obj-y += dma-octeon.o
 obj-y += octeon-memcpy.o
diff --git a/arch/mips/mti-sead3/Makefile b/arch/mips/mti-sead3/Makefile
index ecd71db..2e52cbd 100644
--- a/arch/mips/mti-sead3/Makefile
+++ b/arch/mips/mti-sead3/Makefile
@@ -15,5 +15,3 @@ obj-y				:= sead3-lcd.o sead3-display.o sead3-init.o \
 obj-y				+= leds-sead3.o
 
 obj-$(CONFIG_EARLY_PRINTK)	+= sead3-console.o
-
-CFLAGS_sead3-setup.o = -I$(src)/../../../scripts/dtc/libfdt
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index c1ebbda..c16e836 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -2,7 +2,6 @@
 # Makefile for the linux kernel.
 #
 
-CFLAGS_prom.o		= -I$(src)/../../../scripts/dtc/libfdt
 CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
 
 subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 280bc0a..816dbe9 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -24,8 +24,6 @@ KASAN_SANITIZE			:= n
 lib-y				:= efi-stub-helper.o
 lib-$(CONFIG_EFI_ARMSTUB)	+= arm-stub.o fdt.o
 
-CFLAGS_fdt.o			+= -I$(srctree)/scripts/dtc/libfdt/
-
 #
 # arm64 puts the stub in the kernel proper, which will unnecessarily retain all
 # code indefinitely unless it is annotated as __init/__initdata/__initconst etc.
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index fcacb18..156c072 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -16,6 +16,3 @@ obj-$(CONFIG_OF_RESOLVE)  += resolver.o
 obj-$(CONFIG_OF_OVERLAY) += overlay.o
 
 obj-$(CONFIG_OF_UNITTEST) += unittest-data/
-
-CFLAGS_fdt.o = -I$(src)/../../scripts/dtc/libfdt
-CFLAGS_fdt_address.o = -I$(src)/../../scripts/dtc/libfdt
-- 
2.1.0
