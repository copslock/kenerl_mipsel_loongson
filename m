Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 May 2017 21:50:32 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.187]:59931 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993938AbdEETs6Cip2p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 May 2017 21:48:58 +0200
Received: from wuerfel.lan ([78.42.17.5]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MXi7y-1dav1E0O8c-00WU2d; Fri, 05 May 2017 21:48:38 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     stable@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3.16-stable 84/87] MIPS: MSP71xx: remove odd locking in PCI config space access code
Date:   Fri,  5 May 2017 21:47:42 +0200
Message-Id: <20170505194745.3627137-85-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170505194745.3627137-1-arnd@arndb.de>
References: <20170505194745.3627137-1-arnd@arndb.de>
X-Provags-ID: V03:K0:vepfLDJGfJeS3SkmxoExcga3zrrnB6J74u5Ef3PvPQHXTsaymxE
 PrnsbUsrDTz3FtF5PT4+hjjyoZjGcJDtnSm71C0dGiJGmZsw1k9UTQ4FWIQkE6z8ml/ojVi
 +JxGwR91Eu6/1VyUn9of56vIEyOCruA+5cOZNYgbbSOdFOpMV9wtNrwhkP7wsAAGdgWQGTz
 KLl2VIrE8pheE60B3/Euw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dK0gL/aRSLM=:faLg2k/HGXr9rVbbSIV0t5
 20bx/CRVDXDIVSQJFIw7eJO8ttf6QZZCPLQM4LmBVIeoExykQQ23c+Zaw4GHwPIzAXoJ/fFtN
 /d+bXBWKiCHHRiok1Hard2Bcs++hooVVL6oMLB9tCco/w1Wsef2dChkvd2uFsc2ptJerIodAc
 /sMaZf011WAeiKMkSwoylZB0djrFNkgqRmPeCq5T05vQRHh+8IZ5Pbnw8bgUUX8eOx59yLwkW
 4boDt/uK3iuhazzYUh6ASPSXIsuBz+LFmjzAsIG3qM1nzzZC1FVzF7i8pakv3KMTuxF4MLWG0
 jDlpmwtyAJv4n650WgmkxdOVdAxNFYTH7oGAg/z8yIZbtSXG2DOGSVASZvxzmMU4psJuU4gqQ
 Eo6UTVEQUBgCeN5ep3bve1kVwWHut4zyiaKdNsBnbonghrNeazSuaNg7xLSYK8Y/Tf1XDRd6y
 0XeZVrEVuqqyWRwIEUMnHribtJGCXcVGTPUK8KJQVt1WLc/4jcXSRBTF6fgY6i1n9RVIO1/MU
 SvVyxd4yI6QLMysnbPpXIDJVnEjSOC8EsJf4dtvc/Nc3MLvZd3eUGl02AAPE3ee25jpE5EC93
 1s5JB5ybAxQcaoXeuAml/28zzPGBRGpfWPwyxUpNPl0IQVfIhSjiWaYXhI2L4M1FYQcMg9CRB
 GuDtT0JHglQeE3Y8BJ9CQb/fiPL+x+vFzd4I5IJ99ucF7f591bR6QlZD7h7/e73+nKYo=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

From: Sergey Ryazanov <ryazanov.s.a@gmail.com>

Commit 7b2cae08b63e2acc94139c3dda557ac84165b327 upstream.

Caller (generic PCI code) already do proper locking so no need to add
another one here.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Linux MIPS <linux-mips@linux-mips.org>
Patchwork: https://patchwork.linux-mips.org/patch/7601/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/pci/ops-pmcmsp.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/mips/pci/ops-pmcmsp.c b/arch/mips/pci/ops-pmcmsp.c
index 50034f985be1..dd2d9f7e9412 100644
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
@@ -368,7 +366,6 @@ int msp_pcibios_config_access(unsigned char access_type,
 	struct msp_pci_regs *preg = (void *)PCI_BASE_REG;
 	unsigned char bus_num = bus->number;
 	unsigned char dev_fn = (unsigned char)devfn;
-	unsigned long flags;
 	unsigned long intr;
 	unsigned long value;
 	static char pciirqflag;
@@ -401,10 +398,7 @@ int msp_pcibios_config_access(unsigned char access_type,
 	}
 
 #if defined(CONFIG_PMC_MSP7120_GW) || defined(CONFIG_PMC_MSP7120_EVAL)
-	local_irq_save(flags);
 	vpe_status = dvpe();
-#else
-	spin_lock_irqsave(&bpci_lock, flags);
 #endif
 
 	/*
@@ -457,9 +451,6 @@ int msp_pcibios_config_access(unsigned char access_type,
 
 #if defined(CONFIG_PMC_MSP7120_GW) || defined(CONFIG_PMC_MSP7120_EVAL)
 		evpe(vpe_status);
-		local_irq_restore(flags);
-#else
-		spin_unlock_irqrestore(&bpci_lock, flags);
 #endif
 
 		return -1;
@@ -467,9 +458,6 @@ int msp_pcibios_config_access(unsigned char access_type,
 
 #if defined(CONFIG_PMC_MSP7120_GW) || defined(CONFIG_PMC_MSP7120_EVAL)
 	evpe(vpe_status);
-	local_irq_restore(flags);
-#else
-	spin_unlock_irqrestore(&bpci_lock, flags);
 #endif
 
 	return PCIBIOS_SUCCESSFUL;
-- 
2.9.0
