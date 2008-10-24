Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 02:04:24 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1127 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22251717AbYJXA63 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 01:58:29 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49011d670004>; Thu, 23 Oct 2008 20:57:11 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:11 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:09 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9O0v5Dd005641;
	Thu, 23 Oct 2008 17:57:05 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9O0v5PV005640;
	Thu, 23 Oct 2008 17:57:05 -0700
From:	ddaney@caviumnetworks.com
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 20/37] Cavium OCTEON: add in icache and dcache error functions.
Date:	Thu, 23 Oct 2008 17:56:44 -0700
Message-Id: <1224809821-5532-21-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Oct 2008 00:57:09.0923 (UTC) FILETIME=[718B3730:01C93573]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

From: David Daney <ddaney@caviumnetworks.com>

If there is an icache or dcache error, there is additional data to
be had from the 64bit read of c0 @ $27.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/mipsregs.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 9798660..4a1feb5 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -966,7 +966,12 @@ do {									\
 #define read_c0_derraddr0()	__read_ulong_c0_register($26, 1)
 #define write_c0_derraddr0(val)	__write_ulong_c0_register($26, 1, val)
 
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+#define read_c0_cacheerr()	__read_64bit_c0_register($27, 0)
+#define write_c0_cacheerr(val)	__write_64bit_c0_register($27, 0, val)
+#else
 #define read_c0_cacheerr()	__read_32bit_c0_register($27, 0)
+#endif
 
 #define read_c0_derraddr1()	__read_ulong_c0_register($27, 1)
 #define write_c0_derraddr1(val)	__write_ulong_c0_register($27, 1, val)
-- 
1.5.5.1
