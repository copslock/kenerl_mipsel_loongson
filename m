Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 May 2013 17:32:16 +0200 (CEST)
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:43106 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6825866Ab3EGPbgEOOMb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 May 2013 17:31:36 +0200
Received: from localhost.localdomain (e106165-lin.cambridge.arm.com [10.1.197.23])
        by cam-smtp0.cambridge.arm.com (8.13.8/8.13.8) with ESMTP id r47FVHca017241;
        Tue, 7 May 2013 16:31:19 +0100
From:   Andrew Murray <Andrew.Murray@arm.com>
To:     robherring2@gmail.com
Cc:     benh@kernel.crashing.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, jgunthorpe@obsidianresearch.com,
        linux@arm.linux.org.uk, siva.kallam@samsung.com,
        linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
        jg1.han@samsung.com, Liviu.Dudau@arm.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kgene.kim@samsung.com, bhelgaas@google.com,
        suren.reddy@samsung.com, linux-arm-kernel@lists.infradead.org,
        monstr@monstr.eu, paulus@samba.org,
        thomas.petazzoni@free-electrons.com,
        thierry.reding@avionic-design.de, thomas.abraham@linaro.org,
        arnd@arndb.de, linus.walleij@linaro.org, juhosg@openwrt.org,
        grant.likely@linaro.org, Andrew Murray <Andrew.Murray@arm.com>
Subject: [PATCH v9 1/3] of/pci: Provide support for parsing PCI DT ranges property
Date:   Tue,  7 May 2013 16:31:12 +0100
Message-Id: <1367940674-11987-2-git-send-email-Andrew.Murray@arm.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1367940674-11987-1-git-send-email-Andrew.Murray@arm.com>
References: <1367940674-11987-1-git-send-email-Andrew.Murray@arm.com>
Return-Path: <Andrew.Murray@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrew.Murray@arm.com
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

This patch factors out common implementation patterns to reduce overall kernel
code and provide a means for host bridge drivers to directly obtain struct
resources from the DT's ranges property without relying on architecture specific
DT handling. This will make it easier to write archiecture independent host bridge
drivers and mitigate against further duplication of DT parsing code.

This patch can be used in the following way:

	struct of_pci_range_parser parser;
	struct of_pci_range range;

	if (of_pci_range_parser_init(&parser, np))
		; //no ranges property

	for_each_of_pci_range(&parser, &range) {

		/*
			directly access properties of the address range, e.g.:
			range.pci_space, range.pci_addr, range.cpu_addr,
			range.size, range.flags

			alternatively obtain a struct resource, e.g.:
			struct resource res;
			of_pci_range_to_resource(&range, np, &res);
		*/
	}

Additionally the implementation takes care of adjacent ranges and merges them
into a single range (as was the case with powerpc and microblaze).

Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reviewed-by: Rob Herring <rob.herring@calxeda.com>
Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Jingoo Han <jg1.han@samsung.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/of/address.c       |   67 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_address.h |   48 +++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+), 0 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 04da786..fdd0636 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -227,6 +227,73 @@ int of_pci_address_to_resource(struct device_node *dev, int bar,
 	return __of_address_to_resource(dev, addrp, size, flags, NULL, r);
 }
 EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
+
+int of_pci_range_parser_init(struct of_pci_range_parser *parser,
+				struct device_node *node)
+{
+	const int na = 3, ns = 2;
+	int rlen;
+
+	parser->node = node;
+	parser->pna = of_n_addr_cells(node);
+	parser->np = parser->pna + na + ns;
+
+	parser->range = of_get_property(node, "ranges", &rlen);
+	if (parser->range == NULL)
+		return -ENOENT;
+
+	parser->end = parser->range + rlen / sizeof(__be32);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_pci_range_parser_init);
+
+struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
+						struct of_pci_range *range)
+{
+	const int na = 3, ns = 2;
+
+	if (!range)
+		return NULL;
+
+	if (!parser->range || parser->range + parser->np > parser->end)
+		return NULL;
+
+	range->pci_space = parser->range[0];
+	range->flags = of_bus_pci_get_flags(parser->range);
+	range->pci_addr = of_read_number(parser->range + 1, ns);
+	range->cpu_addr = of_translate_address(parser->node,
+				parser->range + na);
+	range->size = of_read_number(parser->range + parser->pna + na, ns);
+
+	parser->range += parser->np;
+
+	/* Now consume following elements while they are contiguous */
+	while (parser->range + parser->np <= parser->end) {
+		u32 flags, pci_space;
+		u64 pci_addr, cpu_addr, size;
+
+		pci_space = be32_to_cpup(parser->range);
+		flags = of_bus_pci_get_flags(parser->range);
+		pci_addr = of_read_number(parser->range + 1, ns);
+		cpu_addr = of_translate_address(parser->node,
+				parser->range + na);
+		size = of_read_number(parser->range + parser->pna + na, ns);
+
+		if (flags != range->flags)
+			break;
+		if (pci_addr != range->pci_addr + range->size ||
+		    cpu_addr != range->cpu_addr + range->size)
+			break;
+
+		range->size += size;
+		parser->range += parser->np;
+	}
+
+	return range;
+}
+EXPORT_SYMBOL_GPL(of_pci_range_parser_one);
+
 #endif /* CONFIG_PCI */
 
 /*
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 0506eb5..4c2e6f2 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -4,6 +4,36 @@
 #include <linux/errno.h>
 #include <linux/of.h>
 
+struct of_pci_range_parser {
+	struct device_node *node;
+	const __be32 *range;
+	const __be32 *end;
+	int np;
+	int pna;
+};
+
+struct of_pci_range {
+	u32 pci_space;
+	u64 pci_addr;
+	u64 cpu_addr;
+	u64 size;
+	u32 flags;
+};
+
+#define for_each_of_pci_range(parser, range) \
+	for (; of_pci_range_parser_one(parser, range);)
+
+static inline void of_pci_range_to_resource(struct of_pci_range *range,
+					    struct device_node *np,
+					    struct resource *res)
+{
+	res->flags = range->flags;
+	res->start = range->cpu_addr;
+	res->end = range->cpu_addr + range->size - 1;
+	res->parent = res->child = res->sibling = NULL;
+	res->name = np->full_name;
+}
+
 #ifdef CONFIG_OF_ADDRESS
 extern u64 of_translate_address(struct device_node *np, const __be32 *addr);
 extern bool of_can_translate_address(struct device_node *dev);
@@ -27,6 +57,11 @@ static inline unsigned long pci_address_to_pio(phys_addr_t addr) { return -1; }
 #define pci_address_to_pio pci_address_to_pio
 #endif
 
+extern int of_pci_range_parser_init(struct of_pci_range_parser *parser,
+			struct device_node *node);
+extern struct of_pci_range *of_pci_range_parser_one(
+					struct of_pci_range_parser *parser,
+					struct of_pci_range *range);
 #else /* CONFIG_OF_ADDRESS */
 #ifndef of_address_to_resource
 static inline int of_address_to_resource(struct device_node *dev, int index,
@@ -53,6 +88,19 @@ static inline const __be32 *of_get_address(struct device_node *dev, int index,
 {
 	return NULL;
 }
+
+static inline int of_pci_range_parser_init(struct of_pci_range_parser *parser,
+			struct device_node *node)
+{
+	return -1;
+}
+
+static inline struct of_pci_range *of_pci_range_parser_one(
+					struct of_pci_range_parser *parser,
+					struct of_pci_range *range)
+{
+	return NULL;
+}
 #endif /* CONFIG_OF_ADDRESS */
 
 
-- 
1.7.0.4
