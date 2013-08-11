Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Aug 2013 11:15:40 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:1122 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822995Ab3HKJNaOgWsy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Aug 2013 11:13:30 +0200
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sun, 11 Aug 2013 02:09:20 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sun, 11 Aug 2013 02:13:11 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Sun, 11 Aug 2013 02:13:11 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 4D190F2D74; Sun, 11
 Aug 2013 02:13:10 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 02/10] MIPS: Netlogic: Remove memory section from
 built-in DT
Date:   Sun, 11 Aug 2013 14:43:52 +0530
Message-ID: <1376212440-21038-3-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1376212440-21038-1-git-send-email-jchandra@broadcom.com>
References: <1376212440-21038-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7E198B4A31W83115092-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37514
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

Do not pass a memory section in the built-in DTB, and let the
boot code use the values from the DRAM BARs.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/dts/xlp_evp.dts |    7 -------
 arch/mips/netlogic/dts/xlp_svp.dts |    7 -------
 2 files changed, 14 deletions(-)

diff --git a/arch/mips/netlogic/dts/xlp_evp.dts b/arch/mips/netlogic/dts/xlp_evp.dts
index 0640703..7862a6f 100644
--- a/arch/mips/netlogic/dts/xlp_evp.dts
+++ b/arch/mips/netlogic/dts/xlp_evp.dts
@@ -9,13 +9,6 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	memory {
-		device_type = "memory";
-		reg =  <0 0x00100000 0 0x0FF00000	// 255M at 1M
-			0 0x20000000 0 0xa0000000	// 2560M at 512M
-			0 0xe0000000 1 0x00000000>;
-	};
-
 	soc {
 		#address-cells = <2>;
 		#size-cells = <1>;
diff --git a/arch/mips/netlogic/dts/xlp_svp.dts b/arch/mips/netlogic/dts/xlp_svp.dts
index 9c5db10..5aba17e 100644
--- a/arch/mips/netlogic/dts/xlp_svp.dts
+++ b/arch/mips/netlogic/dts/xlp_svp.dts
@@ -9,13 +9,6 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	memory {
-		device_type = "memory";
-		reg =  <0 0x00100000 0 0x0FF00000	// 255M at 1M
-			0 0x20000000 0 0xa0000000	// 2560M at 512M
-			0 0xe0000000 0 0x40000000>;
-	};
-
 	soc {
 		#address-cells = <2>;
 		#size-cells = <1>;
-- 
1.7.9.5
