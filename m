Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 May 2016 23:00:13 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:41573 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27040218AbcE3VAJh2vIl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 May 2016 23:00:09 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 570B983D;
        Mon, 30 May 2016 21:00:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C3=84=C2=8Dm=C3=83=C2=A1=C3=85=E2=84=A2?= 
        <rkrcmar@redhat.com>, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, kvm@vger.kernel.org
Subject: [PATCH 4.4 59/86] MIPS: KVM: Fix timer IRQ race when freezing timer
Date:   Mon, 30 May 2016 13:49:48 -0700
Message-Id: <20160530204939.407129729@linuxfoundation.org>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160530204937.379068148@linuxfoundation.org>
References: <20160530204937.379068148@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53704
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kvm/emulate.c |   28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -302,12 +302,31 @@ static inline ktime_t kvm_mips_count_tim
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
@@ -329,8 +348,7 @@ static uint32_t kvm_mips_read_count_runn
 		}
 	}
 
-	/* Return the biased and scaled guest CP0_Count */
-	return vcpu->arch.count_bias + kvm_mips_ktime_to_count(vcpu, now);
+	return count;
 }
 
 /**
