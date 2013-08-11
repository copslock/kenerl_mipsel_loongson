Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Aug 2013 11:19:02 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:4008 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824926Ab3HKJNftJGwW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Aug 2013 11:13:35 +0200
Received: from [10.9.208.57] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sun, 11 Aug 2013 02:07:04 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sun, 11 Aug 2013 02:13:12 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Sun, 11 Aug 2013 02:13:12 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id AFE90F2D72; Sun, 11
 Aug 2013 02:13:11 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 03/10] MIPS: Netlogic: Fix DT flash size parameter
Date:   Sun, 11 Aug 2013 14:43:53 +0530
Message-ID: <1376212440-21038-4-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1376212440-21038-1-git-send-email-jchandra@broadcom.com>
References: <1376212440-21038-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7E198BB21R079371330-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37519
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

The flash chipselects can span 32MB, fix this in the built-in device
tree.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/dts/xlp_evp.dts |    2 +-
 arch/mips/netlogic/dts/xlp_svp.dts |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/netlogic/dts/xlp_evp.dts b/arch/mips/netlogic/dts/xlp_evp.dts
index 7862a6f..89ad048 100644
--- a/arch/mips/netlogic/dts/xlp_evp.dts
+++ b/arch/mips/netlogic/dts/xlp_evp.dts
@@ -14,7 +14,7 @@
 		#size-cells = <1>;
 		compatible = "simple-bus";
 		ranges = <0 0  0 0x18000000  0x04000000   // PCIe CFG
-			  1 0  0 0x16000000  0x01000000>; // GBU chipselects
+			  1 0  0 0x16000000  0x02000000>; // GBU chipselects
 
 		serial0: serial@30000 {
 			device_type = "serial";
diff --git a/arch/mips/netlogic/dts/xlp_svp.dts b/arch/mips/netlogic/dts/xlp_svp.dts
index 5aba17e..1ebd00ed 100644
--- a/arch/mips/netlogic/dts/xlp_svp.dts
+++ b/arch/mips/netlogic/dts/xlp_svp.dts
@@ -14,7 +14,7 @@
 		#size-cells = <1>;
 		compatible = "simple-bus";
 		ranges = <0 0  0 0x18000000  0x04000000   // PCIe CFG
-			  1 0  0 0x16000000  0x01000000>; // GBU chipselects
+			  1 0  0 0x16000000  0x02000000>; // GBU chipselects
 
 		serial0: serial@30000 {
 			device_type = "serial";
-- 
1.7.9.5
