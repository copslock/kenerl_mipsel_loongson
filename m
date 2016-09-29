Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Sep 2016 14:13:54 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:19220 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991984AbcI2MNZF0dpi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Sep 2016 14:13:25 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 53080B0C9084;
        Thu, 29 Sep 2016 13:13:16 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL03.hh.imgtec.org (10.44.0.22) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 29 Sep 2016 13:13:18 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>
Subject: [GIT PULL 1/6] KVM: MIPS: Override HVA error values for EVA
Date:   Thu, 29 Sep 2016 13:13:08 +0100
Message-ID: <1475151193-28505-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1475151193-28505-1-git-send-email-james.hogan@imgtec.com>
References: <1475151193-28505-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55292
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

MIPS Enhanced Virtual Addressing (EVA) allows the user mode and kernel
mode address spaces to overlap, breaking the assumption that PAGE_OFFSET
is an appropriate KVM HVA error value, since PAGE_OFFSET may be as low
as zero.

Fix this in the same way that s390 does in commit bf640876e21f ("KVM:
s390: Make KVM_HVA_ERR_BAD usable on s390"), by overriding
KVM_HVA_ERR_[RO_]BAD and kvm_is_error_hva() in asm/kvm_host.h.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index b54bcadd8aec..4d7e0e466b5a 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -107,6 +107,20 @@
 #define KVM_INVALID_INST		0xdeadbeef
 #define KVM_INVALID_ADDR		0xdeadbeef
 
+/*
+ * EVA has overlapping user & kernel address spaces, so user VAs may be >
+ * PAGE_OFFSET. For this reason we can't use the default KVM_HVA_ERR_BAD of
+ * PAGE_OFFSET.
+ */
+
+#define KVM_HVA_ERR_BAD			(-1UL)
+#define KVM_HVA_ERR_RO_BAD		(-2UL)
+
+static inline bool kvm_is_error_hva(unsigned long addr)
+{
+	return IS_ERR_VALUE(addr);
+}
+
 extern atomic_t kvm_mips_instance;
 
 struct kvm_vm_stat {
-- 
2.7.3
