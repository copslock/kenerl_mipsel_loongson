Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2017 00:55:51 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34054 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991120AbdKFXyOk9Caf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Nov 2017 00:54:14 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1eBrDV-0008UD-OJ; Mon, 06 Nov 2017 23:54:10 +0000
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1eBrDT-00013g-Rt; Mon, 06 Nov 2017 23:54:07 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Sergey Ryazanov" <ryazanov.s.a@gmail.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Linux MIPS" <linux-mips@linux-mips.org>
Date:   Mon, 06 Nov 2017 23:03:02 +0000
Message-ID: <lsq.1510009382.405486143@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 281/294] MIPS: MSP71xx: remove odd locking in PCI
 config space access code
In-Reply-To: <lsq.1510009377.526284287@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.50-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sergey Ryazanov <ryazanov.s.a@gmail.com>

commit c4a305374bbf36414515d2ae00d588c67051e67d upstream.

Caller (generic PCI code) already do proper locking so no need to add
another one here.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Linux MIPS <linux-mips@linux-mips.org>
Patchwork: https://patchwork.linux-mips.org/patch/7601/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/pci/ops-pmcmsp.c | 12 ------------
 1 file changed, 12 deletions(-)

--- a/arch/mips/pci/ops-pmcmsp.c
+++ b/arch/mips/pci/ops-pmcmsp.c
@@ -193,8 +193,6 @@ static void pci_proc_init(void)
 }
 #endif /* CONFIG_PROC_FS && PCI_COUNTERS */
 
-static DEFINE_SPINLOCK(bpci_lock);
-
 /*****************************************************************************
  *
  *  STRUCT: pci_io_resource
@@ -368,7 +366,6 @@ int msp_pcibios_config_access(unsigned c
 	struct msp_pci_regs *preg = (void *)PCI_BASE_REG;
 	unsigned char bus_num = bus->number;
 	unsigned char dev_fn = (unsigned char)devfn;
-	unsigned long flags;
 	unsigned long intr;
 	unsigned long value;
 	static char pciirqflag;
@@ -401,10 +398,7 @@ int msp_pcibios_config_access(unsigned c
 	}
 
 #if defined(CONFIG_PMC_MSP7120_GW) || defined(CONFIG_PMC_MSP7120_EVAL)
-	local_irq_save(flags);
 	vpe_status = dvpe();
-#else
-	spin_lock_irqsave(&bpci_lock, flags);
 #endif
 
 	/*
@@ -457,9 +451,6 @@ int msp_pcibios_config_access(unsigned c
 
 #if defined(CONFIG_PMC_MSP7120_GW) || defined(CONFIG_PMC_MSP7120_EVAL)
 		evpe(vpe_status);
-		local_irq_restore(flags);
-#else
-		spin_unlock_irqrestore(&bpci_lock, flags);
 #endif
 
 		return -1;
@@ -467,9 +458,6 @@ int msp_pcibios_config_access(unsigned c
 
 #if defined(CONFIG_PMC_MSP7120_GW) || defined(CONFIG_PMC_MSP7120_EVAL)
 	evpe(vpe_status);
-	local_irq_restore(flags);
-#else
-	spin_unlock_irqrestore(&bpci_lock, flags);
 #endif
 
 	return PCIBIOS_SUCCESSFUL;
