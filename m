Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Nov 2017 11:21:35 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:40466 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990502AbdKHKV2Adz1- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Nov 2017 11:21:28 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 08 Nov 2017 10:21:18 +0000
Received: from jhogan-linux.mipstec.com (192.168.154.110) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Wed, 8 Nov 2017 02:19:52 -0800
From:   James Hogan <james.hogan@mips.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "John Crispin" <john@phrozen.org>
Subject: [PATCH] MIPS: ralink: Drop obsolete USB_ARCH_HAS_HCD select
Date:   Wed, 8 Nov 2017 10:20:59 +0000
Message-ID: <20171108102059.21813-1-james.hogan@mips.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510136478-452059-8513-31195-1
X-BESS-VER: 2017.14.1-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186712
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

From: James Hogan <jhogan@kernel.org>

Building an allnoconfig kernel based on the ralink platform results in
the following warning:

warning: (SOC_RT305X) selects USB_ARCH_HAS_HCD which has unmet direct dependencies (USB_SUPPORT)

This is because SOC_RT305X unconditionally selects USB_ARCH_HAS_HCD
which depends on USB_SUPPORT.

However USB_ARCH_HAS_HCD has been effectively obsolete since commit
d9ea21a77927 ("usb: host: make USB_ARCH_HAS_?HCI obsolete") in 3.11.
USB_ARCH_HAS_HCD is now set by default whenever USB_SUPPORT is, so drop
the select to silence the warning.

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/ralink/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index f26736b7080b..1f9cb0e3c79a 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -31,7 +31,6 @@ choice
 
 	config SOC_RT305X
 		bool "RT305x"
-		select USB_ARCH_HAS_HCD
 
 	config SOC_RT3883
 		bool "RT3883"
-- 
2.14.1
