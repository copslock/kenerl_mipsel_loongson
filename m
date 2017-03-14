Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 11:34:10 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41084 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994912AbdCNK0DcsVaH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 11:26:03 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id A9A578B49F9D8;
        Tue, 14 Mar 2017 10:25:54 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Mar 2017 10:25:57 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Subject: [PATCH 3/8] KVM: MIPS/TLB: Handle virtually tagged icaches
Date:   Tue, 14 Mar 2017 10:25:46 +0000
Message-ID: <72c8f0fd8ab01b77e65b34c7b213543043e0ef14.1489486985.git-series.james.hogan@imgtec.com>
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
X-archive-position: 57238
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

When TLB entries are invalidated in the presence of a virtually tagged
icache, such as that found on Octeon CPUs, flush the icache so that we
don't get a reserved instruction exception even though the TLB mapping
is removed.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/tlb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index c215470fdcb0..fbab2f747721 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -185,6 +185,13 @@ int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va,
 
 	local_irq_restore(flags);
 
+	/*
+	 * We don't want to get reserved instruction exceptions for missing tlb
+	 * entries.
+	 */
+	if (cpu_has_vtag_icache)
+		flush_icache_all();
+
 	if (user && idx_user >= 0)
 		kvm_debug("%s: Invalidated guest user entryhi %#lx @ idx %d\n",
 			  __func__, (va & VPN2_MASK) |
@@ -260,6 +267,13 @@ int kvm_vz_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va)
 	htw_start();
 	local_irq_restore(flags);
 
+	/*
+	 * We don't want to get reserved instruction exceptions for missing tlb
+	 * entries.
+	 */
+	if (cpu_has_vtag_icache)
+		flush_icache_all();
+
 	if (idx > 0)
 		kvm_debug("%s: Invalidated root entryhi %#lx @ idx %d\n",
 			  __func__, (va & VPN2_MASK) |
-- 
git-series 0.8.10
