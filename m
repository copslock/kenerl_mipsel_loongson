Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Apr 2013 20:01:14 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:42055 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822444Ab3DDSBLS3tOj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Apr 2013 20:01:11 +0200
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZN27dfRGjWRj; Thu,  4 Apr 2013 20:00:28 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 3B3422800FA;
        Thu,  4 Apr 2013 20:00:28 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 1/2] pci/of: remove weak annotation of pcibios_get_phb_of_node
Date:   Thu,  4 Apr 2013 20:01:22 +0200
Message-Id: <1365098483-26821-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

Due to the __weak annotation in the forward declaration
of the 'pcibios_get_phb_of_node' function GCC will emit
a weak symbol for this functions even if the actual
implementation does not use the weak attribute.

If an architecture tries to override the function
by providing its own implementation there will be
multiple weak symbols with the same name in the
object files. When the kernel is linked from the
object files the linking order determines which
implementation will be used in the final image.

On x86 and on powerpc the architecture specific
version gets used:

  $ readelf -s  arch/x86/kernel/built-in.o drivers/pci/built-in.o \
    vmlinux.o | grep pcibios_get_phb_of_node
    3338: 00029b80    86 FUNC    WEAK   DEFAULT    1 pcibios_get_phb_of_node
    1701: 00012710    77 FUNC    WEAK   DEFAULT    1 pcibios_get_phb_of_node
   52072: 0002a170    86 FUNC    WEAK   DEFAULT    1 pcibios_get_phb_of_node
  $

  $ powerpc-openwrt-linux-uclibc-readelf -s arch/powerpc/kernel/built-in.o \
    drivers/pci/built-in.o vmlinux.o | grep pcibios_get_phb_of_node
    1001: 0000cbb8    12 FUNC    WEAK   DEFAULT    1 pcibios_get_phb_of_node
    1484: 0001471c    88 FUNC    WEAK   DEFAULT    1 pcibios_get_phb_of_node
   28652: 0000d6f8    12 FUNC    WEAK   DEFAULT    1 pcibios_get_phb_of_node
  $

However on MIPS, the linker puts the default
implementation into the final image:

  $ mipsel-openwrt-linux-readelf -s arch/mips/pci/built-in.o \
    drivers/pci/built-in.o vmlinux.o | grep pcibios_get_phb_of_node
      86: 0000046c    12 FUNC    WEAK   DEFAULT    2 pcibios_get_phb_of_node
    1430: 00012e2c   104 FUNC    WEAK   DEFAULT    2 pcibios_get_phb_of_node
   31898: 0017e4ec   104 FUNC    WEAK   DEFAULT    2 pcibios_get_phb_of_node
  $

Rename the default implementation and remove the
__weak annotation of that. This ensures that there
will be no multiple weak symbols with the same name
in the object files. In order to keep the expected
behaviour, call the architecture specific function
if the weak symbol is resolved.

Also move the renamed function to the top instead
of adding a new forward declaration for that.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
Notes:

Unfortunately I'm not a binutils/gcc expert, so
I don't know if this is the expected behaviour
of those or not.

Removing the __weak annotation from the forward
declaration of 'pcibios_get_phb_of_node' in
'include/linux/pci.h' also fixes the problem.

The microblaze architecture also provides its own
implementation. The behaviour of that is not tested
but I assume that the linker chooses the arch specific
implementation on that as well similarly to the
x86/powerpc.

The MIPS version is implemented in the followup
patch.

Removing the __weak annotation from the forward
declaration of 'pcibios_get_phb_of_node' in
'include/linux/pci.h' also fixes the problem.

-Gabor
---
 drivers/pci/of.c |   41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index f092993..5794840 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -15,10 +15,32 @@
 #include <linux/of_pci.h>
 #include "pci.h"
 
+static struct device_node *__pcibios_get_phb_of_node(struct pci_bus *bus)
+{
+	/* This should only be called for PHBs */
+	if (WARN_ON(bus->self || bus->parent))
+		return NULL;
+
+	if (pcibios_get_phb_of_node)
+		return pcibios_get_phb_of_node(bus);
+
+	/* Look for a node pointer in either the intermediary device we
+	 * create above the root bus or it's own parent. Normally only
+	 * the later is populated.
+	 */
+	if (bus->bridge->of_node)
+		return of_node_get(bus->bridge->of_node);
+	if (bus->bridge->parent && bus->bridge->parent->of_node)
+		return of_node_get(bus->bridge->parent->of_node);
+
+	return NULL;
+}
+
 void pci_set_of_node(struct pci_dev *dev)
 {
 	if (!dev->bus->dev.of_node)
 		return;
+
 	dev->dev.of_node = of_pci_find_child_device(dev->bus->dev.of_node,
 						    dev->devfn);
 }
@@ -32,7 +54,7 @@ void pci_release_of_node(struct pci_dev *dev)
 void pci_set_bus_of_node(struct pci_bus *bus)
 {
 	if (bus->self == NULL)
-		bus->dev.of_node = pcibios_get_phb_of_node(bus);
+		bus->dev.of_node = __pcibios_get_phb_of_node(bus);
 	else
 		bus->dev.of_node = of_node_get(bus->self->dev.of_node);
 }
@@ -42,20 +64,3 @@ void pci_release_bus_of_node(struct pci_bus *bus)
 	of_node_put(bus->dev.of_node);
 	bus->dev.of_node = NULL;
 }
-
-struct device_node * __weak pcibios_get_phb_of_node(struct pci_bus *bus)
-{
-	/* This should only be called for PHBs */
-	if (WARN_ON(bus->self || bus->parent))
-		return NULL;
-
-	/* Look for a node pointer in either the intermediary device we
-	 * create above the root bus or it's own parent. Normally only
-	 * the later is populated.
-	 */
-	if (bus->bridge->of_node)
-		return of_node_get(bus->bridge->of_node);
-	if (bus->bridge->parent && bus->bridge->parent->of_node)
-		return of_node_get(bus->bridge->parent->of_node);
-	return NULL;
-}
-- 
1.7.10
