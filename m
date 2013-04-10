Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Apr 2013 00:48:34 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:47534 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835062Ab3DJWr2iePjs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Apr 2013 00:47:28 +0200
Received: from localhost (c-76-28-172-123.hsd1.wa.comcast.net [76.28.172.123])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 95C9E945;
        Wed, 10 Apr 2013 22:47:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Al Cooper <alcooperx@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        viric@viric.name
Subject: [ 27/64] MIPS: Unbreak function tracer for 64-bit kernel.
Date:   Wed, 10 Apr 2013 15:46:24 -0700
Message-Id: <20130410224339.394444541@linuxfoundation.org>
X-Mailer: git-send-email 1.8.1.rc1.5.g7e0651a
In-Reply-To: <20130410224333.114387235@linuxfoundation.org>
References: <20130410224333.114387235@linuxfoundation.org>
User-Agent: quilt/0.60-5.1.1
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Daney <david.daney@cavium.com>

commit ad8c396936e328f5344e1881afde9e28d5f2045f upstream.

Commit 58b69401c797 [MIPS: Function tracer: Fix broken function tracing]
completely broke the function tracer for 64-bit kernels.  The symptom is
a system hang very early in the boot process.

The fix: Remove/fix $sp adjustments for 64-bit case.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org
Cc: Al Cooper <alcooperx@gmail.com>
Cc: viric@viric.name
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/mcount.S |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -46,10 +46,9 @@
 	PTR_L	a5, PT_R9(sp)
 	PTR_L	a6, PT_R10(sp)
 	PTR_L	a7, PT_R11(sp)
-#else
-	PTR_ADDIU	sp, PT_SIZE
 #endif
-.endm
+	PTR_ADDIU	sp, PT_SIZE
+	.endm
 
 	.macro RETURN_BACK
 	jr ra
@@ -68,7 +67,11 @@ NESTED(ftrace_caller, PT_SIZE, ra)
 	.globl _mcount
 _mcount:
 	b	ftrace_stub
-	addiu sp,sp,8
+#ifdef CONFIG_32BIT
+	 addiu sp,sp,8
+#else
+	 nop
+#endif
 
 	/* When tracing is activated, it calls ftrace_caller+8 (aka here) */
 	lw	t1, function_trace_stop
