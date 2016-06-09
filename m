Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:20:31 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:34783 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041441AbcFIVSlMp1VE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:18:41 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1bB7La-0005JW-TY; Thu, 09 Jun 2016 21:18:39 +0000
Received: from kamal by fourier with local (Exim 4.86_2)
        (envelope-from <kamal@whence.com>)
        id 1bB7LY-0006Ao-6b; Thu, 09 Jun 2016 14:18:36 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C3=84=C2=8Dm=C3=83=C2=A1=C3=85=E2=84=A2?= 
        <rkrcmar@redhat.com>, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, kvm@vger.kernel.org,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 4.2.y-ckt 084/206] MIPS: KVM: Fix timer IRQ race when freezing timer
Date:   Thu,  9 Jun 2016 14:14:53 -0700
Message-Id: <1465507015-23052-85-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465507015-23052-1-git-send-email-kamal@canonical.com>
References: <1465507015-23052-1-git-send-email-kamal@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Extended-Stable: 4.2
Content-Transfer-Encoding: 8bit
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

4.2.8-ckt12 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: James Hogan <james.hogan@imgtec.com>

commit 4355c44f063d3de4f072d796604c7f4ba4085cc3 upstream.

There's a particularly narrow and subtle race condition when the
software emulated guest timer is frozen which can allow a guest timer
interrupt to be missed.

This happens due to the hrtimer expiry being inexact, so very
occasionally the freeze time will be after the moment when the emulated
CP0_Count transitions to the same value as CP0_Compare (so an IRQ should
be generated), but before the moment when the hrtimer is due to expire
(so no IRQ is generated). The IRQ won't be generated when the timer is
resumed either, since the resume CP0_Count will already match CP0_Compare.

With VZ guests in particular this is far more likely to happen, since
the soft timer may be frozen frequently in order to restore the timer
state to the hardware guest timer. This happens after 5-10 hours of
guest soak testing, resulting in an overflow in guest kernel timekeeping
calculations, hanging the guest. A more focussed test case to
intentionally hit the race (with the help of a new hypcall to cause the
timer state to migrated between hardware & software) hits the condition
fairly reliably within around 30 seconds.

Instead of relying purely on the inexact hrtimer expiry to determine
whether an IRQ should be generated, read the guest CP0_Compare and
directly check whether the freeze time is before or after it. Only if
CP0_Count is on or after CP0_Compare do we check the hrtimer expiry to
determine whether the last IRQ has already been generated (which will
have pushed back the expiry by one timer period).

Fixes: e30492bbe95a ("MIPS: KVM: Rewrite count/compare timer emulation")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim KrÄmÃ¡Å™" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kvm/emulate.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 41b1b09..eaf77b5 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -302,12 +302,31 @@ static inline ktime_t kvm_mips_count_time(struct kvm_vcpu *vcpu)
  */
 static uint32_t kvm_mips_read_count_running(struct kvm_vcpu *vcpu, ktime_t now)
 {
-	ktime_t expires;
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	ktime_t expires, threshold;
+	uint32_t count, compare;
 	int running;
 
-	/* Is the hrtimer pending? */
+	/* Calculate the biased and scaled guest CP0_Count */
+	count = vcpu->arch.count_bias + kvm_mips_ktime_to_count(vcpu, now);
+	compare = kvm_read_c0_guest_compare(cop0);
+
+	/*
+	 * Find whether CP0_Count has reached the closest timer interrupt. If
+	 * not, we shouldn't inject it.
+	 */
+	if ((int32_t)(count - compare) < 0)
+		return count;
+
+	/*
+	 * The CP0_Count we're going to return has already reached the closest
+	 * timer interrupt. Quickly check if it really is a new interrupt by
+	 * looking at whether the interval until the hrtimer expiry time is
+	 * less than 1/4 of the timer period.
+	 */
 	expires = hrtimer_get_expires(&vcpu->arch.comparecount_timer);
-	if (ktime_compare(now, expires) >= 0) {
+	threshold = ktime_add_ns(now, vcpu->arch.count_period / 4);
+	if (ktime_before(expires, threshold)) {
 		/*
 		 * Cancel it while we handle it so there's no chance of
 		 * interference with the timeout handler.
@@ -329,8 +348,7 @@ static uint32_t kvm_mips_read_count_running(struct kvm_vcpu *vcpu, ktime_t now)
 		}
 	}
 
-	/* Return the biased and scaled guest CP0_Count */
-	return vcpu->arch.count_bias + kvm_mips_ktime_to_count(vcpu, now);
+	return count;
 }
 
 /**
-- 
2.7.4
