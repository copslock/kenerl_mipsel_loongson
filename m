Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2017 09:56:51 +0100 (CET)
Received: from resqmta-ch2-01v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:33]:32774
        "EHLO resqmta-ch2-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992942AbdBBI4nElUDB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2017 09:56:43 +0100
Received: from resomta-ch2-07v.sys.comcast.net ([69.252.207.103])
        by resqmta-ch2-01v.sys.comcast.net with SMTP
        id ZDC5cSTI7dAFEZDC5c1w96; Thu, 02 Feb 2017 08:56:41 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-ch2-07v.sys.comcast.net with SMTP
        id ZDC3cxZlwwPVHZDC4cKY1w; Thu, 02 Feb 2017 08:56:41 +0000
To:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Subject: [PATCH] MIPS: Replace printk calls in cpu-bugs64.c with
 pr_info/pr_cont
Message-ID: <29b7fc69-97f4-6a3a-0e65-2678f9c30cef@gentoo.org>
Date:   Thu, 2 Feb 2017 03:56:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEav9dPs/6rIFevsKgOAr/H8KGc9ew5mxBngYSTQ/VzmLy+JhsfXh0WS7BptgM0kOaAqEzYJ6uxuc79VKQFyZW2RYgnJ9JCtYeKdb+/RxV1nwAXMR9ze
 xNxPCJsTAWUfW11BZRO0/FXeKqhoMq0vRogiFnmgFqWBtUpKKJotdYS7eXhB6cXLstX/fGKteUUL66QTzpo5RsQLKolvVE+gO25nIaX2bDSvH1i0wXQ4xIuR
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: Joshua Kinard <kumba@gentoo.org>

In arch/mips/kernel/cpu-bugs64.c, replace initial printk's in three
bug-checking functions with pr_info and replace several continuation
printk's with pr_info/pr_cont calls to avoid kernel log output like
this:

    [    0.899065] Checking for the daddi bug...
    [    0.899098] no.

This makes the output appear correctly:

    [    0.898643] Checking for the daddi bug... no.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/kernel/cpu-bugs64.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/mips/kernel/cpu-bugs64.c b/arch/mips/kernel/cpu-bugs64.c
index a378e44688f5..d4483551a926 100644
--- a/arch/mips/kernel/cpu-bugs64.c
+++ b/arch/mips/kernel/cpu-bugs64.c
@@ -122,7 +122,7 @@ static inline void check_mult_sh(void)
 	long v1[8], v2[8], w[8];
 	int bug, fix, i;
 
-	printk("Checking for the multiply/shift bug... ");
+	pr_info("Checking for the multiply/shift bug... ");
 
 	/*
 	 * Testing discovered false negatives for certain code offsets
@@ -148,11 +148,11 @@ static inline void check_mult_sh(void)
 			bug = 1;
 
 	if (bug == 0) {
-		printk("no.\n");
+		pr_cont("no.\n");
 		return;
 	}
 
-	printk("yes, workaround... ");
+	pr_cont("yes, workaround... ");
 
 	fix = 1;
 	for (i = 0; i < 8; i++)
@@ -160,11 +160,11 @@ static inline void check_mult_sh(void)
 			fix = 0;
 
 	if (fix == 1) {
-		printk("yes.\n");
+		pr_cont("yes.\n");
 		return;
 	}
 
-	printk("no.\n");
+	pr_cont("no.\n");
 	panic(bug64hit, !R4000_WAR ? r4kwar : nowar);
 }
 
@@ -187,7 +187,7 @@ static inline void check_daddi(void)
 	void *handler;
 	long v, tmp;
 
-	printk("Checking for the daddi bug... ");
+	pr_info("Checking for the daddi bug... ");
 
 	local_irq_save(flags);
 	handler = set_except_vector(EXCCODE_OV, handle_daddi_ov);
@@ -218,11 +218,11 @@ static inline void check_daddi(void)
 	local_irq_restore(flags);
 
 	if (daddi_ov) {
-		printk("no.\n");
+		pr_cont("no.\n");
 		return;
 	}
 
-	printk("yes, workaround... ");
+	pr_cont("yes, workaround... ");
 
 	local_irq_save(flags);
 	handler = set_except_vector(EXCCODE_OV, handle_daddi_ov);
@@ -236,11 +236,11 @@ static inline void check_daddi(void)
 	local_irq_restore(flags);
 
 	if (daddi_ov) {
-		printk("yes.\n");
+		pr_cont("yes.\n");
 		return;
 	}
 
-	printk("no.\n");
+	pr_cont("no.\n");
 	panic(bug64hit, !DADDI_WAR ? daddiwar : nowar);
 }
 
@@ -250,7 +250,7 @@ static inline void check_daddiu(void)
 {
 	long v, w, tmp;
 
-	printk("Checking for the daddiu bug... ");
+	pr_info("Checking for the daddiu bug... ");
 
 	/*
 	 * The following code leads to a wrong result of daddiu when
@@ -288,11 +288,11 @@ static inline void check_daddiu(void)
 	daddiu_bug = v != w;
 
 	if (!daddiu_bug) {
-		printk("no.\n");
+		pr_cont("no.\n");
 		return;
 	}
 
-	printk("yes, workaround... ");
+	pr_cont("yes, workaround... ");
 
 	asm volatile(
 		"addiu	%2, $0, %3\n\t"
@@ -304,11 +304,11 @@ static inline void check_daddiu(void)
 		: "I" (0xffffffffffffdb9aUL), "I" (0x1234));
 
 	if (v == w) {
-		printk("yes.\n");
+		pr_cont("yes.\n");
 		return;
 	}
 
-	printk("no.\n");
+	pr_cont("no.\n");
 	panic(bug64hit, !DADDI_WAR ? daddiwar : nowar);
 }
 
