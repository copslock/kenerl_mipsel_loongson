Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Aug 2015 19:45:44 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:56246 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012275AbbHNRnMNn0n1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Aug 2015 19:43:12 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 57060899;
        Fri, 14 Aug 2015 17:43:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org
Subject: [PATCH 4.1 09/84] MIPS: Flush RPS on kernel entry with EVA
Date:   Fri, 14 Aug 2015 10:41:37 -0700
Message-Id: <20150814174210.494583828@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <20150814174210.214822912@linuxfoundation.org>
References: <20150814174210.214822912@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48906
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

4.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 3aff47c062b944a5e1f9af56a37a23f5295628fc upstream.

When EVA is enabled, flush the Return Prediction Stack (RPS) present on
some MIPS cores on entry to the kernel from user mode.

This is important specifically for interAptiv with EVA enabled,
otherwise kernel mode RPS mispredicts may trigger speculative fetches of
user return addresses, which may be sensitive in the kernel address
space due to EVA's overlapping user/kernel address spaces.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10812/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/stackframe.h |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -152,6 +152,31 @@
 		.set	noreorder
 		bltz	k0, 8f
 		 move	k1, sp
+#ifdef CONFIG_EVA
+		/*
+		 * Flush interAptiv's Return Prediction Stack (RPS) by writing
+		 * EntryHi. Toggling Config7.RPS is slower and less portable.
+		 *
+		 * The RPS isn't automatically flushed when exceptions are
+		 * taken, which can result in kernel mode speculative accesses
+		 * to user addresses if the RPS mispredicts. That's harmless
+		 * when user and kernel share the same address space, but with
+		 * EVA the same user segments may be unmapped to kernel mode,
+		 * even containing sensitive MMIO regions or invalid memory.
+		 *
+		 * This can happen when the kernel sets the return address to
+		 * ret_from_* and jr's to the exception handler, which looks
+		 * more like a tail call than a function call. If nested calls
+		 * don't evict the last user address in the RPS, it will
+		 * mispredict the return and fetch from a user controlled
+		 * address into the icache.
+		 *
+		 * More recent EVA-capable cores with MAAR to restrict
+		 * speculative accesses aren't affected.
+		 */
+		MFC0	k0, CP0_ENTRYHI
+		MTC0	k0, CP0_ENTRYHI
+#endif
 		.set	reorder
 		/* Called from user mode, new stack. */
 		get_saved_sp
