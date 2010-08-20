Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Aug 2010 22:52:10 +0200 (CEST)
Received: from sj-iport-6.cisco.com ([171.71.176.117]:4149 "EHLO
        sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491753Ab0HTUvz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Aug 2010 22:51:55 +0200
Authentication-Results: sj-iport-6.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAAqIbkyrR7Ht/2dsb2JhbACgPXGgBZtZgmWCUgSENA
X-IronPort-AV: E=Sophos;i="4.56,242,1280707200"; 
   d="scan'208";a="576559933"
Received: from sj-core-1.cisco.com ([171.71.177.237])
  by sj-iport-6.cisco.com with ESMTP; 20 Aug 2010 20:51:42 +0000
Received: from dvomlehn-lnx2.corp.sa.net (dhcp-171-71-47-241.cisco.com [171.71.47.241])
        by sj-core-1.cisco.com (8.13.8/8.14.3) with ESMTP id o7KKpg3o005557;
        Fri, 20 Aug 2010 20:51:42 GMT
Date:   Fri, 20 Aug 2010 13:51:42 -0700
From:   David VomLehn <dvomlehn@cisco.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH][MIPS] PowerTV: Cleanup code to handle early bootmem
        allocations
Message-ID: <20100820205142.GA2543@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Change how memory is set up, especially before the page allocator is ready

Cleanup and divide the work of reserving pre-allocated memory into two pieces:

1.	Avoid passing RAM for fixed-address pre-allocated memory to the
	boot allocator. This is done before the boot allocator is initialized.
2.	After the slab allocator is initialized, allocate memory for the
	pre-allocations that do not have fixed address, then add resources
	for both fixed and non-fixed address preallocations

Also, switch to PREALLOC_* macros in arch/mips/powertv/asic/prealloc-gaia.c to 
manage their configuration.

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
---
 arch/mips/include/asm/mach-powertv/asic.h          |   30 +-
 arch/mips/include/asm/mach-powertv/painting.h      |  224 ++++++++
 .../include/asm/mach-powertv/powertv-prealloc.h    |   51 ++
 arch/mips/include/asm/mach-powertv/prealloc.h      |  121 +++++
 arch/mips/powertv/Kconfig                          |   12 +
 arch/mips/powertv/asic/Kconfig                     |   38 +-
 arch/mips/powertv/asic/Makefile                    |    6 +-
 arch/mips/powertv/asic/asic_devices.c              |  219 ++-------
 arch/mips/powertv/asic/asic_int.c                  |    4 +-
 arch/mips/powertv/asic/painting.c                  |  298 ++++++++++
 arch/mips/powertv/asic/powertv-prealloc.c          |  136 +++++
 arch/mips/powertv/asic/prealloc-calliope.c         |    9 +-
 arch/mips/powertv/asic/prealloc-cronus.c           |    7 +-
 arch/mips/powertv/asic/prealloc-cronuslite.c       |    5 +-
 arch/mips/powertv/asic/prealloc-gaia.c             |  490 ++++-------------
 arch/mips/powertv/asic/prealloc-zeus.c             |    7 +-
 arch/mips/powertv/asic/prealloc.c                  |  566 ++++++++++++++++++++
 arch/mips/powertv/asic/prealloc.h                  |   70 ---
 arch/mips/powertv/init.c                           |    4 +-
 arch/mips/powertv/ioremap.c                        |   38 +-
 arch/mips/powertv/memory.c                         |  203 ++-----
 arch/mips/powertv/powertv_setup.c                  |    4 +-
 22 files changed, 1690 insertions(+), 852 deletions(-)

diff --git a/arch/mips/include/asm/mach-powertv/asic.h b/arch/mips/include/asm/mach-powertv/asic.h
index c7077a6..0d7f8a5 100644
--- a/arch/mips/include/asm/mach-powertv/asic.h
+++ b/arch/mips/include/asm/mach-powertv/asic.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009  Cisco Systems, Inc.
+ * Copyright (C) 2009-2010  Cisco Systems, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -51,20 +51,9 @@ extern const struct register_map cronus_register_map;
 extern const struct register_map gaia_register_map;
 extern const struct register_map zeus_register_map;
 
-extern struct resource dvr_cronus_resources[];
-extern struct resource dvr_gaia_resources[];
-extern struct resource dvr_zeus_resources[];
-extern struct resource non_dvr_calliope_resources[];
-extern struct resource non_dvr_cronus_resources[];
-extern struct resource non_dvr_cronuslite_resources[];
-extern struct resource non_dvr_gaia_resources[];
-extern struct resource non_dvr_vz_calliope_resources[];
-extern struct resource non_dvr_vze_calliope_resources[];
-extern struct resource non_dvr_vzf_calliope_resources[];
-extern struct resource non_dvr_zeus_resources[];
-
+/* Platform resources management */
+extern void platform_reserve_bootmem(void);
 extern void powertv_platform_init(void);
-extern void platform_alloc_bootmem(void);
 extern enum asic_type platform_get_asic(void);
 extern enum family_type platform_get_family(void);
 extern int platform_supports_dvr(void);
@@ -73,11 +62,6 @@ extern int platform_supports_pcie(void);
 extern int platform_supports_display(void);
 extern void configure_platform(void);
 
-/* Platform Resources */
-#define ASIC_RESOURCE_GET_EXISTS 1
-extern struct resource *asic_resource_get(const char *name);
-extern void platform_release_memory(void *baddr, int size);
-
 /* USB configuration */
 struct usb_hcd;			/* Forward reference */
 extern void platform_configure_usb_ehci(void);
@@ -87,8 +71,16 @@ extern void platform_unconfigure_usb_ohci(void);
 
 /* Resource for ASIC registers */
 extern struct resource asic_resource;
+#ifdef CONFIG_USB
 extern int platform_usb_devices_init(struct platform_device **echi_dev,
 	struct platform_device **ohci_dev);
+#else
+static inline int platform_usb_devices_init(struct platform_device **echi_dev,
+	struct platform_device **ohci_dev)
+{
+	return 0;
+}
+#endif
 
 /* Reboot Cause */
 extern void set_reboot_cause(char code, unsigned int data, unsigned int data2);
diff --git a/arch/mips/include/asm/mach-powertv/painting.h b/arch/mips/include/asm/mach-powertv/painting.h
new file mode 100644
index 0000000..b748c81
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/painting.h
@@ -0,0 +1,224 @@
+/*
+ *				painting.h
+ *
+ * Definitions to use the paint interface, which allows painting kernel
+ * memory allocations in order to be able to track memory usage.
+ *
+ * Author: David VomLehn
+ */
+/*
+ * Copyright (C) 2008-2009  Scientific-Atlanta, Inc.
+ * Copyright (C) 2009-2010  Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef	_PAINTING_H_
+#define	_PAINTING_H_
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/rbtree.h>
+#include <linux/compiler.h>
+#include <linux/err.h>
+
+/* Classifications of relationships between two areas */
+#define MISMATCH_CUR_ENDS_FIRST		((0 << 1) | 0)
+#define MISMATCH_CUR_ENDS_LAST		((0 << 1) | 1)
+#define MATCH_CUR_ENDS_FIRST		((1 << 1) | 0)
+#define MATCH_CUR_ENDS_LAST		((1 << 1) | 1)
+
+struct painting_desc {
+	phys_addr_t	p;		/* Starting location */
+	phys_addr_t	q;		/* Ending location, inclusive */
+	const void	*color;		/* "color" */
+};
+
+/* Data structure that holds the information for one painting area */
+struct painting_area {
+	struct rb_node		node;
+	struct painting_desc	desc;
+};
+
+/* Operations for a particular painting object */
+struct painting_ops {
+	struct painting_area	*(*alloc)(void *ctx);
+	void			(*free)(void *ctx,
+					const struct painting_area *area);
+	bool			(*equals)(const void *l, const void *r);
+};
+
+/* Basic paint object */
+struct painting {
+	struct rb_root			root;
+	struct list_head		areas;
+};
+
+#define PAINTING_INIT(name)					\
+		{						\
+			.root =	RB_ROOT,			\
+			.areas = LIST_HEAD_INIT(name.areas),	\
+		}
+
+#define	PAINTING(name) struct painting name = PAINTING_INIT(name)
+
+static inline void INIT_PAINTING(struct painting *this)
+{
+	this->root = RB_ROOT;
+}
+
+#define painting_for_each_area(pos, this)		\
+	for ((pos) = painting_first(this);		\
+		(pos) != NULL;				\
+		(pos) = painting_next(pos))
+
+#define painting_for_each_area_save(pos, n, this)		\
+	for ((pos) = painting_first(this),			\
+			(n) = (((pos) == NULL) ? NULL : painting_next(pos)); \
+		(pos) != NULL;					\
+		(pos) = (n),					\
+			(n) = (((pos) == NULL) ? NULL : painting_next(pos)))
+
+/* Functions */
+extern struct painting_area *find_neighbor(const struct painting *this,
+	phys_addr_t p);
+extern struct painting_area *
+	painting_do_prev_overlaps_and_abuts(struct painting *this,
+	struct painting_area *cur, struct painting_desc *new,
+	struct painting_area *tail);
+extern struct painting_area *do_successor(struct painting *this,
+	struct painting_area *cur, struct painting_desc *new);
+extern int finish_new_allocation(struct painting *this,
+	struct painting_area *newp, struct painting_desc *new);
+
+/*
+ * _painting_from_rb - convert an rb_node to the containing &painting_area
+ * @rb:	Pointer to the &struct rb_node
+ */
+static struct painting_area *__pure _painting_from_rb(struct rb_node *node)
+{
+	return (node == NULL) ? NULL :
+		container_of(node, struct painting_area, node);
+}
+
+/**
+ * painting_area_first - find the first &painting_area in a &painting
+ * @painting:	Pointer to a &struct pointing
+ * Returns NULL if no areas are in the &painting, otherwise a pointer to
+ * the first &struct painting_area.
+ */
+static inline struct painting_area *__pure
+	painting_first(const struct painting *p)
+{
+	return _painting_from_rb(rb_first(&p->root));
+}
+
+/**
+ * painting_next - find the next &painting_area
+ * @p:	Pointer to a &struct painting_area
+ *
+ * Returns a pointer to the next &struct painting_area
+ */
+static inline struct painting_area *__pure
+	painting_next(const struct painting_area *p)
+{
+	return _painting_from_rb(rb_next(&p->node));
+}
+
+/**
+ * painting_prev - find the previous &painting_area
+ * @p:	Pointer to a &struct painting_area
+ *
+ * Returns a pointer to the previous &struct painting_area
+ */
+static inline struct painting_area *__pure
+	painting_prev(const struct painting_area *p)
+{
+	return _painting_from_rb(rb_prev(&p->node));
+}
+
+/**
+ * classify - categorize the relationship between two areas
+ * @a:	Pointer to a &struct painting_desc for the first area
+ * @b:	Pointer to a &struct painting_desc for the second area
+ */
+static inline int __pure classify(const struct painting_desc *a,
+	const struct painting_desc *b)
+{
+	int same_color, b_ends_before_a, result;
+
+	same_color = (a->color == b->color);
+	b_ends_before_a = (b->q < a->q);
+	result = ((same_color << 1) | b_ends_before_a);
+	return result;
+}
+
+/**
+ * painting_have_prev - see if the current area preceeds the new area
+ * @cur:	Pointer to the &painting_area for the current area
+ * @new:	Pointer to the &painting_desc for the new area
+ *
+ * Returns true if the current area exists before the new area, false otherwise
+ */
+static inline bool __pure painting_have_prev(const struct painting_area *cur,
+	const struct painting_desc *new)
+{
+	return cur != NULL && cur->desc.p < new->p;
+}
+
+/**
+ * painting_prev_overlaps_or_abuts - does prev area overlaps or abuts new area
+ * @cur:	Pointer to &struct painting_desc for the current area
+ * @new:	Pointer to &struct painting_desc for the current area
+ *
+ * Returns true of the current area is before the new area and either overlaps
+ * or abuts the new area.
+ */
+static inline bool __pure
+	painting_prev_overlaps_or_abuts(const struct painting_desc *cur,
+	const struct painting_desc *new)
+{
+	return cur->p < new->p && cur->q >= new->p - 1;
+}
+
+/**
+ * painting_must_make_hole - see if new area makes a hole in the current area
+ * @cur:	Pointer to the &struct painting_desc for the current area
+ * @new:	Pointer to the &struct painting_desc for the new area
+ *
+ * Returns true if the new area makes a hole in the current area, i.e. the
+ * current area ends up on both sides of the new area, false otherwise.
+ */
+static inline bool __pure
+	painting_must_make_hole(const struct painting_desc *cur,
+	const struct painting_desc *new)
+{
+	return classify(cur, new) == MISMATCH_CUR_ENDS_LAST;
+}
+
+/**
+ * painting_add_area - see if previous area overlaps or abuts the new area
+ * @cur:	Pointer to &struct painting_desc for the current area
+ * @new:	Pointer to &struct painting_desc for the current area
+ *
+ * Returns true of the current area is before the new area and either overlaps
+ * or abuts the new area.
+ */
+static inline bool __pure
+painting_add_area(const struct painting_desc *cur,
+	const struct painting_desc *new)
+{
+	return classify(cur, new) != MATCH_CUR_ENDS_LAST;
+}
+#endif
diff --git a/arch/mips/include/asm/mach-powertv/powertv-prealloc.h b/arch/mips/include/asm/mach-powertv/powertv-prealloc.h
new file mode 100644
index 0000000..5b4f938
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/powertv-prealloc.h
@@ -0,0 +1,51 @@
+/*
+ * Description:  Does platform-specific hardware initialization
+ *
+ * Copyright (C) 2005-2010 Scientific-Atlanta, Inc.
+ * Copyright (C) 2009-2010 Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#ifndef _POWERTV_ASIC_PREALLOC_H_
+#define _POWERTV_ASIC_PREALLOC_H_
+#include <asm/mach-powertv/asic_regs.h>
+#include "prealloc.h"
+
+/* PLATFORM RESOURCE DEFINITIONS */
+extern const struct dma_resource dvr_cronus_resources[];
+extern const struct dma_resource dvr_gaia_resources[];
+extern const struct dma_resource dvr_zeus_resources[];
+extern const struct dma_resource non_dvr_calliope_resources[];
+extern const struct dma_resource non_dvr_cronus_resources[];
+extern const struct dma_resource non_dvr_cronuslite_resources[];
+extern const struct dma_resource non_dvr_gaia_resources[];
+extern const struct dma_resource non_dvr_vz_calliope_resources[];
+extern const struct dma_resource non_dvr_vze_calliope_resources[];
+extern const struct dma_resource non_dvr_vzf_calliope_resources[];
+extern const struct dma_resource non_dvr_zeus_resources[];
+
+extern const struct dma_resource *gp_resources;
+
+/* Resource for ASIC */
+extern struct resource asic_resource;
+
+/* Point to resource-s of Low memory and High memory extents */
+extern struct resource *ptv_res_loext_root;
+extern struct resource *ptv_res_hiext_root;
+
+extern void plat_resource_init(void);
+extern void register_available_ram(void);
+#endif
diff --git a/arch/mips/include/asm/mach-powertv/prealloc.h b/arch/mips/include/asm/mach-powertv/prealloc.h
new file mode 100644
index 0000000..066c11f
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/prealloc.h
@@ -0,0 +1,121 @@
+/*
+ * Definitions for memory preallocations
+ *
+ * Copyright (C) 2005-2009  Scientific-Atlanta, Inc.
+ * Copyright (C) 2009-2010  Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#ifndef _ARCH_MIPS_POWERTV_ASIC_PREALLOC_H
+#define _ARCH_MIPS_POWERTV_ASIC_PREALLOC_H
+#include <linux/ioport.h>
+#include <linux/resource.h>
+#include <asm/mach-powertv/painting.h>
+
+#define KIBIBYTE(n) ((n) * 1024)    /* Number of kibibytes */
+#define MEBIBYTE(n) ((n) * KIBIBYTE(1024)) /* Number of mebibytes */
+
+#define IORESOURCE_PTV_RES_LOEXT	0x1 /* Resource must go in low mem */
+
+/* "struct resource" array element definition */
+#define PREALLOC(NAME, START, END, FLAGS) {	\
+		.name = (NAME),			\
+		.start = (START),		\
+		.end = (END),			\
+		.flags = (FLAGS)		\
+	},
+
+/* Individual resources in the preallocated resource arrays are defined using
+ *  macros.  These macros are conditionally defined based on their
+ *  corresponding kernel configuration flag:
+ *    - CONFIG_PREALLOC_NORMAL: preallocate resources for a normal settop box
+ *    - CONFIG_PREALLOC_TFTP: preallocate the TFTP download resource
+ *    - CONFIG_PREALLOC_DOCSIS: preallocate the DOCSIS resource
+ *    - CONFIG_PREALLOC_PMEM: reserve space for persistent memory
+ */
+#ifdef CONFIG_PREALLOC_NORMAL
+#define PREALLOC_NORMAL(name, start, end, flags) \
+   PREALLOC(name, start, end, flags)
+#else
+#define PREALLOC_NORMAL(name, start, end, flags)
+#endif
+
+#ifdef CONFIG_PREALLOC_TFTP
+#define PREALLOC_TFTP(name, start, end, flags) \
+   PREALLOC(name, start, end, flags)
+#else
+#define PREALLOC_TFTP(name, start, end, flags)
+#endif
+
+#ifdef CONFIG_PREALLOC_DOCSIS
+#define PREALLOC_DOCSIS(name, start, end, flags) \
+   PREALLOC(name, start, end, flags)
+#else
+#define PREALLOC_DOCSIS(name, start, end, flags)
+#endif
+
+#ifdef CONFIG_PREALLOC_PMEM
+#define PREALLOC_PMEM(name, start, end, flags) \
+   PREALLOC(name, start, end, flags)
+#else
+#define PREALLOC_PMEM(name, start, end, flags)
+#endif
+
+/*
+ * Drivers really just need to look up the physical addresss of a resource
+ * name. This is the data we pass back to them
+ */
+struct bus_resource {
+	phys_addr_t start;
+	phys_addr_t end;
+};
+
+/*
+ * For describing resources as DMA addresses
+ */
+struct dma_resource {
+	dma_addr_t	start;
+	dma_addr_t	end;
+	const char	*name;
+	unsigned long	flags;
+};
+
+/* Predefined physical memory types */
+extern const char physmem_bootloader[];
+extern const char physmem_buddy_high[];
+extern const char physmem_buddy_low[];
+extern const char physmem_mem_map[];
+extern const char physmem_ram[];
+extern const char physmem_reserved[];
+extern const char physmem_reset_vector[];
+extern const char physmem_rom_data[];
+extern const char physmem_unknown[];
+extern const char physmem_zero_page[];
+
+/* allow drivers get info but use their data struct instead of passing */
+/* something allocated inside the kernel */
+extern int resource_add_ram(phys_addr_t start, size_t size);
+extern void resource_reserve_static_prealloc(size_t size,
+	const struct dma_resource *dma_res);
+extern void resource_add_memory_regions(void);
+extern size_t __init resource_request_prealloc(size_t n,
+	const struct dma_resource *dma_resources);
+extern bool platform_resource_override(struct resource *plat_res,
+	const struct dma_resource *dma_res);
+extern int platform_lookup_resource(const char *name,
+	struct bus_resource *bres_p);
+extern unsigned long platform_release_memory(unsigned long baddr, int size);
+#endif
diff --git a/arch/mips/powertv/Kconfig b/arch/mips/powertv/Kconfig
index ff0e7e3..e327762 100644
--- a/arch/mips/powertv/Kconfig
+++ b/arch/mips/powertv/Kconfig
@@ -19,3 +19,15 @@ config BOOTLOADER_FAMILY
 	    E1 - Class E  F1 - Class F
 	    44 - 45xx     46 - 46xx
 	    85 - 85xx     86 - 86xx
