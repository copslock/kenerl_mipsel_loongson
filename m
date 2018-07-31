Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2018 16:30:49 +0200 (CEST)
Received: from mail-c.ads.isi.edu ([128.9.180.198]:9794 "EHLO
        mail-c.ads.isi.edu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993354AbeGaOaQOOefh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jul 2018 16:30:16 +0200
X-IronPort-AV: E=Sophos;i="5.51,427,1526367600"; 
   d="scan'208";a="6769796"
Received: from guest228.east.isi.edu (HELO localhost) ([65.123.202.228])
  by mail-c.ads.isi.edu with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2018 07:30:06 -0700
From:   Alexei Colin <acolin@isi.edu>
To:     Alexandre Bounine <alex.bou9@gmail.com>,
        Matt Porter <mporter@kernel.crashing.org>
Cc:     Alexei Colin <acolin@isi.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Paul Walters <jwalters@isi.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Anvin <hpa@zytor.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 1/6] rapidio: define top Kconfig menu in driver subtree
Date:   Tue, 31 Jul 2018 10:29:49 -0400
Message-Id: <20180731142954.30345-2-acolin@isi.edu>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731142954.30345-1-acolin@isi.edu>
References: <20180731142954.30345-1-acolin@isi.edu>
Return-Path: <acolin@isi.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: acolin@isi.edu
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

The top-level Kconfig entry for RapidIO subsystem is currently
duplicated in several architecture-specific Kconfigs. This
commit re-defines it in the driver subtree, and subsequent
commits, one per architecture, will remove the duplicated
definitions from respective per-architecture Kconfigs.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Paul Walters <jwalters@isi.edu>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Anvin <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-mips@linux-mips.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alexei Colin <acolin@isi.edu>
---
 drivers/rapidio/Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/rapidio/Kconfig b/drivers/rapidio/Kconfig
index d6d2f20c4597..98e301847584 100644
--- a/drivers/rapidio/Kconfig
+++ b/drivers/rapidio/Kconfig
@@ -1,6 +1,21 @@
 #
 # RapidIO configuration
 #
+
+config HAS_RAPIDIO
+	bool
+	default n
+
+config RAPIDIO
+	tristate "RapidIO support"
+	depends on HAS_RAPIDIO || PCI
+	help
+	  This feature enables support for RapidIO high-performance
+	  packet-switched interconnect.
+
+	  If you say Y here, the kernel will include drivers and
+	  infrastructure code to support RapidIO interconnect devices.
+
 source "drivers/rapidio/devices/Kconfig"
 
 config RAPIDIO_DISC_TIMEOUT
-- 
2.18.0
