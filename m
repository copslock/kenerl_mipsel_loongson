Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jul 2015 03:12:03 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:38704 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011337AbbGPBMBC0UMj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Jul 2015 03:12:01 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1ZFXiN-0007hk-4P; Thu, 16 Jul 2015 01:11:55 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1ZFXiK-0002mM-RW; Wed, 15 Jul 2015 18:11:52 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Paul Martin <paul.martin@codethink.co.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.19.y-ckt 234/251] MIPS: Octeon: Set OHCI and EHCI MMIO byte order to match CPU
Date:   Wed, 15 Jul 2015 18:09:15 -0700
Message-Id: <1437008972-9140-235-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1437008972-9140-1-git-send-email-kamal@canonical.com>
References: <1437008972-9140-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.19
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

3.19.8-ckt4 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

commit df115f3ee9ea703e1209392cd08f8d6783244721 upstream.

The Octeon OHCI is now supported by the ohci-platform driver, and
USB_OCTEON_OHCI is marked as deprecated.  However, it is currently
still necessary to enable it in order to select
USB_OHCI_BIG_ENDIAN_MMIO.  Make CPU_CAVIUM_OCTEON select that as well,
so that USB_OCTEON_OHCI is really obsolete.

The old ohci-octeon and ehci-octeon drivers also only enabled big-endian
MMIO in case the CPU was big-endian.  Make the selections of
USB_EHCI_BIG_ENDIAN_MMIO and USB_OHCI_BIG_ENDIAN_MMIO conditional, to
match this.

Fixes: 2193dda5eec6 ("USB: host: Remove ehci-octeon and ohci-octeon drivers")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-mips@linux-mips.org
Cc: David Daney <david.daney@cavium.com>
Cc: Chandrakala Chavva <cchavva@caviumnetworks.com>
Cc: Paul Martin <paul.martin@codethink.co.uk>
Patchwork: https://patchwork.linux-mips.org/patch/10178/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/Kconfig        | 3 ++-
 drivers/usb/host/Kconfig | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 843713c..2a50476 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1484,7 +1484,8 @@ config CPU_CAVIUM_OCTEON
 	select WEAK_ORDERING
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_HUGEPAGES
-	select USB_EHCI_BIG_ENDIAN_MMIO
+	select USB_EHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
+	select USB_OHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
 	select MIPS_L1_CACHE_SHIFT_7
 	help
 	  The Cavium Octeon processor is a highly integrated chip containing
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index fafc628..c87e6e7 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -295,7 +295,7 @@ config USB_OCTEON_EHCI
 	bool "Octeon on-chip EHCI support (DEPRECATED)"
 	depends on CAVIUM_OCTEON_SOC
 	default n
-	select USB_EHCI_BIG_ENDIAN_MMIO
+	select USB_EHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
 	select USB_EHCI_HCD_PLATFORM
 	help
 	  This option is deprecated now and the driver was removed, use
@@ -582,7 +582,7 @@ config USB_OCTEON_OHCI
 	bool "Octeon on-chip OHCI support (DEPRECATED)"
 	depends on CAVIUM_OCTEON_SOC
 	default USB_OCTEON_EHCI
-	select USB_OHCI_BIG_ENDIAN_MMIO
+	select USB_OHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
 	select USB_OHCI_LITTLE_ENDIAN
 	select USB_OHCI_HCD_PLATFORM
 	help
-- 
1.9.1
