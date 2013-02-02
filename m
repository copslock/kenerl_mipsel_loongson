Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Feb 2013 15:19:18 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:47448 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827465Ab3BBOTR3H1SJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Feb 2013 15:19:17 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 3923B25D29B;
        Sat,  2 Feb 2013 15:19:11 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UQwEDOQuwp7F; Sat,  2 Feb 2013 15:19:11 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 164D525D296;
        Sat,  2 Feb 2013 15:19:09 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] MIPS: avoid possible resource conflict in register_pci_controller
Date:   Sat,  2 Feb 2013 15:18:54 +0100
Message-Id: <1359814734-13963-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
X-archive-position: 35685
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The IO and memory resources of a PCI controller
might already have a parent resource set when
they are passed to 'register_pci_controller'.

If the parent resource is set, the request_resource
call will fail due to resource conflict and the
current code will not be able to register the
PCI controller.

Use the parent resource if it is available in the
request_resource call to avoid the isssue.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/pci/pci.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index a184344..eb65399 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -175,9 +175,20 @@ static DEFINE_MUTEX(pci_scan_mutex);
 
 void register_pci_controller(struct pci_controller *hose)
 {
-	if (request_resource(&iomem_resource, hose->mem_resource) < 0)
+	struct resource *parent;
+
+	parent = hose->mem_resource->parent;
+	if (!parent)
+		parent = &iomem_resource;
+
+	if (request_resource(parent, hose->mem_resource) < 0)
 		goto out;
-	if (request_resource(&ioport_resource, hose->io_resource) < 0) {
+
+	parent = hose->io_resource->parent;
+	if (!parent)
+		parent = &ioport_resource;
+
+	if (request_resource(parent, hose->io_resource) < 0) {
 		release_resource(hose->mem_resource);
 		goto out;
 	}
-- 
1.7.10
