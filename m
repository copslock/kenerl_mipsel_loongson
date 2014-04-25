Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2014 17:21:25 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:7139 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827439AbaDYPUjBisTe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Apr 2014 17:20:39 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id AF41DB5F39EDD;
        Fri, 25 Apr 2014 16:20:29 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Fri, 25 Apr 2014 16:20:32 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.65) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 25 Apr 2014 16:20:31 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 03/21] MIPS: KVM: Use tlb_write_random
Date:   Fri, 25 Apr 2014 16:19:46 +0100
Message-ID: <1398439204-26171-4-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com>
References: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.65]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39927
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

When MIPS KVM needs to write a TLB entry for the guest it reads the
CP0_Random register, uses it to generate the CP_Index, and writes the
TLB entry using the TLBWI instruction (tlb_write_indexed()).

However there's an instruction for that, TLBWR (tlb_write_random()) so
use that instead.

This happens to also fix an issue with Ingenic XBurst cores where the
same TLB entry is replaced each time preventing forward progress on
stores due to alternating between TLB load misses for the instruction
fetch and TLB store misses.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kvm/kvm_tlb.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index 50ab9c4d4a5d..9d371ee0a755 100644
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -222,16 +222,14 @@ kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, unsigned long entryhi,
 		return -1;
 	}
 
-	if (idx < 0) {
-		idx = read_c0_random() % current_cpu_data.tlbsize;
-		write_c0_index(idx);
-		mtc0_tlbw_hazard();
-	}
 	write_c0_entrylo0(entrylo0);
 	write_c0_entrylo1(entrylo1);
 	mtc0_tlbw_hazard();
 
-	tlb_write_indexed();
+	if (idx < 0)
+		tlb_write_random();
+	else
+		tlb_write_indexed();
 	tlbw_use_hazard();
 
 #ifdef DEBUG
-- 
1.8.1.2
