Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2013 19:58:11 +0100 (CET)
Received: from mxout1.idt.com ([157.165.5.25]:51274 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867263Ab3LRS6FI7QS- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Dec 2013 19:58:05 +0100
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id rBIIvjlo003366;
        Wed, 18 Dec 2013 10:57:45 -0800
Received: from corpml1.corp.idt.com (corpml1.corp.idt.com [157.165.140.20])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id rBIIviBF005769;
        Wed, 18 Dec 2013 10:57:44 -0800 (PST)
Received: from kaneng03.ott.idt.com (kaneng03.ott.idt.com [10.1.0.147])
        by corpml1.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id rBIIvh119239;
        Wed, 18 Dec 2013 10:57:43 -0800 (PST)
Received: from kaneng03.ott.idt.com (localhost.localdomain [127.0.0.1])
        by kaneng03.ott.idt.com (8.13.8/8.13.8) with ESMTP id rBIIvfWa010150;
        Wed, 18 Dec 2013 13:57:41 -0500
Received: (from abounine@localhost)
        by kaneng03.ott.idt.com (8.13.8/8.13.8/Submit) id rBIIvdDU010148;
        Wed, 18 Dec 2013 13:57:39 -0500
From:   Alexandre Bounine <alexandre.bounine@idt.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Alexandre Bounine <alexandre.bounine@idt.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Jean Delvare <jdelvare@suse.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Li Yang <leoli@freescale.com>, linux-mips@linux-mips.org
Subject: [PATCH] rapidio: add modular rapidio core build into powerpc and mips branches
Date:   Wed, 18 Dec 2013 13:57:35 -0500
Message-Id: <1387393055-10114-1-git-send-email-alexandre.bounine@idt.com>
X-Mailer: git-send-email 1.7.8.4
X-Scanned-By: MIMEDefang 2.43
Return-Path: <abounine@idt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.bounine@idt.com
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

Allow modular build option for RapidIO subsystem core in MIPS and PowerPC
architectural branches.

At this moment modular RapidIO subsystem build is enabled only for platforms
that use PCI/PCIe based RapidIO controllers (e.g. Tsi721).

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Jean Delvare <jdelvare@suse.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Li Yang <leoli@freescale.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/Kconfig    |    2 +-
 arch/powerpc/Kconfig |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 650de39..e6a8a7a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2442,7 +2442,7 @@ source "drivers/pcmcia/Kconfig"
 source "drivers/pci/hotplug/Kconfig"
 
 config RAPIDIO
-	bool "RapidIO support"
+	tristate "RapidIO support"
 	depends on PCI
 	default n
 	help
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b44b52c..992531f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -790,7 +790,7 @@ config HAS_RAPIDIO
 	default n
 
 config RAPIDIO
-	bool "RapidIO support"
+	tristate "RapidIO support"
 	depends on HAS_RAPIDIO || PCI
 	help
 	  If you say Y here, the kernel will include drivers and
@@ -798,7 +798,7 @@ config RAPIDIO
 
 config FSL_RIO
 	bool "Freescale Embedded SRIO Controller support"
-	depends on RAPIDIO && HAS_RAPIDIO
+	depends on RAPIDIO = y && HAS_RAPIDIO
 	default "n"
 	---help---
 	  Include support for RapidIO controller on Freescale embedded
-- 
1.7.8.4
