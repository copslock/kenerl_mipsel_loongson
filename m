Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2014 18:02:29 +0200 (CEST)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:14807 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854776AbaEIQC01zQwa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 May 2014 18:02:26 +0200
X-IronPort-AV: E=Sophos;i="4.97,1019,1389772800"; 
   d="scan'208";a="28926877"
Received: from irvexchcas07.broadcom.com (HELO IRVEXCHCAS07.corp.ad.broadcom.com) ([10.9.208.55])
  by mail-gw1-out.broadcom.com with ESMTP; 09 May 2014 10:18:09 -0700
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Fri, 9 May 2014 09:02:19 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Fri, 9 May 2014 09:02:19 -0700
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 CFEA65D818;    Fri,  9 May 2014 09:02:17 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH 1/5] MIPS: Make MAPPED_KERNEL config option common
Date:   Fri, 9 May 2014 21:39:20 +0530
Message-ID: <1399651764-14202-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1399649304-25856-1-git-send-email-jchandra@broadcom.com>
References: <1399649304-25856-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

This will be needed for the mapped kernel patches for Netlogic XLP.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/Kconfig          |    8 ++++++++
 arch/mips/sgi-ip27/Kconfig |    8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d0bcfce..acf85a8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2093,6 +2093,14 @@ config SB1_PASS_2_1_WORKAROUNDS
 	depends on CPU_SB1 && CPU_SB1_PASS_2
 	default y
 
+config MAPPED_KERNEL
+	bool "Mapped kernel support"
+	depends on SGI_IP27
+	help
+	  Change the way a Linux kernel is loaded into memory on a MIPS64
+	  machine.  This is required in order to support text replication on
+	  NUMA.  If you need to understand it, read the source code.
+
 
 config 64BIT_PHYS_ADDR
 	bool
diff --git a/arch/mips/sgi-ip27/Kconfig b/arch/mips/sgi-ip27/Kconfig
index 4d8705a..2c9dd3d 100644
--- a/arch/mips/sgi-ip27/Kconfig
+++ b/arch/mips/sgi-ip27/Kconfig
@@ -21,14 +21,6 @@ config SGI_SN_N_MODE
 
 endchoice
 
-config MAPPED_KERNEL
-	bool "Mapped kernel support"
-	depends on SGI_IP27
-	help
-	  Change the way a Linux kernel is loaded into memory on a MIPS64
-	  machine.  This is required in order to support text replication on
-	  NUMA.  If you need to understand it, read the source code.
-
 config REPLICATE_KTEXT
 	bool "Kernel text replication support"
 	depends on SGI_IP27
-- 
1.7.9.5
