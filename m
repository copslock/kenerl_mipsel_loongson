Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Sep 2011 19:27:53 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5953 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491918Ab1IVR0f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Sep 2011 19:26:35 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e7b70130000>; Thu, 22 Sep 2011 10:27:47 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 22 Sep 2011 10:26:32 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 22 Sep 2011 10:26:30 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id p8MHQR6Y007324;
        Thu, 22 Sep 2011 10:26:27 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p8MHQR1T007323;
        Thu, 22 Sep 2011 10:26:27 -0700
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH v5 1/5] MIPS: Add accessor macros for 64-bit performance counter registers.
Date:   Thu, 22 Sep 2011 10:26:14 -0700
Message-Id: <1316712378-7282-2-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1316712378-7282-1-git-send-email-david.daney@cavium.com>
References: <1316712378-7282-1-git-send-email-david.daney@cavium.com>
X-OriginalArrivalTime: 22 Sep 2011 17:26:32.0157 (UTC) FILETIME=[C54D88D0:01CC794C]
X-archive-position: 31130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12721

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/mipsregs.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index a1f0f32..2619900 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1019,18 +1019,26 @@ do {									\
 #define write_c0_perfctrl0(val)	__write_32bit_c0_register($25, 0, val)
 #define read_c0_perfcntr0()	__read_32bit_c0_register($25, 1)
 #define write_c0_perfcntr0(val)	__write_32bit_c0_register($25, 1, val)
+#define read_c0_perfcntr0_64()	__read_64bit_c0_register($25, 1)
+#define write_c0_perfcntr0_64(val) __write_64bit_c0_register($25, 1, val)
 #define read_c0_perfctrl1()	__read_32bit_c0_register($25, 2)
 #define write_c0_perfctrl1(val)	__write_32bit_c0_register($25, 2, val)
 #define read_c0_perfcntr1()	__read_32bit_c0_register($25, 3)
 #define write_c0_perfcntr1(val)	__write_32bit_c0_register($25, 3, val)
+#define read_c0_perfcntr1_64()	__read_64bit_c0_register($25, 3)
+#define write_c0_perfcntr1_64(val) __write_64bit_c0_register($25, 3, val)
 #define read_c0_perfctrl2()	__read_32bit_c0_register($25, 4)
 #define write_c0_perfctrl2(val)	__write_32bit_c0_register($25, 4, val)
 #define read_c0_perfcntr2()	__read_32bit_c0_register($25, 5)
 #define write_c0_perfcntr2(val)	__write_32bit_c0_register($25, 5, val)
+#define read_c0_perfcntr2_64()	__read_64bit_c0_register($25, 5)
+#define write_c0_perfcntr2_64(val) __write_64bit_c0_register($25, 5, val)
 #define read_c0_perfctrl3()	__read_32bit_c0_register($25, 6)
 #define write_c0_perfctrl3(val)	__write_32bit_c0_register($25, 6, val)
 #define read_c0_perfcntr3()	__read_32bit_c0_register($25, 7)
 #define write_c0_perfcntr3(val)	__write_32bit_c0_register($25, 7, val)
+#define read_c0_perfcntr3_64()	__read_64bit_c0_register($25, 7)
+#define write_c0_perfcntr3_64(val) __write_64bit_c0_register($25, 7, val)
 
 /* RM9000 PerfCount performance counter register */
 #define read_c0_perfcount()	__read_64bit_c0_register($25, 0)
-- 
1.7.2.3
