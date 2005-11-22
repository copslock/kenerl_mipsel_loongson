Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2005 20:56:32 +0000 (GMT)
Received: from amdext3.amd.com ([139.95.251.6]:726 "EHLO amdext3.amd.com")
	by ftp.linux-mips.org with ESMTP id S8134455AbVKVUz7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Nov 2005 20:55:59 +0000
Received: from SSVLGW01.amd.com (ssvlgw01.amd.com [139.95.250.169])
	by amdext3.amd.com (8.12.11/8.12.11/AMD) with ESMTP id jAMKwLfo013592;
	Tue, 22 Nov 2005 12:58:35 -0800
Received: from 139.95.250.1 by SSVLGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Tue, 22 Nov 2005 12:56:01 -0800
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint.amd.com (8.12.8/8.12.8/AMD) with ESMTP id jAMKu0Zi010726; Tue,
 22 Nov 2005 12:56:00 -0800 (PST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 4ECD61FF4; Tue, 22 Nov 2005
 13:56:00 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id jAML1CMG004550; Tue, 22 Nov 2005 14:01:12
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id jAML1Ce8004549; Tue, 22 Nov 2005 14:01:12
 -0700
Date:	Tue, 22 Nov 2005 14:01:12 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Subject: [PATCH] Cleanups in au1000/common/time.c
Message-ID: <20051122210112.GS18119@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F9D5A6B2VS8350436-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

More from Sergei.

Cleanups in arch/mips/au1000/common/time.c

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Acked-by: Jordan Crouse <jordan.crouse@amd.com>
---

 arch/mips/au1000/common/time.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/mips/au1000/common/time.c b/arch/mips/au1000/common/time.c
index 883d3f3..fe883d4 100644
--- a/arch/mips/au1000/common/time.c
+++ b/arch/mips/au1000/common/time.c
@@ -50,10 +50,6 @@
 #include <linux/mc146818rtc.h>
 #include <linux/timex.h>
 
-extern void do_softirq(void);
-extern volatile unsigned long wall_jiffies;
-unsigned long missed_heart_beats = 0;
-
 static unsigned long r4k_offset; /* Amount to increment compare reg each time */
 static unsigned long r4k_cur;    /* What counter should be at next timer irq */
 int	no_au1xxx_32khz;
@@ -387,10 +383,9 @@ static unsigned long do_fast_pm_gettimeo
 }
 #endif
 
-void au1xxx_timer_setup(struct irqaction *irq)
+void __init au1xxx_timer_setup(struct irqaction *irq)
 {
-        unsigned int est_freq;
-	extern unsigned long (*do_gettimeoffset)(void);
+	unsigned int est_freq;
 
 	printk("calculating r4koff... ");
 	r4k_offset = cal_r4koff();
