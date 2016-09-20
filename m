Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2016 14:06:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34938 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992836AbcITMGSn-dB6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Sep 2016 14:06:18 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id DC649E7CCB628;
        Tue, 20 Sep 2016 13:05:59 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 20 Sep 2016 13:06:02 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <kvm@vger.kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 4/4] KVM: MIPS: Drop dubious EntryHi optimisation
Date:   Tue, 20 Sep 2016 13:05:57 +0100
Message-ID: <6c11917e34276ec1175d920950be665ef869c119.1474372617.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.7.3
MIME-Version: 1.0
In-Reply-To: <cover.b4aaacd5414bd20c4eb4d53417956b268d69d1af.1474372617.git-series.james.hogan@imgtec.com>
References: <cover.b4aaacd5414bd20c4eb4d53417956b268d69d1af.1474372617.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55212
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

There exists a slightly dubious optimisation in the implementation of
the MIPS KVM EntryHi emulation which skips TLB invalidation if the
EntryHi points to an address in the guest KSeg0 region, intended to
catch guest TLB invalidations where the ASID is almost immediately
restored to the previous value.

Now that we perform lazy host ASID regeneration for guest user mode when
the guest ASID changes we should be able to drop the optimisation
without a significant impact (only the extra TLB refills for the small
amount of code while the TLB is being invalidated).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/emulate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 8dc9e64346e6..4db4c0370859 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1162,8 +1162,7 @@ enum emulation_result kvm_mips_emulate_CP0(union mips_instruction inst,
 			} else if (rd == MIPS_CP0_TLB_HI && sel == 0) {
 				u32 nasid =
 					vcpu->arch.gprs[rt] & KVM_ENTRYHI_ASID;
-				if ((KSEGX(vcpu->arch.gprs[rt]) != CKSEG0) &&
-				    ((kvm_read_c0_guest_entryhi(cop0) &
+				if (((kvm_read_c0_guest_entryhi(cop0) &
 				      KVM_ENTRYHI_ASID) != nasid)) {
 					trace_kvm_asid_change(vcpu,
 						kvm_read_c0_guest_entryhi(cop0)
-- 
git-series 0.8.10
