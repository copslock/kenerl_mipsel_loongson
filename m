Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Dec 2008 23:43:49 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:20779 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24207791AbYLKXkb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Dec 2008 23:40:31 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4941a3ab0000>; Thu, 11 Dec 2008 18:35:12 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Dec 2008 15:33:50 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Dec 2008 15:33:50 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mBBNXjUF031891;
	Thu, 11 Dec 2008 15:33:45 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mBBNXi71031890;
	Thu, 11 Dec 2008 15:33:44 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 09/20] MIPS: Hook Cavium OCTEON cache init into cache.c
Date:	Thu, 11 Dec 2008 15:33:27 -0800
Message-Id: <1229038418-31833-9-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <4941A2F5.1010202@caviumnetworks.com>
References: <4941A2F5.1010202@caviumnetworks.com>
X-OriginalArrivalTime: 11 Dec 2008 23:33:50.0161 (UTC) FILETIME=[EBB1D410:01C95BE8]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Follow precedent of other boards, and hook-up the CPU specific cache
init.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/cpu-features.h |    3 +++
 arch/mips/mm/cache.c                 |    6 ++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 12d12df..a0d14f8 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -38,6 +38,9 @@
 #ifndef cpu_has_tx39_cache
 #define cpu_has_tx39_cache	(cpu_data[0].options & MIPS_CPU_TX39_CACHE)
 #endif
+#ifndef cpu_has_octeon_cache
+#define cpu_has_octeon_cache	0
+#endif
 #ifndef cpu_has_fpu
 #define cpu_has_fpu		(current_cpu_data.options & MIPS_CPU_FPU)
 #define raw_cpu_has_fpu		(raw_current_cpu_data.options & MIPS_CPU_FPU)
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 1eb7c71..98ad0a8 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -182,6 +182,12 @@ void __devinit cpu_cache_init(void)
 		tx39_cache_init();
 	}
 
+	if (cpu_has_octeon_cache) {
+		extern void __weak octeon_cache_init(void);
+
+		octeon_cache_init();
+	}
+
 	setup_protection_map();
 }
 
-- 
1.5.6.5
