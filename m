Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2015 07:14:19 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:48270 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006750AbbCDGORmvlb5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Mar 2015 07:14:17 +0100
Received: from localhost (unknown [166.170.43.162])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4DBA1990;
        Wed,  4 Mar 2015 06:14:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 3.10 20/53] MIPS: KVM: Deliver guest interrupts after local_irq_disable()
Date:   Tue,  3 Mar 2015 22:06:23 -0800
Message-Id: <20150304054613.294474233@linuxfoundation.org>
X-Mailer: git-send-email 2.3.1
In-Reply-To: <20150304054609.869052846@linuxfoundation.org>
References: <20150304054609.869052846@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 044f0f03eca0110e1835b2ea038a484b93950328 upstream.

When about to run the guest, deliver guest interrupts after disabling
host interrupts. This should prevent an hrtimer interrupt from being
handled after delivering guest interrupts, and therefore not delivering
the guest timer interrupt until after the next guest exit.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Sanjay Lal <sanjayl@kymasys.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kvm/kvm_mips.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -413,11 +413,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_v
 		vcpu->mmio_needed = 0;
 	}
 
+	local_irq_disable();
 	/* Check if we have any exceptions/interrupts pending */
 	kvm_mips_deliver_interrupts(vcpu,
 				    kvm_read_c0_guest_cause(vcpu->arch.cop0));
 
-	local_irq_disable();
 	kvm_guest_enter();
 
 	r = __kvm_mips_vcpu_run(run, vcpu);
