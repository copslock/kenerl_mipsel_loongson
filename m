Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jul 2017 21:25:23 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:36292 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993967AbdGYTUoOWJon (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jul 2017 21:20:44 +0200
Received: from localhost (rrcs-64-183-28-114.west.biz.rr.com [64.183.28.114])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 35283A55;
        Tue, 25 Jul 2017 19:20:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 54/83] MIPS: Fix mips_atomic_set() retry condition
Date:   Tue, 25 Jul 2017 12:19:18 -0700
Message-Id: <20170725191716.901970563@linuxfoundation.org>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170725191708.449126292@linuxfoundation.org>
References: <20170725191708.449126292@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59247
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 2ec420b26f7b6ff332393f0bb5a7d245f7ad87f0 upstream.

The inline asm retry check in the MIPS_ATOMIC_SET operation of the
sysmips system call has been backwards since commit f1e39a4a616c ("MIPS:
Rewrite sysmips(MIPS_ATOMIC_SET, ...) in C with inline assembler")
merged in v2.6.32, resulting in the non R10000_LLSC_WAR case retrying
until the operation was inatomic, before returning the new value that
was probably just written multiple times instead of the old value.

Invert the branch condition to fix that particular issue.

Fixes: f1e39a4a616c ("MIPS: Rewrite sysmips(MIPS_ATOMIC_SET, ...) in C with inline assembler")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16148/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/syscall.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -141,7 +141,7 @@ static inline int mips_atomic_set(unsign
 		"1:	ll	%[old], (%[addr])			\n"
 		"	move	%[tmp], %[new]				\n"
 		"2:	sc	%[tmp], (%[addr])			\n"
-		"	bnez	%[tmp], 4f				\n"
+		"	beqz	%[tmp], 4f				\n"
 		"3:							\n"
 		"	.insn						\n"
 		"	.subsection 2					\n"