+
+config PREALLOCATED_AREAS_ITEMS
+	int "Number items for handling driver pre-allocations"
+	default 100
+	depends on POWERTV
+	help
+	  Very early allocations of large chunks of memory is done before any
+	  of the memory allocators are in use. This requires that any memory
+	  required be statically allocated. It is difficult to calculate the
+	  exact value, but it is roughly twice the number of preallocations
+	  plus two for the kernel and an extra two for each contiguous chunk
+	  of memory.
diff --git a/arch/mips/powertv/asic/Kconfig b/arch/mips/powertv/asic/Kconfig
index 2016bfe..1a48e17 100644
--- a/arch/mips/powertv/asic/Kconfig
+++ b/arch/mips/powertv/asic/Kconfig
@@ -1,28 +1,34 @@
-config MIN_RUNTIME_RESOURCES
-	bool "Support for minimum runtime resources"
-	default n
+menu "Preallocated resource options"
+
+config PREALLOC_NORMAL
+	bool "Preallocate normal resources"
 	depends on POWERTV
+	default y
 	help
-	  Enables support for minimizing the number of (SA asic) runtime
-	  resources that are preallocated by the kernel.
+	  Enables support for the preallocated kernel resources used in normal
+	  settop operation.  This includes all preallocated resources that
+	  aren't individually controlled via a separate CONFIG_PREALLOC_
+	  option.
 
-config MIN_RUNTIME_DOCSIS
-	bool "Support for minimum DOCSIS resource"
+config PREALLOC_DOCSIS
+	bool "Preallocate the DOCSIS resource"
+	depends on POWERTV
 	default y
-	depends on MIN_RUNTIME_RESOURCES
 	help
 	  Enables support for the preallocated DOCSIS resource.
 
-config MIN_RUNTIME_PMEM
-	bool "Support for minimum PMEM resource"
+config PREALLOC_PMEM
+	bool "Preallocate the PMEM resource"
+	depends on POWERTV
 	default y
-	depends on MIN_RUNTIME_RESOURCES
 	help
-	  Enables support for the preallocated Memory resource.
+	  Enables support for the preallocated persistent memory resource.
 
-config MIN_RUNTIME_TFTP
-	bool "Support for minimum TFTP resource"
-	default y
-	depends on MIN_RUNTIME_RESOURCES
+config PREALLOC_TFTP
+	bool "Preallocate the TFTP resource"
+	depends on POWERTV
+	default n
 	help
 	  Enables support for the preallocated TFTP resource.
+
+endmenu
diff --git a/arch/mips/powertv/asic/Makefile b/arch/mips/powertv/asic/Makefile
index f0e95dc..db0846b 100644
--- a/arch/mips/powertv/asic/Makefile
+++ b/arch/mips/powertv/asic/Makefile
@@ -1,5 +1,6 @@
 #
 # Copyright (C) 2009  Scientific-Atlanta, Inc.
+# Copyright (C) 2010  Cisco Systems, Inc.
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
@@ -17,7 +18,8 @@
 #
 
 obj-y += asic-calliope.o asic-cronus.o asic-gaia.o asic-zeus.o \
-	asic_devices.o asic_int.o irq_asic.o prealloc-calliope.o \
-	prealloc-cronus.o prealloc-cronuslite.o prealloc-gaia.o prealloc-zeus.o
+	asic_devices.o asic_int.o irq_asic.o painting.o \
+	powertv-prealloc.o prealloc.o prealloc-calliope.o prealloc-cronus.o \
+	prealloc-cronuslite.o prealloc-gaia.o prealloc-zeus.o
 
 EXTRA_CFLAGS += -Wall -Werror
diff --git a/arch/mips/powertv/asic/asic_devices.c b/arch/mips/powertv/asic/asic_devices.c
index e56fa61..a8c018b 100644
--- a/arch/mips/powertv/asic/asic_devices.c
+++ b/arch/mips/powertv/asic/asic_devices.c
@@ -1,8 +1,9 @@
 /*
  *
- * Description:  Defines the platform resources for Gaia-based settops.
+ * Description:  Does platform-specific hardware initialization
  *
  * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ * Copyright (C) 2009-2010 Cisco Systems, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -21,22 +22,16 @@
  * NOTE: The bootloader allocates persistent memory at an address which is
  * 16 MiB below the end of the highest address in KSEG0. All fixed
  * address memory reservations must avoid this region.
+ *
+ * NOTE: This does not pre-allocate memory areas with dynamic address in
+ * memory outside of kseg0/kseg1. Dynamic allocation is restricted to
+ * kseg0/kseg1 memory. It wouldn't really be all that hard to support it;
+ * it just hasn't been needed.
  */
 
-#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/resource.h>
-#include <linux/serial_reg.h>
-#include <linux/io.h>
-#include <linux/bootmem.h>
-#include <linux/mm.h>
-#include <linux/platform_device.h>
 #include <linux/module.h>
-#include <asm/page.h>
-#include <linux/swap.h>
-#include <linux/highmem.h>
-#include <linux/dma-mapping.h>
 
 #include <asm/mach-powertv/asic.h>
 #include <asm/mach-powertv/asic_regs.h>
@@ -46,15 +41,11 @@
 #include <asm/mach-powertv/kbldr.h>
 #endif
 #include <asm/bootinfo.h>
+#include <asm/mach-powertv/powertv-prealloc.h>
 
 #define BOOTLDRFAMILY(byte1, byte0) (((byte1) << 8) | (byte0))
 
 /*
- * Forward Prototypes
- */
-static void pmem_setup_resource(void);
-
-/*
  * Global Variables
  */
 enum asic_type asic;
@@ -66,14 +57,6 @@ EXPORT_SYMBOL(_asic_register_map);		/* Exported for testing */
 unsigned long asic_phy_base;
 unsigned long asic_base;
 EXPORT_SYMBOL(asic_base);			/* Exported for testing */
-struct resource *gp_resources;
-
-/*
- * Don't recommend to use it directly, it is usually used by kernel internally.
- * Portable code should be using interfaces such as ioremp, dma_map_single, etc.
- */
-unsigned long phys_to_dma_offset;
-EXPORT_SYMBOL(phys_to_dma_offset);
 
 /*
  *
@@ -89,6 +72,13 @@ struct resource asic_resource = {
 };
 
 /*
+ * Don't recommend to use it directly, it is usually used by kernel internally.
+ * Portable code should be using interfaces such as ioremp, dma_map_single, etc.
+ */
+unsigned long phys_to_dma_offset;
+EXPORT_SYMBOL(phys_to_dma_offset);
+
+/*
  * Allow override of bootloader-specified model
  * Returns zero on success, a negative errno value on failure.  This parameter
  * allows overriding of the bootloader-specified model.
@@ -236,9 +226,9 @@ static void __init set_register_map(unsigned long phys_base,
 }
 
 /**
- * configure_platform - configuration based on platform type.
+ * powertv_platform_init - configuration based on platform type.
  */
-void __init configure_platform(void)
+void __init powertv_platform_init(void)
 {
 	platform_set_family();
 
@@ -374,176 +364,35 @@ void __init configure_platform(void)
 	}
 }
 
