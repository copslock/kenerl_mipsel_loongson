Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2018 23:19:26 +0100 (CET)
Received: from mail-pg1-x542.google.com ([IPv6:2607:f8b0:4864:20::542]:39269
        "EHLO mail-pg1-x542.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994540AbeJ3WTLlPHO9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Oct 2018 23:19:11 +0100
Received: by mail-pg1-x542.google.com with SMTP id r9-v6so6353631pgv.6
        for <linux-mips@linux-mips.org>; Tue, 30 Oct 2018 15:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2NS1b32dry8FBqsbwDYcAdWFDtBND6KS5TkJqBVyebo=;
        b=SzLosIbSFm8dO/V9QXWTWcjH2x0nuoG2myAK9vJPjqH1h1m+ZQgz+0WGi1Iqcjibfc
         HyVaCpXHmqFXd2mJRyp98PZknM79AbKznKF5tU7O/6thgpU/p18TfElN4C/AKB2aBuhH
         ytEhXQjosGOsm2YlRbq80AU1ma8Bozj6iyFWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2NS1b32dry8FBqsbwDYcAdWFDtBND6KS5TkJqBVyebo=;
        b=dXrMhX7F7QPdPKNpnOPmG2/u1Th8mVuSmCYb0KQbMMQ5grFEoVRUEF13GD/7vucHc7
         vPx6wSIPmJKx3u2UTgzJmFVqrAXRxHNehuTpUsfYAopXfN18V4YAryYgFgcYr5sWLl8T
         KLzhjVeT1FF92HtNzfP1i8maSeOlruC21m4BNX5N3N8NSwaNpG0cVuMLPxeyqqf8dLD2
         9pz4RZFmEhlVeJH9tZ3hgljcDn2ICwFSyFbgKHP8y61yPqttZCLnyFvVMEt2ach9H8LB
         rDeSwAzOImgVqz7axQGQsd+2K1fblh8V6urOaDxeVzCfG3kiSWChK9Z9C1sVFIFKFLh/
         QQlw==
X-Gm-Message-State: AGRZ1gIqEUu2x8bQyJvGEPKQquzRf8skP/mocqMfLgCPgGbv94tKT3Fx
        OwxegzqWLIG0p26aHswJ8a25vg==
X-Google-Smtp-Source: AJdET5cmxrvWhTuTuL7xcPAvd2o8xT/0mk/uR5CmvJmAwXuqWLoxL8C0BGww0coTk0Tcr+aaiTz43w==
X-Received: by 2002:a63:6bc1:: with SMTP id g184mr529714pgc.25.1540937945185;
        Tue, 30 Oct 2018 15:19:05 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id c70-v6sm2889774pfe.93.2018.10.30.15.19.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 15:19:04 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Paul Burton <paul.burton@mips.com>, sparclinux@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Hogan <jhogan@kernel.org>, linux-hexagon@vger.kernel.org,
        x86@kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-snps-arc@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Huang Ying <ying.huang@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rich Felker <dalias@libc.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/2] kgdb: Remove irq flags from roundup
Date:   Tue, 30 Oct 2018 15:18:42 -0700
Message-Id: <20181030221843.121254-2-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181030221843.121254-1-dianders@chromium.org>
References: <20181030221843.121254-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <dianders@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dianders@chromium.org
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

The function kgdb_roundup_cpus() was passed a parameter that was
documented as:

> the flags that will be used when restoring the interrupts. There is
> local_irq_save() call before kgdb_roundup_cpus().

Nobody used those flags.  Anyone who wanted to temporarily turn on
interrupts just did local_irq_enable() and local_irq_disable() without
looking at them.  So we can definitely remove the flags.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Removing irq flags separated from fixing lockdep splat.

 arch/arc/kernel/kgdb.c     | 2 +-
 arch/arm/kernel/kgdb.c     | 2 +-
 arch/arm64/kernel/kgdb.c   | 2 +-
 arch/hexagon/kernel/kgdb.c | 9 ++-------
 arch/mips/kernel/kgdb.c    | 2 +-
 arch/powerpc/kernel/kgdb.c | 2 +-
 arch/sh/kernel/kgdb.c      | 2 +-
 arch/sparc/kernel/smp_64.c | 2 +-
 arch/x86/kernel/kgdb.c     | 9 ++-------
 include/linux/kgdb.h       | 9 ++-------
 kernel/debug/debug_core.c  | 2 +-
 11 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/arch/arc/kernel/kgdb.c b/arch/arc/kernel/kgdb.c
