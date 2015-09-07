Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Sep 2015 12:47:10 +0200 (CEST)
Received: from resqmta-ch2-09v.sys.comcast.net ([69.252.207.41]:51994 "EHLO
        resqmta-ch2-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007489AbbIGKrILf8B3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Sep 2015 12:47:08 +0200
Received: from resomta-ch2-11v.sys.comcast.net ([69.252.207.107])
        by resqmta-ch2-09v.sys.comcast.net with comcast
        id EAn11r0012Ka2Q501An18S; Mon, 07 Sep 2015 10:47:01 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-11v.sys.comcast.net with comcast
        id EAmz1r00C0w5D3801An0od; Mon, 07 Sep 2015 10:47:01 +0000
From:   Joshua Kinard <kumba@gentoo.org>
Subject: [PATCH]: MIPS: IP27: Fix section mismatches & mark boot functions w/
 __init
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
X-Enigmail-Draft-Status: N1110
Message-ID: <55ED6B21.8030401@gentoo.org>
Date:   Mon, 7 Sep 2015 06:46:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1441622821;
        bh=LVBXZmIMwaE7daYwHO9qlfjIxiM5eC4lb6bScXienCw=;
        h=Received:Received:From:Subject:To:Message-ID:Date:MIME-Version:
         Content-Type;
        b=pzV17mtXSPYHmkq0FvToO7l306nUW1XaOVQ73v16cu1G1aIBVlqMr1aF2ZW1ENuJT
         jYJ1tyIvJtDr9kcHK4s2jYyH4pdgpg/+jEogJlGfI1lMjqUe1t3ofYFV5Z+1pHRT36
         cZamVJkao1sU5cc1SymTisTa+u69zoDuAJUKZhcGlAxUxMrd+RpAZCl79eh3+VN9nx
         82Zm4n2uFl10yWxtSYKpMBjVtPOQt2G6V4s+aTknJQcJCaNBd0V2e3jO8TpgG3mcdL
         Vh7QuzQr5IOiv1fPUP7ddAPx/UO4f0N8QQOwbRhmrDcgCuiDW0RwS5i5aEHtJSxrG+
         QkEX0TyC2vy6g==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

When the xwidget.h changes were added in 4.1, they inadvertently created
a few section mismatch warnings due to not using '__init' on a few
functions:

WARNING: vmlinux.o(.text+0x38f8): Section mismatch in reference from the function xbow_probe() to the variable .init.rodata:widget_idents
The function xbow_probe() references
the variable __initconst widget_idents.
This is often because xbow_probe lacks a __initconst
annotation or the annotation of widget_idents is wrong.

WARNING: vmlinux.o(.text+0x3bd8): Section mismatch in reference from the function xtalk_probe_node() to the variable .init.rodata:widget_idents
The function xtalk_probe_node() references
the variable __initconst widget_idents.
This is often because xtalk_probe_node lacks a __initconst
annotation or the annotation of widget_idents is wrong.

Fix this, and add __init to nearby IP27 functions that are only used
during system boot up, as this platform can't hotswap CPUs/nodes while
running anyways.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/sgi-ip27/ip27-init.c  |    2 +-
 arch/mips/sgi-ip27/ip27-smp.c   |   10 +++++-----
 arch/mips/sgi-ip27/ip27-xtalk.c |    6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

linux-mips-ip27-fix-section-mismatches.patch
diff --git a/arch/mips/sgi-ip27/ip27-init.c b/arch/mips/sgi-ip27/ip27-init.c
index 570098b..bb00afd 100644
--- a/arch/mips/sgi-ip27/ip27-init.c
+++ b/arch/mips/sgi-ip27/ip27-init.c
@@ -110,7 +110,7 @@ static void per_hub_init(cnodeid_t cnode)
 	}
 }
 
-void per_cpu_init(void)
+void __init per_cpu_init(void)
 {
 	int cpu = smp_processor_id();
 	int slice = LOCAL_HUB_L(PI_CPU_NUM);
diff --git a/arch/mips/sgi-ip27/ip27-smp.c b/arch/mips/sgi-ip27/ip27-smp.c
index f9ae6a8..cd6fc2e 100644
--- a/arch/mips/sgi-ip27/ip27-smp.c
+++ b/arch/mips/sgi-ip27/ip27-smp.c
@@ -94,7 +94,7 @@ static int do_cpumask(cnodeid_t cnode, nasid_t nasid, int highest)
 	return highest;
 }
 
-void cpu_node_probe(void)
+void __init cpu_node_probe(void)
 {
 	int i, highest = 0;
 	gda_t *gdap = GDA;
@@ -127,7 +127,7 @@ void cpu_node_probe(void)
 	printk("Discovered %d cpus on %d nodes\n", highest + 1, num_online_nodes());
 }
 
-static __init void intr_clear_all(nasid_t nasid)
+static void __init intr_clear_all(nasid_t nasid)
 {
 	int i;
 
@@ -173,12 +173,12 @@ static void ip27_send_ipi_mask(const struct cpumask *mask, unsigned int action)
 		ip27_send_ipi_single(i, action);
 }
 
-static void ip27_init_secondary(void)
+static void __init ip27_init_secondary(void)
 {
 	per_cpu_init();
 }
 
-static void ip27_smp_finish(void)
+static void __init ip27_smp_finish(void)
 {
 	extern void hub_rt_clock_event_init(void);
 
@@ -191,7 +191,7 @@ static void ip27_smp_finish(void)
  * set sp to the kernel stack of the newly created idle process, gp to the proc
  * struct so that current_thread_info() will work.
  */
-static void ip27_boot_secondary(int cpu, struct task_struct *idle)
+static void __init ip27_boot_secondary(int cpu, struct task_struct *idle)
 {
 	unsigned long gp = (unsigned long)task_thread_info(idle);
 	unsigned long sp = __KSTK_TOS(idle);
diff --git a/arch/mips/sgi-ip27/ip27-xtalk.c b/arch/mips/sgi-ip27/ip27-xtalk.c
index c262208..07bb8fd 100644
--- a/arch/mips/sgi-ip27/ip27-xtalk.c
+++ b/arch/mips/sgi-ip27/ip27-xtalk.c
@@ -22,7 +22,7 @@
 
 extern int bridge_probe(nasid_t nasid, int widget, int masterwid);
 
-static int probe_one_port(nasid_t nasid, int widget, int masterwid)
+static int __init probe_one_port(nasid_t nasid, int widget, int masterwid)
 {
 	const struct widget_ident *res;
 	u32 wid_id, wid_part, wid_mfgr, wid_rev;
@@ -63,7 +63,7 @@ static int probe_one_port(nasid_t nasid, int widget, int masterwid)
 	return 0;
 }
 
-static int xbow_probe(nasid_t nasid)
+static int __init xbow_probe(nasid_t nasid)
 {
 	lboard_t *brd;
 	klxbow_t *xbow_p;
@@ -116,7 +116,7 @@ static int xbow_probe(nasid_t nasid)
 	return 0;
 }
 
-void xtalk_probe_node(cnodeid_t nid)
+void __init xtalk_probe_node(cnodeid_t nid)
 {
 	volatile u64		hubreg;
 	nasid_t			nasid;
