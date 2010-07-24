Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jul 2010 03:43:56 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16616 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492623Ab0GXBmT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jul 2010 03:42:19 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c4a45140001>; Fri, 23 Jul 2010 18:42:44 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 18:42:17 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 18:42:17 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6O1gDcH004070;
        Fri, 23 Jul 2010 18:42:13 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6O1gCFB004069;
        Fri, 23 Jul 2010 18:42:12 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org, wim@iguana.be
Cc:     linux-kernel@vger.kernel.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 6/7] MIPS: Define ST0_NMI in asm/mipsregs.h
Date:   Fri, 23 Jul 2010 18:41:46 -0700
Message-Id: <1279935707-3997-7-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1279935707-3997-1-git-send-email-ddaney@caviumnetworks.com>
References: <1279935707-3997-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Jul 2010 01:42:17.0187 (UTC) FILETIME=[72BF6B30:01CB2AD1]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This is used by the forthcoming OCTEON watchdog patch.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/mipsregs.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index c6e3c93..335474c 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -408,6 +408,7 @@
 #define  STATUSB_IP15		7
 #define  STATUSF_IP15		(_ULCAST_(1) <<  7)
 #define ST0_CH			0x00040000
+#define ST0_NMI			0x00080000
 #define ST0_SR			0x00100000
 #define ST0_TS			0x00200000
 #define ST0_BEV			0x00400000
-- 
1.7.1.1
