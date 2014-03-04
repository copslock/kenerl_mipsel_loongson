Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2014 22:08:18 +0100 (CET)
Received: from mail-ig0-f180.google.com ([209.85.213.180]:40222 "EHLO
        mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831267AbaCDVHwoBHh4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Mar 2014 22:07:52 +0100
Received: by mail-ig0-f180.google.com with SMTP id hl1so2477867igb.1
        for <linux-mips@linux-mips.org>; Tue, 04 Mar 2014 13:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=4jK++tivuiCXS3fMuEA3P8BmPtUwCjNt1WnsxIiJq0Y=;
        b=Ad6B9xuBtpFtAARDZhH53YfIJYcsGdyzy88t3XjnAZgwE0wZyiwJdnceoWAiVDc1B0
         zDEsKPcZWHhxFCU//0oeTaBIOuNlvfz6zJaklidICRfJ0efiUA2F7ButUQIuxPMckACl
         xvDDURKn7UJ+k3NM6r0nxk9oQKualWWcaNmlgYqfKZgxWwa7ZCHGp0hIzSVqH2JtxkGF
         yDbvT/z07ED/B3+yjzYnm+CijeVknLxYvVI5ihvlhuOTj33zN1U9i1I4mVHROr/QbUYP
         0NmYHvzRDV3d4FLuEBmHFPKLL0dwdLmJfAv9Z460DwenCv+f86XSip6h2kTSJCPFceO4
         oGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=4jK++tivuiCXS3fMuEA3P8BmPtUwCjNt1WnsxIiJq0Y=;
        b=Y+qRFqsl7lxSQUtFxLBoWTaVqxSS9w4qTcCL+Vu4xVvGPTkt5ps9sG1jKkieQMkf7X
         PMLqlNEtsdLU+och2kaSj+7ycggIJASf9Ld5okYnWAOy1+5FmBsRFWpQnqAPGAkxk+4L
         AGRukGuzkzicXXP1ccJQM9GNScdurDx8r3v7YwB8ebv89M4wsXcotgeA7q6qjd/5yZdd
         O3Ena7XP3Ds3WNEqH58yiwf/RYTbKfhDAVrMVMZdsyWuAA2BwthI5ErpUHCuvMRYjYGu
         X1gjUlaGsFngT5V1/x0nCJj19unhC10EyZ6BQMsaMq1WjEPMnhzO6OoO/3BnC68ROAnH
         kljg==
X-Gm-Message-State: ALoCoQlCDXrBWlBbkhxU93QVskFJags6ihik4URuNhlxvunO7S1IO5MKLeDqQ5x9MUyzIwAO0gkQDmsGHuVNA9pBSWOzI1Yc9W7gxgNOuP5Pd7I5/CJNHA3GtkXMRUcKOWQmxQiRUVb54FZQU8UrXaG4SeKPmC5v3wI+PUUfFE94XLSa506FZ5jbM4wT63h+4duX9tEVIPS8MRJ5lzLpV1dbgfjz8ZyKgQ==
X-Received: by 10.42.54.67 with SMTP id q3mr1502537icg.21.1393967266662;
        Tue, 04 Mar 2014 13:07:46 -0800 (PST)
Received: from localhost ([172.16.49.180])
        by mx.google.com with ESMTPSA id dz8sm53557969igb.5.2014.03.04.13.07.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 04 Mar 2014 13:07:45 -0800 (PST)
Subject: [PATCH 2/2] sparc64: Remove unused sparc64_multi_core
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 04 Mar 2014 14:07:44 -0700
Message-ID: <20140304210744.16893.75929.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140304210621.16893.8772.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140304210621.16893.8772.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39410
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

Remove sparc64_multi_core because it's not used any more.

It was added by a2f9f6bbb30e ("Fix {mc,smt}_capable()"), and the last uses
were removed by e637d96bf462 ("sched: Remove unused mc_capable() and
smt_capable()").

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/sparc/include/asm/smp_64.h |    1 -
 arch/sparc/kernel/mdesc.c       |    4 ----
 arch/sparc/kernel/prom_64.c     |    3 ---
 arch/sparc/kernel/smp_64.c      |    2 --
 4 files changed, 10 deletions(-)

diff --git a/arch/sparc/include/asm/smp_64.h b/arch/sparc/include/asm/smp_64.h
index dd3bef4b9896..05710393959f 100644
--- a/arch/sparc/include/asm/smp_64.h
+++ b/arch/sparc/include/asm/smp_64.h
@@ -32,7 +32,6 @@
 
 DECLARE_PER_CPU(cpumask_t, cpu_sibling_map);
 extern cpumask_t cpu_core_map[NR_CPUS];
-extern int sparc64_multi_core;
 
 extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index b90bf23e3aab..a1a4400d4025 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -896,10 +896,6 @@ void mdesc_fill_in_cpu_data(cpumask_t *mask)
 
 	mdesc_iterate_over_cpus(fill_in_one_cpu, NULL, mask);
 
-#ifdef CONFIG_SMP
-	sparc64_multi_core = 1;
-#endif
-
 	hp = mdesc_grab();
 
 	set_core_ids(hp);
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index 6b39125eb927..9a690d39c01b 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -555,9 +555,6 @@ static void *fill_in_one_cpu(struct device_node *dp, int cpuid, int arg)
 
 		cpu_data(cpuid).core_id = portid + 1;
 		cpu_data(cpuid).proc_id = portid;
-#ifdef CONFIG_SMP
-		sparc64_multi_core = 1;
-#endif
 	} else {
 		cpu_data(cpuid).dcache_size =
 			of_getintprop_default(dp, "dcache-size", 16 * 1024);
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index b085311dcd0e..9781048161ab 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -53,8 +53,6 @@
 
 #include "cpumap.h"
 
-int sparc64_multi_core __read_mostly;
-
 DEFINE_PER_CPU(cpumask_t, cpu_sibling_map) = CPU_MASK_NONE;
 cpumask_t cpu_core_map[NR_CPUS] __read_mostly =
 	{ [0 ... NR_CPUS-1] = CPU_MASK_NONE };
