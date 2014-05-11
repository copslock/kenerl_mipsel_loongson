Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 May 2014 21:23:26 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:44022 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6837156AbaEKTWxAdqZ6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 May 2014 21:22:53 +0200
Received: from localhost (unknown [217.9.101.140])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D6F67523;
        Sun, 11 May 2014 19:22:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 3.10 10/48] MIPS: Hibernate: Flush TLB entries in swsusp_arch_resume()
Date:   Sun, 11 May 2014 21:19:44 +0200
Message-Id: <20140511191949.532289351@linuxfoundation.org>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <20140511191948.079900414@linuxfoundation.org>
References: <20140511191948.079900414@linuxfoundation.org>
User-Agent: quilt/0.60-1
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40077
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

3.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhc@lemote.com>

commit c14af233fbe279d0e561ecf84f1208b1bae087ef upstream.

The original MIPS hibernate code flushes cache and TLB entries in
swsusp_arch_resume(). But they are removed in Commit 44eeab67416711
(MIPS: Hibernation: Remove SMP TLB and cacheflushing code.). A cross-
CPU flush is surely unnecessary because all but the local CPU have
already been disabled. But a local flush (at least the TLB flush) is
needed. When we do hibernation on Loongson-3 with an E1000E NIC, it is
very easy to produce a kernel panic (kernel page fault, or unaligned
access). The root cause is E1000E driver use vzalloc_node() to allocate
pages, the stale TLB entries of the booting kernel will be misused by
the resumed target kernel.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: John Crispin <john@phrozen.org>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Patchwork: https://patchwork.linux-mips.org/patch/6643/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/power/hibernate.S |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/power/hibernate.S
+++ b/arch/mips/power/hibernate.S
@@ -43,6 +43,7 @@ LEAF(swsusp_arch_resume)
 	bne t1, t3, 1b
 	PTR_L t0, PBE_NEXT(t0)
 	bnez t0, 0b
+	jal local_flush_tlb_all /* Avoid TLB mismatch after kernel resume */
 	PTR_LA t0, saved_regs
 	PTR_L ra, PT_R31(t0)
 	PTR_L sp, PT_R29(t0)
