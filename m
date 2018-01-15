Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jan 2018 22:19:20 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:42952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994647AbeAOVTMrHeax (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Jan 2018 22:19:12 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 199EF2178B;
        Mon, 15 Jan 2018 21:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199EF2178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH for-4.15] ssb: Disable PCI host for PCI_DRIVERS_GENERIC
Date:   Mon, 15 Jan 2018 21:17:14 +0000
Message-Id: <20180115211714.24009-1-jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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

Since commit d41e6858ba58 ("MIPS: Kconfig: Set default MIPS system type
as generic") changed the default MIPS platform to the "generic"
platform, which uses PCI_DRIVERS_GENERIC instead of PCI_DRIVERS_LEGACY,
various files in drivers/ssb/ have failed to build.

This is particularly due to the existence of struct pci_controller being
dependent on PCI_DRIVERS_LEGACY since commit c5611df96804 ("MIPS: PCI:
Introduce CONFIG_PCI_DRIVERS_LEGACY"), so add that dependency to Kconfig
to prevent these files being built for the "generic" platform including
all{yes,mod}config builds.

Fixes: c5611df96804 ("MIPS: PCI: Introduce CONFIG_PCI_DRIVERS_LEGACY")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Michael Buesch <m@bues.ch>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-wireless@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 drivers/ssb/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
index d8e4219c2324..71c73766ee22 100644
--- a/drivers/ssb/Kconfig
+++ b/drivers/ssb/Kconfig
@@ -32,7 +32,7 @@ config SSB_BLOCKIO
 
 config SSB_PCIHOST_POSSIBLE
 	bool
-	depends on SSB && (PCI = y || PCI = SSB)
+	depends on SSB && (PCI = y || PCI = SSB) && PCI_DRIVERS_LEGACY
 	default y
 
 config SSB_PCIHOST
-- 
2.13.6