-/*
- * RESOURCE ALLOCATION
- *
- */
-/*
- * Allocates/reserves the Platform memory resources early in the boot process.
- * This ignores any resources that are designated IORESOURCE_IO
- */
-void __init platform_alloc_bootmem(void)
-{
-	int i;
-	int total = 0;
-
-	/* Get persistent memory data from command line before allocating
-	 * resources. This need to happen before normal command line parsing
-	 * has been done */
-	pmem_setup_resource();
-
-	/* Loop through looking for resources that want a particular address */
-	for (i = 0; gp_resources[i].flags != 0; i++) {
-		int size = gp_resources[i].end - gp_resources[i].start + 1;
-		if ((gp_resources[i].start != 0) &&
-			((gp_resources[i].flags & IORESOURCE_MEM) != 0)) {
-			reserve_bootmem(dma_to_phys(gp_resources[i].start),
-				size, 0);
-			total += gp_resources[i].end -
-				gp_resources[i].start + 1;
-			pr_info("reserve resource %s at %08x (%u bytes)\n",
-				gp_resources[i].name, gp_resources[i].start,
-				gp_resources[i].end -
-					gp_resources[i].start + 1);
-		}
-	}
-
-	/* Loop through assigning addresses for those that are left */
-	for (i = 0; gp_resources[i].flags != 0; i++) {
-		int size = gp_resources[i].end - gp_resources[i].start + 1;
-		if ((gp_resources[i].start == 0) &&
-			((gp_resources[i].flags & IORESOURCE_MEM) != 0)) {
-			void *mem = alloc_bootmem_pages(size);
-
-			if (mem == NULL)
-				pr_err("Unable to allocate bootmem pages "
-					"for %s\n", gp_resources[i].name);
-
-			else {
-				gp_resources[i].start =
-					phys_to_dma(virt_to_phys(mem));
-				gp_resources[i].end =
-					gp_resources[i].start + size - 1;
-				total += size;
-				pr_info("allocate resource %s at %08x "
-						"(%u bytes)\n",
-					gp_resources[i].name,
-					gp_resources[i].start, size);
-			}
-		}
-	}
-
-	pr_info("Total Platform driver memory allocation: 0x%08x\n", total);
-
-	/* indicate resources that are platform I/O related */
-	for (i = 0; gp_resources[i].flags != 0; i++) {
-		if ((gp_resources[i].start != 0) &&
-			((gp_resources[i].flags & IORESOURCE_IO) != 0)) {
-			pr_info("reserved platform resource %s at %08x\n",
-				gp_resources[i].name, gp_resources[i].start);
-		}
-	}
-}
-
-/*
- *
- * PERSISTENT MEMORY (PMEM) CONFIGURATION
- *
- */
-static unsigned long pmemaddr __initdata;
-
-static int __init early_param_pmemaddr(char *p)
-{
-	pmemaddr = (unsigned long)simple_strtoul(p, NULL, 0);
-	return 0;
-}
-early_param("pmemaddr", early_param_pmemaddr);
-
-static long pmemlen __initdata;
-
-static int __init early_param_pmemlen(char *p)
-{
-/* TODO: we can use this code when and if the bootloader ever changes this */
-#if 0
-	pmemlen = (unsigned long)simple_strtoul(p, NULL, 0);
+#ifdef CONFIG_USB
+#define NUM_USB_IFS	2
 #else
-	pmemlen = 0x20000;
+#define NUM_USB_IFS	0
 #endif
-	return 0;
-}
-early_param("pmemlen", early_param_pmemlen);
 
-/*
- * Set up persistent memory. If we were given values, we patch the array of
- * resources. Otherwise, persistent memory may be allocated anywhere at all.
- */
-static void __init pmem_setup_resource(void)
-{
-	struct resource *resource;
-	resource = asic_resource_get("DiagPersistentMemory");
-
-	if (resource && pmemaddr && pmemlen) {
-		/* The address provided by bootloader is in kseg0. Convert to
-		 * a bus address. */
-		resource->start = phys_to_dma(pmemaddr - 0x80000000);
-		resource->end = resource->start + pmemlen - 1;
-
-		pr_info("persistent memory: start=0x%x  end=0x%x\n",
-			resource->start, resource->end);
-	}
-}
+static struct platform_device *platform_devices[NUM_USB_IFS];
 
 /*
- *
- * RESOURCE ACCESS FUNCTIONS
- *
+ * platform_devices_init - initialize platform resource usage
  */
-
-/**
- * asic_resource_get - retrieves parameters for a platform resource.
- * @name:	string to match resource
- *
- * Returns a pointer to a struct resource corresponding to the given name.
- *
- * CANNOT BE NAMED platform_resource_get, which would be the obvious choice,
- * as this function name is already declared
- */
-struct resource *asic_resource_get(const char *name)
+int __init platform_devices_init(void)
 {
-	int i;
+	int ret;
 
-	for (i = 0; gp_resources[i].flags != 0; i++) {
-		if (strcmp(gp_resources[i].name, name) == 0)
-			return &gp_resources[i];
-	}
+	asic_resource.start = asic_phy_base;
+	asic_resource.end += asic_resource.start;
 
-	return NULL;
-}
-EXPORT_SYMBOL(asic_resource_get);
-
-/**
- * platform_release_memory - release pre-allocated memory
- * @ptr:	pointer to memory to release
- * @size:	size of resource
- *
- * This must only be called for memory allocated or reserved via the boot
- * memory allocator.
- */
-void platform_release_memory(void *ptr, int size)
-{
-	unsigned long addr;
-	unsigned long end;
+	ret = platform_usb_devices_init(&platform_devices[0],
+		&platform_devices[1]);
+	if (ret != 0)
+		return ret;
 
-	addr = ((unsigned long)ptr + (PAGE_SIZE - 1)) & PAGE_MASK;
-	end = ((unsigned long)ptr + size) & PAGE_MASK;
+	set_io_port_base(0);
+	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 
-	for (; addr < end; addr += PAGE_SIZE) {
-		ClearPageReserved(virt_to_page(__va(addr)));
-		init_page_count(virt_to_page(__va(addr)));
-		free_page((unsigned long)__va(addr));
-	}
+	return 0;
 }
