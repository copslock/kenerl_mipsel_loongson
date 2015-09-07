Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Sep 2015 11:43:20 +0200 (CEST)
Received: from resqmta-ch2-02v.sys.comcast.net ([69.252.207.34]:36206 "EHLO
        resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007281AbbIGJnSqcgDz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Sep 2015 11:43:18 +0200
Received: from resomta-ch2-20v.sys.comcast.net ([69.252.207.116])
        by resqmta-ch2-02v.sys.comcast.net with comcast
        id E9in1r0012XD5SV019jAFA; Mon, 07 Sep 2015 09:43:10 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-20v.sys.comcast.net with comcast
        id E9j81r00G0w5D38019j9XJ; Mon, 07 Sep 2015 09:43:10 +0000
From:   Joshua Kinard <kumba@gentoo.org>
Subject: [PATCH v3]: MIPS: PCI: Add pre_enable hook, minor readability fixes
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
Message-ID: <55ED5C28.1020402@gentoo.org>
Date:   Mon, 7 Sep 2015 05:43:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1441618990;
        bh=OAJV23iLyjVVRf9kmXicyPHi3nASVOIPRfsgc4nntjU=;
        h=Received:Received:From:Subject:To:Message-ID:Date:MIME-Version:
         Content-Type;
        b=sQQPoCCj8LhLeWZ9p0tOVEmPdnRK7oTWT7jFjRHfzljbGohl2Foix8TOKjCJaLf9G
         PV+uz+JMUBhaERjfQRAgSALMSv0YSNse6qkch+35sI5LCVYo35ezocsb7IzQYFM5f0
         kN26MUvDL3izLTMY2iHtbX5zZseCfg7OHtCBbrLOCHSD/Vj66Z+XXPpz7b12RwHhgk
         7ezauUdl+I3x9JY+FmbHzpzSsOKT/J2U6jj53sg6bIH7I256xYUTC4F2za1rB5BP0D
         CZqUKqekhwRzkhSCWMc8Fj3al6ErxGxh7GekHRyzGhsuAotOYEbziK9VaCFByeSffM
         vC6QU8eqNy4pA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49121
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

This patch adds a hook, "pre_enable", to the core MIPS PCI code.  It is
used by the IP30 Port to setup the PCI resources prior to probing the
BRIDGE and detecting available PCI devices.  It also adds some minor
whitespace to improve readability.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/include/asm/pci.h |    3 +++
 arch/mips/pci/pci.c         |   10 ++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

This version is diff'ed against the post-4.2/pre-4.3 tree.

linux-mips-pci-pre_enable.patch
diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 98c31e5..0acee98 100644
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
index c6996cf..02e3103 100644
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
 
+		if (hose->pre_enable)
+			if (hose->pre_enable(hose, dev, idx) < 0)
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
 
