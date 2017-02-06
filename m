Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2017 11:47:41 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21692 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991726AbdBFKrNRXJUl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Feb 2017 11:47:13 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 5CCE0EAAE93DE;
        Mon,  6 Feb 2017 10:47:04 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 6 Feb 2017 10:47:06 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        David Daney <david.daney@cavium.com>,
        Jonathan Corbet <corbet@lwn.net>, <kvm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH 2/4] KVM: MIPS: Implement GET_CLOCK_FREQ hypercall
Date:   Mon, 6 Feb 2017 10:46:47 +0000
Message-ID: <f9d4759bdad2f939e3d28c6a7b4711a60101655e.1486377433.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.3a9aba89648ae37be335c79cc2b18cf6bf57ef08.1486377433.git-series.james.hogan@imgtec.com>
References: <cover.3a9aba89648ae37be335c79cc2b18cf6bf57ef08.1486377433.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56652
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

Implement the MIPS GET_CLOCK_FREQ hypercall used by paravirtual guest
kernels. When the guest performs this hypercall, the value of count_hz
is returned, which is the current rate of the CP0_Count register.

We also document the hypercall along with the others as the
documentation was never added.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc: David Daney <david.daney@cavium.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 Documentation/virtual/kvm/hypercalls.txt |  6 ++++++
 arch/mips/kvm/hypcall.c                  | 18 +++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/virtual/kvm/hypercalls.txt b/Documentation/virtual/kvm/hypercalls.txt
index 8f36582ce2b7..e9f1c9d3da98 100644
--- a/Documentation/virtual/kvm/hypercalls.txt
+++ b/Documentation/virtual/kvm/hypercalls.txt
@@ -86,3 +86,9 @@ the vcpu to sleep until occurrence of an appropriate event. Another vcpu of the
 same guest can wakeup the sleeping vcpu by issuing KVM_HC_KICK_CPU hypercall,
 specifying APIC ID (a1) of the vcpu to be woken up. An additional argument (a0)
 is used in the hypercall for future use.
+
+6. KVM_HC_MIPS_GET_CLOCK_FREQ
+------------------------
+Architecture: mips
+Status: active
+Purpose: Return the frequency of CP0_Count in HZ.
diff --git a/arch/mips/kvm/hypcall.c b/arch/mips/kvm/hypcall.c
index 83063435195f..7c74ec25f2b9 100644
--- a/arch/mips/kvm/hypcall.c
+++ b/arch/mips/kvm/hypcall.c
@@ -32,9 +32,21 @@ enum emulation_result kvm_mips_emul_hypcall(struct kvm_vcpu *vcpu,
 static int kvm_mips_hypercall(struct kvm_vcpu *vcpu, unsigned long num,
 			      const unsigned long *args, unsigned long *hret)
 {
-	/* Report unimplemented hypercall to guest */
-	*hret = -KVM_ENOSYS;
-	return RESUME_GUEST;
+	int ret = RESUME_GUEST;
+
+	switch (num) {
+	case KVM_HC_MIPS_GET_CLOCK_FREQ:
+		/* Return frequency of count/compare timer */
+		*hret = (s32)vcpu->arch.count_hz;
+		break;
+
+	default:
+		/* Report unimplemented hypercall to guest */
+		*hret = -KVM_ENOSYS;
+		break;
+	};
+
+	return ret;
 }
 
 int kvm_mips_handle_hypcall(struct kvm_vcpu *vcpu)
-- 
git-series 0.8.10
