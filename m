Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 15:49:51 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:48650 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992540AbdJSNtopXNTJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Oct 2017 15:49:44 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 76C1AAC9;
        Thu, 19 Oct 2017 13:49:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Darius Ivanauskas <dasilt@yahoo.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Petr Mladek <pmladek@suse.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        "Jason A. Donenfeld" <jason@zx2c4.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.9 01/51] MIPS: Fix minimum alignment requirement of IRQ stack
Date:   Thu, 19 Oct 2017 15:48:22 +0200
Message-Id: <20171019134841.516482615@linuxfoundation.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171019134841.383925150@linuxfoundation.org>
References: <20171019134841.383925150@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60471
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@imgtec.com>

commit 5fdc66e046206306bf61ff2d626bfa52ca087f7b upstream.

Commit db8466c581cc ("MIPS: IRQ Stack: Unwind IRQ stack onto task
stack") erroneously set the initial stack pointer of the IRQ stack to a
value with a 4 byte alignment. The MIPS32 ABI requires that the minimum
stack alignment is 8 byte, and the MIPS64 ABIs(n32/n64) require 16 byte
minimum alignment. Fix IRQ_STACK_START such that it leaves space for the
dummy stack frame (containing interrupted task kernel stack pointer)
while also meeting minimum alignment requirements.

Fixes: db8466c581cc ("MIPS: IRQ Stack: Unwind IRQ stack onto task stack")
Reported-by: Darius Ivanauskas <dasilt@yahoo.com>
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Aaron Tomlin <atomlin@redhat.com>
Cc: Jason A. Donenfeld <jason@zx2c4.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/16760/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/irq.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -18,7 +18,7 @@
 #include <irq.h>
 
 #define IRQ_STACK_SIZE			THREAD_SIZE
-#define IRQ_STACK_START			(IRQ_STACK_SIZE - sizeof(unsigned long))
+#define IRQ_STACK_START			(IRQ_STACK_SIZE - 16)
 
 extern void *irq_stack[NR_CPUS];
 
