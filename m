Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2017 18:19:58 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:38062 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992361AbdJPQTu2M-LC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Oct 2017 18:19:50 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8A9F9A84;
        Mon, 16 Oct 2017 16:19:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Redfearn <matt.redfearn@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.13 03/53] MIPS: bpf: Fix uninitialised target compiler error
Date:   Mon, 16 Oct 2017 18:16:00 +0200
Message-Id: <20171016161442.396316989@linuxfoundation.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171016161442.263947886@linuxfoundation.org>
References: <20171016161442.263947886@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60414
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

4.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@imgtec.com>

commit 94c3390ab84a6b449accc7351ffda4a0c17bdb92 upstream.

Compiling ebpf_jit.c with gcc 4.9 results in a (likely spurious)
compiler warning, as gcc has detected that the variable "target" may be
used uninitialised. Since -Werror is active, this is treated as an error
and causes a kernel build failure whenever CONFIG_MIPS_EBPF_JIT is
enabled.

arch/mips/net/ebpf_jit.c: In function 'build_one_insn':
arch/mips/net/ebpf_jit.c:1118:80: error: 'target' may be used
uninitialized in this function [-Werror=maybe-uninitialized]
    emit_instr(ctx, j, target);
                                                                                ^
cc1: all warnings being treated as errors

Fix this by initialising "target" to 0. If it really is used
uninitialised this would result in a jump to 0 and a detectable run time
failure.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Fixes: b6bd53f9c4e8 ("MIPS: Add missing file for eBPF JIT.")
Cc: James Hogan <james.hogan@imgtec.com>
Cc: David Daney <david.daney@cavium.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/17375/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/net/ebpf_jit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/net/ebpf_jit.c
+++ b/arch/mips/net/ebpf_jit.c
@@ -679,7 +679,7 @@ static int build_one_insn(const struct b
 {
 	int src, dst, r, td, ts, mem_off, b_off;
 	bool need_swap, did_move, cmp_eq;
-	unsigned int target;
+	unsigned int target = 0;
 	u64 t64;
 	s64 t64s;
 