-EXPORT_SYMBOL(platform_release_memory);
+arch_initcall(platform_devices_init);
 
 /*
  *
diff --git a/arch/mips/powertv/asic/asic_int.c b/arch/mips/powertv/asic/asic_int.c
index 7362f63..6866302 100644
--- a/arch/mips/powertv/asic/asic_int.c
+++ b/arch/mips/powertv/asic/asic_int.c
@@ -2,7 +2,7 @@
  * Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000, 2001, 2004 MIPS Technologies, Inc.
  * Copyright (C) 2001 Ralf Baechle
- * Portions copyright (C) 2009  Cisco Systems, Inc.
+ * Portions copyright (C) 2009-2010  Cisco Systems, Inc.
  *
  *  This program is free software; you can distribute it and/or modify it
  *  under the terms of the GNU General Public License (Version 2) as
@@ -37,6 +37,7 @@
 #include <asm/mips-boards/generic.h>
 
 #include <asm/mach-powertv/asic_regs.h>
+#include <asm/mach-powertv/powertv-prealloc.h>
 
 static DEFINE_RAW_SPINLOCK(asic_irq_lock);
 
@@ -98,6 +99,7 @@ void __init arch_init_irq(void)
 {
 	int i;
 
+	plat_resource_init();
 	asic_irq_init();
 
 	/*
diff --git a/arch/mips/powertv/asic/painting.c b/arch/mips/powertv/asic/painting.c
new file mode 100644
index 0000000..306622e
--- /dev/null
+++ b/arch/mips/powertv/asic/painting.c
@@ -0,0 +1,298 @@
+/*
+ *				painting.c
+ *
+ * Functions that allow assigning "paints" (really, arbitrary tokens) to
+ * different areas of a "painting". This is useful for keeping track of
+ * the usage of given chunks of memory or I/O devices. Areas are
+ * described using phys_addr_t values to keep the representation as
+ * abstract as possible. Areas are not intended to wrap around the value
+ * space, e.g. if an area starts at zero, it won't be consolidated with an area
+ * of the same color ending at ~0.
+ *
+ * Copyright (C) 2008  Scientific-Atlanta, Inc.
+ * Copyright (C) 2010  Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * Author: David VomLehn
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <asm/mach-powertv/painting.h>
+
+/**
+ * painting_link - link a &painting_area into a &painting
+ * @this:	Pointer to &struct painting in which to add the
+ *		&struct painting_area
+ * @new:	Pointer to the &struct painting area to add
+ *
+ * Returns zero on success or a negative errno value on error
+ */
+static int painting_link(struct painting *this, struct painting_area *new)
+{
+	struct rb_node **n = &(this->root.rb_node), *parent = NULL;
+
+	while (*n) {
+		struct painting_area *this;
+		phys_addr_t p;
+
+		this = container_of(*n, struct painting_area, node);
+		parent = *n;
+		p = new->desc.p;
+
+		if (p < this->desc.p)
+			n = &((*n)->rb_left);
+		else if (p > this->desc.p)
+			n = &((*n)->rb_right);
+		else
+			return false;
+	}
+
+	rb_link_node(&new->node, parent, n);
+	rb_insert_color(&new->node, &this->root);
+
+	return true;
+}
+
+/**
+ * find_neighbor - find a neighbor close to the beginning of a &painting_area
+ * @this:	Pointer to the &struct painting we are coloring
+ * @p:		Location the area about which we are search starts
+ *
+ * Returns NULL if it didn't find anything at all. Otherwise it returns
+ * either a pointer to the last &struct painting_area before @p or, if
+ * there wasn't one, a pointer to the first &struct painting_area after p.
+ */
+struct painting_area *find_neighbor(const struct painting *this,
+	phys_addr_t p)
+{
+	struct rb_node *n = this->root.rb_node;
+	struct rb_node *parent;
+	struct painting_area *parent_area = NULL;
+
+	while (n) {
+		parent = n;
+		parent_area = container_of(n, struct painting_area, node);
+
+		if (p < parent_area->desc.p)
+			n = n->rb_left;
+		else if (p > parent_area->desc.p)
+			n = n->rb_right;
+		else
+			n = NULL;
+	}
+
+	if (parent_area != NULL && parent_area->desc.p > p) {
+		struct painting_area *right;
+		right = painting_prev(parent_area);
+		if (right != NULL)
+			parent_area = right;
+	}
+
+	return parent_area;
+}
+
+/**
+ * painting_unlink - remove an area from the tree
+ * @this:	Pointer to the &struct painting in which we are working
+ * @area:	Start of the &struct painting_area
+ */
+static void painting_unlink(struct painting *this,
+	struct painting_area *cur)
+{
+	rb_erase(&cur->node, &this->root);
+}
+
+/**
+ * make_a_hole - create a hole for new area in current area
+ * @this:	Pointer &struct painting
+ * @cur:	Pointer to current &pointer_area. This might be NULL if we're
+ *		all done.
+ * @new:	Starting location of new area. This has not yet been linked
+ * @tail:	Newly allocated &struct painting_area to hold the end of the
+ *		current area
+ *
+ * Returns zero on success, a negative errno value on failure.
+ */
+static int make_a_hole(struct painting *this,
+	struct painting_desc *cur, struct painting_desc *new,
+	struct painting_area *tail)
+{
+	int retval;
+
+	if (tail == NULL)
+		retval = -ENOMEM;
+	else {
+		tail->desc.p = new->q + 1;
+		tail->desc.q = cur->q;
+		tail->desc.color = cur->color;
+		painting_link(this, tail);
+
+		cur->q = new->p - 1;
+		retval = 0;
+	}
+
+	return retval;
+}
+
+/**
+ * extend_new - extend a new painting area, discarding an overlapping area
+ * @this:	Pointer to a &struct painting in which we are working
+ * @cur:	Pointer to the &struct painting_area for the overlapping
+ *		area to be discarded
+ * @new:	Pointer to the &struct painting_desc of an area to be extended
+ */
+static void extend_new(struct painting *this, struct painting_area *cur,
+	struct painting_desc *new)
+{
+	new->p = cur->desc.p;
+	painting_unlink(this, cur);
+}
+
+/**
+ * chop_cur - truncate an area current in the list
+ * @cur:	Pointer to a &struct painting_area for an area in the list
+ * @new:	New area that overwrites the current area
+ */
+static void chop_cur(struct painting_area *cur, const struct painting_desc *new)
+{
+	cur->desc.q = new->p - 1;
+}
+
+/**
+ * painting_do_prev_overlaps_and_abuts - handle previous that overlaps or abuts
+ * @this:	Pointer to &struct painting on which we're working
+ * @cur:	Pointer to &struct painting_area for the current area
+ * @new:	Pointer to the &struct painting_desc for the current area
+ * @tail:	Pointer to storage alloted for the left side of the hole made
+ *		in the current area by the new area
+ *
+ * Returns an ERR_PTR if an error occurred, a non-NULL pointer of we have
+ * a &struct painting_area to free, and a NULL pointer otherwise.
+ *
+ * Here we handle a current area that is overlapping and before
+ * the new area. There are four cases:
+ * Cur	RRRRRR          RRRRRRRRRR	RRRRRR		RRRRRRRR
+ * New	  bbbbbb	  bbbbbb	  RRRRRR	  RRRR
+ * Res	RRbbbbbb	RRbbbbbbRR	RRRRRRRR	RRRRRRRR
+ * Rslt	New+Cur		Cur+New+Head	Cur		Cur
+ * Done	No		Yes		No		Yes
+ */
+struct painting_area *
+	painting_do_prev_overlaps_and_abuts(struct painting *this,
+	struct painting_area *cur, struct painting_desc *new,
+	struct painting_area *tail)
+{
+	struct painting_area *free_me = NULL;
+	int retval;
+
+	switch (classify(&cur->desc, new)) {
+	case MISMATCH_CUR_ENDS_FIRST:
+		chop_cur(cur, new);
+		break;
+
+	case MISMATCH_CUR_ENDS_LAST:
+		retval = make_a_hole(this, &cur->desc, new, tail);
+		if (retval != 0)
+			free_me = ERR_PTR(retval);
+		break;
+
+	case MATCH_CUR_ENDS_FIRST:
+		extend_new(this, cur, new);
+		free_me = cur;
+		break;
+
+	case MATCH_CUR_ENDS_LAST:
+		/* Nothing to do since all of the new area is already the same
+		 * color as the current area. */
+		break;
+	}
+
+	return free_me;
+}
+
+/**
+ * do_successor - do an area at or following the new area
+ * @this:	Pointer to the &struct painting we're working on
+ * @cur:	Current area in the area list
+ * @new:	Pointer to the &struct painting_desc we're trying to add
+ *
+ * Returns a pointer to a &struct painting_area if it needs to be freed,
+ * otherwise it returns NULL.
+ */
+struct painting_area *do_successor(struct painting *this,
+	struct painting_area *cur, struct painting_desc *new)
+{
+	struct painting_area *retval = NULL;
+
+	/*
+	 * Every remaining area starts after the new area. Cases are therefore
+	 * Cur	RRRRRR		RRRRRRRR	RRRRRR		RRRRRRRR
+	 * New	bbbbbbbb	bbbbbb		RRRRRRRR	RRRRRR
+	 * Res	bbbbbbbb	bbbbbbRR	RRRRRRRR	RRRRRRRR
+	 * Name	past end	before end	overpaint	extend
+	 * Rslt	New+Cur		New		New		New
+	 */
+	switch (classify(&cur->desc, new)) {
+	case MISMATCH_CUR_ENDS_FIRST:
+		painting_unlink(this, cur);
+		retval = cur;
+		break;
+
+	case MISMATCH_CUR_ENDS_LAST:
+		painting_unlink(this, cur);
+		cur->desc.p = new->q + 1;
+		painting_link(this, cur);
+		break;
+
+	case MATCH_CUR_ENDS_FIRST:
+		painting_unlink(this, cur);
+		retval = cur;
+		break;
+
+	case MATCH_CUR_ENDS_LAST:
+		new->q = cur->desc.q;
+		painting_unlink(this, cur);
+		retval = cur;
+		break;
+	}
+
+	return retval;
+}
+
+/**
+ * finish_new_allocation - finish the work for add an area to the list
+ * @this:	Pointer to the &struct painting on which we are working
+ * @newp:	Pointer to the newly allocated &struct painting_area.
+ * @new:	Pointer to the &struct painting_desc values to be stored
+ *		in the new area
+ *
+ * Returns 0 in success, otherwise a negative errno value
+ */
+int finish_new_allocation(struct painting *this,
+	struct painting_area *newp, struct painting_desc *new)
+{
+	int	retval = 0;
+
+	if (newp == NULL)
+		retval = -ENOMEM;
+	else {
+		newp->desc = *new;
+		painting_link(this, newp);
+	}
+
+	return retval;
+}
diff --git a/arch/mips/powertv/asic/powertv-prealloc.c b/arch/mips/powertv/asic/powertv-prealloc.c
new file mode 100644
index 0000000..1047b5b
--- /dev/null
+++ b/arch/mips/powertv/asic/powertv-prealloc.c
@@ -0,0 +1,136 @@
+/*
+ * Handle platform-specific resources
+ *
+ * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ * Copyright (C) 2009-2010 Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include <linux/init.h>
+#include <asm/mach-powertv/asic.h>
+#include <asm/mach-powertv/powertv-prealloc.h>
+
+static struct dma_resource base_resources[] __initdata = {
+	{0x10000000, 0x10000000 + 0x40000 - 1, physmem_bootloader},
+	{0x1fc00000, 0x1fc00000 + 0x400000 - 1, physmem_reset_vector},
+};
+
+static unsigned long pmemaddr __initdata;
+
+static int __init early_param_pmemaddr(char *p)
+{
+	pmemaddr = (unsigned long)simple_strtoul(p, NULL, 0);
+	return 0;
+}
+early_param("pmemaddr", early_param_pmemaddr);
+
+static long pmemlen __initdata;
+
+static int __init early_param_pmemlen(char *p)
+{
+/* TODO: we can use this code when and if the bootloader ever changes this */
+#if 0
+	pmemlen = (unsigned long)simple_strtoul(p, NULL, 0);
+#else
+	pmemlen = 0x20000;
+#endif
+	return 0;
+}
+early_param("pmemlen", early_param_pmemlen);
+
+/*
+ * platform_resource_override - override information from platform resources
+ * @plat_res:	Pointer to &struct resource to set if this resource is being
+ *		overridden.
+ * @res:	Pointer to &struct dma_resource to check whether it should be
+ *		overridden.
+ *
+ * Returns true if the resource was overridden and should not be further
+ * processed, false if the resource wasn't overriden and should be processed
+ * as normal.
+ */
+bool __init platform_resource_override(struct resource *plat_res,
+	const struct dma_resource *res)
+{
+	if (strcmp(res->name, "DiagPersistentMemory") == 0) {
+		if (pmemaddr && pmemlen) {
+			/* The address provided by bootloader is in kseg0.
+			 * Convert to a physical address. */
+			plat_res->start = __pa(pmemaddr);
+			plat_res->end = plat_res->start + pmemlen - 1;
+			pr_info("persistent memory: start=0x%0*x  end=0x%0*x\n",
+				2 * sizeof(plat_res->start), plat_res->start,
+				2 * sizeof(plat_res->end), plat_res->end);
+		}
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * dma_resource_count - tallies the number of DMA resources available
+ * @plat_res:	Pointer to an array of &struct dma_resource objects
+ *
+ * Returns the number of non empty entries found
+ */
+static size_t __init dma_resource_count(const struct dma_resource *dma_res)
+{
+	int i;
+	/* Count number of resources */
+	for (i = 0; dma_res[i].flags != 0; i++)
+		;
+	return i;
+}
+
+/**
+ * register_available_ram - give RAM minus preallocations to the sytem
+ */
+void __init register_available_ram()
+{
+	size_t num_plat_res;
+
+	/* Subtract all of the preallocated RAM at a static address */
+	resource_reserve_static_prealloc(ARRAY_SIZE(base_resources),
+		base_resources);
+	num_plat_res = dma_resource_count(gp_resources);
+	resource_reserve_static_prealloc(num_plat_res, gp_resources);
+
+	/* Give all of the remaining RAM to the system */
+	resource_add_memory_regions();
+}
+
+/**
+ * plat_resource_init - request resources for preallocated memory
+ */
+void __init plat_resource_init()
+{
+	size_t size;
+	size_t total = 0;
+	size_t num_plat_res;
+
+	size = resource_request_prealloc(ARRAY_SIZE(base_resources),
+		base_resources);
+	if (size > 0)
+		total += size;
+
+	num_plat_res = dma_resource_count(gp_resources);
+	size = resource_request_prealloc(num_plat_res, gp_resources);
+	if (size > 0)
+		total += size;
+
+	pr_info("Total platform driver memory allocation: 0x%08x\n", total);
+}
diff --git a/arch/mips/powertv/asic/prealloc-calliope.c b/arch/mips/powertv/asic/prealloc-calliope.c
index 3fc5d46..d1ad146 100644
--- a/arch/mips/powertv/asic/prealloc-calliope.c
+++ b/arch/mips/powertv/asic/prealloc-calliope.c
@@ -2,6 +2,7 @@
  * Memory pre-allocations for Calliope boxes.
  *
  * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ * Copyright (C) 2009-2010 Cisco Systems, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -24,12 +25,12 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <asm/mach-powertv/asic.h>
-#include "prealloc.h"
+#include <asm/mach-powertv/powertv-prealloc.h>
 
 /*
  * NON_DVR_CAPABLE CALLIOPE RESOURCES
  */
-struct resource non_dvr_calliope_resources[] __initdata =
+const struct dma_resource non_dvr_calliope_resources[] __initdata =
 {
 	/*
 	 * VIDEO / LX1
@@ -158,7 +159,7 @@ struct resource non_dvr_calliope_resources[] __initdata =
 };
 
 
-struct resource non_dvr_vze_calliope_resources[] __initdata =
+const struct dma_resource non_dvr_vze_calliope_resources[] __initdata =
 {
 	/*
 	 * VIDEO / LX1
@@ -264,7 +265,7 @@ struct resource non_dvr_vze_calliope_resources[] __initdata =
 	},
 };
 
-struct resource non_dvr_vzf_calliope_resources[] __initdata =
+const struct dma_resource non_dvr_vzf_calliope_resources[] __initdata =
 {
 	/*
 	 * VIDEO / LX1
diff --git a/arch/mips/powertv/asic/prealloc-cronus.c b/arch/mips/powertv/asic/prealloc-cronus.c
index c532b50..cd0d034 100644
--- a/arch/mips/powertv/asic/prealloc-cronus.c
+++ b/arch/mips/powertv/asic/prealloc-cronus.c
@@ -2,6 +2,7 @@
  * Memory pre-allocations for Cronus boxes.
  *
  * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ * Copyright (C) 2009-2010 Cisco Systems, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -24,12 +25,12 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <asm/mach-powertv/asic.h>
-#include "prealloc.h"
+#include <asm/mach-powertv/powertv-prealloc.h>
 
 /*
  * DVR_CAPABLE CRONUS RESOURCES
  */
-struct resource dvr_cronus_resources[] __initdata =
+const struct dma_resource dvr_cronus_resources[] __initdata =
 {
 	/*
 	 * VIDEO1 / LX1
@@ -192,7 +193,7 @@ struct resource dvr_cronus_resources[] __initdata =
 /*
  * NON_DVR_CAPABLE CRONUS RESOURCES
  */
-struct resource non_dvr_cronus_resources[] __initdata =
+const struct dma_resource non_dvr_cronus_resources[] __initdata =
 {
 	/*
 	 * VIDEO1 / LX1
diff --git a/arch/mips/powertv/asic/prealloc-cronuslite.c b/arch/mips/powertv/asic/prealloc-cronuslite.c
index b5537e4..851a626 100644
--- a/arch/mips/powertv/asic/prealloc-cronuslite.c
+++ b/arch/mips/powertv/asic/prealloc-cronuslite.c
@@ -2,6 +2,7 @@
  * Memory pre-allocations for Cronus Lite boxes.
  *
  * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ * Copyright (C) 2009-2010 Cisco Sysems, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -24,12 +25,12 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <asm/mach-powertv/asic.h>
-#include "prealloc.h"
+#include <asm/mach-powertv/powertv-prealloc.h>
 
 /*
  * NON_DVR_CAPABLE CRONUSLITE RESOURCES
  */
-struct resource non_dvr_cronuslite_resources[] __initdata =
+const struct dma_resource non_dvr_cronuslite_resources[] __initdata =
 {
 	/*
 	 * VIDEO2 / LX2
diff --git a/arch/mips/powertv/asic/prealloc-gaia.c b/arch/mips/powertv/asic/prealloc-gaia.c
index 8ac8c7a..d3f6694 100644
--- a/arch/mips/powertv/asic/prealloc-gaia.c
+++ b/arch/mips/powertv/asic/prealloc-gaia.c
@@ -2,6 +2,7 @@
  * Memory pre-allocations for Gaia boxes.
  *
  * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ * Copyright (C) 2009-2010 Cisco Sysems, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -22,291 +23,154 @@
 
 #include <linux/init.h>
 #include <asm/mach-powertv/asic.h>
+#include <asm/mach-powertv/powertv-prealloc.h>
 
 /*
  * DVR_CAPABLE GAIA RESOURCES
  */
-struct resource dvr_gaia_resources[] __initdata = {
+const struct dma_resource dvr_gaia_resources[] __initdata = {
 	/*
-	 *
 	 * VIDEO1 / LX1
-	 *
 	 */
-	{
-		.name   = "ST231aImage",	/* Delta-Mu 1 image and ram */
-		.start  = 0x24000000,
-		.end    = 0x241FFFFF,		/* 2MiB */
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ST231aMonitor",	/* 8KiB block ST231a monitor */
-		.start  = 0x24200000,
-		.end    = 0x24201FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "MediaMemory1",
-		.start  = 0x24202000,
-		.end    = 0x25FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* Delta-Mu 1 image and RAM (2 MiB) */
+	PREALLOC_NORMAL("ST231aImage", 0x24000000, 0x241FFFFF, IORESOURCE_MEM)
+	/* 8KiB block ST231a monitor */
+	PREALLOC_NORMAL("ST231aMonitor", 0x24200000, 0x24201FFF, IORESOURCE_MEM)
+	/*~29.9MiB (32MiB - (2MiB + 8KiB)) */
+	PREALLOC_NORMAL("MediaMemory1", 0x24202000, 0x25FFFFFF, IORESOURCE_MEM)
 	/*
-	 *
 	 * VIDEO2 / LX2
-	 *
 	 */
-	{
-		.name   = "ST231bImage",	/* Delta-Mu 2 image and ram */
-		.start  = 0x60000000,
-		.end    = 0x601FFFFF,		/* 2MiB */
-		.flags  = IORESOURCE_IO,
-	},
-	{
-		.name   = "ST231bMonitor",	/* 8KiB block ST231b monitor */
-		.start  = 0x60200000,
-		.end    = 0x60201FFF,
-		.flags  = IORESOURCE_IO,
-	},
-	{
-		.name   = "MediaMemory2",
-		.start  = 0x60202000,
-		.end    = 0x61FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
-		.flags  = IORESOURCE_IO,
-	},
+	/* Delta-Mu 2 image and RAM (2 MiB)*/
+	PREALLOC_NORMAL("ST231bImage", 0x60000000, 0x601FFFFF, IORESOURCE_IO)
+	/* 8KiB block ST231b monitor */
+	PREALLOC_NORMAL("ST231bMonitor", 0x60200000, 0x60201FFF, IORESOURCE_IO)
+	/*~29.9MiB (32MiB - (2MiB + 8KiB)) */
+	PREALLOC_NORMAL("MediaMemory2", 0x60202000, 0x61FFFFFF, IORESOURCE_IO)
 	/*
-	 *
 	 * Sysaudio Driver
-	 *
 	 * This driver requires:
-	 *
 	 * Arbitrary Based Buffers:
 	 *  DSP_Image_Buff - DSP code and data images (1MB)
 	 *  ADSC_CPU_PCM_Buff - ADSC CPU PCM buffer (40KB)
 	 *  ADSC_AUX_Buff - ADSC AUX buffer (16KB)
 	 *  ADSC_Main_Buff - ADSC Main buffer (16KB)
-	 *
 	 */
-	{
-		.name   = "DSP_Image_Buff",
-		.start  = 0x00000000,
-		.end    = 0x000FFFFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_CPU_PCM_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00009FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_AUX_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00003FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_Main_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00003FFF,
-		.flags  = IORESOURCE_MEM,
-	},
+	PREALLOC_NORMAL("DSP_Image_Buff", 0x00000000, 0x000FFFFF,
+		IORESOURCE_MEM)
+	PREALLOC_NORMAL("ADSC_CPU_PCM_Buff", 0x00000000, 0x00009FFF,
+		IORESOURCE_MEM)
+	PREALLOC_NORMAL("ADSC_AUX_Buff", 0x00000000, 0x00003FFF, IORESOURCE_MEM)
+	PREALLOC_NORMAL("ADSC_Main_Buff", 0x00000000, 0x00003FFF,
+		IORESOURCE_MEM)
 	/*
-	 *
 	 * STAVEM driver/STAPI
-	 *
 	 * This driver requires:
-	 *
 	 * Arbitrary Based Buffers:
 	 *  This memory area is used for allocating buffers for Video decoding
 	 *  purposes.  Allocation/De-allocation within this buffer is managed
 	 *  by the STAVMEM driver of the STAPI.  They could be Decimated
 	 *  Picture Buffers, Intermediate Buffers, as deemed necessary for
 	 *  video decoding purposes, for any video decoders on Zeus.
-	 *
 	 */
-	{
-		.name   = "AVMEMPartition0",
-		.start  = 0x63580000,
-		.end    = 0x64180000 - 1,  /* 12 MB total */
-		.flags  = IORESOURCE_IO,
-	},
+	/* 12 MB total */
+	PREALLOC_NORMAL("AVMEMPartition0", 0x63580000, 0x64180000 - 1,
+		IORESOURCE_IO)
 	/*
-	 *
 	 * DOCSIS Subsystem
-	 *
 	 * This driver requires:
-	 *
 	 * Arbitrary Based Buffers:
 	 *  Docsis -
-	 *
 	 */
-	{
-		.name   = "Docsis",
-		.start  = 0x62000000,
-		.end    = 0x62700000 - 1,	/* 7 MB total */
-		.flags  = IORESOURCE_IO,
-	},
+	/* 7 MB total */
+	PREALLOC_DOCSIS("Docsis", 0x62000000, 0x62700000 - 1, IORESOURCE_IO)
 	/*
-	 *
 	 * GHW HAL Driver
-	 *
 	 * This driver requires:
-	 *
 	 * Arbitrary Based Buffers:
 	 *  GraphicsHeap - PowerTV Graphics Heap
-	 *
 	 */
-	{
-		.name   = "GraphicsHeap",
-		.start  = 0x62700000,
-		.end    = 0x63500000 - 1,	/* 14 MB total */
-		.flags  = IORESOURCE_IO,
-	},
+	/* 14 MB total */
+	PREALLOC_NORMAL("GraphicsHeap", 0x62700000, 0x63500000 - 1,
+		IORESOURCE_IO)
 	/*
-	 *
 	 * multi com buffer area
-	 *
 	 * This driver requires:
-	 *
 	 * Arbitrary Based Buffers:
 	 *  Docsis -
-	 *
 	 */
-	{
-		.name   = "MulticomSHM",
-		.start  = 0x26000000,
-		.end    = 0x26020000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	PREALLOC_NORMAL("MulticomSHM", 0x26000000, 0x26020000 - 1,
+		IORESOURCE_MEM)
 	/*
-	 *
 	 * DMA Ring buffer
-	 *
 	 * This driver requires:
-	 *
 	 * Arbitrary Based Buffers:
 	 *  Docsis -
-	 *
 	 */
-	{
-		.name   = "BMM_Buffer",
-		.start  = 0x00000000,
-		.end    = 0x00280000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	PREALLOC_NORMAL("BMM_Buffer", 0x00000000, 0x00280000 - 1,
+		IORESOURCE_MEM)
 	/*
-	 *
 	 * Display bins buffer for unit0
-	 *
 	 * This driver requires:
-	 *
 	 * Arbitrary Based Buffers:
 	 *  Display Bins for unit0
-	 *
 	 */
-	{
-		.name   = "DisplayBins0",
-		.start  = 0x00000000,
-		.end    = 0x00000FFF,		/* 4 KB total */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 4 KB total */
+	PREALLOC_NORMAL("DisplayBins0", 0x00000000, 0x00000FFF, IORESOURCE_MEM)
 	/*
-	 *
 	 * Display bins buffer
-	 *
 	 * This driver requires:
-	 *
 	 * Arbitrary Based Buffers:
 	 *  Display Bins for unit1
-	 *
 	 */
-	{
-		.name   = "DisplayBins1",
-		.start  = 0x64AD4000,
-		.end    = 0x64AD5000 - 1,  /* 4 KB total */
-		.flags  = IORESOURCE_IO,
-	},
+	 /* 4 KB total */
+	PREALLOC_NORMAL("DisplayBins1", 0x64AD4000, 0x64AD5000 - 1,
+		IORESOURCE_IO)
 	/*
-	 *
 	 * ITFS
-	 *
 	 * This driver requires:
-	 *
 	 * Arbitrary Based Buffers:
 	 *  Docsis -
-	 *
 	 */
-	{
-		.name   = "ITFS",
-		.start  = 0x64180000,
-		/* 815,104 bytes each for 2 ITFS partitions. */
-		.end    = 0x6430DFFF,
-		.flags  = IORESOURCE_IO,
-	},
+	/* 815, 104 bytes each for 2 ITFS partitions. */
+	PREALLOC_NORMAL("ITFS", 0x64180000, 0x6430DFFF, IORESOURCE_IO)
 	/*
-	 *
 	 * AVFS
-	 *
 	 * This driver requires:
-	 *
 	 * Arbitrary Based Buffers:
 	 *  Docsis -
-	 *
 	 */
-	{
-		.name   = "AvfsDmaMem",
-		.start  = 0x6430E000,
-		/* (945K * 8) = (128K *3) 5 playbacks / 3 server */
-		.end    = 0x64AD0000 - 1,
-		.flags  = IORESOURCE_IO,
-	},
-	{
-		.name   = "AvfsFileSys",
-		.start  = 0x64AD0000,
-		.end    = 0x64AD1000 - 1,  /* 4K */
-		.flags  = IORESOURCE_IO,
-	},
+	/* (945K * 8) = (128K *3) 5 playbacks / 3 server */
+	PREALLOC_NORMAL("AvfsDmaMem", 0x6430E000, 0x64AD0000 - 1, IORESOURCE_IO)
+	/* 4K */
+	PREALLOC_NORMAL("AvfsFileSys", 0x64AD0000, 0x64AD1000 - 1,
+		IORESOURCE_IO)
+	/*
+	 * PMEM
+	 * This driver requires:
+	 * Arbitrary Based Buffers:
+	 *  Persistent memory for diagnostics.
+	 */
+	PREALLOC_PMEM("DiagPersistentMemory", 0x00000000, 0x10000 - 1,
+		IORESOURCE_MEM)
 	/*
-	 *
 	 * Smartcard
-	 *
 	 * This driver requires:
-	 *
 	 * Arbitrary Based Buffers:
 	 *  Read and write buffers for Internal/External cards
-	 *
 	 */
-	{
-		.name   = "SmartCardInfo",
-		.start  = 0x64AD1000,
-		.end    = 0x64AD3800 - 1,
-		.flags  = IORESOURCE_IO,
-	},
+	PREALLOC_NORMAL("SmartCardInfo", 0x64AD1000, 0x64AD3800 - 1,
+		IORESOURCE_IO)
 	/*
-	 *
 	 * KAVNET
 	 *    NP Reset Vector - must be of the form xxCxxxxx
 	 *	   NP Image - must be video bank 1
 	 *	   NP IPC - must be video bank 2
 	 */
-	{
-		.name   = "NP_Reset_Vector",
-		.start  = 0x27c00000,
-		.end    = 0x27c01000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "NP_Image",
-		.start  = 0x27020000,
-		.end    = 0x27060000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "NP_IPC",
-		.start  = 0x63500000,
-		.end    = 0x63580000 - 1,
-		.flags  = IORESOURCE_IO,
-	},
+	PREALLOC_NORMAL("NP_Reset_Vector", 0x27c00000, 0x27c01000 - 1,
+		IORESOURCE_MEM)
+	PREALLOC_NORMAL("NP_Image", 0x27020000, 0x27060000 - 1, IORESOURCE_MEM)
+	PREALLOC_NORMAL("NP_IPC", 0x63500000, 0x63580000 - 1, IORESOURCE_IO)
 	/*
 	 * Add other resources here
 	 */
@@ -316,274 +180,134 @@ struct resource dvr_gaia_resources[] __initdata = {
 /*
  * NON_DVR_CAPABLE GAIA RESOURCES
  */
-struct resource non_dvr_gaia_resources[] __initdata = {
+const struct dma_resource non_dvr_gaia_resources[] __initdata = {
 	/*
-	 *
 	 * VIDEO1 / LX1
-	 *
 	 */
-	{
-		.name   = "ST231aImage",	/* Delta-Mu 1 image and ram */
-		.start  = 0x24000000,
-		.end    = 0x241FFFFF,		/* 2MiB */
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ST231aMonitor",	/* 8KiB block ST231a monitor */
-		.start  = 0x24200000,
-		.end    = 0x24201FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "MediaMemory1",
-		.start  = 0x24202000,
-		.end    = 0x25FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* Delta-Mu 1 image and ram (2 MiB) */
+	PREALLOC_NORMAL("ST231aImage", 0x24000000, 0x241FFFFF, IORESOURCE_MEM)
+	/* 8KiB block ST231a monitor */
+	PREALLOC_NORMAL("ST231aMonitor", 0x24200000, 0x24201FFF, IORESOURCE_MEM)
+	/*~29.9MiB (32MiB - (2MiB + 8KiB)) */
+	PREALLOC_NORMAL("MediaMemory1", 0x24202000, 0x25FFFFFF, IORESOURCE_MEM)
 	/*
-	 *
 	 * VIDEO2 / LX2
-	 *
 	 */
-	{
-		.name   = "ST231bImage",	/* Delta-Mu 2 image and ram */
-		.start  = 0x60000000,
-		.end    = 0x601FFFFF,		/* 2MiB */
-		.flags  = IORESOURCE_IO,
-	},
-	{
-		.name   = "ST231bMonitor",	/* 8KiB block ST231b monitor */
-		.start  = 0x60200000,
-		.end    = 0x60201FFF,
-		.flags  = IORESOURCE_IO,
-	},
-	{
-		.name   = "MediaMemory2",
-		.start  = 0x60202000,
-		.end    = 0x61FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
-		.flags  = IORESOURCE_IO,
-	},
+	/* Delta-Mu 2 image and ram (2 MiB)*/
+	PREALLOC_NORMAL("ST231bImage", 0x60000000, 0x601FFFFF, IORESOURCE_IO)
+	/* 8KiB block ST231b monitor */
+	PREALLOC_NORMAL("ST231bMonitor", 0x60200000, 0x60201FFF, IORESOURCE_IO)
+	/*~29.9MiB (32MiB - (2MiB + 8KiB)) */
+	PREALLOC_NORMAL("MediaMemory2", 0x60202000, 0x61FFFFFF, IORESOURCE_IO)
 	/*
-	 *
 	 * Sysaudio Driver
-	 *
 	 * This driver requires:
-	 *
 	 * Arbitrary Based Buffers:
 	 *  DSP_Image_Buff - DSP code and data images (1MB)
 	 *  ADSC_CPU_PCM_Buff - ADSC CPU PCM buffer (40KB)
 	 *  ADSC_AUX_Buff - ADSC AUX buffer (16KB)
 	 *  ADSC_Main_Buff - ADSC Main buffer (16KB)
-	 *
 	 */
-	{
-		.name   = "DSP_Image_Buff",
-		.start  = 0x00000000,
-		.end    = 0x000FFFFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_CPU_PCM_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00009FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_AUX_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00003FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_Main_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00003FFF,
-		.flags  = IORESOURCE_MEM,
-	},
+	PREALLOC_NORMAL("DSP_Image_Buff", 0x00000000, 0x000FFFFF,
+		IORESOURCE_MEM)
+	PREALLOC_NORMAL("ADSC_CPU_PCM_Buff", 0x00000000, 0x00009FFF,
+		IORESOURCE_MEM)
+	PREALLOC_NORMAL("ADSC_AUX_Buff", 0x00000000, 0x00003FFF, IORESOURCE_MEM)
+	PREALLOC_NORMAL("ADSC_Main_Buff", 0x00000000, 0x00003FFF,
+		IORESOURCE_MEM)
 	/*
-	 *
 	 * STAVEM driver/STAPI
-	 *
 	 * This driver requires:
-	 *
 	 * Arbitrary Based Buffers:
 	 *  This memory area is used for allocating buffers for Video decoding
 	 *  purposes.  Allocation/De-allocation within this buffer is managed
 	 *  by the STAVMEM driver of the STAPI.  They could be Decimated
 	 *  Picture Buffers, Intermediate Buffers, as deemed necessary for
 	 *  video decoding purposes, for any video decoders on Zeus.
-	 *
 	 */
-	{
-		.name   = "AVMEMPartition0",
-		.start  = 0x63580000,
-		.end    = 0x64180000 - 1,  /* 12 MB total */
-		.flags  = IORESOURCE_IO,
-	},
+	/* 12 MB total */
+	PREALLOC_NORMAL("AVMEMPartition0", 0x63580000, 0x64180000 - 1,
+		IORESOURCE_IO)
 	/*
-	 *
 	 * DOCSIS Subsystem
-	 *
 	 * This driver requires:
-	 *
 	 * Arbitrary Based Buffers:
 	 *  Docsis -
-	 *
 	 */
-	{
-		.name   = "Docsis",
-		.start  = 0x62000000,
-		.end    = 0x62700000 - 1,	/* 7 MB total */
-		.flags  = IORESOURCE_IO,
-	},
+	/* 7 MB total */
+	PREALLOC_DOCSIS("Docsis", 0x62000000, 0x62700000 - 1, IORESOURCE_IO)
 	/*
-	 *
 	 * GHW HAL Driver
-	 *
 	 * This driver requires:
-	 *
 	 * Arbitrary Based Buffers:
 	 *  GraphicsHeap - PowerTV Graphics Heap
-	 *
 	 */
-	{
-		.name   = "GraphicsHeap",
-		.start  = 0x62700000,
-		.end    = 0x63500000 - 1,	/* 14 MB total */
-		.flags  = IORESOURCE_IO,
-	},
+	/* 14 MB total */
+	PREALLOC_NORMAL("GraphicsHeap", 0x62700000, 0x63500000 - 1,
+		IORESOURCE_IO)
 	/*
-	 *
 	 * multi com buffer area
-	 *
 	 * This driver requires:
-	 *
 	 * Arbitrary Based Buffers:
 	 *  Docsis -
-	 *
 	 */
-	{
-		.name   = "MulticomSHM",
-		.start  = 0x26000000,
-		.end    = 0x26020000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	PREALLOC_NORMAL("MulticomSHM", 0x26000000, 0x26020000 - 1,
+		IORESOURCE_MEM)
 	/*
-	 *
 	 * DMA Ring buffer
-	 *
 	 * This driver requires:
-	 *
 	 * Arbitrary Based Buffers:
 	 *  Docsis -
-	 *
 	 */
-	{
-		.name   = "BMM_Buffer",
-		.start  = 0x00000000,
-		.end    = 0x000AA000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	PREALLOC_NORMAL("BMM_Buffer", 0x00000000, 0x000AA000 - 1,
+		IORESOURCE_MEM)
 	/*
-	 *
 	 * Display bins buffer for unit0
-	 *
 	 * This driver requires:
-	 *
 	 * Arbitrary Based Buffers:
 	 *  Display Bins for unit0
-	 *
 	 */
-	{
-		.name   = "DisplayBins0",
-		.start  = 0x00000000,
-		.end    = 0x00000FFF,		/* 4 KB total */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 4 KB total */
+	PREALLOC_NORMAL("DisplayBins0", 0x00000000, 0x00000FFF, IORESOURCE_MEM)
 	/*
-	 *
 	 * Display bins buffer
-	 *
 	 * This driver requires:
-	 *
 	 * Arbitrary Based Buffers:
 	 *  Display Bins for unit1
-	 *
 	 */
-	{
-		.name   = "DisplayBins1",
-		.start  = 0x64AD4000,
-		.end    = 0x64AD5000 - 1,  /* 4 KB total */
-		.flags  = IORESOURCE_IO,
-	},
+	/* 4 KB total */
+	PREALLOC_NORMAL("DisplayBins1", 0x64AD4000, 0x64AD5000 - 1,
+		IORESOURCE_IO)
 	/*
-	 *
 	 * AVFS: player HAL memory
-	 *
-	 *
 	 */
-	{
-		.name   = "AvfsDmaMem",
-		.start  = 0x6430E000,
-		.end    = 0x645D2C00 - 1,  /* 945K * 3 for playback */
-		.flags  = IORESOURCE_IO,
-	},
+	/* 945K * 3 for playback */
+	PREALLOC_NORMAL("AvfsDmaMem", 0x6430E000, 0x645D2C00 - 1, IORESOURCE_IO)
 	/*
-	 *
 	 * PMEM
-	 *
 	 * This driver requires:
-	 *
 	 * Arbitrary Based Buffers:
 	 *  Persistent memory for diagnostics.
-	 *
 	 */
-	{
-		.name   = "DiagPersistentMemory",
-		.start  = 0x00000000,
-		.end    = 0x10000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	PREALLOC_PMEM("DiagPersistentMemory", 0x00000000, 0x10000 - 1,
+		IORESOURCE_MEM)
 	/*
-	 *
 	 * Smartcard
-	 *
 	 * This driver requires:
-	 *
 	 * Arbitrary Based Buffers:
 	 *  Read and write buffers for Internal/External cards
-	 *
 	 */
-	{
-		.name   = "SmartCardInfo",
-		.start  = 0x64AD1000,
-		.end    = 0x64AD3800 - 1,
-		.flags  = IORESOURCE_IO,
-	},
+	PREALLOC_NORMAL("SmartCardInfo", 0x64AD1000, 0x64AD3800 - 1,
+		IORESOURCE_IO)
 	/*
-	 *
 	 * KAVNET
 	 *    NP Reset Vector - must be of the form xxCxxxxx
 	 *	   NP Image - must be video bank 1
 	 *	   NP IPC - must be video bank 2
 	 */
-	{
-		.name   = "NP_Reset_Vector",
-		.start  = 0x27c00000,
-		.end    = 0x27c01000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "NP_Image",
-		.start  = 0x27020000,
-		.end    = 0x27060000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "NP_IPC",
-		.start  = 0x63500000,
-		.end    = 0x63580000 - 1,
-		.flags  = IORESOURCE_IO,
-	},
+	PREALLOC_NORMAL("NP_Reset_Vector", 0x27c00000, 0x27c01000 - 1,
+		IORESOURCE_MEM)
+	PREALLOC_NORMAL("NP_Image", 0x27020000, 0x27060000 - 1, IORESOURCE_MEM)
+	PREALLOC_NORMAL("NP_IPC", 0x63500000, 0x63580000 - 1, IORESOURCE_IO)
 	{ },
 };
diff --git a/arch/mips/powertv/asic/prealloc-zeus.c b/arch/mips/powertv/asic/prealloc-zeus.c
index 96480a2..0212f89 100644
--- a/arch/mips/powertv/asic/prealloc-zeus.c
+++ b/arch/mips/powertv/asic/prealloc-zeus.c
@@ -2,6 +2,7 @@
  * Memory pre-allocations for Zeus boxes.
  *
  * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ * Copyright (C) 2009-2010 Cisco Sysems, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -24,12 +25,12 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <asm/mach-powertv/asic.h>
-#include "prealloc.h"
+#include <asm/mach-powertv/powertv-prealloc.h>
 
 /*
  * DVR_CAPABLE RESOURCES
  */
-struct resource dvr_zeus_resources[] __initdata =
+const struct dma_resource dvr_zeus_resources[] __initdata =
 {
 	/*
 	 * VIDEO1 / LX1
@@ -182,7 +183,7 @@ struct resource dvr_zeus_resources[] __initdata =
 /*
  * NON_DVR_CAPABLE ZEUS RESOURCES
  */
-struct resource non_dvr_zeus_resources[] __initdata =
+const struct dma_resource non_dvr_zeus_resources[] __initdata =
 {
 	/*
 	 * VIDEO1 / LX1
diff --git a/arch/mips/powertv/asic/prealloc.c b/arch/mips/powertv/asic/prealloc.c
new file mode 100644
index 0000000..f2b63aa
--- /dev/null
+++ b/arch/mips/powertv/asic/prealloc.c
@@ -0,0 +1,566 @@
+/*
+ *
+ * Description:  Preallocate large chunks of memory for drivers
+ *
+ * Copyright (C) 2005-2010 Scientific-Atlanta, Inc.
+ * Copyright (C) 2009-2010 Cisco Sysems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <asm/bootinfo.h>
+#include <asm/mach-powertv/powertv-prealloc.h>
+#include <asm/mach-powertv/asic.h>
+
+/*
+ * Type Definitions
+ */
+
+const struct dma_resource *gp_resources __initdata;
+
+/* Definitions for physical memory area information. We don't have
+ * kmalloc working at this point. In fact, we don't even have the boot
+ * memory allocator, so we have no choice but to use a static allocation.
+ * In the best of all possible worlds, we might have a way to switch to
+ * the boot memory allocator, and then the slab/slob/slub allocator when
+ * they become available, but this probably isn't really worth the effort. */
+struct alloc_item {
+	struct list_head	free_areas;
+	struct painting_area	area;
+};
+
+static struct alloc_item areas[CONFIG_PREALLOCATED_AREAS_ITEMS] __initdata;
+
+static LIST_HEAD(free_areas);		/* List of avail. area allocations */
+static int areas_unallocated = ARRAY_SIZE(areas); /* # never-allocated areas */
+static loff_t	num_areas;		/* Current count of areas */
+static bool	alloc_errors;		/* Flag to indicate faulty data */
+static PAINTING(ram_painting);
+
+/*
+ * Allocate a painting_area. We do the allocation so early that we can't
+ * count on running any code to initialize the list of free areas, so we
+ * also have a counter of the number of items unused in the array of areas.
+ *
+ * Returns:	Pointer to a struct painting_area, or NULL if none is
+ * available.
+ */
+static __init struct painting_area *physmem_alloc(void)
+{
+	struct alloc_item	*item;
+	struct painting_area	*result;
+
+	/* First use anything in the areas array that hasn't been used. If
+	 * that fails, then go to our list of free areas. */
+	if (areas_unallocated != 0) {
+		areas_unallocated--;
+		item = &areas[areas_unallocated];
+	} else if (!list_empty(&free_areas)) {
+		item = list_first_entry(&free_areas, struct alloc_item,
+			free_areas);
+		list_del(&item->free_areas);
+	}
+
+	else
+		item = NULL;
+
+	/* If we failed to allocate something, then log it and return NULL.
+	 * Otherwise, return a pointer to the painting_area portion */
+	if (!item) {
+		alloc_errors = true;
+		result = NULL;
+	} else {
+		result = &item->area;
+		num_areas++;
+	}
+
+	return result;
+}
+
+/*
+ * Free a painting area
+ * @p:		Pointer to struct painting_area to free
+ */
+static __init void physmem_free(const struct painting_area *p)
+{
+	struct alloc_item	*item;
+
+	item = container_of(p, struct alloc_item, area);
+	list_add(&item->free_areas, &free_areas);
+	num_areas--;
+}
+
+/*
+ * mem_painting_add - add a painting area to a painting
+ * @this:	Pointer to the &struct painting on which we are working
+ * @desc:	Pointer to a &struct painting_desc to add.
+ *
+ * Returns zere on success, otherwise a negative errno value
+ *
+ * The approach is to start with the area preceeding the new area, then any
+ * areas that start at the same place as the new area, then all of rest of
+ * areas that start before, at, or right after the end of the new area.
+ */
+int __init mem_painting_add(struct painting *this,
+	const struct painting_desc *new_desc)
+{
+	struct painting_area *newp;	/* Area we are adding */
+	struct painting_area *cur;	/* Current area we are working on */
+	struct painting_area *next;
+	struct painting_desc new;
+	int retval = 0;
+	bool add_new = true;
+
+	new = *new_desc;		/* Make a copy so we can modify these */
+	cur = find_neighbor(this, new.p);
+
+	if (painting_have_prev(cur, &new)) {
+		next = painting_next(cur);
+
+		if (painting_prev_overlaps_or_abuts(&cur->desc, &new)) {
+			struct painting_area *tail;
+			struct painting_area *free_me;
+
+			tail = painting_must_make_hole(&cur->desc, &new) ?
+				physmem_alloc() : NULL;
+			free_me = painting_do_prev_overlaps_and_abuts(this,
+				cur, &new, tail);
+			if (IS_ERR(free_me))
+				retval = PTR_ERR(free_me);
+			else if (free_me != NULL)
+				physmem_free(free_me);
+			add_new = painting_add_area(&cur->desc, &new);
+		}
+
+		cur = next;
+	}
+
+	/* TODO: Ensure proper handling of wrap-around of value space here */
+	while (retval == 0 && cur != NULL && cur->desc.p <= new.q + 1) {
+		struct painting_area *ret;
+
+		ret = do_successor(this, cur, &new);
+		if (ret != NULL)
+			physmem_free(ret);
+
+		cur = painting_next(cur);
+	}
+
+	/*
+	 * If the new area wasn't subsumed by another area, we need to allocate
+	 * storage for it and line it in.
+	 */
+	if (retval == 0 && add_new) {
+		newp = physmem_alloc();
+		retval = finish_new_allocation(this, newp, &new);
+	}
+
+	return retval;
+}
+
+/**
+ * resource_add_ram - add actual RAM
+ * @start:	Physical address of the start of RAM
+ * @end:	Physical address of the last byte of RAM
+ *
+ * Returns zero on success, a negative errno value on failure
+ */
+int __init resource_add_ram(phys_addr_t start, phys_addr_t end)
+{
+	struct painting_desc desc;
+	int res;
+
+	desc.p = start;
+	desc.q = end;
+	desc.color = physmem_ram;
+	res = mem_painting_add(&ram_painting, &desc);
+	return res;
+}
+
+/*
+ *
+ * RESOURCE ACCESS FUNCTIONS
+ *
+ */
+
+/*
+ * lookup_root_resource - finds the right root resource for a range
+ * @start:	the physical address of start of resource.
+ * @size:	the size of resource in byte
+ *
+ * Returns a pointer to the resource or NULL upon failure. It finds the most
+ * deeply nested resource that can hold the resource we were passed.
+ */
+static __init struct resource *__init lookup_root_resource(unsigned long start,
+		unsigned long size)
+{
+	struct resource *result;
+	struct resource *res_p;
+
+	result = NULL;
+	res_p = iomem_resource.child;
+
+	while (res_p) {
+		/*
+		 * If we have a resource that can hold the resource we
+		 * were passed, remember it and then switch to scanning
+		 * its children.
+		 */
+		if ((res_p->start <= start) &&
+			(res_p->end >= (start + size - 1))) {
+			result = res_p;
+			res_p = result->child;
+		} else {
+			res_p = res_p->sibling;
+		}
+	}
+
+	if (result == NULL)
+		pr_err("Can't find root resource for resource at "
+			"0x%lx-0x%lx\n", start, start + size - 1);
+
+	return result;
+}
+
+/**
+ * platform_lookup_resource_entry - finds resource entry by name
+ * @name:	pointer to string containing name of resource
+ *
+ * Returns a pointer to the corresponding &struct resource or NULL if it
+ * couldn't find one.
+ */
+static struct resource *platform_lookup_resource_entry(const char *name)
+{
+	struct resource *p;
+	struct resource *next;
+
+	for (p = iomem_resource.child; p != NULL; p = next) {
+		if (strcmp(p->name, name) == 0)
+			return p;
+
+		next = p->child;		/* Go deeper, if possible */
+
+		if (next == NULL) {
+			next = p->sibling;	/* Go sideways, if possible */
+
+			if (next == NULL) {
+				/* Go up and, possibly, over */
+				for (next = p->parent; next != NULL;
+					next = p->parent) {
+					p = next;
+					next = p->sibling;
+					if (next != NULL)
+						break;
+				}
+			}
+		}
+	}
+
+	return NULL;
+}
+
+/*
+ * set_resource_addresses - set platform resource address information
+ * @plat_res:	Pointer to &struct resource whose addresses to are
+ *		be set
+ * @res:	Pointer to &struct dma_resource from which to get addresses.
+ *
+ * Returns true on success, false on failure.
+ */
+static __init bool set_resource_addresses(struct resource *plat_res,
+	const struct dma_resource *dma_res)
+{
+	if (platform_resource_override(plat_res, dma_res))
+		return true;
+
+	if (dma_res->start != 0) {
+		/* Have a statically defined address */
+		plat_res->start = dma_to_phys(dma_res->start);
+		plat_res->end = dma_to_phys(dma_res->end);
+
+		/* We've already warned about these */
+		if (plat_res->start >= HIGHMEM_START)
+			return false;
+	} else {
+		void *virt_start;
+		size_t size;
+
+		/* Need to allocation an address dynamically */
+
+		size = dma_res->end;
+		virt_start = kmalloc(size, GFP_KERNEL);
+		if (virt_start == NULL) {
+			pr_err("Unable to allocate memory for %s\n",
+				dma_res->name);
+			return false;
+		}
+		plat_res->start = virt_to_phys(virt_start);
+		plat_res->end = plat_res->start + size;
+	}
+
+	return true;
+}
+
+/**
+ * plat_reserve_resource_list - reserve a list of dma_resources
+ * @n:			Number of &dma_resources to reserve
+ * @dma_resources:	Pointer to the list of &struct dma_resource items
+ *
+ * Adds the list of &dma_resources to the ram_painting. This changes
+ * color from physmem_ram so that the memory areas won't be given to
+ * the boot memory allocator. Since this is called before any memory
+ * allocator is initialized, it can't allocate memory.
+ */
+void __init resource_reserve_static_prealloc(size_t n,
+	const struct dma_resource *dma_resources)
+{
+	int i;
+
+	for (i = 0; i < n; i++) {
+		const struct dma_resource *dma_res;
+		struct painting_desc desc;
+
+		dma_res = &dma_resources[i];
+
+		/* Skip anything with a dynamically-assigned address */
+		if (dma_res->start == 0)
+			continue;
+
+		desc.p = dma_to_phys(dma_res->start);
+		desc.q = dma_to_phys(dma_res->end);
+
+#ifndef CONFIG_HIGHMEM
+		if (desc.p >= HIGHMEM_START) {
+			pr_warn("No highmem--skipping reservation at %0*x "
+				"for %s\n",
+				2 * sizeof(dma_res->start), dma_res->start,
+				dma_res->name);
+			continue;
+		}
+#endif
+		desc.color = dma_res->name;
+		mem_painting_add(&ram_painting, &desc);
+	}
+}
+
+/**
+ * resource_add_memory_region - add non-preallocated ram
+ */
+void __init resource_add_memory_regions()
+{
+	struct painting_area *area;
+
+	painting_for_each_area(area, &ram_painting) {
+		struct painting_desc *desc;
+
+		desc = &area->desc;
+		add_memory_region(desc->p, desc->q - desc->p + 1,
+			(desc->color == physmem_ram) ? BOOT_MEM_RAM :
+			BOOT_MEM_RESERVED);
+	}
+}
+
+/*
+ * init_one_resource - set up resources for one preallocation
+ * @plat_res:	Pointer to &struct resource that we be set up
+ * @dma_res:	Pointer to &struct dma_resource holding the data
+ *
+ * On success, returns the number of bytes in the resources. Otherwise,
+ * returns zero.
+ */
+int __init init_one_resource(struct resource *plat_res,
+	const struct dma_resource *dma_res)
+{
+	struct resource *root_res;
+	size_t size;
+	int conflict;
+
+	if (platform_lookup_resource_entry(dma_res->name) != NULL) {
+		pr_err("resource %s has already been allocated\n",
+			dma_res->name);
+		return 0;
+	}
+
+	if (!set_resource_addresses(plat_res, dma_res))
+		return 0;
+
+	plat_res->name = kstrdup(dma_res->name, GFP_KERNEL);
+	plat_res->flags = dma_res->flags;
+	size = (plat_res->end - plat_res->start + 1);
+
+	root_res = lookup_root_resource(plat_res->start, size);
+
+	/* If there is no highmem extent root_res_p might be NULL */
+	if (root_res)
+		conflict = request_resource(root_res, plat_res);
+	else
+		conflict = -1;
+
+	if (conflict) {
+		if (request_resource(&iomem_resource, plat_res) != 0) {
+			pr_err("PTV resource request conflict "
+				"%s: 0x%x-0x%x\n",
+				plat_res->name,
+				plat_res->start,
+				plat_res->end);
+			plat_res->start = 0;
+			plat_res->end = 0;
+		}
+		return 0;
+	}
+
+	plat_res->flags |= IORESOURCE_BUSY;
+	pr_info("Reserved resource at 0x%0*x for %s (%u bytes)\n",
+		2 * sizeof(plat_res->start), plat_res->start,
+		plat_res->name, size);
+	return size;
+}
+
+/**
+ * resource_request_prealloc - reserve resources for a list of preallocs
+ * @n:			Number of resources to request
+ * @dma_resources:	Pointer of DMA resources which are to be requested
+ *
+ * Called when we can allocate memory. Requests resources corresponding
+ * to both statically and dynamically assigned addreses.
+ *
+ * Recall that memory for resources at constant addresses was not passed
+ * to the boot memory allocator, so it is already reserved. Such memory still
+ * has still has no resource associated with it. We don't have addresses
+ * for memory whose address can be dynamically defined and will have to
+ * get them.
+ *
+ * Returns the number of bytes of resources successfully requested.
+ */
+size_t __init resource_request_prealloc(size_t n,
+	const struct dma_resource *dma_resources)
+{
+	struct resource *plat_resources;
+	size_t alloc_size;
+	size_t total;
+	int i;
+
+	if (n == 0)
+		return 0;
+
+	/* Allocate an array for the result */
+	alloc_size = sizeof(*plat_resources) * n;
+	plat_resources = kmalloc(alloc_size, GFP_KERNEL | __GFP_ZERO);
+
+	if (plat_resources == NULL) {
+		pr_err("could not allocate %d bytes for platform resource "
+			"structs\n", alloc_size);
+		return 0;
+	}
+
+	total = 0;
+
+	/* Populate the array */
+	for (i = 0; i < n; i++) {
+		const struct dma_resource *dma_res;
+		struct resource *plat_res;
+		size_t size;
+
+		dma_res = &dma_resources[i];
+		plat_res = &plat_resources[i];
+
+		size = init_one_resource(plat_res, dma_res);
+		if (size > 0)
+			total += size;
+	}
+
+	return total;
+}
+
+/**
+ * platform_lookup_resource - provides start and end physical addresses
+ *	for preallocated and reserved resources for drivers.
+ *
+ * @name:	pointer to string containing name of resource
+ * @bres_p:	pointer to callers struct that addrs are copied to
+ * Returns 0 on success, a negative errno value on failure
+ *
+ */
+int platform_lookup_resource(const char *name, struct bus_resource *bres_p)
+{
+	struct resource *p;
+
+	p = platform_lookup_resource_entry(name);
+
+	if (p == NULL)
+		return -ENODEV;
+
+	bres_p->start = p->start;
+	bres_p->end = p->end;
+	return 0;
+}
+EXPORT_SYMBOL(platform_lookup_resource);
+
+/**
+ * platform_release_memory - release pre-allocated memory
+ * @ptr:	pointer to memory to release
+ * @size:	size of resource
+ * @baddr:	Bus address of memory to release
+ * @size:	size of resource, in bytes
+ *
+ * This must only be called for memory allocated or reserved via the boot
+ * or buddy memory allocators.
+ * Returns the number of bytes actually released. This must only be called
+ * for memory allocated or reserved via the boot memory allocator.
+ */
+unsigned long platform_release_memory(unsigned long baddr, int size)
+{
+	unsigned long paddr = dma_to_phys(baddr);
+	unsigned long pfn;
+	unsigned long end_pfn;
+	unsigned long pgs = 0;
+
+	pr_info("Platform_release_memory:\n");
+	pfn = PFN_UP(paddr);
+	end_pfn = PFN_DOWN(paddr + size);
+
+	for (; pfn < end_pfn; pfn++) {
+		struct page *page = pfn_to_page(pfn);
+
+		if (!pfn_valid(pfn)) {
+			pr_err("Trying to release invalid pfn:0x%lx\n", pfn);
+			BUG();
+			break;
+		}
+
+		if (!PageReserved(page)) {
+			pr_err("Trying to release page that is not"
+				" currently \"reserved\":0x%lx\n", pfn);
+			BUG();
+			break;
+		}
+
+		ClearPageReserved(page);
+		init_page_count(page);
+		__free_page(page);
+
+		totalram_pages++;
+		num_physpages++;
+		pgs++;
+	}
+
+	return pgs << PAGE_SHIFT;
+}
+EXPORT_SYMBOL(platform_release_memory);
diff --git a/arch/mips/powertv/asic/prealloc.h b/arch/mips/powertv/asic/prealloc.h
deleted file mode 100644
index 8e682df..0000000
--- a/arch/mips/powertv/asic/prealloc.h
+++ /dev/null
@@ -1,70 +0,0 @@
-/*
- * Definitions for memory preallocations
- *
- * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-#ifndef _ARCH_MIPS_POWERTV_ASIC_PREALLOC_H
-#define _ARCH_MIPS_POWERTV_ASIC_PREALLOC_H
-
-#define KIBIBYTE(n) ((n) * 1024)    /* Number of kibibytes */
-#define MEBIBYTE(n) ((n) * KIBIBYTE(1024)) /* Number of mebibytes */
-
-/* "struct resource" array element definition */
-#define PREALLOC(NAME, START, END, FLAGS) {	\
-		.name = (NAME),			\
-		.start = (START),		\
-		.end = (END),			\
-		.flags = (FLAGS)		\
-	},
-
-/* Individual resources in the preallocated resource arrays are defined using
- *  macros.  These macros are conditionally defined based on their
- *  corresponding kernel configuration flag:
- *    - CONFIG_PREALLOC_NORMAL: preallocate resources for a normal settop box
- *    - CONFIG_PREALLOC_TFTP: preallocate the TFTP download resource
- *    - CONFIG_PREALLOC_DOCSIS: preallocate the DOCSIS resource
- *    - CONFIG_PREALLOC_PMEM: reserve space for persistent memory
- */
-#ifdef CONFIG_PREALLOC_NORMAL
-#define PREALLOC_NORMAL(name, start, end, flags) \
-   PREALLOC(name, start, end, flags)
-#else
-#define PREALLOC_NORMAL(name, start, end, flags)
-#endif
-
-#ifdef CONFIG_PREALLOC_TFTP
-#define PREALLOC_TFTP(name, start, end, flags) \
-   PREALLOC(name, start, end, flags)
-#else
-#define PREALLOC_TFTP(name, start, end, flags)
-#endif
-
-#ifdef CONFIG_PREALLOC_DOCSIS
-#define PREALLOC_DOCSIS(name, start, end, flags) \
-   PREALLOC(name, start, end, flags)
-#else
-#define PREALLOC_DOCSIS(name, start, end, flags)
-#endif
-
-#ifdef CONFIG_PREALLOC_PMEM
-#define PREALLOC_PMEM(name, start, end, flags) \
-   PREALLOC(name, start, end, flags)
-#else
-#define PREALLOC_PMEM(name, start, end, flags)
-#endif
-#endif
diff --git a/arch/mips/powertv/init.c b/arch/mips/powertv/init.c
index 0aac039..6ee3145 100644
--- a/arch/mips/powertv/init.c
+++ b/arch/mips/powertv/init.c
@@ -3,7 +3,7 @@
  *	All rights reserved.
  *	Authors: Carsten Langgaard <carstenl@mips.com>
  *		 Maciej W. Rozycki <macro@mips.com>
- * Portions copyright (C) 2009 Cisco Systems, Inc.
+ * Portions copyright (C) 2009-2010 Cisco Systems, Inc.
  *
  *  This program is free software; you can distribute it and/or modify it
  *  under the terms of the GNU General Public License (Version 2) as
@@ -122,7 +122,7 @@ void __init prom_init(void)
 		strlcat(arcs_cmdline, prom_argv, COMMAND_LINE_SIZE);
 	}
 
-	configure_platform();
+	powertv_platform_init();
 	prom_meminit();
 
 #ifndef CONFIG_BOOTLOADER_DRIVER
diff --git a/arch/mips/powertv/ioremap.c b/arch/mips/powertv/ioremap.c
index a77c6f6..22a5c29 100644
--- a/arch/mips/powertv/ioremap.c
+++ b/arch/mips/powertv/ioremap.c
@@ -4,6 +4,7 @@
  * Support for mapping between dma_addr_t values a phys_addr_t values.
  *
  * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ * Copyright (C) 2009-2010 Cisco Sysems, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -80,8 +81,17 @@ static void setup_dma_to_phys(dma_addr_t dma, phys_addr_t delta, dma_addr_t s)
 	first_idx = first >> IOR_LSBITS;		/* Convert to indices */
 	last_idx = last >> IOR_LSBITS;
 
-	for (dma_idx = first_idx; dma_idx <= last_idx; dma_idx++)
-		_ior_dma_to_phys[dma_idx].offset = delta >> IOR_DMA_SHIFT;
+	for (dma_idx = first_idx; dma_idx <= last_idx; dma_idx++) {
+		dma_addr_t offset;
+		offset = delta >> IOR_DMA_SHIFT;
+
+		if (_ior_dma_to_phys[dma_idx].offset != 0 &&
+			_ior_dma_to_phys[dma_idx].offset != offset)
+			panic("Memory remapped: DMA %x physical %x size %d\n",
+				dma, dma + delta, s);
+
+		_ior_dma_to_phys[dma_idx].offset = offset;
+	}
 }
 
 /**
@@ -104,11 +114,21 @@ static void setup_phys_to_dma(phys_addr_t phys, dma_addr_t delta, phys_addr_t s)
 	 */
 	first = phys & ~IOR_PHYS_GRAIN_MASK;
 	last = (phys + s - 1) & ~IOR_PHYS_GRAIN_MASK;
-	first_idx = first >> IOR_LSBITS;		/* Convert to indices */
+	first_idx = first >> IOR_LSBITS;	/* Convert to indices */
 	last_idx = last >> IOR_LSBITS;
 
-	for (phys_idx = first_idx; phys_idx <= last_idx; phys_idx++)
-		_ior_phys_to_dma[phys_idx].offset = delta >> IOR_PHYS_SHIFT;
+	for (phys_idx = first_idx; phys_idx <= last_idx; phys_idx++) {
+		dma_addr_t offset;
+
+		offset = delta >> IOR_PHYS_SHIFT;
+
+		if (_ior_phys_to_dma[phys_idx].offset != 0 &&
+			_ior_phys_to_dma[phys_idx].offset != offset)
+			panic("Memory remapped: physical %x DMA %x size %d\n",
+				phys, phys + delta, s);
+
+		_ior_phys_to_dma[phys_idx].offset = offset;
+	}
 }
 
 /**
@@ -120,17 +140,11 @@ static void setup_phys_to_dma(phys_addr_t phys, dma_addr_t delta, phys_addr_t s)
  * NOTE: It might be obvious, but the assumption is that all @size bytes have
  * the same offset between the physical address and the DMA address.
  */
-void ioremap_add_map(phys_addr_t phys, phys_addr_t dma, phys_addr_t size)
+void ioremap_add_map(phys_addr_t phys, dma_addr_t dma, size_t size)
 {
 	if (size == 0)
 		return;
 
-	if ((dma & IOR_DMA_GRAIN_MASK) != 0 ||
-		(phys & IOR_PHYS_GRAIN_MASK) != 0 ||
-		(size & IOR_PHYS_GRAIN_MASK) != 0)
-		pr_crit("Memory allocation must be in chunks of 0x%x bytes\n",
-			IOR_PHYS_GRAIN);
-
 	setup_dma_to_phys(dma, phys - dma, size);
 	setup_phys_to_dma(phys, dma - phys, size);
 }
diff --git a/arch/mips/powertv/memory.c b/arch/mips/powertv/memory.c
index c463cd3..6b0c10e 100644
--- a/arch/mips/powertv/memory.c
+++ b/arch/mips/powertv/memory.c
@@ -1,7 +1,7 @@
 /*
  * Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
- * Portions copyright (C) 2009 Cisco Systems, Inc.
+ * Portions copyright (C) 2009-2010 Cisco Systems, Inc.
  *
  *  This program is free software; you can distribute it and/or modify it
  *  under the terms of the GNU General Public License (Version 2) as
@@ -25,28 +25,38 @@
 #include <linux/pfn.h>
 #include <linux/string.h>
 
-#include <asm/bootinfo.h>
 #include <asm/page.h>
 #include <asm/sections.h>
+#include <asm/setup.h>
+#include <asm/bootinfo.h>
 
 #include <asm/mips-boards/prom.h>
 #include <asm/mach-powertv/asic.h>
 #include <asm/mach-powertv/ioremap.h>
+#include <asm/mach-powertv/powertv-prealloc.h>
 
 #include "init.h"
 
 /* Memory constants */
 #define KIBIBYTE(n)		((n) * 1024)	/* Number of kibibytes */
 #define MEBIBYTE(n)		((n) * KIBIBYTE(1024)) /* Number of mebibytes */
+#define GIBIBYTE(n)		((n) * MEBIBYTE(1024)) /* Number of mebibytes */
 #define DEFAULT_MEMSIZE		MEBIBYTE(128)	/* If no memsize provided */
 
 #define BLDR_SIZE	KIBIBYTE(256)		/* Memory reserved for bldr */
 #define RV_SIZE		MEBIBYTE(4)		/* Size of reset vector */
 
-#define LOW_MEM_END	0x20000000		/* Highest low memory address */
-#define BLDR_ALIAS	0x10000000		/* Bootloader address */
-#define RV_PHYS		0x1fc00000		/* Reset vector address */
-#define LOW_RAM_END	RV_PHYS			/* End of real RAM in low mem */
+/* Predefined physical memory types */
+const char physmem_bootloader[] = "bootloader";
+const char physmem_buddy_high[] = "buddy allocator (high)";
+const char physmem_buddy_low[] = "buddy allocator (low)";
+const char physmem_mem_map[] = "page descriptors";
+const char physmem_ram[] = "RAM";
+const char physmem_reserved[] = "reserved";
+const char physmem_reset_vector[] = "reset vector";
+const char physmem_rom_data[] = "ROM data";
+const char physmem_unknown[] = "unknown type";
+const char physmem_zero_page[] = "zero page";
 
 /*
  * Very low-level conversion from processor physical address to device
@@ -57,30 +67,8 @@
 unsigned long ptv_memsize;
 
 /*
- * struct low_mem_reserved - Items in low memmory that are reserved
- * @start:	Physical address of item
- * @size:	Size, in bytes, of this item
- * @is_aliased:	True if this is RAM aliased from another location. If false,
- *		it is something other than aliased RAM and the RAM in the
- *		unaliased address is still visible outside of low memory.
- */
-struct low_mem_reserved {
-	phys_addr_t	start;
-	phys_addr_t	size;
-	bool		is_aliased;
-};
-
-/*
- * Must be in ascending address order
- */
-struct low_mem_reserved low_mem_reserved[] = {
-	{BLDR_ALIAS, BLDR_SIZE, true},	/* Bootloader RAM */
-	{RV_PHYS, RV_SIZE, false},	/* Reset vector */
-};
-
-/*
  * struct mem_layout - layout of a piece of the system RAM
- * @phys:	Physical address of the start of this piece of RAM. This is the
+ * @dma:	Physical address of the start of this piece of RAM. This is the
  *		address at which both the processor and I/O devices see the
  *		RAM.
  * @alias:	Alias of this piece of memory in order to make it appear in
@@ -89,9 +77,9 @@ struct low_mem_reserved low_mem_reserved[] = {
  * @size:	Size, in bytes, of this piece of RAM
  */
 struct mem_layout {
-	phys_addr_t	phys;
+	dma_addr_t	dma;
 	phys_addr_t	alias;
-	phys_addr_t	size;
+	size_t		size;
 };
 
 /*
@@ -106,27 +94,32 @@ struct mem_layout_list {
 	struct mem_layout	*layout;
 };
 
-static struct mem_layout f1500_layout[] = {
+static struct mem_layout f1500_layout[] __initdata = {
 	{0x20000000, 0x10000000, MEBIBYTE(256)},
 };
 
-static struct mem_layout f4500_layout[] = {
+static struct mem_layout f4500_layout[] __initdata = {
 	{0x40000000, 0x10000000, MEBIBYTE(256)},
 	{0x20000000, 0x20000000, MEBIBYTE(32)},
 };
 
-static struct mem_layout f8500_layout[] = {
+static struct mem_layout f8500_layout[] __initdata = {
 	{0x40000000, 0x10000000, MEBIBYTE(256)},
 	{0x20000000, 0x20000000, MEBIBYTE(32)},
 	{0x30000000, 0x30000000, MEBIBYTE(32)},
 };
 
-static struct mem_layout fx600_layout[] = {
+static struct mem_layout fx600_layout[] __initdata = {
 	{0x20000000, 0x10000000, MEBIBYTE(256)},
 	{0x60000000, 0x60000000, MEBIBYTE(128)},
 };
 
-static struct mem_layout_list layout_list[] = {
+static struct mem_layout fx700_layout[] __initdata = {
+	{0x20000000, 0x10000000, GIBIBYTE(1)},
+	{0x60000000, 0x60000000, GIBIBYTE(1)},
+};
+
+static struct mem_layout_list layout_list[] __initdata = {
 	{FAMILY_1500, ARRAY_SIZE(f1500_layout), f1500_layout},
 	{FAMILY_1500VZE, ARRAY_SIZE(f1500_layout), f1500_layout},
 	{FAMILY_1500VZF, ARRAY_SIZE(f1500_layout), f1500_layout},
@@ -137,26 +130,15 @@ static struct mem_layout_list layout_list[] = {
 	{FAMILY_4600VZA, ARRAY_SIZE(fx600_layout), fx600_layout},
 	{FAMILY_8600, ARRAY_SIZE(fx600_layout), fx600_layout},
 	{FAMILY_8600VZB, ARRAY_SIZE(fx600_layout), fx600_layout},
+	{FAMILY_8700, ARRAY_SIZE(fx600_layout), fx700_layout},
 };
 
 /* If we can't determine the layout, use this */
-static struct mem_layout default_layout[] = {
+static struct mem_layout default_layout[] __initdata = {
 	{0x20000000, 0x10000000, MEBIBYTE(128)},
 };
 
 /**
- * register_non_ram - register low memory not available for RAM usage
- */
-static __init void register_non_ram(void)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(low_mem_reserved); i++)
-		add_memory_region(low_mem_reserved[i].start,
-			low_mem_reserved[i].size, BOOT_MEM_RESERVED);
-}
-
-/**
  * get_memsize - get the size of memory as a single bank
  */
 static phys_addr_t get_memsize(void)
@@ -201,91 +183,7 @@ static phys_addr_t get_memsize(void)
 }
 
 /**
- * register_low_ram - register an aliased section of RAM
- * @p:		Alias address of memory
- * @n:		Number of bytes in this section of memory
- *
- * Returns the number of bytes registered
- *
- */
-static __init phys_addr_t register_low_ram(phys_addr_t p, phys_addr_t n)
-{
-	phys_addr_t s;
-	int i;
-	phys_addr_t orig_n;
-
-	orig_n = n;
-
-	BUG_ON(p + n > RV_PHYS);
-
-	for (i = 0; n != 0 && i < ARRAY_SIZE(low_mem_reserved); i++) {
-		phys_addr_t start;
-		phys_addr_t size;
-
-		start = low_mem_reserved[i].start;
-		size = low_mem_reserved[i].size;
-
-		/* Handle memory before this low memory section */
-		if (p < start) {
-			phys_addr_t s;
-			s = min(n, start - p);
-			add_memory_region(p, s, BOOT_MEM_RAM);
-			p += s;
-			n -= s;
-		}
-
-		/* Handle the low memory section itself. If it's aliased,
-		 * we reduce the number of byes left, but if not, the RAM
-		 * is available elsewhere and we don't reduce the number of
-		 * bytes remaining. */
-		if (p == start) {
-			if (low_mem_reserved[i].is_aliased) {
-				s = min(n, size);
-				n -= s;
-				p += s;
-			} else
-				p += n;
-		}
-	}
-
-	return orig_n - n;
-}
-
-/*
- * register_ram - register real RAM
- * @p:	Address of memory as seen by devices
- * @alias:	If the memory is seen at an additional address by the processor,
- *		this will be the address, otherwise it is the same as @p.
- * @n:		Number of bytes in this section of memory
- */
-static __init void register_ram(phys_addr_t p, phys_addr_t alias,
-	phys_addr_t n)
-{
-	/*
-	 * If some or all of this memory has an alias, break it into the
-	 * aliased and non-aliased portion.
-	 */
-	if (p != alias) {
-		phys_addr_t alias_size;
-		phys_addr_t registered;
-
-		alias_size = min(n, LOW_RAM_END - alias);
-		registered = register_low_ram(alias, alias_size);
-		ioremap_add_map(alias, p, n);
-		n -= registered;
-		p += registered;
-	}
-
-#ifdef CONFIG_HIGHMEM
-	if (n != 0) {
-		add_memory_region(p, n, BOOT_MEM_RAM);
-		ioremap_add_map(p, p, n);
-	}
-#endif
-}
-
-/**
- * register_address_space - register things in the address space
+ * register_raw_ram - register things in the address space
  * @memsize:	Number of bytes of RAM installed
  *
  * Takes the given number of bytes of RAM and registers as many of the regions,
@@ -294,19 +192,13 @@ static __init void register_ram(phys_addr_t p, phys_addr_t alias,
  * is 384 MiB, it will register the first region with 256 MiB and the second
  * with 128 MiB.
  */
-static __init void register_address_space(phys_addr_t memsize)
+static void __init register_raw_ram(phys_addr_t memsize)
 {
-	int i;
-	phys_addr_t size;
-	size_t n;
 	struct mem_layout *layout;
+	int num_layouts;
 	enum family_type family;
-
-	/*
-	 * Register all of the things that aren't available to the kernel as
-	 * memory.
-	 */
-	register_non_ram();
+	int res;
+	int i;
 
 	/* Find the appropriate memory description */
 	family = platform_get_family();
@@ -317,16 +209,27 @@ static __init void register_address_space(phys_addr_t memsize)
 	}
 
 	if (i == ARRAY_SIZE(layout_list)) {
-		n = ARRAY_SIZE(default_layout);
+		num_layouts = ARRAY_SIZE(default_layout);
 		layout = default_layout;
 	} else {
-		n = layout_list[i].n;
+		num_layouts = layout_list[i].n;
 		layout = layout_list[i].layout;
 	}
 
-	for (i = 0; memsize != 0 && i < n; i++) {
+	/* Add all possible RAM */
+	for (i = 0; memsize != 0 && i < num_layouts; i++) {
+		dma_addr_t dma;
+		phys_addr_t alias;
+		size_t size;
+
+		dma = layout[i].dma;
+		alias = layout[i].alias;
 		size = min(memsize, layout[i].size);
-		register_ram(layout[i].phys, layout[i].alias, size);
+
+		ioremap_add_map(alias, dma, size);
+		res = resource_add_ram(alias, alias + size - 1);
+		if (res != 0)
+			break;
 		memsize -= size;
 	}
 }
@@ -334,7 +237,9 @@ static __init void register_address_space(phys_addr_t memsize)
 void __init prom_meminit(void)
 {
 	ptv_memsize = get_memsize();
-	register_address_space(ptv_memsize);
+	register_raw_ram(ptv_memsize);
+	register_available_ram();
+
 }
 
 void __init prom_free_prom_memory(void)
diff --git a/arch/mips/powertv/powertv_setup.c b/arch/mips/powertv/powertv_setup.c
index af2cae0..f430156 100644
--- a/arch/mips/powertv/powertv_setup.c
+++ b/arch/mips/powertv/powertv_setup.c
@@ -1,7 +1,7 @@
 /*
  * Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
- * Portions copyright (C) 2009 Cisco Systems, Inc.
+ * Portions copyright (C) 2009-2010  Cisco Systems, Inc.
  *
  *  This program is free software; you can distribute it and/or modify it
  *  under the terms of the GNU General Public License (Version 2) as
@@ -36,6 +36,8 @@
 #include <asm/asm.h>
 #include <asm/traps.h>
 #include <asm/asm-offsets.h>
+#include <asm/mach-powertv/asic.h>
+#include <asm/mach-powertv/prealloc.h>
 #include "reset.h"
 
 #define VAL(n)		STR(n)
