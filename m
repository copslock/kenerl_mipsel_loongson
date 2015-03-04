Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2015 07:17:43 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:49234 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006674AbbCDGRlCkxqw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Mar 2015 07:17:41 +0100
Received: from localhost (unknown [166.170.43.162])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4CD9AB10;
        Wed,  4 Mar 2015 06:17:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 3.18 066/151] KVM: MIPS: Disable HTW while in guest
Date:   Tue,  3 Mar 2015 22:13:20 -0800
Message-Id: <20150304055508.234461067@linuxfoundation.org>
X-Mailer: git-send-email 2.3.1
In-Reply-To: <20150304055457.084276421@linuxfoundation.org>
References: <20150304055457.084276421@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46130
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit c4c6f2cad9e1d4cc076bc183c3689cc9e7019c75 upstream.

Ensure any hardware page table walker (HTW) is disabled while in KVM
guest mode, as KVM doesn't yet set up hardware page table walking for
guest mappings so the wrong mappings would get loaded, resulting in the
guest hanging or crashing once it reaches userland.

The HTW is disabled and re-enabled around the call to
__kvm_mips_vcpu_run() which does the initial switch into guest mode and
the final switch out of guest context. Additionally it is enabled for
the duration of guest exits (i.e. kvm_mips_handle_exit()), getting
disabled again before returning back to guest or host.

In all cases the HTW is only disabled in normal kernel mode while
interrupts are disabled, so that the HTW doesn't get left disabled if
the process is preempted.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kvm/mips.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -18,6 +18,7 @@
 #include <asm/page.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
+#include <asm/pgtable.h>
 
 #include <linux/kvm_host.h>
 
@@ -385,8 +386,14 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_v
 
 	kvm_guest_enter();
 
+	/* Disable hardware page table walking while in guest */
+	htw_stop();
+
 	r = __kvm_mips_vcpu_run(run, vcpu);
 
+	/* Re-enable HTW before enabling interrupts */
+	htw_start();
+
 	kvm_guest_exit();
 	local_irq_enable();
 
@@ -1002,6 +1009,9 @@ int kvm_mips_handle_exit(struct kvm_run
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
+	/* re-enable HTW before enabling interrupts */
+	htw_start();
+
 	/* Set a default exit reason */
 	run->exit_reason = KVM_EXIT_UNKNOWN;
 	run->ready_for_interrupt_injection = 1;
@@ -1136,6 +1146,9 @@ skip_emul:
 		}
 	}
 
+	/* Disable HTW before returning to guest or host */
+	htw_stop();
+
 	return ret;
 }
 
