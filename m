Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 May 2013 07:53:43 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:34758 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6835050Ab3ESFtSed03A (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 May 2013 07:49:18 +0200
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Sat, 18 May 2013 22:49:11 -0700
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 51A37630066; Sat, 18 May 2013 22:47:43 -0700 (PDT)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 14/18] KVM/MIPS32-VZ: Guest exception batching support.
Date:   Sat, 18 May 2013 22:47:36 -0700
Message-Id: <1368942460-15577-15-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
References: <n>
 <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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

- In Trap & Emulate the hypervisor maintains exception priority
  in order to comply with the priorities defined by the architecture.

- In VZ mode, we just set all the pending exception bits, and let
  the processor deliver them to the guest in the expected priority
  order.

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kvm/kvm_mips_int.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/kvm/kvm_mips_int.h b/arch/mips/kvm/kvm_mips_int.h
index 20da7d2..7eac28e 100644
--- a/arch/mips/kvm/kvm_mips_int.h
+++ b/arch/mips/kvm/kvm_mips_int.h
@@ -29,8 +29,13 @@
 
 #define C_TI        (_ULCAST_(1) << 30)
 
+#ifdef CONFIG_KVM_MIPS_VZ
+#define KVM_MIPS_IRQ_DELIVER_ALL_AT_ONCE (1)
+#define KVM_MIPS_IRQ_CLEAR_ALL_AT_ONCE   (1)
+#else
 #define KVM_MIPS_IRQ_DELIVER_ALL_AT_ONCE (0)
 #define KVM_MIPS_IRQ_CLEAR_ALL_AT_ONCE   (0)
+#endif
 
 void kvm_mips_queue_irq(struct kvm_vcpu *vcpu, uint32_t priority);
 void kvm_mips_dequeue_irq(struct kvm_vcpu *vcpu, uint32_t priority);
-- 
1.7.11.3
