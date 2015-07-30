Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jul 2015 17:17:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21586 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011376AbbG3PRERkyyM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Jul 2015 17:17:04 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 91776FCC88328;
        Thu, 30 Jul 2015 16:16:55 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 30 Jul 2015 16:16:58 +0100
Received: from localhost (10.100.200.243) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 30 Jul
 2015 16:16:57 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@codesourcery.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>
Subject: [PATCH] MIPS: select CONFIG_ARCH_USE_CMPXCHG_LOCKREF for MIPS64
Date:   Thu, 30 Jul 2015 08:16:10 -0700
Message-ID: <1438269370-2757-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.243]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On MIPS64 we have spinlocks that are 32b in size and an efficient
cmpxchg64 implementation, so we qualify to make use of cmpxchg backed
lockrefs. Select the ARCH_USE_CMPXCHG_LOCKREF Kconfig symbol and provide
a trivial implementation of arch_spin_value_unlocked to satisfy the
lockref code.

Using Linus' simple testcase from
http://article.gmane.org/gmane.linux.file-systems/77466 on a dual core
system with an in-development MIPS64 CPU running on FPGA I see around an
8% gain:

Pre-patch:
    Total loops: 252698
    Total loops: 251482
    Total loops: 250806
    Total loops: 252885
    Total loops: 251666

Post-patch:
    Total loops: 273728
    Total loops: 269932
    Total loops: 269341
    Total loops: 275004
    Total loops: 270208

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/Kconfig                | 1 +
 arch/mips/include/asm/spinlock.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f501665..ec6b430 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3,6 +3,7 @@ config MIPS
 	default y
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
+	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
 	select HAVE_CONTEXT_TRACKING
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_IDE
diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
index 1fca2e0..418a5acb 100644
--- a/arch/mips/include/asm/spinlock.h
+++ b/arch/mips/include/asm/spinlock.h
@@ -42,6 +42,11 @@ static inline int arch_spin_is_locked(arch_spinlock_t *lock)
 	return ((counters >> 16) ^ counters) & 0xffff;
 }
 
+static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
+{
+	return lock.h.serving_now == lock.h.ticket;
+}
+
 #define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
 #define arch_spin_unlock_wait(x) \
 	while (arch_spin_is_locked(x)) { cpu_relax(); }
-- 
2.5.0
