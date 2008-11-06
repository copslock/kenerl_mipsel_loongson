Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Nov 2008 20:58:21 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:45978 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23298200AbYKFUz1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Nov 2008 20:55:27 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4913599e0000>; Thu, 06 Nov 2008 15:54:54 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Nov 2008 12:54:54 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Nov 2008 12:54:53 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mA6Ksmmo027716;
	Thu, 6 Nov 2008 12:54:48 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mA6KsmQ0027715;
	Thu, 6 Nov 2008 12:54:48 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 10/29] MIPS: Add Cavium OCTEON specific register definitions to mipsregs.h
Date:	Thu,  6 Nov 2008 12:54:23 -0800
Message-Id: <1226004875-27654-10-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <491358F5.7040002@caviumnetworks.com>
References: <491358F5.7040002@caviumnetworks.com>
X-OriginalArrivalTime: 06 Nov 2008 20:54:53.0902 (UTC) FILETIME=[EB2EEEE0:01C94051]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21204
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
