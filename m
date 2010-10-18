Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2010 23:08:05 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:37668 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491868Ab0JRVIC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Oct 2010 23:08:02 +0200
Received: by yxl31 with SMTP id 31so218202yxl.36
        for <multiple recipients>; Mon, 18 Oct 2010 14:07:51 -0700 (PDT)
Received: by 10.42.165.136 with SMTP id k8mr3892039icy.217.1287436071648;
        Mon, 18 Oct 2010 14:07:51 -0700 (PDT)
Received: from angua (S01060002b3d79728.cg.shawcable.net [70.72.87.49])
        by mx.google.com with ESMTPS id in12sm18247896ibb.3.2010.10.18.14.07.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 14:07:50 -0700 (PDT)
Received: by angua (Postfix, from userid 1000)
        id 618293C00E5; Mon, 18 Oct 2010 15:07:48 -0600 (MDT)
Date:   Mon, 18 Oct 2010 15:07:48 -0600
From:   Grant Likely <grant.likely@secretlab.ca>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     dediao@cisco.com, benh@kernel.crashing.org, ralf@linux-mips.org,
        linux-mips@linux-mips.org, monstr@monstr.eu, dvomlehn@cisco.com,
        devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH 2/2 RFC] of/mips: Add device tree support to MIPS
Message-ID: <20101018210748.GG2259@angua.secretlab.ca>
References: <20101013064352.2743.80378.stgit@localhost6.localdomain6>
 <20101013064416.2743.42892.stgit@localhost6.localdomain6>
 <4CBCB330.4090205@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CBCB330.4090205@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

On Mon, Oct 18, 2010 at 01:50:56PM -0700, David Daney wrote:
> Although I tested this patch, and it compiles, I have a few more
> comments now that I have studied it.
> 
> Basically, it looks like most of the code in arch/mips/kernel/prom.c
> is not generic to MIPS, but instead highly specific to some platform
> (perhaps PowerTV).
> 
> On 10/12/2010 11:48 PM, Grant Likely wrote:
> >From: Dezhong Diao<dediao@cisco.com>
> >
> >Add the ability to enable CONFIG_OF on the MIPS architecture.
> >
> >Signed-off-by: Dezhong Diao<dediao@cisco.com>
> >[grant.likely@secretlab.ca: cleared out obsolete hooks,
> >	removed ARCH_HAS_DEVTREE_MEM from being manually selected,
> >	remove __init tags from header file]
> >Signed-off-by: Grant Likely<grant.likely@secretlab.ca>
> >Cc: linux-mips@linux-mips.org
> >Cc: David Daney<ddaney@caviumnetworks.com>
> >Cc: David VomLehn<dvomlehn@cisco.com>
> >---
> >
> >I've not tested this on anything, but I picked up the MIPS device tree
> >patch written by Dezhong and updated it to match the changes in
> >mainline.  I also half-heartedly tried to rebase the powertv support
> >patch, didn't get very far due to the refactoring in
> >arch/mips/powertv/memory.c
> >
> >Anyway, please take a look and give it a spin.  If it looks good, then
> >I can add it into my -next branch.
> >
> >g.
> >
> >  arch/mips/Kconfig            |   13 ++++
> >  arch/mips/include/asm/prom.h |   35 +++++++++++
> >  arch/mips/kernel/Makefile    |    2 +
> >  arch/mips/kernel/prom.c      |  135 ++++++++++++++++++++++++++++++++++++++++++
> >  arch/mips/kernel/setup.c     |    2 +
> >  5 files changed, 187 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/mips/include/asm/prom.h
> >  create mode 100644 arch/mips/kernel/prom.c
> >
> >diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> >index 3ad59dd..15e364d 100644
> >--- a/arch/mips/Kconfig
> >+++ b/arch/mips/Kconfig
> >@@ -2107,6 +2107,19 @@ config SECCOMP
> >
> >  	  If unsure, say Y. Only embedded should say N here.
> >
> >+config USE_OF
> >+	bool "Flattened Device Tree support"
> >+	select OF
> >+	select OF_FLATTREE
> >+	help
> >+	  Include support for flattened device tree machine descriptions.
> >+
> >+config ARCH_HAS_DEVTREE_MEM
> >+	bool
> >+	depends on OF
> >+	help
> >+	  The user has a customized function to parse memory nodes.
> >+
> >  endmenu
> >
> 
> These Kconfig items should only be selectable if OF is truly
> supported.  Hardwiring  ARCH_HAS_DEVTREE_MEM to USE_OF at this
> global level doesn't seem quite right either.  I think it is
> conceivable that we would want USE_OF without ARCH_HAS_DEVTREE_MEM.

