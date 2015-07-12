Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 00:02:15 +0200 (CEST)
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37299 "EHLO
        mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010139AbbGLWCDULd42 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 00:02:03 +0200
Received: by igpy18 with SMTP id y18so44658776igp.0
        for <linux-mips@linux-mips.org>; Sun, 12 Jul 2015 15:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=G/0r62PaWXJ1YHagQIHY9T7i+OYlTDLsPqktueROlqs=;
        b=afWXACq1nDA5pGvjM74RmDBOohFf2tKJJF9xXxobtmVRwIo4GCrLrq5wU/PHYYUls8
         VKuAS4K6GwqKC9BRRnR1LQOJSQKMhCDaYmMBUILo6wPnK/E7Cc4mfV1aQwe7ug79WfHO
         afFPuhsBkF3m+EJ1B9LnAmE1Jr0P2QphNPQ1S15ofWrm3qSrWRzLzWOfr3r3opQNQDKO
         twBjjjV0PZ5PAfL2uwVn5IXHB9QZ/Ek/yTep75teOL0pQZrOcyx5hyEAyNjKujE7VmoD
         8wdreAkXQkXY+mQGKh5ioo9RwJCDBdAAEibS/gSRLyTCiFR546bKGjf9eI3pj33RQI28
         ysig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=G/0r62PaWXJ1YHagQIHY9T7i+OYlTDLsPqktueROlqs=;
        b=l1t8O+1TK1Xc6fvZGBmRuLgjomOhiPRWGdM//PJWmkxK4PJqta2u70EVnOB1vABIVm
         FHon2UAtQ4O8ZZYGXtadyHUMbcoQFCFOqHIlC9sQad85VsAP7epjbURk7XiJaCABm9am
         jLIsZUKtdZ5ALFq9SkbSem3KDarvoW/5uA7S3VI4AKQuxuk7heGyOzIEVg2pSdXTznxt
         a9TYklkj838ckbaENRRtk4qFeA38rEKlPijU5aIzPcuwmxXTb3l1FqRmUpjUCK5uhMbZ
         LA9cLnlzlBRWfmCsigTydzeZEOss68KhYkC1wP4FPy/dnhuM3i/yC76x0zLizHyoDjBv
         dj4g==
X-Gm-Message-State: ALoCoQmk6EN9sEP10GB7bdNIzuR2feOYFLQqsb4elKrcf6uFEdPyLX6eoMw3JZsffcTz80mnH5gA
X-Received: by 10.50.79.169 with SMTP id k9mr9511550igx.44.1436738517530;
        Sun, 12 Jul 2015 15:01:57 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id j20sm4393114igt.5.2015.07.12.15.01.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 12 Jul 2015 15:01:55 -0700 (PDT)
Subject: [PATCH 1/3] x86,
 irq: Rename VECTOR_UNDEFINED and VECTOR_RETRIGGERED to IRQ_*
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
Date:   Sun, 12 Jul 2015 17:01:54 -0500
Message-ID: <20150712220154.7166.48327.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
X-archive-position: 48200
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

The per-cpu vector_irq[] table is indexed by CPU vector numbers, and each
entry contains an IRQ number.

Rename the special values VECTOR_UNDEFINED and VECTOR_RETRIGGERED to
IRQ_UNDEFINED and IRQ_RETRIGGERED to indicate that they are in the IRQ
number space, not the CPU vector number space.

No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/include/asm/hw_irq.h |    4 ++--
 arch/x86/kernel/apic/vector.c |   14 +++++++-------
 arch/x86/kernel/irq.c         |   12 ++++++------
 arch/x86/kernel/irqinit.c     |    4 ++--
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 6615032..b51a1ca 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -182,8 +182,8 @@ extern char irq_entries_start[];
 #define trace_irq_entries_start irq_entries_start
 #endif
 
-#define VECTOR_UNDEFINED	(-1)
-#define VECTOR_RETRIGGERED	(-2)
+#define IRQ_UNDEFINED	(-1)
+#define IRQ_RETRIGGERED	(-2)
 
 typedef int vector_irq_t[NR_VECTORS];
 DECLARE_PER_CPU(vector_irq_t, vector_irq);
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 28eba2d..8ae84b4 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -170,7 +170,7 @@ next:
 
 		for_each_cpu_and(new_cpu, vector_cpumask, cpu_online_mask) {
 			if (per_cpu(vector_irq, new_cpu)[vector] >
-			    VECTOR_UNDEFINED)
+			    IRQ_UNDEFINED)
 				goto next;
 		}
 		/* Found one! */
@@ -232,7 +232,7 @@ static void clear_irq_vector(int irq, struct apic_chip_data *data)
 
 	vector = data->cfg.vector;
 	for_each_cpu_and(cpu, data->domain, cpu_online_mask)
-		per_cpu(vector_irq, cpu)[vector] = VECTOR_UNDEFINED;
+		per_cpu(vector_irq, cpu)[vector] = IRQ_UNDEFINED;
 
 	data->cfg.vector = 0;
 	cpumask_clear(data->domain);
