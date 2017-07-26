Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jul 2017 15:36:01 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.13]:55126 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993866AbdGZNft4dkE0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Jul 2017 15:35:49 +0200
Received: from wuerfel.lan ([5.56.224.194]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M2Mj6-1dszmH2zem-00s6cO; Wed, 26 Jul 2017 15:34:57 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] smp_call_function: use inline helpers instead of macros
Date:   Wed, 26 Jul 2017 15:32:28 +0200
Message-Id: <20170726133447.2056379-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:ozb/DBC7+MVFrdRtsDhLmFgW5PJY9A9Tr/kjmI+7n/xvBEszkOk
 VbYl0rPmE9d0UMZ/bnIJp/MbG1w5uRE2x1rOoGTgJUkEMKGFWVbw9JyhSx5X8E956FSsQ0J
 mNHbJYE0wQ+plQzUvUfgrKhqPeTnWNcBOOCB5pALGkksxWHZWDiXWQyndPR411QfNFFNgAx
 kXMAkb7mFvt4lePNG/Cjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BaV9/BVGy2A=:c9B79YDi9Sta7w8+wtXHAV
 mtAEtBF338R85s8VUESCQBThyjN0EEKYhaA4CZ4Bvwf7bgrqO55q9UoQLIAXxC5Hds0/zQDIE
 6lMcu8Mmngi2P6KtGPZNdPL6ycbFvw7TEb5exdblLVYP8CbFLyH0GIpVAaG/y/cIzzXk3p6mF
 B0F8949T8bq+RgHqpcjCZdqN5gLIsjDAW0EEoeVfoQacgusTHeohawwJnykTnpTGKZS5NUuI7
 xzZh6IAW2t/J/DTVS2uGR4GWrVNoQZGCif4OOmBA5MXfv4+Nu+QtBh8JJyVTzJ9XZLqpqWy/k
 RR3unIyspdL8xNc0Ramwru1h6wq8oPFC78urMvO1GdBQea0PUqyRiG53u0Tp+Zfeww5GnuBuM
 eXC1D4vg54c0vZSZGn07jXHyOcZu1hQ3g2Y7CXJbthATHOoWIWQ3XA4oyPXlt1pI8lG+sP2W/
 3vbMIAti9GziqQRUnU/j+lhy97TLkiXkL1zq5bA+afLh0xbo6PdyESxRrRoevNzv2qVPIFe7F
 qSuNcmJkKhv4VUYOweYDkS/Dqr4Bh8KCgWE+hpDRaLjnl4oJfy0dKiAMhg/NTVXehxvLVSBpp
 RbelOY5/oBsbOljb9GlJYZNiEOUTyRicOQmnADJnaX2wL9baJoUS4e6G6a/rtbKD2tOSDuxjW
 4Hd2OdMur8Qk1vStFNNkZXMqvBbQ62pMwXAaKUTDKYwFCpDBOVB6rO/WfTQjiKQNN8au9aasx
 98sHvlHXFbuxnleNGUKY8FNi7KrUJVIeHRM96w==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

A new caller of smp_call_function() passes a local variable as the 'wait'
argument, and that variable is otherwise unused, so we get a warning
in non-SMP configurations:

virt/kvm/kvm_main.c: In function 'kvm_make_all_cpus_request':
virt/kvm/kvm_main.c:195:7: error: unused variable 'wait' [-Werror=unused-variable]
  bool wait = req & KVM_REQUEST_WAIT;

This addresses the warning by changing the two macros into inline functions.
As reported by the 0day build bot, a small change is required in the MIPS
r4k code for this, which then gets a warning about a missing variable.

Fixes: 7a97cec26b94 ("KVM: mark requests that need synchronization")
Cc: Paolo Bonzini <pbonzini@redhat.com>
Link: https://patchwork.kernel.org/patch/9722063/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: - fix MIPS build error reported by kbuild test robot
    - remove up_smp_call_function()
---
 arch/mips/mm/c-r4k.c |  2 ++
 include/linux/smp.h  | 12 +++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 81d6a15c93d0..f353bf5f24f1 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -97,9 +97,11 @@ static inline void r4k_on_each_cpu(unsigned int type,
 				   void (*func)(void *info), void *info)
 {
 	preempt_disable();
+#ifdef CONFIG_SMP
 	if (r4k_op_needs_ipi(type))
 		smp_call_function_many(&cpu_foreign_map[smp_processor_id()],
 				       func, info, 1);
+#endif
 	func(info);
 	preempt_enable();
 }
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 68123c1fe549..ea24e2d3504c 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -135,17 +135,19 @@ static inline void smp_send_stop(void) { }
  *	These macros fold the SMP functionality into a single CPU system
  */
 #define raw_smp_processor_id()			0
-static inline int up_smp_call_function(smp_call_func_t func, void *info)
+static inline int smp_call_function(smp_call_func_t func, void *info, int wait)
 {
 	return 0;
 }
-#define smp_call_function(func, info, wait) \
-			(up_smp_call_function(func, info))
 
 static inline void smp_send_reschedule(int cpu) { }
 #define smp_prepare_boot_cpu()			do {} while (0)
-#define smp_call_function_many(mask, func, info, wait) \
-			(up_smp_call_function(func, info))
+
+static inline void smp_call_function_many(const struct cpumask *mask,
+			    smp_call_func_t func, void *info, bool wait)
+{
+}
+
 static inline void call_function_init(void) { }
 
 static inline int
-- 
2.9.0
