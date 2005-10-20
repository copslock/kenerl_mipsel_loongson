Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 07:07:03 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:43546
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133382AbVJTGGq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 07:06:46 +0100
Received: from dl2.hq2.avtrex.com (dl2.hq2.avtrex.com [127.0.0.1])
	by avtrex.com (8.13.1/8.13.1) with ESMTP id j9K66i1T001295;
	Wed, 19 Oct 2005 23:06:44 -0700
Received: (from daney@localhost)
	by dl2.hq2.avtrex.com (8.13.1/8.13.1/Submit) id j9K66iPo001292;
	Wed, 19 Oct 2005 23:06:44 -0700
From:	David Daney <ddaney@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17239.13300.410843.465349@dl2.hq2.avtrex.com>
Date:	Wed, 19 Oct 2005 23:06:44 -0700
To:	linux-mips@linux-mips.org
CC:	linux-kernel@vger.kernel.org
Subject: Patch: ATI Xilleon port 4/11 Xilleon PCI IDs
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: ddaney@avtrex.com
Return-Path: <daney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

This is the fourth part of my Xilleon port.

I am sending the full set of patches to linux-mips@linux-mips.org
which is archived at: http://www.linux-mips.org/archives/

Only the patches that touch generic parts of the kernel are coming
here.

This patch adds some PCI ids for ATI's Xilleon family of SOCs.

Patch against 2.6.14-rc2 from linux-mips.org

Signed-off-by: David Daney <ddaney@avtrex.com>

Add xilleon PCI ids.

---
commit 43a5e067ae126cee417017e8c69dfde18b82e670
tree 4251b31b2be06f724ecf0ff3f63805f09d3bffca
parent d559c11c9fecd8ec2a952982083e3a1fe118ab09
author David Daney <daney@dl2.hq2.avtrex.com> Tue, 04 Oct 2005 13:41:55 -0700
committer David Daney <daney@dl2.hq2.avtrex.com> Tue, 04 Oct 2005 13:41:55 -0700

 include/linux/pci_ids.h |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -370,6 +370,27 @@
 #define PCI_DEVICE_ID_ATI_IXP400_IDE	0x4376
 #define PCI_DEVICE_ID_ATI_IXP400_SATA   0x4379
 
+/* Xilleon X210 chip */
+#define PCI_DEVICE_ID_ATI_X210_HBIU	0x4860
+#define PCI_DEVICE_ID_ATI_X210_IDE	0x4861
+#define PCI_DEVICE_ID_ATI_X210_USB	0x4862
+#define PCI_DEVICE_ID_ATI_X210_DAIO	0x4863
+#define PCI_DEVICE_ID_ATI_X210_MODEM	0x4864
+
+/* Xilleon X226 chip */
+#define PCI_DEVICE_ID_ATI_X226_HBIU	0x4865
+#define PCI_DEVICE_ID_ATI_X226_IDE	0x4866
+#define PCI_DEVICE_ID_ATI_X226_USB	0x4867
+#define PCI_DEVICE_ID_ATI_X226_DAIO	0x4868
+#define PCI_DEVICE_ID_ATI_X226_MODEM	0x4869
+
+/* Xilleon X225 chip */
+#define PCI_DEVICE_ID_ATI_X225_HBIU	0x4855
+#define PCI_DEVICE_ID_ATI_X225_IDE	0x4856
+#define PCI_DEVICE_ID_ATI_X225_USB	0x4857
+#define PCI_DEVICE_ID_ATI_X225_DAIO	0x4858
+#define PCI_DEVICE_ID_ATI_X225_MODEM	0x4859
+
 #define PCI_VENDOR_ID_VLSI		0x1004
 #define PCI_DEVICE_ID_VLSI_82C592	0x0005
 #define PCI_DEVICE_ID_VLSI_82C593	0x0006
