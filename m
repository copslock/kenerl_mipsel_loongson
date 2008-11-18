Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2008 22:25:11 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9006 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23754597AbYKRWX6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Nov 2008 22:23:58 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4923406e0005>; Tue, 18 Nov 2008 17:23:42 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 18 Nov 2008 14:23:40 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 18 Nov 2008 14:23:40 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mAIMNZXx004830;
	Tue, 18 Nov 2008 14:23:35 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mAIMNZbc004829;
	Tue, 18 Nov 2008 14:23:35 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 06/26] MIPS: Add Cavium OCTEON specific register definitions to mipsregs.h
Date:	Tue, 18 Nov 2008 14:23:21 -0800
Message-Id: <1227047013-4785-6-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <49233FDE.3010404@caviumnetworks.com>
References: <49233FDE.3010404@caviumnetworks.com>
X-OriginalArrivalTime: 18 Nov 2008 22:23:40.0144 (UTC) FILETIME=[4ED3F700:01C949CC]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/mipsregs.h |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 9316324..207d098 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1000,6 +1000,26 @@ do {									\
 #define read_c0_ebase()		__read_32bit_c0_register($15, 1)
 #define write_c0_ebase(val)	__write_32bit_c0_register($15, 1, val)
 
+
+/* Cavium OCTEON (cnMIPS) */
+#define read_c0_cvmcount()	__read_ulong_c0_register($9, 6)
+#define write_c0_cvmcount(val)	__write_ulong_c0_register($9, 6, val)
+
+#define read_c0_cvmctl()	__read_64bit_c0_register($9, 7)
+#define write_c0_cvmctl(val)	__write_64bit_c0_register($9, 7, val)
+
+#define read_c0_cvmmemctl()	__read_64bit_c0_register($11, 7)
+#define write_c0_cvmmemctl(val)	__write_64bit_c0_register($11, 7, val)
+/*
+ * The cacheerr registers are not standardized.  On OCTEON, they are
+ * 64 bits wide.
+ */
+#define read_octeon_c0_icacheerr()	__read_64bit_c0_register($27, 0)
+#define write_octeon_c0_icacheerr(val)	__write_64bit_c0_register($27, 0, val)
+
+#define read_octeon_c0_dcacheerr()	__read_64bit_c0_register($27, 1)
+#define write_octeon_c0_dcacheerr(val)	__write_64bit_c0_register($27, 1, val)
+
 /*
  * Macros to access the floating point coprocessor control registers
  */
-- 
1.5.6.5
