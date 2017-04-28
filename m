Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2017 10:34:57 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:57472 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990644AbdD1IetSM2Zl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Apr 2017 10:34:49 +0200
Received: from localhost (unknown [195.77.54.9])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CB31D898;
        Fri, 28 Apr 2017 08:34:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3.18 34/47] MIPS: MSP71xx: remove odd locking in PCI config space access code
Date:   Fri, 28 Apr 2017 10:32:47 +0200
Message-Id: <20170428083039.734072662@linuxfoundation.org>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170428083038.327543269@linuxfoundation.org>
References: <20170428083038.327543269@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57806
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergey Ryazanov <ryazanov.s.a@gmail.com>

commit c4a305374bbf36414515d2ae00d588c67051e67d upstream.

Caller (generic PCI code) already do proper locking so no need to add
another one here.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Linux MIPS <linux-mips@linux-mips.org>
Patchwork: https://patchwork.linux-mips.org/patch/7601/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/pci/ops-pmcmsp.c |   12 ------------
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
