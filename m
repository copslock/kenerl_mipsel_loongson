Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2005 20:52:25 +0000 (GMT)
Received: from amdext4.amd.com ([163.181.251.6]:27817 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8134136AbVKVUwG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Nov 2005 20:52:06 +0000
Received: from SAUSGW02.amd.com (sausgw02.amd.com [163.181.250.22])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id jAMKsg6l026186;
	Tue, 22 Nov 2005 14:54:43 -0600
Received: from 163.181.250.1 by SAUSGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Tue, 22 Nov 2005 14:54:27 -0600
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint2.amd.com (8.12.8/8.12.8/AMD) with ESMTP id jAMKsQeP021677; Tue,
 22 Nov 2005 14:54:26 -0600 (CST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 923D31FF4; Tue, 22 Nov 2005
 13:54:26 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id jAMKxc1c004512; Tue, 22 Nov 2005 13:59:38
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id jAMKxcSk004511; Tue, 22 Nov 2005 13:59:38
 -0700
Date:	Tue, 22 Nov 2005 13:59:38 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Subject: [PATCH] Retain the write-only OD from being clobbered
Message-ID: <20051122205938.GR18119@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F9D5A091M8573332-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

First of several patches forwarded to me by Sergei Shtylyov.  Ralf,
these should be good to go for the tree.

Retain the write-only OD bit from being clobbered by coherency_setup()

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Acked-by: Jordan Crouse <jordan.crouse@amd.com>
---

 arch/mips/mm/c-r4k.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 38223b4..044c468 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -29,6 +29,10 @@
 #include <asm/war.h>
 #include <asm/cacheflush.h> /* for run_uncached() */
 
+#ifdef CONFIG_SOC_AU1X00
+#include <au1000.h>
+#endif
+
 /*
  * Must die.
  */
@@ -1203,6 +1207,16 @@ static inline void coherency_setup(void)
 {
 	change_c0_config(CONF_CM_CMASK, CONF_CM_DEFAULT);
 
+#ifdef CONFIG_SOC_AU1X00
+	/*
+	 * c0_config.od (bit 19) is write only (and reads as 0) on many early
+	 * revs of AMD Au1x00 SOCs. It disables the bus transaction overlapping 
+	 * and needs to be set to correct the various errata. So if it has been
+	 * set by the board setup code we must leave it set...
+	 */
+	if (cur_cpu_spec[0]->cpu_od)
+		set_c0_config(1 << 19);
+#endif
 	/*
 	 * c0_status.cu=0 specifies that updates by the sc instruction use
 	 * the coherency mode specified by the TLB; 1 means cachable
