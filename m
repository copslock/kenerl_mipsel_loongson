Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2010 12:42:59 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:56752 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491831Ab0JNKlx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Oct 2010 12:41:53 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9EAfqfq029690
        for <linux-mips@linux-mips.org>; Thu, 14 Oct 2010 11:41:52 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9EAfpV9029689
        for linux-mips@linux-mips.org; Thu, 14 Oct 2010 11:41:51 +0100
Resent-From: ralf@linux-mips.org
Resent-Date: Thu, 14 Oct 2010 11:41:51 +0100
Resent-Message-ID: <20101014104151.GD28911@linux-mips.org>
Resent-To: linux-mips@linux-mips.org
Received: from zeniv.linux.org.uk ([195.92.253.2]:46424 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491139Ab0I1Rur (ORCPT <rfc822;ralf@linux-mips.org>);
        Tue, 28 Sep 2010 19:50:47 +0200
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
        id 1P0eKF-0006jH-5I; Tue, 28 Sep 2010 17:50:47 +0000
Date:   Tue, 28 Sep 2010 18:50:47 +0100
To:     ralf@linux-mips.org
Subject: [PATCH 4/5] mips: fix error values in case of bad_stack
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
User-Agent: Heirloom mailx 12.4 7/29/08
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1P0eKF-0006jH-5I@ZenIV.linux.org.uk>
From:   Al Viro <viro@ftp.linux.org.uk>
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips


we want EFAULT, not -<syscall number>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/mips/kernel/scall32-o32.S |    2 +-
 arch/mips/kernel/scall64-o32.S |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index d3edb9f..da98051 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -169,7 +169,7 @@ stackargs:
 	 * We probably should handle this case a bit more drastic.
 	 */
 bad_stack:
-	negu	v0				# error
+	li	v0, EFAULT
 	sw	v0, PT_R2(sp)
 	li	t0, 1				# set error flag
 	sw	t0, PT_R7(sp)
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 7ce0a36..d2bc285 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -156,7 +156,7 @@ trace_a_syscall:
 	 * The stackpointer for a call with more than 4 arguments is bad.
 	 */
 bad_stack:
-	dnegu	v0			# error
+	li	v0, EFAULT
 	sd	v0, PT_R2(sp)
 	li	t0, 1			# set error flag
 	sd	t0, PT_R7(sp)
-- 
1.5.6.5
