Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jun 2014 21:14:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12567 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860050AbaFZTMyAsxp4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Jun 2014 21:12:54 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9A5AB42C78C54;
        Thu, 26 Jun 2014 20:12:43 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.10.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Thu, 26 Jun
 2014 20:12:47 +0100
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by klmail02.kl.imgtec.org
 (10.40.10.222) with Microsoft SMTP Server (TLS) id 14.3.181.6; Thu, 26 Jun
 2014 20:12:46 +0100
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 26 Jun 2014 20:12:46 +0100
Received: from fun-lab.mips.com (10.20.2.221) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 26 Jun
 2014 12:12:44 -0700
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <pbonzini@redhat.com>
CC:     <gleb@kernel.org>, <kvm@vger.kernel.org>, <sanjayl@kymasys.com>,
        <james.hogan@imgtec.com>, <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <dengcheng.zhu@imgtec.com>
Subject: [PATCH v4 6/7] MIPS: KVM: Skip memory cleaning in kvm_mips_commpage_init()
Date:   Thu, 26 Jun 2014 12:11:39 -0700
Message-ID: <1403809900-17454-7-git-send-email-dengcheng.zhu@imgtec.com>
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
X-archive-position: 40857
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

The commpage is allocated using kzalloc(), so there's no need of cleaning
the memory of the kvm_mips_commpage struct and its internal mips_coproc.

Reviewed-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 arch/mips/kvm/commpage.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/kvm/commpage.c b/arch/mips/kvm/commpage.c
index 61b9c04..2d6e976 100644
--- a/arch/mips/kvm/commpage.c
+++ b/arch/mips/kvm/commpage.c
@@ -28,9 +28,6 @@ void kvm_mips_commpage_init(struct kvm_vcpu *vcpu)
 {
 	struct kvm_mips_commpage *page = vcpu->arch.kseg0_commpage;
 
-	memset(page, 0, sizeof(struct kvm_mips_commpage));
-
 	/* Specific init values for fields */
 	vcpu->arch.cop0 = &page->cop0;
-	memset(vcpu->arch.cop0, 0, sizeof(struct mips_coproc));
 }
-- 
1.8.5.3
