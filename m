Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2006 18:21:41 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:20233 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133720AbWBQSVV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Feb 2006 18:21:21 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 990BE64D59; Fri, 17 Feb 2006 18:27:59 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id AAB4A8F77; Fri, 17 Feb 2006 18:27:51 +0000 (GMT)
Date:	Fri, 17 Feb 2006 18:27:51 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] Enable VIA82CXXX and TULIP in Cobalt defconfig
Message-ID: <20060217182747.GA25475@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

All MIPS based Cobalt machines have an in-built VIA82CXXX IDE chip and
Tulip Ethernet.  It therefore makes sense to activate those in the Cobalt
defconfig.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

---

 cobalt_defconfig |   44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/arch/mips/configs/cobalt_defconfig b/arch/mips/configs/cobalt_defconfig
index b08c852..8336b21 100644
--- a/arch/mips/configs/cobalt_defconfig
+++ b/arch/mips/configs/cobalt_defconfig
@@ -370,9 +370,38 @@ CONFIG_BLK_DEV_IDEDISK=y
 # IDE chipset support/bugfixes
 #
 CONFIG_IDE_GENERIC=y
-# CONFIG_BLK_DEV_IDEPCI is not set
+CONFIG_BLK_DEV_IDEPCI=y
+# CONFIG_IDEPCI_SHARE_IRQ is not set
+# CONFIG_BLK_DEV_OFFBOARD is not set
+# CONFIG_BLK_DEV_GENERIC is not set
+# CONFIG_BLK_DEV_OPTI621 is not set
+CONFIG_BLK_DEV_IDEDMA_PCI=y
+# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
+# CONFIG_IDEDMA_PCI_AUTO is not set
+# CONFIG_BLK_DEV_AEC62XX is not set
+# CONFIG_BLK_DEV_ALI15X3 is not set
+# CONFIG_BLK_DEV_AMD74XX is not set
+# CONFIG_BLK_DEV_CMD64X is not set
+# CONFIG_BLK_DEV_TRIFLEX is not set
+# CONFIG_BLK_DEV_CY82C693 is not set
+# CONFIG_BLK_DEV_CS5520 is not set
+# CONFIG_BLK_DEV_CS5530 is not set
+# CONFIG_BLK_DEV_HPT34X is not set
+# CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_SC1200 is not set
+# CONFIG_BLK_DEV_PIIX is not set
+# CONFIG_BLK_DEV_IT821X is not set
+# CONFIG_BLK_DEV_NS87415 is not set
+# CONFIG_BLK_DEV_PDC202XX_OLD is not set
+# CONFIG_BLK_DEV_PDC202XX_NEW is not set
+# CONFIG_BLK_DEV_SVWKS is not set
+# CONFIG_BLK_DEV_SIIMAGE is not set
+# CONFIG_BLK_DEV_SLC90E66 is not set
+# CONFIG_BLK_DEV_TRM290 is not set
+CONFIG_BLK_DEV_VIA82CXXX=y
 # CONFIG_IDE_ARM is not set
-# CONFIG_BLK_DEV_IDEDMA is not set
+CONFIG_BLK_DEV_IDEDMA=y
+# CONFIG_IDEDMA_IVB is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_BLK_DEV_HD is not set
 
@@ -444,7 +473,16 @@ CONFIG_NET_ETHERNET=y
 #
 # Tulip family network device support
 #
-# CONFIG_NET_TULIP is not set
+CONFIG_NET_TULIP=y
+CONFIG_DE2104X=y
+CONFIG_TULIP=y
+# CONFIG_TULIP_MWI is not set
+# CONFIG_TULIP_MMIO is not set
+# CONFIG_TULIP_NAPI is not set
+# CONFIG_DE4X5 is not set
+# CONFIG_WINBOND_840 is not set
+# CONFIG_DM9102 is not set
+# CONFIG_ULI526X is not set
 # CONFIG_HP100 is not set
 # CONFIG_NET_PCI is not set
 

-- 
Martin Michlmayr
http://www.cyrius.com/
