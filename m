Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 22:40:15 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:59436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993637AbdJEUjR5RC-f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Oct 2017 22:39:17 +0200
Received: from localhost (unknown [64.22.228.164])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C34F42191B;
        Thu,  5 Oct 2017 20:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34F42191B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Subject: [PATCH 4/4] alpha/PCI: Make pdev_save_srm_config() static
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Howells <dhowells@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        linux-am33-list@redhat.com,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Helge Deller <deller@gmx.de>, x86@kernel.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Ingo Molnar <mingo@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        linux-xtensa@linux-xtensa.org, Mikael Starvik <starvik@axis.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Henderson <rth@twiddle.net>,
        Chris Zankel <chris@zankel.net>,
        Tony Luck <tony.luck@intel.com>, linux-cris-kernel@axis.com,
        linux-parisc@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Date:   Thu, 05 Oct 2017 15:39:06 -0500
Message-ID: <20171005203906.18300.63272.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171005201939.18300.25690.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20171005201939.18300.25690.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <helgaas@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60288
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

pdev_save_srm_config() and struct pdev_srm_saved_conf are only used in
arch/alpha/kernel/pci.c, so make them static there.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/alpha/kernel/pci.c      |   11 ++++++++++-
 arch/alpha/kernel/pci_impl.h |    8 --------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 564114eb85e1..16b67621a0d5 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -196,9 +196,16 @@ pcibios_init(void)
 subsys_initcall(pcibios_init);
 
 #ifdef ALPHA_RESTORE_SRM_SETUP
+/* Store PCI device configuration left by SRM here. */
+struct pdev_srm_saved_conf
+{
+	struct pdev_srm_saved_conf *next;
+	struct pci_dev *dev;
+};
+
 static struct pdev_srm_saved_conf *srm_saved_configs;
 
-void pdev_save_srm_config(struct pci_dev *dev)
+static void pdev_save_srm_config(struct pci_dev *dev)
 {
 	struct pdev_srm_saved_conf *tmp;
 	static int printed = 0;
@@ -238,6 +245,8 @@ pci_restore_srm_config(void)
 		pci_restore_state(tmp->dev);
 	}
 }
+#else
+#define pdev_save_srm_config(dev)	do {} while (0)
 #endif
 
 void pcibios_fixup_bus(struct pci_bus *bus)
diff --git a/arch/alpha/kernel/pci_impl.h b/arch/alpha/kernel/pci_impl.h
index 2b0ac429f5eb..65adea0d3d78 100644
--- a/arch/alpha/kernel/pci_impl.h
+++ b/arch/alpha/kernel/pci_impl.h
@@ -156,16 +156,8 @@ struct pci_iommu_arena
 #endif
 
 #ifdef ALPHA_RESTORE_SRM_SETUP
-/* Store PCI device configuration left by SRM here. */
-struct pdev_srm_saved_conf
-{
-	struct pdev_srm_saved_conf *next;
-	struct pci_dev *dev;
-};
-
 extern void pci_restore_srm_config(void);
 #else
-#define pdev_save_srm_config(dev)	do {} while (0)
 #define pci_restore_srm_config()	do {} while (0)
 #endif
 
