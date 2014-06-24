Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 19:34:49 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13542 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6834666AbaFXRbpus67p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2014 19:31:45 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9043AF8219441;
        Tue, 24 Jun 2014 18:31:36 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Tue, 24 Jun
 2014 18:31:38 +0100
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by klmail02.kl.imgtec.org
 (192.168.5.97) with Microsoft SMTP Server (TLS) id 14.3.181.6; Tue, 24 Jun
 2014 18:31:38 +0100
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 24 Jun 2014 18:31:38 +0100
Received: from fun-lab.mips.com (10.20.2.221) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 24 Jun
 2014 10:31:36 -0700
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <pbonzini@redhat.com>
CC:     <gleb@kernel.org>, <kvm@vger.kernel.org>, <sanjayl@kymasys.com>,
        <james.hogan@imgtec.com>, <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <dengcheng.zhu@imgtec.com>
Subject: [PATCH v3 6/9] MIPS: KVM: Restore correct value for WIRED at TLB uninit
Date:   Tue, 24 Jun 2014 10:31:07 -0700
Message-ID: <1403631071-6012-7-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1403631071-6012-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1403631071-6012-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.2.221]
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40749
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

At TLB initialization, the commpage TLB entry is reserved on top of the
existing WIRED entries (the number not necessarily be 0).

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 arch/mips/kvm/mips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 27250ee..3d53d34 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -170,7 +170,7 @@ void kvm_arch_sync_events(struct kvm *kvm)
 static void kvm_mips_uninit_tlbs(void *arg)
 {
 	/* Restore wired count */
-	write_c0_wired(0);
+	write_c0_wired(read_c0_wired() - 1);
 	mtc0_tlbw_hazard();
 	/* Clear out all the TLBs */
 	kvm_local_flush_tlb_all();
-- 
1.8.5.3
