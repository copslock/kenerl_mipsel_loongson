Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2016 16:08:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12004 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992607AbcGSOIQ4E7hv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jul 2016 16:08:16 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1709CE893CDC2;
        Tue, 19 Jul 2016 15:08:07 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (192.168.154.116) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 19 Jul 2016 15:08:10 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: OCTEON: cavium_octeon_defconfig: Enable OCTEON SATA
Date:   Tue, 19 Jul 2016 15:08:06 +0100
Message-ID: <1468937286-13454-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54347
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

Commit a2127e400edd ("libata: support AHCI on OCTEON platform") added a
driver for the OCTEON AHCI controller. Enable this driver in the OCTEON
defconfig.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 arch/mips/configs/cavium_octeon_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/configs/cavium_octeon_defconfig b/arch/mips/configs/cavium_octeon_defconfig
index dcac308cec39..d470d08362c0 100644
--- a/arch/mips/configs/cavium_octeon_defconfig
+++ b/arch/mips/configs/cavium_octeon_defconfig
@@ -59,6 +59,8 @@ CONFIG_EEPROM_AT25=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
+CONFIG_SATA_AHCI_PLATFORM=y
+CONFIG_AHCI_OCTEON=y
 CONFIG_PATA_OCTEON_CF=y
 CONFIG_SATA_SIL=y
 CONFIG_NETDEVICES=y
-- 
2.7.4
