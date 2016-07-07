Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2016 09:51:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44697 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992400AbcGGHvZ4WeD6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jul 2016 09:51:25 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 374B079724715;
        Thu,  7 Jul 2016 08:51:17 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (192.168.154.116) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 7 Jul 2016 08:51:19 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] MIPS: Move CPU Hotplug config option into submenu
Date:   Thu, 7 Jul 2016 08:50:40 +0100
Message-ID: <1467877840-32569-4-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1467877840-32569-1-git-send-email-matt.redfearn@imgtec.com>
References: <1467877840-32569-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

The KConfig option HOTPLUG_CPU should appear in the "Kernel Type"
submenu. Relocate it to where SMP support is configured.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 arch/mips/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ac91939b9b75..fd06bccf2011 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1111,16 +1111,6 @@ config NEED_DMA_MAP_STATE
 config SYS_HAS_EARLY_PRINTK
 	bool
 
-config HOTPLUG_CPU
-	bool "Support for hot-pluggable CPUs"
-	depends on SMP && SYS_SUPPORTS_HOTPLUG_CPU
-	help
-	  Say Y here to allow turning CPUs off and on. CPUs can be
-	  controlled through /sys/devices/system/cpu.
-	  (Note: power management support will enable this option
-	    automatically on SMP systems. )
-	  Say N if you want to disable CPU hotplug.
-
 config SYS_SUPPORTS_HOTPLUG_CPU
 	bool
 
@@ -2634,6 +2624,16 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
+config HOTPLUG_CPU
+	bool "Support for hot-pluggable CPUs"
+	depends on SMP && SYS_SUPPORTS_HOTPLUG_CPU
+	help
+	  Say Y here to allow turning CPUs off and on. CPUs can be
+	  controlled through /sys/devices/system/cpu.
+	  (Note: power management support will enable this option
+	    automatically on SMP systems. )
+	  Say N if you want to disable CPU hotplug.
+
 config SMP_UP
 	bool
 
-- 
2.7.4
