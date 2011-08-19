Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2011 20:44:18 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11735 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491867Ab1HSSoK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2011 20:44:10 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e4eaf3c0000>; Fri, 19 Aug 2011 11:45:16 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 19 Aug 2011 11:44:07 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 19 Aug 2011 11:44:07 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id p7JIi4l1012556;
        Fri, 19 Aug 2011 11:44:05 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p7JIi2NH012555;
        Fri, 19 Aug 2011 11:44:03 -0700
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        Jason Kwon <jason.kwon@ericsson.com>
Subject: [PATCH] MIPS: Octeon: Select CONFIG_HOLES_IN_ZONE
Date:   Fri, 19 Aug 2011 11:44:00 -0700
Message-Id: <1313779440-12522-1-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 19 Aug 2011 18:44:07.0583 (UTC) FILETIME=[FA1BAAF0:01CC5E9F]
X-archive-position: 30924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14632

Current Octeon systems do in fact have holes in their memory zones.
We need to select HOLES_IN_ZONE.  If we do not, some memory
configurations will result in crashes at boot time like this:

.
.
.
CPU 6 Unable to handle kernel paging request at virtual address 0000000000700000, epc == ffffffff8118fe00, ra == ffffffff8118fe9c
Oops[#1]:
Cpu 6
.
.
.
        ...
Call Trace:
[<ffffffff8118fe00>] setup_per_zone_wmarks+0x1b0/0x338
[<ffffffff815cd738>] init_per_zone_wmark_min+0x64/0xd0
[<ffffffff81100438>] do_one_initcall+0x38/0x160
.
.
.

Reported-by: Jason Kwon <jason.kwon@ericsson.com>
Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Jason Kwon <jason.kwon@ericsson.com>
---
Jason, can you test this patch?

Ralf, if Jason reports that it fixes his problem, it probably is
needed for 3.0 and 3.1.

 arch/mips/Kconfig |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d300c2b..b122adc 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -723,6 +723,7 @@ config CAVIUM_OCTEON_SIMULATOR
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_HOTPLUG_CPU
 	select SYS_HAS_CPU_CAVIUM_OCTEON
+	select HOLES_IN_ZONE
 	help
 	  The Octeon simulator is software performance model of the Cavium
 	  Octeon Processor. It supports simulating Octeon processors on x86
@@ -745,6 +746,7 @@ config CAVIUM_OCTEON_REFERENCE_BOARD
 	select ZONE_DMA32
 	select USB_ARCH_HAS_OHCI
 	select USB_ARCH_HAS_EHCI
+	select HOLES_IN_ZONE
 	help
 	  This option supports all of the Octeon reference boards from Cavium
 	  Networks. It builds a kernel that dynamically determines the Octeon
@@ -974,6 +976,9 @@ config ISA_DMA_API
 config GENERIC_GPIO
 	bool
 
+config HOLES_IN_ZONE
+	bool
+
 #
 # Endianess selection.  Sufficiently obscure so many users don't know what to
 # answer,so we try hard to limit the available choices.  Also the use of a
-- 
1.7.2.3
