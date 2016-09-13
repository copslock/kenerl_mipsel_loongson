Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2016 17:22:10 +0200 (CEST)
Received: from mga04.intel.com ([192.55.52.120]:46153 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991894AbcIMPWECM0Iz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Sep 2016 17:22:04 +0200
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP; 13 Sep 2016 08:21:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,329,1470726000"; 
   d="scan'208";a="8048297"
Received: from dcgshare.lm.intel.com ([10.232.118.254])
  by orsmga005.jf.intel.com with ESMTP; 13 Sep 2016 08:21:56 -0700
Received: by dcgshare.lm.intel.com (Postfix, from userid 1017)
        id 80B57E0C6D; Tue, 13 Sep 2016 09:21:56 -0600 (MDT)
From:   Keith Busch <keith.busch@intel.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCH] mips/pci: Reduce stack frame usage
Date:   Tue, 13 Sep 2016 09:21:47 -0600
Message-Id: <1473780107-4375-1-git-send-email-keith.busch@intel.com>
X-Mailer: git-send-email 1.7.1
Return-Path: <keith.busch@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keith.busch@intel.com
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

This patch removes creating a fake pci device in MIPS early config
access and instead just uses the pci bus to get the same functionality.
The struct pci_dev is too large to allocate on the stack, and was relying
on compiler optimizations to remove its usage.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---

While I don't have any hardware to test this, the change should be
exactly the same as before, taking the direct route to the config read
instead of letting the compiler optimize this.

This patch is preparing to add surprise removed device handling to the
pci_read_config_*, which makes the compiler optimization that currently
removes the excessive stack usage impossible.

 arch/mips/txx9/generic/pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/mips/txx9/generic/pci.c b/arch/mips/txx9/generic/pci.c
index 1f6bc9a..285d84e 100644
--- a/arch/mips/txx9/generic/pci.c
+++ b/arch/mips/txx9/generic/pci.c
@@ -29,12 +29,8 @@ static int __init
 early_read_config_word(struct pci_controller *hose,
 		       int top_bus, int bus, int devfn, int offset, u16 *value)
 {
-	struct pci_dev fake_dev;
 	struct pci_bus fake_bus;
 
-	fake_dev.bus = &fake_bus;
-	fake_dev.sysdata = hose;
-	fake_dev.devfn = devfn;
 	fake_bus.number = bus;
 	fake_bus.sysdata = hose;
 	fake_bus.ops = hose->pci_ops;
@@ -45,7 +41,7 @@ early_read_config_word(struct pci_controller *hose,
 	else
 		fake_bus.parent = NULL;
 
-	return pci_read_config_word(&fake_dev, offset, value);
+	return pci_bus_read_config_word(&fake_bus, devfn, offset, value);
 }
 
 int __init txx9_pci66_check(struct pci_controller *hose, int top_bus,
-- 
2.7.2
