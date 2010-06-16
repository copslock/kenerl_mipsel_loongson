Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jun 2010 13:35:53 +0200 (CEST)
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:43813 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492047Ab0FPLfu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jun 2010 13:35:50 +0200
Received: from faui48a.informatik.uni-erlangen.de (faui48a.informatik.uni-erlangen.de [131.188.34.55])
        by faui40.informatik.uni-erlangen.de (Postfix) with ESMTP id B2ED95F1C2;
        Wed, 16 Jun 2010 13:35:48 +0200 (MEST)
Received: by faui48a.informatik.uni-erlangen.de (Postfix, from userid 31996)
        id A2845774CF7; Wed, 16 Jun 2010 13:35:48 +0200 (CEST)
Date:   Wed, 16 Jun 2010 13:35:48 +0200
From:   Christoph Egger <siccegge@cs.fau.de>
To:     Shane McDonald <mcdonald.shane@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, vamos@i4.informatik.uni-erlangen.de
Subject: Re: [PATCH 5/9] Removing dead CONFIG_BLK_DEV_IDE
Message-ID: <20100616113548.GA10065@faui48a.informatik.uni-erlangen.de>
References: <cover.1275925108.git.siccegge@cs.fau.de> <73e9e4bd7615488c9567f02f8962825386956365.1275925108.git.siccegge@cs.fau.de> <AANLkTillx50SaxZU2cT9YSlS4uRF_ED5-wlG-JwfXfFT@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTillx50SaxZU2cT9YSlS4uRF_ED5-wlG-JwfXfFT@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 27144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: siccegge@cs.fau.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 11137

On Thu, Jun 10, 2010 at 12:23:06PM -0600, Shane McDonald wrote:
>   I wonder if, instead of deleting the code, the constant should be
> changed from CONFIG_BLK_DEV_IDE to CONFIG_IDE.  The original
> patch that removed CONFIG_BLK_DEV_IDE seemed to make this change:
> http://kerneltrap.org/mailarchive/linux-kernel/2008/8/13/2929444
> 
> Shane

You're probably right, updated patch below

-------
From: Christoph Egger <siccegge@cs.fau.de>
Date: Mon, 7 Jun 2010 17:29:48 +0200
Subject: [PATCH 5/9] Removing dead CONFIG_BLK_DEV_IDE

CONFIG_BLK_DEV_IDE doesn't exist in Kconfig, therefore removing all
references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
diff --git a/arch/mips/mti-malta/malta-setup.c
b/arch/mips/mti-malta/malta-setup.c
index b7f37d4..f6a5ea8 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -105,7 +105,7 @@ static void __init fd_activate(void)
 }
 #endif
 
-#ifdef CONFIG_BLK_DEV_IDE
+#ifdef CONFIG_IDE
 static void __init pci_clock_check(void)
 {
        unsigned int __iomem *jmpr_p =
@@ -207,7 +207,7 @@ void __init plat_mem_setup(void)
        if (mips_revision_sconid == MIPS_REVISION_SCON_BONITO)
                bonito_quirks_setup();
 
-#ifdef CONFIG_BLK_DEV_IDE
+#ifdef CONFIG_IDE
        pci_clock_check();
 #endif
 
