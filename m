Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 11:33:46 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16239 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994812AbdCNK0C6nqlH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 11:26:02 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id F195EB57A4148;
        Tue, 14 Mar 2017 10:25:53 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Mar 2017 10:25:56 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Subject: [PATCH 2/8] KVM: MIPS/Emulate: Adapt T&E CACHE emulation for Octeon
Date:   Tue, 14 Mar 2017 10:25:45 +0000
Message-ID: <a3e03cb7a8953dc654af9173c64447a9e557a306.1489486985.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
In-Reply-To: <cover.79b3feae3a98cb166c2d40a7bd4e854a5faedc89.1489486985.git-series.james.hogan@imgtec.com>
References: <cover.79b3feae3a98cb166c2d40a7bd4e854a5faedc89.1489486985.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57237
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

Cache management is implemented separately for Cavium Octeon CPUs, so
r4k_blast_[id]cache aren't available. Instead for Octeon perform a local
icache flush using local_flush_icache_range(), and for other platforms
which don't use c-r4k.c use __flush_cache_all() / flush_icache_all().

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/emulate.c | 30 +++++++++++++++++++++++++++---
 arch/mips/mm/cache.c    |  1 +
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 2070864c8e48..4833ebad89d9 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1833,11 +1833,35 @@ enum emulation_result kvm_mips_emulate_cache(union mips_instruction inst,
 			  vcpu->arch.pc, vcpu->arch.gprs[31], cache, op, base,
 			  arch->gprs[base], offset);
 
-		if (cache == Cache_D)
+		if (cache == Cache_D) {
+#ifdef CONFIG_CPU_R4K_CACHE_TLB
 			r4k_blast_dcache();
-		else if (cache == Cache_I)
+#else
+			switch (boot_cpu_type()) {
+			case CPU_CAVIUM_OCTEON3:
+				/* locally flush icache */
+				local_flush_icache_range(0, 0);
+				break;
+			default:
+				__flush_cache_all();
+				break;
+			}
+#endif
+		} else if (cache == Cache_I) {
+#ifdef CONFIG_CPU_R4K_CACHE_TLB
 			r4k_blast_icache();
-		else {
+#else
+			switch (boot_cpu_type()) {
+			case CPU_CAVIUM_OCTEON3:
+				/* locally flush icache */
+				local_flush_icache_range(0, 0);
+				break;
+			default:
+				flush_icache_all();
+				break;
+			}
+#endif
+		} else {
 			kvm_err("%s: unsupported CACHE INDEX operation\n",
 				__func__);
 			return EMULATE_FAIL;
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 6db341347202..899e46279902 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -24,6 +24,7 @@
 /* Cache operations. */
 void (*flush_cache_all)(void);
 void (*__flush_cache_all)(void);
+EXPORT_SYMBOL_GPL(__flush_cache_all);
 void (*flush_cache_mm)(struct mm_struct *mm);
 void (*flush_cache_range)(struct vm_area_struct *vma, unsigned long start,
 	unsigned long end);
-- 
git-series 0.8.10
