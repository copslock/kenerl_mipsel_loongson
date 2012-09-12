Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2012 01:30:41 +0200 (CEST)
Received: from mail-oa0-f49.google.com ([209.85.219.49]:36385 "EHLO
        mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903509Ab2ILXah (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Sep 2012 01:30:37 +0200
Received: by oagh1 with SMTP id h1so1475100oag.36
        for <linux-mips@linux-mips.org>; Wed, 12 Sep 2012 16:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :user-agent:x-gm-message-state;
        bh=vQ39qJL+h6bbvFbm66yuvK+8ljwMYCb/tvFJISbeKDU=;
        b=f3arxAw+rVx9nRJNU688H01HNG0EHx7mMLsg7OoNdqwldmrTP8Xp7TceId0Z973RVm
         FvjGjU2BYHrZstMvbYWfGTGE8hbT8wGdwk7+HL1w//T+66yJDr/KLBjx1UQjaBO+SIX/
         WJX8gJDlv3K3M5ggwjdNPWnXQ9EvYXLkiQvwzMGsku6rM1MdXdJ9pSAZwG20GCEb6m5w
         do5R3MY3cm6X9E+ieBcnb1OHmJbRzZvr+/Bl5oIcE70Xoa6R3iUxSRBKn72fOXO/uJer
         0vd4TF9p89AlNSYTXAfhNIjRs5+zob6cc707VRIVczLZ9QWxyUexpTRFa2Mk6xkah3dS
         SOfg==
Received: by 10.60.25.129 with SMTP id c1mr126314oeg.36.1347492631227;
        Wed, 12 Sep 2012 16:30:31 -0700 (PDT)
Received: from localhost (c-67-168-183-230.hsd1.wa.comcast.net. [67.168.183.230])
        by mx.google.com with ESMTPS id 2sm21739513obi.20.2012.09.12.16.30.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 12 Sep 2012 16:30:29 -0700 (PDT)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [ 017/108] MIPS: pci-ar724x: avoid data bus error due to a missing PCIe module
Date:   Wed, 12 Sep 2012 16:28:15 -0700
Message-Id: <20120912232452.346902780@linuxfoundation.org>
X-Mailer: git-send-email 1.7.10.1.362.g242cab3
In-Reply-To: <20120912232450.500619493@linuxfoundation.org>
References: <20120912232816.GA1655@kroah.com>
 <20120912232450.500619493@linuxfoundation.org>
User-Agent: quilt/0.60-2.1.2
X-Gm-Message-State: ALoCoQkQFT7zXfmAlDdnO2vSRgvVud2LxuegwF89sKEJGbzINcyJl6+6Csa9zJIrer08HhRSrDEg
X-archive-position: 34489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

From: Greg KH <gregkh@linuxfoundation.org>

3.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabor Juhos <juhosg@openwrt.org>

commit a1dca315ce3f78347bca8ce8befe3cc71ae63b7e upstream.

If the controller has no PCIe module attached, accessing of the device
configuration space causes a data bus error. Avoid this by checking the
status of the PCIe link in advance, and indicate an error if the link
is down.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/4293/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/pci/pci-ar724x.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -23,9 +23,12 @@
 #define AR724X_PCI_MEM_BASE	0x10000000
 #define AR724X_PCI_MEM_SIZE	0x08000000
 
+#define AR724X_PCI_REG_RESET		0x18
 #define AR724X_PCI_REG_INT_STATUS	0x4c
 #define AR724X_PCI_REG_INT_MASK		0x50
 
+#define AR724X_PCI_RESET_LINK_UP	BIT(0)
+
 #define AR724X_PCI_INT_DEV0		BIT(14)
 
 #define AR724X_PCI_IRQ_COUNT		1
@@ -38,6 +41,15 @@ static void __iomem *ar724x_pci_ctrl_bas
 
 static u32 ar724x_pci_bar0_value;
 static bool ar724x_pci_bar0_is_cached;
+static bool ar724x_pci_link_up;
+
+static inline bool ar724x_pci_check_link(void)
+{
+	u32 reset;
+
+	reset = __raw_readl(ar724x_pci_ctrl_base + AR724X_PCI_REG_RESET);
+	return reset & AR724X_PCI_RESET_LINK_UP;
+}
 
 static int ar724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
 			    int size, uint32_t *value)
@@ -46,6 +58,9 @@ static int ar724x_pci_read(struct pci_bu
 	void __iomem *base;
 	u32 data;
 
+	if (!ar724x_pci_link_up)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
 	if (devfn)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -96,6 +111,9 @@ static int ar724x_pci_write(struct pci_b
 	u32 data;
 	int s;
 
+	if (!ar724x_pci_link_up)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
 	if (devfn)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -280,6 +298,10 @@ int __init ar724x_pcibios_init(int irq)
 	if (ar724x_pci_ctrl_base == NULL)
 		goto err_unmap_devcfg;
 
+	ar724x_pci_link_up = ar724x_pci_check_link();
+	if (!ar724x_pci_link_up)
+		pr_warn("ar724x: PCIe link is down\n");
+
 	ar724x_pci_irq_init(irq);
 	register_pci_controller(&ar724x_pci_controller);
 
