From: Ben Hutchings <ben@decadent.org.uk>
Date: Mon, 25 May 2015 20:27:29 +0100
Subject: MIPS: Octeon: Set OHCI and EHCI MMIO byte order to match CPU
Message-ID: <20150525192729.C2_uUigzYuAOyI_X7oDjUZ1Pd6jztmqKzF7VEz9qsk8@z>

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
