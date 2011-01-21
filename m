Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Jan 2011 00:00:22 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13204 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491834Ab1AUW74 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jan 2011 23:59:56 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d3a101b0000>; Fri, 21 Jan 2011 15:00:43 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 21 Jan 2011 14:59:54 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 21 Jan 2011 14:59:53 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p0LMxmsQ028486;
        Fri, 21 Jan 2011 14:59:48 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p0LMxlNb028485;
        Fri, 21 Jan 2011 14:59:47 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH v2 1/4] MIPS: Add accessor macros for 64-bit performance counter registers.
Date:   Fri, 21 Jan 2011 14:59:33 -0800
Message-Id: <1295650776-28444-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1295650776-28444-1-git-send-email-ddaney@caviumnetworks.com>
References: <1295650776-28444-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 21 Jan 2011 22:59:54.0016 (UTC) FILETIME=[EA8C0200:01CBB9BE]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/mipsregs.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index d5c9eaa..86c7ec1 100644
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