@@ -247,7 +247,7 @@ static void clear_irq_vector(int irq, struct apic_chip_data *data)
 		     vector++) {
 			if (per_cpu(vector_irq, cpu)[vector] != irq)
 				continue;
-			per_cpu(vector_irq, cpu)[vector] = VECTOR_UNDEFINED;
+			per_cpu(vector_irq, cpu)[vector] = IRQ_UNDEFINED;
 			break;
 		}
 	}
@@ -429,12 +429,12 @@ static void __setup_vector_irq(int cpu)
 	/* Mark the free vectors */
 	for (vector = 0; vector < NR_VECTORS; ++vector) {
 		irq = per_cpu(vector_irq, cpu)[vector];
-		if (irq <= VECTOR_UNDEFINED)
+		if (irq <= IRQ_UNDEFINED)
 			continue;
 
 		data = apic_chip_data(irq_get_irq_data(irq));
 		if (!cpumask_test_cpu(cpu, data->domain))
-			per_cpu(vector_irq, cpu)[vector] = VECTOR_UNDEFINED;
+			per_cpu(vector_irq, cpu)[vector] = IRQ_UNDEFINED;
 	}
 	raw_spin_unlock(&vector_lock);
 }
@@ -553,7 +553,7 @@ asmlinkage __visible void smp_irq_move_cleanup_interrupt(void)
 
 		irq = __this_cpu_read(vector_irq[vector]);
 
-		if (irq <= VECTOR_UNDEFINED)
+		if (irq <= IRQ_UNDEFINED)
 			continue;
 
 		desc = irq_to_desc(irq);
@@ -589,7 +589,7 @@ asmlinkage __visible void smp_irq_move_cleanup_interrupt(void)
 			apic->send_IPI_self(IRQ_MOVE_CLEANUP_VECTOR);
 			goto unlock;
 		}
-		__this_cpu_write(vector_irq[vector], VECTOR_UNDEFINED);
+		__this_cpu_write(vector_irq[vector], IRQ_UNDEFINED);
 unlock:
 		raw_spin_unlock(&desc->lock);
 	}
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 88b36648..2949c6e 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -223,12 +223,12 @@ __visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
 	if (!handle_irq(irq, regs)) {
 		ack_APIC_irq();
 
-		if (irq != VECTOR_RETRIGGERED) {
+		if (irq != IRQ_RETRIGGERED) {
 			pr_emerg_ratelimited("%s: %d.%d No irq handler for vector (irq %d)\n",
 					     __func__, smp_processor_id(),
 					     vector, irq);
 		} else {
-			__this_cpu_write(vector_irq[vector], VECTOR_UNDEFINED);
+			__this_cpu_write(vector_irq[vector], IRQ_UNDEFINED);
 		}
 	}
 
@@ -489,7 +489,7 @@ void fixup_irqs(void)
 	for (vector = FIRST_EXTERNAL_VECTOR; vector < NR_VECTORS; vector++) {
 		unsigned int irr;
 
-		if (__this_cpu_read(vector_irq[vector]) <= VECTOR_UNDEFINED)
+		if (__this_cpu_read(vector_irq[vector]) <= IRQ_UNDEFINED)
 			continue;
 
 		irr = apic_read(APIC_IRR + (vector / 32 * 0x10));
@@ -502,12 +502,12 @@ void fixup_irqs(void)
 			raw_spin_lock(&desc->lock);
 			if (chip->irq_retrigger) {
 				chip->irq_retrigger(data);
-				__this_cpu_write(vector_irq[vector], VECTOR_RETRIGGERED);
+				__this_cpu_write(vector_irq[vector], IRQ_RETRIGGERED);
 			}
 			raw_spin_unlock(&desc->lock);
 		}
-		if (__this_cpu_read(vector_irq[vector]) != VECTOR_RETRIGGERED)
-			__this_cpu_write(vector_irq[vector], VECTOR_UNDEFINED);
+		if (__this_cpu_read(vector_irq[vector]) != IRQ_RETRIGGERED)
+			__this_cpu_write(vector_irq[vector], IRQ_UNDEFINED);
 	}
 }
 #endif
diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
index a3a5e15..fc1822d 100644
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -52,7 +52,7 @@ static struct irqaction irq2 = {
 };
 
 DEFINE_PER_CPU(vector_irq_t, vector_irq) = {
-	[0 ... NR_VECTORS - 1] = VECTOR_UNDEFINED,
+	[0 ... NR_VECTORS - 1] = IRQ_UNDEFINED,
 };
 
 int vector_used_by_percpu_irq(unsigned int vector)
@@ -60,7 +60,7 @@ int vector_used_by_percpu_irq(unsigned int vector)
 	int cpu;
 
 	for_each_online_cpu(cpu) {
-		if (per_cpu(vector_irq, cpu)[vector] > VECTOR_UNDEFINED)
+		if (per_cpu(vector_irq, cpu)[vector] > IRQ_UNDEFINED)
 			return 1;
 	}
 