index 9a3c34af2ae8..0932851028e0 100644
--- a/arch/arc/kernel/kgdb.c
+++ b/arch/arc/kernel/kgdb.c
@@ -197,7 +197,7 @@ static void kgdb_call_nmi_hook(void *ignored)
 	kgdb_nmicallback(raw_smp_processor_id(), NULL);
 }
 
-void kgdb_roundup_cpus(unsigned long flags)
+void kgdb_roundup_cpus(void)
 {
 	local_irq_enable();
 	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
diff --git a/arch/arm/kernel/kgdb.c b/arch/arm/kernel/kgdb.c
index caa0dbe3dc61..f21077b077be 100644
--- a/arch/arm/kernel/kgdb.c
+++ b/arch/arm/kernel/kgdb.c
@@ -175,7 +175,7 @@ static void kgdb_call_nmi_hook(void *ignored)
        kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
 }
 
-void kgdb_roundup_cpus(unsigned long flags)
+void kgdb_roundup_cpus(void)
 {
        local_irq_enable();
        smp_call_function(kgdb_call_nmi_hook, NULL, 0);
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index a20de58061a8..12c339ff6e75 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -289,7 +289,7 @@ static void kgdb_call_nmi_hook(void *ignored)
 	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
 }
 
-void kgdb_roundup_cpus(unsigned long flags)
+void kgdb_roundup_cpus(void)
 {
 	local_irq_enable();
 	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
diff --git a/arch/hexagon/kernel/kgdb.c b/arch/hexagon/kernel/kgdb.c
index 16c24b22d0b2..012e0e230ac2 100644
--- a/arch/hexagon/kernel/kgdb.c
+++ b/arch/hexagon/kernel/kgdb.c
@@ -119,17 +119,12 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
 
 /**
  * kgdb_roundup_cpus - Get other CPUs into a holding pattern
- * @flags: Current IRQ state
  *
  * On SMP systems, we need to get the attention of the other CPUs
  * and get them be in a known state.  This should do what is needed
  * to get the other CPUs to call kgdb_wait(). Note that on some arches,
  * the NMI approach is not used for rounding up all the CPUs. For example,
- * in case of MIPS, smp_call_function() is used to roundup CPUs. In
- * this case, we have to make sure that interrupts are enabled before
- * calling smp_call_function(). The argument to this function is
- * the flags that will be used when restoring the interrupts. There is
- * local_irq_save() call before kgdb_roundup_cpus().
+ * in case of MIPS, smp_call_function() is used to roundup CPUs.
  *
  * On non-SMP systems, this is not called.
  */
@@ -139,7 +134,7 @@ static void hexagon_kgdb_nmi_hook(void *ignored)
 	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
 }
 
-void kgdb_roundup_cpus(unsigned long flags)
+void kgdb_roundup_cpus(void)
 {
 	local_irq_enable();
 	smp_call_function(hexagon_kgdb_nmi_hook, NULL, 0);
diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
index eb6c0d582626..2b05effc17b4 100644
--- a/arch/mips/kernel/kgdb.c
+++ b/arch/mips/kernel/kgdb.c
@@ -219,7 +219,7 @@ static void kgdb_call_nmi_hook(void *ignored)
 	set_fs(old_fs);
 }
 
-void kgdb_roundup_cpus(unsigned long flags)
+void kgdb_roundup_cpus(void)
 {
 	local_irq_enable();
 	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index 59c578f865aa..b0e804844be0 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -124,7 +124,7 @@ static int kgdb_call_nmi_hook(struct pt_regs *regs)
 }
 
 #ifdef CONFIG_SMP
