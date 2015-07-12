Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 00:02:51 +0200 (CEST)
Received: from mail-ie0-f180.google.com ([209.85.223.180]:32779 "EHLO
        mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010484AbbGLWCUI6fT2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 00:02:20 +0200
Received: by ietj16 with SMTP id j16so51103286iet.0
        for <linux-mips@linux-mips.org>; Sun, 12 Jul 2015 15:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=nGZCTj9EbnBQz+zXbkLp/Y4p1KDwQj260/ISbNdUSfc=;
        b=YVwtyMiL1/HxzC8djkAd5pF+qTOFNszvbLDt5n848uh7ZC6yihuREfYCudgl10zl3j
         geJHWlOiYZUGIcqAtRmLjwFcLQFI82JXCuQRsEDBeLTJVy4ZwbmIF+l5fRNx2mnX8vgM
         UxLbNJfsimsTPNVn1eTwQLPPIOWOFOBDilE4tTE/ZE/+pxVH9+czJ51z5m0gehtUfbr/
         OWMTcptWfQFnDI9d1QwP3wVN1h5Ed11rQd4HLs2PdsQIFrzH5SjvI8jD95jrpxLvFyK9
         uVqURSo3jnLSddcC2xOHw5AYLJFI3IyFRy0XU+y/ZcCtR7iYWV9MmH2TEj8IEQPtphel
         IXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=nGZCTj9EbnBQz+zXbkLp/Y4p1KDwQj260/ISbNdUSfc=;
        b=gA5Sr69jqqM3qcbOn4WnqBwKhHQofp9HNScR2Np/zle1KL3t3n0WcrseghVufQ3/Su
         UYiXUcBc52XVYMpJ75iSOeT9Pq5nTySOIcliLQlRWd+kj/laPxdOfCpXLPQ839LPYweC
         LQitLhlEdedN6MWdYal/orr4HgtAYTj5qWf9bD1f9+1zcKz17hPTfwp8O/epGi8IbskD
         bU0cGThGecMfFKjixwfeIByGxFZVJL+ik+uRKrwutjr+dFnQ5WX7/FNQU2DUJuN+jcTb
         LhfuVeKYIicNfiWVFPASQR5luf+VBe2oxKh4Qi04oeo4+ZyGyeZWJufDlY+q6plH+++7
         yRTg==
X-Gm-Message-State: ALoCoQmaJhd+wWe46Lb6oziXNtSbAxaGd6RJB1+i3O367HjK7mq8tDoMtrvsizuWE7UJlmk9g/Is
X-Received: by 10.107.10.96 with SMTP id u93mr14318119ioi.172.1436738534297;
        Sun, 12 Jul 2015 15:02:14 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id l62sm11258117iol.36.2015.07.12.15.02.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 12 Jul 2015 15:02:13 -0700 (PDT)
Subject: [PATCH 3/3] IRQ: Print "unexpected IRQ" messages consistently
 across architectures
To:     Thomas Gleixner <tglx@linutronix.de>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-am33-list@redhat.com, linux-ia64@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-alpha@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Sun, 12 Jul 2015 17:02:11 -0500
Message-ID: <20150712220211.7166.42035.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150712215559.7166.33068.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150712215559.7166.33068.stgit@bhelgaas-glaptop2.roam.corp.google.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

Many architectures use a variant of "unexpected IRQ trap at vector %x" to
log unexpected IRQs.  This is confusing because (a) it prints the Linux IRQ
number, but "vector" more often refers to a CPU vector number, and (b) it
prints the IRQ number in hex with no base indication, while Linux IRQ
numbers are usually printed in decimal.

Print the same text ("unexpected IRQ %d") across all architectures.

No functional change other than the output text.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/alpha/kernel/irq.c            |    2 +-
 arch/blackfin/kernel/irqchip.c     |    2 +-
 arch/c6x/kernel/irq.c              |    2 +-
 arch/ia64/kernel/irq.c             |    2 +-
 arch/m68k/include/asm/hardirq.h    |    2 +-
 arch/mips/kernel/irq.c             |    2 +-
 arch/mn10300/kernel/irq.c          |    2 +-
 arch/parisc/include/asm/hardirq.h  |    2 +-
 arch/powerpc/include/asm/hardirq.h |    2 +-
 arch/s390/include/asm/hardirq.h    |    2 +-
 arch/sh/kernel/irq.c               |    2 +-
 arch/tile/kernel/irq.c             |    2 +-
 arch/x86/kernel/irq.c              |    2 +-
 include/asm-generic/hardirq.h      |    2 +-
 14 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/kernel/irq.c b/arch/alpha/kernel/irq.c
index 51f2c86..9acdc14 100644
--- a/arch/alpha/kernel/irq.c
+++ b/arch/alpha/kernel/irq.c
@@ -34,7 +34,7 @@ DEFINE_PER_CPU(unsigned long, irq_pmi_count);
 void ack_bad_irq(unsigned int irq)
 {
 	irq_err_count++;
-	printk(KERN_CRIT "Unexpected IRQ trap at vector %u\n", irq);
+	printk(KERN_CRIT "Unexpected IRQ %d\n", irq);
 }
 
 #ifdef CONFIG_SMP 
diff --git a/arch/blackfin/kernel/irqchip.c b/arch/blackfin/kernel/irqchip.c
index 0ba2576..608741e 100644
--- a/arch/blackfin/kernel/irqchip.c
+++ b/arch/blackfin/kernel/irqchip.c
@@ -20,7 +20,7 @@ static atomic_t irq_err_count;
 void ack_bad_irq(unsigned int irq)
 {
 	atomic_inc(&irq_err_count);
-	printk(KERN_ERR "IRQ: spurious interrupt %d\n", irq);
+	printk(KERN_ERR "unexpected IRQ %d\n", irq);
 }
 
 static struct irq_desc bad_irq_desc = {
diff --git a/arch/c6x/kernel/irq.c b/arch/c6x/kernel/irq.c
index 247e0eb..cd7fb55 100644
--- a/arch/c6x/kernel/irq.c
+++ b/arch/c6x/kernel/irq.c
@@ -120,7 +120,7 @@ void __init init_IRQ(void)
 
 void ack_bad_irq(int irq)
 {
-	printk(KERN_ERR "IRQ: spurious interrupt %d\n", irq);
+	printk(KERN_ERR "unexpected IRQ %d\n", irq);
 	irq_err_count++;
 }
 
diff --git a/arch/ia64/kernel/irq.c b/arch/ia64/kernel/irq.c
index 812a1e6..b198c69 100644
--- a/arch/ia64/kernel/irq.c
+++ b/arch/ia64/kernel/irq.c
@@ -31,7 +31,7 @@
  */
 void ack_bad_irq(unsigned int irq)
 {
-	printk(KERN_ERR "Unexpected irq vector 0x%x on CPU %u!\n", irq, smp_processor_id());
+	printk(KERN_ERR "unexpected IRQ %d on CPU %u!\n", irq, smp_processor_id());
 }
 
 #ifdef CONFIG_IA64_GENERIC
diff --git a/arch/m68k/include/asm/hardirq.h b/arch/m68k/include/asm/hardirq.h
index 6c61852..5f0fe98 100644
--- a/arch/m68k/include/asm/hardirq.h
+++ b/arch/m68k/include/asm/hardirq.h
@@ -9,7 +9,7 @@
 
 static inline void ack_bad_irq(unsigned int irq)
 {
-	pr_crit("unexpected IRQ trap at vector %02x\n", irq);
+	pr_crit("unexpected IRQ %d\n", irq);
 }
 
 /* entry.S is sensitive to the offsets of these fields */
diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index 8eb5af8..f6b9ce9 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -31,7 +31,7 @@
  */
 void ack_bad_irq(unsigned int irq)
 {
-	printk("unexpected IRQ # %d\n", irq);
+	printk("unexpected IRQ %d\n", irq);
 }
 
 atomic_t irq_err_count;
diff --git a/arch/mn10300/kernel/irq.c b/arch/mn10300/kernel/irq.c
index 480de70..c7b780d 100644
--- a/arch/mn10300/kernel/irq.c
+++ b/arch/mn10300/kernel/irq.c
@@ -197,7 +197,7 @@ static struct irq_chip mn10300_cpu_pic_edge = {
  */
 void ack_bad_irq(int irq)
 {
-	printk(KERN_WARNING "unexpected IRQ trap at vector %02x\n", irq);
+	printk(KERN_WARNING "unexpected IRQ %d\n", irq);
 }
 
 /*
diff --git a/arch/parisc/include/asm/hardirq.h b/arch/parisc/include/asm/hardirq.h
index 9b3bd03..c093c4f 100644
--- a/arch/parisc/include/asm/hardirq.h
+++ b/arch/parisc/include/asm/hardirq.h
@@ -41,6 +41,6 @@ DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 		this_cpu_write(irq_stat.__softirq_pending, (x))
 #define or_softirq_pending(x)	this_cpu_or(irq_stat.__softirq_pending, (x))
 
-#define ack_bad_irq(irq) WARN(1, "unexpected IRQ trap at vector %02x\n", irq)
+#define ack_bad_irq(irq) WARN(1, "unexpected IRQ %d\n", irq)
 
 #endif /* _PARISC_HARDIRQ_H */
diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
index 8add8b8..aa8ebbb 100644
--- a/arch/powerpc/include/asm/hardirq.h
+++ b/arch/powerpc/include/asm/hardirq.h
@@ -30,7 +30,7 @@ DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 
 static inline void ack_bad_irq(unsigned int irq)
 {
-	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
+	printk(KERN_CRIT "unexpected IRQ %d\n", irq);
 }
 
 extern u64 arch_irq_stat_cpu(unsigned int cpu);
diff --git a/arch/s390/include/asm/hardirq.h b/arch/s390/include/asm/hardirq.h
index b7eabaa..08eeacd 100644
--- a/arch/s390/include/asm/hardirq.h
+++ b/arch/s390/include/asm/hardirq.h
@@ -20,7 +20,7 @@
 
 static inline void ack_bad_irq(unsigned int irq)
 {
-	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
+	printk(KERN_CRIT "unexpected IRQ %d\n", irq);
 }
 
 #endif /* __ASM_HARDIRQ_H */
diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index eb10ff8..093e434 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -30,7 +30,7 @@ atomic_t irq_err_count;
 void ack_bad_irq(unsigned int irq)
 {
 	atomic_inc(&irq_err_count);
-	printk("unexpected IRQ trap at vector %02x\n", irq);
+	printk("unexpected IRQ %d\n", irq);
 }
 
 #if defined(CONFIG_PROC_FS)
diff --git a/arch/tile/kernel/irq.c b/arch/tile/kernel/irq.c
index 22044fc..c8e4f88 100644
--- a/arch/tile/kernel/irq.c
+++ b/arch/tile/kernel/irq.c
@@ -250,7 +250,7 @@ EXPORT_SYMBOL(tile_irq_activate);
 
 void ack_bad_irq(unsigned int irq)
 {
-	pr_err("unexpected IRQ trap at vector %02x\n", irq);
+	pr_err("unexpected IRQ %d\n", irq);
 }
 
 /*
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 3c6b069..a0d46d2 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -40,7 +40,7 @@ void (*x86_platform_ipi_callback)(void) = NULL;
 void ack_bad_irq(unsigned int irq)
 {
 	if (printk_ratelimit())
-		pr_err("unexpected IRQ trap at vector %02x\n", irq);
+		pr_err("unexpected IRQ %d\n", irq);
 
 	/*
 	 * Currently unexpected vectors happen only on SMP and APIC.
diff --git a/include/asm-generic/hardirq.h b/include/asm-generic/hardirq.h
index 04d0a97..516ff5f 100644
--- a/include/asm-generic/hardirq.h
+++ b/include/asm-generic/hardirq.h
@@ -14,7 +14,7 @@ typedef struct {
 #ifndef ack_bad_irq
 static inline void ack_bad_irq(unsigned int irq)
 {
-	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
+	printk(KERN_CRIT "unexpected IRQ %d\n", irq);
 }
 #endif
 
