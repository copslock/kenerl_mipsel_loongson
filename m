Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2018 00:51:16 +0200 (CEST)
Received: from mail-d.ads.isi.edu ([128.9.180.199]:8922 "EHLO
        mail-d.ads.isi.edu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993066AbeG3WvEJz40Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jul 2018 00:51:04 +0200
X-IronPort-AV: E=Sophos;i="5.51,424,1526367600"; 
   d="scan'208";a="2623820"
Received: from guest228.east.isi.edu (HELO localhost) ([65.123.202.228])
  by mail-d.ads.isi.edu with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 15:51:02 -0700
From:   Alexei Colin <acolin@isi.edu>
To:     Alexandre Bounine <alex.bou9@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     Alexei Colin <acolin@isi.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        John Paul Walters <jwalters@isi.edu>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] mips: factor out RapidIO Kconfig entry
Date:   Mon, 30 Jul 2018 18:50:32 -0400
Message-Id: <20180730225035.28365-5-acolin@isi.edu>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180730225035.28365-1-acolin@isi.edu>
References: <20180730225035.28365-1-acolin@isi.edu>
Return-Path: <acolin@isi.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65267
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

The menu entry is now defined in the rapidio subtree.

Platforms with a PCI bus will be offered the RapidIO menu since they may
be want support for a RapidIO PCI device. Platforms without a PCI bus
that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
in the platform-/machine-specific "config ARCH_*" Kconfig entry.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: John Paul Walters <jwalters@isi.edu>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alexei Colin <acolin@isi.edu>
---
 arch/mips/Kconfig | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 10256056647c..92b9262ee731 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3106,17 +3106,6 @@ config ZONE_DMA32
 
 source "drivers/pcmcia/Kconfig"
 
-config HAS_RAPIDIO
-	bool
-	default n
-
-config RAPIDIO
-	tristate "RapidIO support"
-	depends on HAS_RAPIDIO || PCI
-	help
-	  If you say Y here, the kernel will include drivers and
-	  infrastructure code to support RapidIO interconnect devices.
-
 source "drivers/rapidio/Kconfig"
 
 endmenu
-- 
2.18.0
