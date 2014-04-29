Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2014 16:35:34 +0200 (CEST)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:30646 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843089AbaD2OcDBeXdV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Apr 2014 16:32:03 +0200
X-IronPort-AV: E=Sophos;i="4.97,951,1389772800"; 
   d="scan'208";a="27211036"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw1-out.broadcom.com with ESMTP; 29 Apr 2014 08:42:28 -0700
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Tue, 29 Apr 2014 07:32:00 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.3.174.1; Tue, 29 Apr 2014 07:32:01 -0700
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 7340451E83;    Tue, 29 Apr 2014 07:32:00 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH 11/17] MIPS: Netlogic: Fix XLP9XX pic entry
Date:   Tue, 29 Apr 2014 20:07:50 +0530
Message-ID: <db9d6d674a9fadeb7bad499ade3d66cc715fb6dd.1398780013.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1398780013.git.jchandra@broadcom.com>
References: <cover.1398780013.git.jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39978
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

Add the compatible property to the PIC entry. Also fix up the nodename
to use the correct address.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/dts/xlp_gvp.dts |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/netlogic/dts/xlp_gvp.dts b/arch/mips/netlogic/dts/xlp_gvp.dts
index 047d27f..bb4ecd1 100644
--- a/arch/mips/netlogic/dts/xlp_gvp.dts
+++ b/arch/mips/netlogic/dts/xlp_gvp.dts
@@ -26,11 +26,12 @@
 			interrupt-parent = <&pic>;
 			interrupts = <17>;
 		};
-		pic: pic@4000 {
-			interrupt-controller;
+		pic: pic@110000 {
+			compatible = "netlogic,xlp-pic";
 			#address-cells = <0>;
 			#interrupt-cells = <1>;
 			reg = <0 0x110000 0x200>;
+			interrupt-controller;
 		};
 
 		nor_flash@1,0 {
-- 
1.7.9.5
