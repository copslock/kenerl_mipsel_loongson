Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jun 2014 21:13:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42036 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860047AbaFZTMkj2DAI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Jun 2014 21:12:40 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 183FAA9B2B9A5;
        Thu, 26 Jun 2014 20:12:30 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.10.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Thu, 26 Jun
 2014 20:12:34 +0100
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by klmail02.kl.imgtec.org
 (10.40.10.222) with Microsoft SMTP Server (TLS) id 14.3.181.6; Thu, 26 Jun
 2014 20:12:33 +0100
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 26 Jun 2014 20:12:33 +0100
Received: from fun-lab.mips.com (10.20.2.221) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 26 Jun
 2014 12:12:24 -0700
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <pbonzini@redhat.com>
CC:     <gleb@kernel.org>, <kvm@vger.kernel.org>, <sanjayl@kymasys.com>,
        <james.hogan@imgtec.com>, <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <dengcheng.zhu@imgtec.com>
Subject: [PATCH v4 4/7] MIPS: KVM: Remove unneeded volatile
Date:   Thu, 26 Jun 2014 12:11:37 -0700
Message-ID: <1403809900-17454-5-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1403809900-17454-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1403809900-17454-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.2.221]
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

The keyword volatile for idx in the TLB functions is unnecessary.

Reviewed-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 arch/mips/kvm/kvm_tlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index 29a5bdb..bbcd822 100644
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -201,7 +201,7 @@ int kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, unsigned long entryhi,
 {
 	unsigned long flags;
 	unsigned long old_entryhi;
-	volatile int idx;
+	int idx;
 
 	local_irq_save(flags);
 
@@ -426,7 +426,7 @@ EXPORT_SYMBOL(kvm_mips_guest_tlb_lookup);
 int kvm_mips_host_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long vaddr)
 {
 	unsigned long old_entryhi, flags;
-	volatile int idx;
+	int idx;
 
 	local_irq_save(flags);
 
-- 
1.8.5.3
