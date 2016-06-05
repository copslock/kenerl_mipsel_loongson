Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jun 2016 23:43:46 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:59969 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042444AbcFEVmhSSuMp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Jun 2016 23:42:37 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 66E58892;
        Sun,  5 Jun 2016 21:42:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 05/99] MIPS: Avoid using unwind_stack() with usermode
Date:   Sun,  5 Jun 2016 14:40:38 -0700
Message-Id: <20160605213903.501150187@linuxfoundation.org>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160605213902.974592018@linuxfoundation.org>
References: <20160605213902.974592018@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53820
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

commit 81a76d7119f63c359750e4adeff922a31ad1135f upstream.

When showing backtraces in response to traps, for example crashes and
address errors (usually unaligned accesses) when they are set in debugfs
to be reported, unwind_stack will be used if the PC was in the kernel
text address range. However since EVA it is possible for user and kernel
address ranges to overlap, and even without EVA userland can still
trigger an address error by jumping to a KSeg0 address.

Adjust the check to also ensure that it was running in kernel mode. I
don't believe any harm can come of this problem, since unwind_stack() is
sufficiently defensive, however it is only meant for unwinding kernel
code, so to be correct it should use the raw backtracing instead.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/11701/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
(cherry picked from commit d2941a975ac745c607dfb590e92bb30bc352dad9)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/traps.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -144,7 +144,7 @@ static void show_backtrace(struct task_s
 	if (!task)
 		task = current;
 
-	if (raw_show_trace || !__kernel_text_address(pc)) {
+	if (raw_show_trace || user_mode(regs) || !__kernel_text_address(pc)) {
 		show_raw_backtrace(sp);
 		return;
 	}
