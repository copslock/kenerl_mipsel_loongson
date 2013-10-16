Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Oct 2013 19:46:34 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:37364 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817179Ab3JPRqcIsVjE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Oct 2013 19:46:32 +0200
Received: from localhost (c-76-28-172-123.hsd1.wa.comcast.net [76.28.172.123])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A64DD93B;
        Wed, 16 Oct 2013 17:46:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        linux-mips@linux-mips.org
Subject: [ 21/50] MIPS: stack protector: Fix per-task canary switch
Date:   Wed, 16 Oct 2013 10:45:07 -0700
Message-Id: <20131016174400.952627917@linuxfoundation.org>
X-Mailer: git-send-email 1.8.4.3.gca3854a
In-Reply-To: <20131016174358.335646140@linuxfoundation.org>
References: <20131016174358.335646140@linuxfoundation.org>
User-Agent: quilt/0.60-5.1.1
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38355
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

3.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 8b3c569a3999a8fd5a819f892525ab5520777c92 upstream.

Commit 1400eb6 (MIPS: r4k,octeon,r2300: stack protector: change canary
per task) was merged in v3.11 and introduced assembly in the MIPS resume
functions to update the value of the current canary in
__stack_chk_guard. However it used PTR_L resulting in a load of the
canary value, instead of PTR_LA to construct its address. The value is
intended to be random but is then treated as an address in the
subsequent LONG_S (store).

This was observed to cause a fault and panic:

CPU 0 Unable to handle kernel paging request at virtual address 139fea20, epc == 8000cc0c, ra == 8034f2a4
Oops[#1]:
...
$24   : 139fea20 1e1f7cb6
...
Call Trace:
[<8000cc0c>] resume+0xac/0x118
[<8034f2a4>] __schedule+0x5f8/0x78c
[<8034f4e0>] schedule_preempt_disabled+0x20/0x2c
[<80348eec>] rest_init+0x74/0x84
[<804dc990>] start_kernel+0x43c/0x454
Code: 3c18804b  8f184030  8cb901f8 <af190000> 00c0e021  8cb002f0 8cb102f4  8cb202f8  8cb302fc

This can also be forced by modifying
arch/mips/include/asm/stackprotector.h so that the default
__stack_chk_guard value is more likely to be a bad (or unaligned)
pointer.

Fix it to use PTR_LA instead, to load the address of the canary value,
which the LONG_S can then use to write into it.

Reported-by: bobjones (via #mipslinux on IRC)
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gregory Fong <gregory.0xf0@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/6026/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/octeon_switch.S |    2 +-
 arch/mips/kernel/r2300_switch.S  |    2 +-
 arch/mips/kernel/r4k_switch.S    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/arch/mips/kernel/octeon_switch.S
+++ b/arch/mips/kernel/octeon_switch.S
@@ -73,7 +73,7 @@
 3:
 
 #if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
-	PTR_L	t8, __stack_chk_guard
+	PTR_LA	t8, __stack_chk_guard
 	LONG_L	t9, TASK_STACK_CANARY(a1)
 	LONG_S	t9, 0(t8)
 #endif
--- a/arch/mips/kernel/r2300_switch.S
+++ b/arch/mips/kernel/r2300_switch.S
@@ -67,7 +67,7 @@ LEAF(resume)
 1:
 
 #if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
-	PTR_L	t8, __stack_chk_guard
+	PTR_LA	t8, __stack_chk_guard
 	LONG_L	t9, TASK_STACK_CANARY(a1)
 	LONG_S	t9, 0(t8)
 #endif
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -69,7 +69,7 @@
 1:
 
 #if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
-	PTR_L	t8, __stack_chk_guard
+	PTR_LA	t8, __stack_chk_guard
 	LONG_L	t9, TASK_STACK_CANARY(a1)
 	LONG_S	t9, 0(t8)
 #endif
