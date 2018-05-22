Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2018 15:12:05 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:60870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994737AbeEVNLugDRtk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 May 2018 15:11:50 +0200
Received: from localhost (173-24-227-115.client.mchsi.com [173.24.227.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B14AD20876;
        Tue, 22 May 2018 13:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526994703;
        bh=VdJHlNvt+IXLPKTYH+ZNSOp4lnqITM440viU7wCrHO8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hFV6YgWTJTWxSaiBbUqVxxzqsDqWt+/JR+EllECVzfBOgeB6N5k4At+rFGDKtp91S
         RbR/Ka8AuekZnjA6F5p29BJvbyh/hH00oe1iHcRlF4c9qhXjC2aVgAbAKDlVZj3bL4
         Fw2qz1WbuLvhbnB8sKOxhGhNkOXqPaoXLbehcBPY=
Subject: [PATCH v1] MIPS: PCI: Use dev_printk() when possible
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 22 May 2018 08:11:42 -0500
Message-ID: <152699470263.162686.16975145205315900817.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152699466671.162686.1029992586935534102.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152699466671.162686.1029992586935534102.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <helgaas@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: helgaas@kernel.org
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

From: Bjorn Helgaas <bhelgaas@google.com>

Use the pci_info() and pci_err() wrappers for dev_printk() when possible.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mips/pci/pci-legacy.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
index 0c65c38e05d6..73643e80f02d 100644
--- a/arch/mips/pci/pci-legacy.c
+++ b/arch/mips/pci/pci-legacy.c
@@ -263,9 +263,7 @@ static int pcibios_enable_resources(struct pci_dev *dev, int mask)
 				(!(r->flags & IORESOURCE_ROM_ENABLE)))
 			continue;
 		if (!r->start && r->end) {
-			printk(KERN_ERR "PCI: Device %s not available "
-			       "because of resource collisions\n",
-			       pci_name(dev));
+			pci_err(dev, "can't enable device: resource collisions\n");
 			return -EINVAL;
 		}
 		if (r->flags & IORESOURCE_IO)
@@ -274,8 +272,7 @@ static int pcibios_enable_resources(struct pci_dev *dev, int mask)
 			cmd |= PCI_COMMAND_MEMORY;
 	}
 	if (cmd != old_cmd) {
-		printk("PCI: Enabling device %s (%04x -> %04x)\n",
-		       pci_name(dev), old_cmd, cmd);
+		pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
 	return 0;
