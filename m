Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 11:35:21 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60420 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994915AbdCNK0Gou54H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 11:26:06 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 30A83D6DC1B34;
        Tue, 14 Mar 2017 10:25:56 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Mar 2017 10:25:58 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Subject: [PATCH 5/8] KVM: MIPS/VZ: VZ hardware setup for Octeon III
Date:   Tue, 14 Mar 2017 10:25:48 +0000
Message-ID: <0e606fbc0d8b5e8d3ee43271399cd890404ac92e.1489486985.git-series.james.hogan@imgtec.com>
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
X-archive-position: 57241
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

Set up hardware virtualisation on Octeon III cores, configuring guest
interrupt routing and carving out half of the root TLB for guest use,
restoring it back again afterwards.

We need to be careful to inhibit TLB shutdown machine check exceptions
while invalidating guest TLB entries, since TLB invalidation is not
available so guest entries must be invalidated by setting them to unique
unmapped addresses, which could conflict with mappings set by the guest
or root if recently repartitioned.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/tlb.c |  16 ++++++-
 arch/mips/kvm/vz.c  | 120 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 108 insertions(+), 28 deletions(-)

diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index fbab2f747721..7c6336dd2638 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -447,6 +447,7 @@ void kvm_vz_local_flush_guesttlb_all(void)
 	unsigned long old_entrylo[2];
 	unsigned long old_pagemask;
 	int entry;
+	u64 cvmmemctl2 = 0;
 
 	local_irq_save(flags);
 
@@ -457,6 +458,15 @@ void kvm_vz_local_flush_guesttlb_all(void)
 	old_entrylo[1] = read_gc0_entrylo1();
 	old_pagemask = read_gc0_pagemask();
 
+	switch (current_cpu_type()) {
+	case CPU_CAVIUM_OCTEON3:
+		/* Inhibit machine check due to multiple matching TLB entries */
+		cvmmemctl2 = read_c0_cvmmemctl2();
+		cvmmemctl2 |= CVMMEMCTL2_INHIBITTS;
+		write_c0_cvmmemctl2(cvmmemctl2);
+		break;
+	};
+
 	/* Invalidate guest entries in guest TLB */
 	write_gc0_entrylo0(0);
 	write_gc0_entrylo1(0);
@@ -468,6 +478,12 @@ void kvm_vz_local_flush_guesttlb_all(void)
 		mtc0_tlbw_hazard();
 		guest_tlb_write_indexed();
 	}
+
+	if (cvmmemctl2) {
+		cvmmemctl2 &= ~CVMMEMCTL2_INHIBITTS;
+		write_c0_cvmmemctl2(cvmmemctl2);
+	};
+
 	write_gc0_index(old_index);
 	write_gc0_entryhi(old_entryhi);
 	write_gc0_entrylo0(old_entrylo[0]);
diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index 33bb8c6e1b05..21f4495feb15 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -2747,37 +2747,73 @@ static unsigned int kvm_vz_resize_guest_vtlb(unsigned int size)
 static int kvm_vz_hardware_enable(void)
 {
 	unsigned int mmu_size, guest_mmu_size, ftlb_size;
+	u64 guest_cvmctl, cvmvmconfig;
+
+	switch (current_cpu_type()) {
+	case CPU_CAVIUM_OCTEON3:
+		/* Set up guest timer/perfcount IRQ lines */
+		guest_cvmctl = read_gc0_cvmctl();
+		guest_cvmctl &= ~CVMCTL_IPTI;
+		guest_cvmctl |= 7ull << CVMCTL_IPTI_SHIFT;
+		guest_cvmctl &= ~CVMCTL_IPPCI;
+		guest_cvmctl |= 6ull << CVMCTL_IPPCI_SHIFT;
+		write_gc0_cvmctl(guest_cvmctl);
+
+		cvmvmconfig = read_c0_cvmvmconfig();
+		/* No I/O hole translation. */
+		cvmvmconfig |= CVMVMCONF_DGHT;
+		/* Halve the root MMU size */
+		mmu_size = ((cvmvmconfig & CVMVMCONF_MMUSIZEM1)
+			    >> CVMVMCONF_MMUSIZEM1_S) + 1;
+		guest_mmu_size = mmu_size / 2;
+		mmu_size -= guest_mmu_size;
+		cvmvmconfig &= ~CVMVMCONF_RMMUSIZEM1;
+		cvmvmconfig |= mmu_size - 1;
+		write_c0_cvmvmconfig(cvmvmconfig);
+
+		/* Update our records */
+		current_cpu_data.tlbsize = mmu_size;
+		current_cpu_data.tlbsizevtlb = mmu_size;
+		current_cpu_data.guest.tlbsize = guest_mmu_size;
+
+		/* Flush moved entries in new (guest) context */
+		kvm_vz_local_flush_guesttlb_all();
+		break;
+	default:
+		/*
+		 * ImgTec cores tend to use a shared root/guest TLB. To avoid
+		 * overlap of root wired and guest entries, the guest TLB may
+		 * need resizing.
+		 */
+		mmu_size = current_cpu_data.tlbsizevtlb;
+		ftlb_size = current_cpu_data.tlbsize - mmu_size;
 
-	/*
-	 * ImgTec cores tend to use a shared root/guest TLB. To avoid overlap of
-	 * root wired and guest entries, the guest TLB may need resizing.
-	 */
-	mmu_size = current_cpu_data.tlbsizevtlb;
-	ftlb_size = current_cpu_data.tlbsize - mmu_size;
-
-	/* Try switching to maximum guest VTLB size for flush */
-	guest_mmu_size = kvm_vz_resize_guest_vtlb(mmu_size);
-	current_cpu_data.guest.tlbsize = guest_mmu_size + ftlb_size;
-	kvm_vz_local_flush_guesttlb_all();
+		/* Try switching to maximum guest VTLB size for flush */
+		guest_mmu_size = kvm_vz_resize_guest_vtlb(mmu_size);
+		current_cpu_data.guest.tlbsize = guest_mmu_size + ftlb_size;
+		kvm_vz_local_flush_guesttlb_all();
 
-	/*
-	 * Reduce to make space for root wired entries and at least 2 root
-	 * non-wired entries. This does assume that long-term wired entries
-	 * won't be added later.
-	 */
-	guest_mmu_size = mmu_size - num_wired_entries() - 2;
-	guest_mmu_size = kvm_vz_resize_guest_vtlb(guest_mmu_size);
-	current_cpu_data.guest.tlbsize = guest_mmu_size + ftlb_size;
+		/*
+		 * Reduce to make space for root wired entries and at least 2
+		 * root non-wired entries. This does assume that long-term wired
+		 * entries won't be added later.
+		 */
+		guest_mmu_size = mmu_size - num_wired_entries() - 2;
+		guest_mmu_size = kvm_vz_resize_guest_vtlb(guest_mmu_size);
+		current_cpu_data.guest.tlbsize = guest_mmu_size + ftlb_size;
 
-	/*
-	 * Write the VTLB size, but if another CPU has already written, check it
-	 * matches or we won't provide a consistent view to the guest. If this
-	 * ever happens it suggests an asymmetric number of wired entries.
-	 */
-	if (cmpxchg(&kvm_vz_guest_vtlb_size, 0, guest_mmu_size) &&
-	    WARN(guest_mmu_size != kvm_vz_guest_vtlb_size,
-		 "Available guest VTLB size mismatch"))
-		return -EINVAL;
+		/*
+		 * Write the VTLB size, but if another CPU has already written,
+		 * check it matches or we won't provide a consistent view to the
+		 * guest. If this ever happens it suggests an asymmetric number
+		 * of wired entries.
+		 */
+		if (cmpxchg(&kvm_vz_guest_vtlb_size, 0, guest_mmu_size) &&
+		    WARN(guest_mmu_size != kvm_vz_guest_vtlb_size,
+			 "Available guest VTLB size mismatch"))
+			return -EINVAL;
+		break;
+	}
 
 	/*
 	 * Enable virtualization features granting guest direct control of
@@ -2814,8 +2850,36 @@ static int kvm_vz_hardware_enable(void)
 
 static void kvm_vz_hardware_disable(void)
 {
+	u64 cvmvmconfig;
+	unsigned int mmu_size;
+
+	/* Flush any remaining guest TLB entries */
 	kvm_vz_local_flush_guesttlb_all();
 
+	switch (current_cpu_type()) {
+	case CPU_CAVIUM_OCTEON3:
+		/*
+		 * Allocate whole TLB for root. Existing guest TLB entries will
+		 * change ownership to the root TLB. We should be safe though as
+		 * they've already been flushed above while in guest TLB.
+		 */
+		cvmvmconfig = read_c0_cvmvmconfig();
+		mmu_size = ((cvmvmconfig & CVMVMCONF_MMUSIZEM1)
+			    >> CVMVMCONF_MMUSIZEM1_S) + 1;
+		cvmvmconfig &= ~CVMVMCONF_RMMUSIZEM1;
+		cvmvmconfig |= mmu_size - 1;
+		write_c0_cvmvmconfig(cvmvmconfig);
+
+		/* Update our records */
+		current_cpu_data.tlbsize = mmu_size;
+		current_cpu_data.tlbsizevtlb = mmu_size;
+		current_cpu_data.guest.tlbsize = 0;
+
+		/* Flush moved entries in new (root) context */
+		local_flush_tlb_all();
+		break;
+	}
+
 	if (cpu_has_guestid) {
 		write_c0_guestctl1(0);
 		kvm_vz_local_flush_roottlb_all_guests();
-- 
git-series 0.8.10
