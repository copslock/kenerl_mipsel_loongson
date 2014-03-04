Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2014 22:07:59 +0100 (CET)
Received: from mail-ie0-f172.google.com ([209.85.223.172]:49666 "EHLO
        mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831266AbaCDVHpRAt6v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Mar 2014 22:07:45 +0100
Received: by mail-ie0-f172.google.com with SMTP id as1so112287iec.17
        for <linux-mips@linux-mips.org>; Tue, 04 Mar 2014 13:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=fSZ+FbvWAnYHF30y9n/+7+iEs9DzHxQQN704PrDyoac=;
        b=c1JMSqwQhYPqL51SwRoFpE+fFlQ+EfJPGel8HqL4wFnHyYgh+xpuaCDiAcgqctaB99
         IVZiVwDGxX1rYRYiy8MY/z1nq9pZPL1jNRP9r9JSugx0ot4kMIJY5hJm/iSDL2+p0xiP
         soWY6b2D3B35bESfuwWjk8n4LvSWYOsXJ2wed//qlqEi08CErBolRFAGI3DiFh9ZCDeJ
         oSMG3j7Bv2vGrmbzKKVBKtYyW0PV5o0VAmYgK6JxLbTayn6Wf+B/aDj43WXQuuM+5UXu
         KVG/26NUtjCJOGoEWy6fUYWE7HXQdoO20APPLFZqjrXcdMYRiLAwZtbu/K5tCukhewgG
         HW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=fSZ+FbvWAnYHF30y9n/+7+iEs9DzHxQQN704PrDyoac=;
        b=Z8+kq+cMEnz8rp4c/7y7gxhmYYvoETeR93TvryGdmTBKXQr22XZpd0FitbgHGiWTRG
         EjAjD3moQ/m5tpHzaBU7SEa8cNgzp0CK9QqS7zQl8WQSrFPYnF/StCBLq/s23NMFHxp7
         Mpa1GKEECi+2f0aSRCyxG43+LR0n5S6KeVLCndwY0sfry0YUcXxPWKzQlAlDv0CHmfq+
         hRee5EorDgk1hRFHMgBG/rSUWouw5Q08+lO19yDCBXerSlrJ+8lnZ8Kwt3ScukRZstBh
         fzbflEH5967wLNnyAJiDetHZj6OODnxeSSj6/kUW/fEijb/cUdTMbI2RYFyJzNwzYzl6
         X22A==
X-Gm-Message-State: ALoCoQlBNQj01xaAnI2vc0qzYSAT9hwr8frjT15Ivb/8YDzXHxRAp7ot04Tm5NJ/+W3YeIx1uDF2dqpagR0E7POGDWAejvil9v3wWyBG6Ybg5fHBFLos6I/eHTG5JstK47OFR5Ag6wBUQzwHf000q20C7bzdTyIVg6uFk1E7HBcPWE+J5N1Gb7PzSTlCckdpkpuFTD3jxHmezuK1Q+AaZBywiEFwwRoa/w==
X-Received: by 10.50.78.229 with SMTP id e5mr30708180igx.24.1393967259102;
        Tue, 04 Mar 2014 13:07:39 -0800 (PST)
Received: from localhost ([172.16.49.180])
        by mx.google.com with ESMTPSA id r4sm53578317igh.1.2014.03.04.13.07.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 04 Mar 2014 13:07:38 -0800 (PST)
Subject: [PATCH 1/2] sched: Remove unused mc_capable() and smt_capable()
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 04 Mar 2014 14:07:37 -0700
Message-ID: <20140304210737.16893.54289.stgit@bhelgaas-glaptop.roam.corp.google.com>
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
X-archive-position: 39409
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

Remove mc_capable() and smt_capable().  Neither is used.

Both were added by 5c45bf279d37 ("sched: mc/smt power savings sched
policy").  Uses of both were removed by 8e7fbcbc22c1 ("sched: Remove stale
power aware scheduling remnants and dysfunctional knobs").

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm/include/asm/topology.h      |    3 ---
 arch/ia64/include/asm/topology.h     |    1 -
 arch/mips/include/asm/topology.h     |    4 ----
 arch/powerpc/include/asm/topology.h  |    1 -
 arch/sparc/include/asm/topology_64.h |    2 --
 arch/x86/include/asm/topology.h      |    6 ------
 6 files changed, 17 deletions(-)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index 58b8b84adcd2..2fe85fff5cca 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -20,9 +20,6 @@ extern struct cputopo_arm cpu_topology[NR_CPUS];
 #define topology_core_cpumask(cpu)	(&cpu_topology[cpu].core_sibling)
 #define topology_thread_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
 
-#define mc_capable()	(cpu_topology[0].socket_id != -1)
-#define smt_capable()	(cpu_topology[0].thread_id != -1)
-
 void init_cpu_topology(void);
 void store_cpu_topology(unsigned int cpuid);
 const struct cpumask *cpu_coregroup_mask(int cpu);
diff --git a/arch/ia64/include/asm/topology.h b/arch/ia64/include/asm/topology.h
index a2496e449b75..5cb55a1e606b 100644
--- a/arch/ia64/include/asm/topology.h
+++ b/arch/ia64/include/asm/topology.h
@@ -77,7 +77,6 @@ void build_cpu_to_node_map(void);
 #define topology_core_id(cpu)			(cpu_data(cpu)->core_id)
 #define topology_core_cpumask(cpu)		(&cpu_core_map[cpu])
 #define topology_thread_cpumask(cpu)		(&per_cpu(cpu_sibling_map, cpu))
-#define smt_capable() 				(smp_num_siblings > 1)
 #endif
 
 extern void arch_fix_phys_package_id(int num, u32 slot);
diff --git a/arch/mips/include/asm/topology.h b/arch/mips/include/asm/topology.h
index 12609a17dc8b..20ea4859c822 100644
--- a/arch/mips/include/asm/topology.h
+++ b/arch/mips/include/asm/topology.h
@@ -10,8 +10,4 @@
 
 #include <topology.h>
 
-#ifdef CONFIG_SMP
-#define smt_capable()	(smp_num_siblings > 1)
-#endif
-
 #endif /* __ASM_TOPOLOGY_H */
diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index d0b5fca6b077..c9202151079f 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -99,7 +99,6 @@ static inline int prrn_is_enabled(void)
 
 #ifdef CONFIG_SMP
 #include <asm/cputable.h>
-#define smt_capable()		(cpu_has_feature(CPU_FTR_SMT))
 
 #ifdef CONFIG_PPC64
 #include <asm/smp.h>
diff --git a/arch/sparc/include/asm/topology_64.h b/arch/sparc/include/asm/topology_64.h
index 1754390a426f..a2d10fc64faf 100644
--- a/arch/sparc/include/asm/topology_64.h
+++ b/arch/sparc/include/asm/topology_64.h
@@ -42,8 +42,6 @@ static inline int pcibus_to_node(struct pci_bus *pbus)
 #define topology_core_id(cpu)			(cpu_data(cpu).core_id)
 #define topology_core_cpumask(cpu)		(&cpu_core_map[cpu])
 #define topology_thread_cpumask(cpu)		(&per_cpu(cpu_sibling_map, cpu))
-#define mc_capable()				(sparc64_multi_core)
-#define smt_capable()				(sparc64_multi_core)
 #endif /* CONFIG_SMP */
 
 extern cpumask_t cpu_core_map[NR_CPUS];
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index d35f24e231cd..9bcc724cafdd 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -133,12 +133,6 @@ static inline void arch_fix_phys_package_id(int num, u32 slot)
 struct pci_bus;
 void x86_pci_root_bus_resources(int bus, struct list_head *resources);
 
-#ifdef CONFIG_SMP
-#define mc_capable()	((boot_cpu_data.x86_max_cores > 1) && \
-			(cpumask_weight(cpu_core_mask(0)) != nr_cpu_ids))
-#define smt_capable()			(smp_num_siblings > 1)
-#endif
-
 #ifdef CONFIG_NUMA
 extern int get_mp_bus_to_node(int busnum);
 extern void set_mp_bus_to_node(int busnum, int node);
