Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Nov 2012 00:16:55 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:1452 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825931Ab2KOXQySvZRb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Nov 2012 00:16:54 +0100
Received: from [10.9.200.133] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Thu, 15 Nov 2012 15:12:33 -0800
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Thu, 15 Nov 2012 15:16:09 -0800
Received: from stbsrv-and-2.and.broadcom.com (
 stbsrv-and-2.and.broadcom.com [10.32.128.96]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 2B6B440FE3; Thu, 15
 Nov 2012 15:16:35 -0800 (PST)
From:   "Al Cooper" <alcooperx@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, cernekee@gmail.com
cc:     "Al Cooper" <alcooperx@gmail.com>
Subject: [PATCH] MIPS: Fix crash that occurs when function tracing is
 enabled
Date:   Thu, 15 Nov 2012 18:16:14 -0500
Message-ID: <1353021374-3311-1-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <y>
References: <y>
MIME-Version: 1.0
X-WSS-ID: 7CBBA96B3P83507328-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alcooperx@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

A recent patch changed some irq routines from inlines to functions.
These routines are called by the tracer code. Now that they're functions,
if they are compiled for function tracing they will call the tracer
and crash the system due to infinite recursion. The fix disables
tracing in these functions by using "notrace" in the function
definition.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 arch/mips/lib/mips-atomic.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/lib/mips-atomic.c b/arch/mips/lib/mips-atomic.c
index e091430..cd160be 100644
--- a/arch/mips/lib/mips-atomic.c
+++ b/arch/mips/lib/mips-atomic.c
@@ -56,7 +56,7 @@ __asm__(
 	"	.set	pop						\n"
 	"	.endm							\n");
 
-void arch_local_irq_disable(void)
+notrace void arch_local_irq_disable(void)
 {
 	preempt_disable();
 	__asm__ __volatile__(
@@ -93,7 +93,7 @@ __asm__(
 	"	.set	pop						\n"
 	"	.endm							\n");
 
-unsigned long arch_local_irq_save(void)
+notrace unsigned long arch_local_irq_save(void)
 {
 	unsigned long flags;
 	preempt_disable();
@@ -135,7 +135,7 @@ __asm__(
 	"	.set	pop						\n"
 	"	.endm							\n");
 
-void arch_local_irq_restore(unsigned long flags)
+notrace void arch_local_irq_restore(unsigned long flags)
 {
 	unsigned long __tmp1;
 
@@ -159,7 +159,7 @@ void arch_local_irq_restore(unsigned long flags)
 EXPORT_SYMBOL(arch_local_irq_restore);
 
 
-void __arch_local_irq_restore(unsigned long flags)
+notrace void __arch_local_irq_restore(unsigned long flags)
 {
 	unsigned long __tmp1;
 
-- 
1.7.6
