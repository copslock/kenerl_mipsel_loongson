Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jan 2010 06:10:01 +0100 (CET)
Received: from ozlabs.org ([203.10.76.45]:40721 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491079Ab0AFFJ5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Jan 2010 06:09:57 +0100
Received: by ozlabs.org (Postfix, from userid 1010)
        id 83CA1B6F07; Wed,  6 Jan 2010 16:09:53 +1100 (EST)
Message-Id: <20100106045525.207405499@samba.org>>
References: <20100106045509.245662398@samba.org>>
User-Agent: quilt/0.46-1
Date:   Wed, 06 Jan 2010 15:55:13 +1100
From:   Anton Blanchard <anton@samba.org>
To:     anton@samba.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [patch 4/6] mips: cpumask_of_node() should handle -1 as a node
X-archive-position: 25516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anton@samba.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 3858

pcibus_to_node can return -1 if we cannot determine which node a pci bus
is on. If passed -1, cpumask_of_node will negatively index the lookup array
and pull in random data:

# cat /sys/devices/pci0000:00/0000:00:01.0/local_cpus
00000000,00000003,00000000,00000000
# cat /sys/devices/pci0000:00/0000:00:01.0/local_cpulist
64-65

Change cpumask_of_node to check for -1 and return cpu_all_mask in this
case:

# cat /sys/devices/pci0000:00/0000:00:01.0/local_cpus
ffffffff,ffffffff,ffffffff,ffffffff
# cat /sys/devices/pci0000:00/0000:00:01.0/local_cpulist
0-127

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/mips/include/asm/mach-ip27/topology.h
===================================================================
--- linux-cpumask.orig/arch/mips/include/asm/mach-ip27/topology.h	2010-01-06 15:20:22.872583883 +1100
+++ linux-cpumask/arch/mips/include/asm/mach-ip27/topology.h	2010-01-06 15:20:47.310083709 +1100
@@ -24,7 +24,9 @@ extern struct cpuinfo_ip27 sn_cpu_info[N
 
 #define cpu_to_node(cpu)	(sn_cpu_info[(cpu)].p_nodeid)
 #define parent_node(node)	(node)
-#define cpumask_of_node(node)	(&hub_data(node)->h_cpus)
+#define cpumask_of_node(node)	((node) == -1 ?				\
+				 cpu_all_mask :				\
+				 &hub_data(node)->h_cpus)
 struct pci_bus;
 extern int pcibus_to_node(struct pci_bus *);
 

-- 
