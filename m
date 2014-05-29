Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 11:23:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29125 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6834872AbaE2JRMOybcS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 11:17:12 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5E08969F64B67;
        Thu, 29 May 2014 10:17:03 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Thu, 29 May
 2014 10:17:05 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 29 May 2014 10:17:05 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.101) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 29 May 2014 10:17:04 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        James Hogan <james.hogan@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH v2 14/23] MIPS: KVM: Override guest kernel timer frequency directly
Date:   Thu, 29 May 2014 10:16:36 +0100
Message-ID: <1401355005-20370-15-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com>
References: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

The KVM_HOST_FREQ Kconfig symbol was used by KVM guest kernels to
override the timer frequency calculation to a value based on the host
frequency. Now that the KVM timer emulation is implemented independent
of the host timer frequency and defaults to 100MHz, adjust the working
of CONFIG_KVM_HOST_FREQ to match.

The Kconfig symbol now specifies the guest timer frequency directly, and
has been renamed accordingly to KVM_GUEST_TIMER_FREQ. It now defaults to
100MHz too and the help text is updated to make it clear that a zero
value will allow the normal timer frequency calculation to take place
(based on the emulated RTC).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/Kconfig                | 12 ++++++------
 arch/mips/mti-malta/malta-time.c | 14 ++------------
 2 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5cd695f905a1..5e0014e864f3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1756,14 +1756,14 @@ config KVM_GUEST
 	help
 	  Select this option if building a guest kernel for KVM (Trap & Emulate) mode
 
-config KVM_HOST_FREQ
-	int "KVM Host Processor Frequency (MHz)"
+config KVM_GUEST_TIMER_FREQ
+	int "Count/Compare Timer Frequency (MHz)"
 	depends on KVM_GUEST
-	default 500
+	default 100
 	help
-	  Select this option if building a guest kernel for KVM to skip
-	  RTC emulation when determining guest CPU Frequency.  Instead, the guest
-	  processor frequency is automatically derived from the host frequency.
+	  Set this to non-zero if building a guest kernel for KVM to skip RTC
+	  emulation when determining guest CPU Frequency. Instead, the guest's
+	  timer frequency is specified directly.
 
 choice
 	prompt "Kernel page size"
diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 319009912142..3778a359f3ad 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -74,18 +74,8 @@ static void __init estimate_frequencies(void)
 	unsigned int giccount = 0, gicstart = 0;
 #endif
 
-#if defined (CONFIG_KVM_GUEST) && defined (CONFIG_KVM_HOST_FREQ)
-	unsigned int prid = read_c0_prid() & (PRID_COMP_MASK | PRID_IMP_MASK);
-
-	/*
-	 * XXXKYMA: hardwire the CPU frequency to Host Freq/4
-	 */
-	count = (CONFIG_KVM_HOST_FREQ * 1000000) >> 3;
-	if ((prid != (PRID_COMP_MIPS | PRID_IMP_20KC)) &&
-	    (prid != (PRID_COMP_MIPS | PRID_IMP_25KF)))
-		count *= 2;
-
-	mips_hpt_frequency = count;
+#if defined(CONFIG_KVM_GUEST) && CONFIG_KVM_GUEST_TIMER_FREQ
+	mips_hpt_frequency = CONFIG_KVM_GUEST_TIMER_FREQ * 1000000;
 	return;
 #endif
 
-- 
1.9.3