-void kgdb_roundup_cpus(unsigned long flags)
+void kgdb_roundup_cpus(void)
 {
 	smp_send_debugger_break();
 }
diff --git a/arch/sh/kernel/kgdb.c b/arch/sh/kernel/kgdb.c
index 4f04c6638a4d..cc57630f6bf2 100644
--- a/arch/sh/kernel/kgdb.c
+++ b/arch/sh/kernel/kgdb.c
@@ -319,7 +319,7 @@ static void kgdb_call_nmi_hook(void *ignored)
 	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
 }
 
-void kgdb_roundup_cpus(unsigned long flags)
+void kgdb_roundup_cpus(void)
 {
 	local_irq_enable();
 	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index d3ea1f3c06a0..68098bbf3705 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1014,7 +1014,7 @@ void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
 }
 
 #ifdef CONFIG_KGDB
-void kgdb_roundup_cpus(unsigned long flags)
+void kgdb_roundup_cpus(void)
 {
 	smp_cross_call(&xcall_kgdb_capture, 0, 0, 0);
 }
diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 8e36f249646e..ac6291a4178d 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -422,21 +422,16 @@ static void kgdb_disable_hw_debug(struct pt_regs *regs)
 #ifdef CONFIG_SMP
 /**
  *	kgdb_roundup_cpus - Get other CPUs into a holding pattern
- *	@flags: Current IRQ state
  *
  *	On SMP systems, we need to get the attention of the other CPUs
  *	and get them be in a known state.  This should do what is needed
  *	to get the other CPUs to call kgdb_wait(). Note that on some arches,
  *	the NMI approach is not used for rounding up all the CPUs. For example,
- *	in case of MIPS, smp_call_function() is used to roundup CPUs. In
- *	this case, we have to make sure that interrupts are enabled before
- *	calling smp_call_function(). The argument to this function is
- *	the flags that will be used when restoring the interrupts. There is
- *	local_irq_save() call before kgdb_roundup_cpus().
+ *	in case of MIPS, smp_call_function() is used to roundup CPUs.
  *
  *	On non-SMP systems, this is not called.
  */
-void kgdb_roundup_cpus(unsigned long flags)
+void kgdb_roundup_cpus(void)
 {
 	apic->send_IPI_allbutself(APIC_DM_NMI);
 }
diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index e465bb15912d..05e5b2eb0d32 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -178,21 +178,16 @@ kgdb_arch_handle_exception(int vector, int signo, int err_code,
 
 /**
  *	kgdb_roundup_cpus - Get other CPUs into a holding pattern
- *	@flags: Current IRQ state
  *
  *	On SMP systems, we need to get the attention of the other CPUs
  *	and get them into a known state.  This should do what is needed
  *	to get the other CPUs to call kgdb_wait(). Note that on some arches,
  *	the NMI approach is not used for rounding up all the CPUs. For example,
- *	in case of MIPS, smp_call_function() is used to roundup CPUs. In
- *	this case, we have to make sure that interrupts are enabled before
- *	calling smp_call_function(). The argument to this function is
- *	the flags that will be used when restoring the interrupts. There is
- *	local_irq_save() call before kgdb_roundup_cpus().
+ *	in case of MIPS, smp_call_function() is used to roundup CPUs.
  *
  *	On non-SMP systems, this is not called.
  */
-extern void kgdb_roundup_cpus(unsigned long flags);
+extern void kgdb_roundup_cpus(void);
 
 /**
  *	kgdb_arch_set_pc - Generic call back to the program counter
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 65c0f1363788..f3cadda45f07 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -593,7 +593,7 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 
 	/* Signal the other CPUs to enter kgdb_wait() */
 	else if ((!kgdb_single_step) && kgdb_do_roundup)
-		kgdb_roundup_cpus(flags);
+		kgdb_roundup_cpus();
 #endif
 
 	/*
-- 
2.19.1.568.g152ad8e336-goog
