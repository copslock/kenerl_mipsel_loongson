Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 18:45:17 +0000 (GMT)
Received: from amdext4.amd.com ([163.181.251.6]:3975 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133657AbWAISo6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2006 18:44:58 +0000
Received: from SAUSGW02.amd.com (sausgw02.amd.com [163.181.250.22])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k09IlrFP006887;
	Mon, 9 Jan 2006 12:47:53 -0600
Received: from 163.181.250.1 by SAUSGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Mon, 09 Jan 2006 12:47:41 -0600
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint2.amd.com (8.12.8/8.12.8/AMD) with ESMTP id k09Ilfh5027308; Mon,
 9 Jan 2006 12:47:41 -0600 (CST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id E71E12028; Mon, 9 Jan 2006
 11:47:40 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k09IuH7J011581; Mon, 9 Jan 2006 11:56:17
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k09IuHSu011580; Mon, 9 Jan 2006 11:56:17 -0700
Date:	Mon, 9 Jan 2006 11:56:17 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Subject: [PATCH] Cleanups for au1000/common/time.c
Message-ID: <20060109185617.GN17575@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FDC70470T02739764-01-01
Content-Type: multipart/mixed;
 boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips


--ibTvN161/egqYuK8
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Cleaning out my pending queue, this is a patch from Sergei Shtylyov
that just does some minor cleanups in au1000/common/time.c - fairly
trivial stuff.

Jordan

--ibTvN161/egqYuK8
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=Au1xx0-time-cleanup.patch
Content-Transfer-Encoding: 7bit

Cleanups in arch/mips/au1000/common/time.c

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
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

--ibTvN161/egqYuK8--
