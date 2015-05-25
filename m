Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 May 2015 07:41:43 +0200 (CEST)
Received: from resqmta-ch2-09v.sys.comcast.net ([69.252.207.41]:44321 "EHLO
        resqmta-ch2-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006587AbbEYFliC5unN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 May 2015 07:41:38 +0200
Received: from resomta-ch2-19v.sys.comcast.net ([69.252.207.115])
        by resqmta-ch2-09v.sys.comcast.net with comcast
        id Y5ha1q0042VvR6D015hacG; Mon, 25 May 2015 05:41:34 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-19v.sys.comcast.net with comcast
        id Y5hZ1q00K42s2jH015hZzH; Mon, 25 May 2015 05:41:34 +0000
Message-ID: <5562B60D.3050507@gentoo.org>
Date:   Mon, 25 May 2015 01:41:33 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH]: MIPS: PCI: Add pre_enable hook, minor readability fixes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1432532494;
        bh=lZ7OvP58DpfOn8OxQ4aH8Zk102r3wPwMeTJMFmnJt/M=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=RKNWiAxOaX4/WjnMVvQtoKwMSRnIfa9AyUgYeCSS9AdQJlWeqfct9ixAPn5/nzzTu
         pdYIFWVHpbALdEBnuSqTJuMLUpFsZ8lUxJBiTr7gjrDaZLNavMjaYHSTPNE+qGrubb
         VLkJUTwyTQYvogx/qrFT5UUGWBBN8EEljgqFvjy8R1ObiK9IRxK92ZMZgWD/2BduEr
         5vUK2Be6YUc/AS85KPm3UBoxc6E7myXXWRppXwhKYVNxO/mKbXMH3DcRLAjNCTYGaR
         QAN5BS4ooQC16kOpHL10aa0qWyfdwSY1Bj12ZpBbH5HyGdDLrEMMRO1KszgoKIuOdM
         FIfeAOZBqqPcA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47646
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

This patch adds a hook "pre_enable", to the core MIPS PCI code.  It is
used by the IP30 Port to setup the PCI resources prior to probing the
BRIDGE and detecting available PCI devices.  It also adds some minor
whitespace to improve readability.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/include/asm/pci.h |    3 +++
 arch/mips/pci/pci.c         |   10 ++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

linux-mips-pci-pre_enable.patch
diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index d969299..b51ccbd 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -43,6 +43,9 @@ struct pci_controller {
 	   and XFree86. Eventually will be removed. */
 	unsigned int need_domain_info;
 
+	/* called in pcibios_enable_resources */
+	int (*pre_enable)(struct pci_controller *, struct pci_dev *, int);
+
 	int iommu;
 
 	/* Optional access methods for reading/writing the bus number
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index b8a0bf5..af17c16 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -261,14 +261,19 @@ static int pcibios_enable_resources(struct pci_dev *dev, int mask)
 	u16 cmd, old_cmd;
 	int idx;
 	struct resource *r;
+	struct pci_controller *hose = (struct pci_controller *)dev->sysdata;
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	old_cmd = cmd;
-	for (idx=0; idx < PCI_NUM_RESOURCES; idx++) {
+	for (idx = 0; idx < PCI_NUM_RESOURCES; idx++) {
 		/* Only set up the requested stuff */
-		if (!(mask & (1<<idx)))
+		if (!(mask & (1 << idx)))
 			continue;
 
+		if(hose->pre_enable)
+			if(hose->pre_enable(hose, dev, idx) < 0)
+				return -EINVAL;
+
 		r = &dev->resource[idx];
 		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
 			continue;
@@ -291,6 +296,7 @@ static int pcibios_enable_resources(struct pci_dev *dev, int mask)
 		       pci_name(dev), old_cmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
+
 	return 0;
 }
 