Right.  That ARCH_HAS_DEVTREE_MEM thing really shouldn't be in this
patch since it is implemented only so that powertv can override them.
Instead, it should be in another patch so it can be reviewed
separately.  I'll remove.

> >+unsigned int irq_create_of_mapping(struct device_node *controller,
> >+				   const u32 *intspec, unsigned int intsize)
> >+{
> >+	return intspec[0];
> >+}
> >+EXPORT_SYMBOL_GPL(irq_create_of_mapping);
> >+
> 
> This mapping function depends on the interrupt controller
> architecture.  It is not at all a good fit for what I want to do on
> Octeon.  We have a hierarchy of interrupt mapping that is best
> described by a two level tree, so has '#interrupt-cells = <2>;'.  We
> definitely need a different implementation than this.
> 

All of the IRQ mapping infrastructure is the biggest current missing
piece needed for the device tree architecture to be nicely cross
platform.  This map function is definitely a hack, but it is a stop
gap until a port or write a cross architecture irq mapping code so
that each irq controller can claim a different slice of the irq number
space and be able to resolve it to interrupt-controller device tree nodes.

> >+void __init early_init_devtree(void *params)
> >+{
> >+	/* Setup flat device-tree pointer */
> >+	initial_boot_params = params;
> >+
> >+	/* Retrieve various informations from the /chosen node of the
> >+	 * device-tree, including the platform type, initrd location and
> >+	 * size, and more ...
> >+	 */
> >+	of_scan_flat_dt(early_init_dt_scan_chosen, NULL);
> >+
> >+	/* Scan memory nodes */
> >+	of_scan_flat_dt(early_init_dt_scan_root, NULL);
> >+	of_scan_flat_dt(early_init_dt_scan_memory_arch, NULL);
> >+}
> >+
> >+void __init device_tree_init(void)
> >+{
> >+	unsigned long base, size;
> >+
> >+	if (!initial_boot_params)
> >+		return;
> >+
> >+	base = virt_to_phys((void *)initial_boot_params);
> >+	size = initial_boot_params->totalsize;
> >+
> >+	/* Before we do anything, lets reserve the dt blob */
> >+	reserve_mem_mach(base, size);
> >+
> >+	unflatten_device_tree();
> >+
> >+	/* free the space reserved for the dt blob */
> >+	free_mem_mach(base, size);
> >+}
> >+
> >+#if defined(CONFIG_DEBUG_FS)&&  defined(DEBUG)
> >+static struct dentry *of_debugfs_root;
> >+static struct debugfs_blob_wrapper flat_dt_blob;
> >+
> >+static int __init export_flat_device_tree(void)
> >+{
> >+	struct dentry *d;
> >+
> >+	flat_dt_blob.data = initial_boot_params;
> >+	flat_dt_blob.size = initial_boot_params->totalsize;
> >+
> >+	d = debugfs_create_blob("flat-device-tree", S_IFREG | S_IRUSR,
> >+				of_debugfs_root,&flat_dt_blob);
> >+	if (!d)
> >+		return 1;
> >+
> >+	return 0;
> >+}
> >+device_initcall(export_flat_device_tree);
> 
> This debugfs bit will fail.  of_debugfs_root is never initialized
> that I can see.

I'm happy to drop the debugfs bits from this patch.

g.
