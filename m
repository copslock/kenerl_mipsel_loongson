Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 19:57:14 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35750 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027472AbbEKRzu14tlh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 19:55:50 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 51F3FBB8;
        Mon, 11 May 2015 17:55:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.0 17/72] MIPS: asm: spinlock: Fix addiu instruction for R10000_LLSC_WAR case
Date:   Mon, 11 May 2015 10:54:23 -0700
Message-Id: <20150511175437.626968074@linuxfoundation.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <20150511175437.112151861@linuxfoundation.org>
References: <20150511175437.112151861@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47316
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

4.0-stable review patch.  If anyone has any objections, please let me know.

------------------


From: Markos Chandras <markos.chandras@imgtec.com>

Commit 518222161d4a2d3f3b2700098563b62383f83878 upstream.

Commit 5753762cbd1c("MIPS: asm: spinlock: Replace "sub" instruction
with "addiu") replaced the "sub" instruction with addiu but it did
not update the immediate value in the R10000_LLSC_WAR case.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Fixes: 5753762cbd1c("MIPS: asm: spinlock: Replace "sub" instruction with "addiu"")
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9385/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/include/asm/spinlock.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/include/asm/spinlock.h
+++ b/arch/mips/include/asm/spinlock.h
@@ -263,7 +263,7 @@ static inline void arch_read_unlock(arch
 	if (R10000_LLSC_WAR) {
 		__asm__ __volatile__(
 		"1:	ll	%1, %2		# arch_read_unlock	\n"
-		"	addiu	%1, 1					\n"
+		"	addiu	%1, -1					\n"
 		"	sc	%1, %0					\n"
 		"	beqzl	%1, 1b					\n"
 		: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp)
