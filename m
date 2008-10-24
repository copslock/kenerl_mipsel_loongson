Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 02:01:08 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:30566 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22251731AbYJXA5v (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 01:57:51 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49011d660001>; Thu, 23 Oct 2008 20:57:10 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:09 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:08 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9O0v3Ii005605;
	Thu, 23 Oct 2008 17:57:03 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9O0v3D7005604;
	Thu, 23 Oct 2008 17:57:03 -0700
From:	ddaney@caviumnetworks.com
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 11/37] Cavium OCTEON: ebase isn't just CAC_BASE
Date:	Thu, 23 Oct 2008 17:56:35 -0700
Message-Id: <1224809821-5532-12-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Oct 2008 00:57:08.0516 (UTC) FILETIME=[70B48640:01C93573]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

From: David Daney <ddaney@caviumnetworks.com>

On Cavium, the ebase isn't just CAC_BASE, but also the part of
read_c0_ebase() too.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/traps.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 8e40795..91c7aa2 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1610,7 +1610,11 @@ void __init trap_init(void)
 	if (cpu_has_veic || cpu_has_vint)
 		ebase = (unsigned long) alloc_bootmem_low_pages(0x200 + VECTORSPACING*64);
 	else
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+		ebase = CAC_BASE + (read_c0_ebase() & 0x3ffff000);
+#else
 		ebase = CAC_BASE;
+#endif
 
 	per_cpu_trap_init();
 
@@ -1718,11 +1722,11 @@ void __init trap_init(void)
 
 	if (cpu_has_vce)
 		/* Special exception: R4[04]00 uses also the divec space. */
-		memcpy((void *)(CAC_BASE + 0x180), &except_vec3_r4000, 0x100);
+		memcpy((void *)(ebase + 0x180), &except_vec3_r4000, 0x100);
 	else if (cpu_has_4kex)
-		memcpy((void *)(CAC_BASE + 0x180), &except_vec3_generic, 0x80);
+		memcpy((void *)(ebase + 0x180), &except_vec3_generic, 0x80);
 	else
-		memcpy((void *)(CAC_BASE + 0x080), &except_vec3_generic, 0x80);
+		memcpy((void *)(ebase + 0x080), &except_vec3_generic, 0x80);
 
 	signal_init();
 #ifdef CONFIG_MIPS32_COMPAT
-- 
1.5.5.1
