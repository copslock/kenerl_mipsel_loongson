Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Aug 2014 04:05:43 +0200 (CEST)
Received: from mail-lb0-f173.google.com ([209.85.217.173]:51691 "EHLO
        mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007489AbaH3CF2KU8n2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Aug 2014 04:05:28 +0200
Received: by mail-lb0-f173.google.com with SMTP id c11so3458246lbj.4
        for <multiple recipients>; Fri, 29 Aug 2014 19:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/WwoaBNfI2W4mHIplH7ME/HynIAsLeev9DADzHSp7sc=;
        b=l7FZSHlohqhWXiNg1Gpu0GuV/inj8jxxdHT5b+zSh+kBpp/OCoq73x5n2g+3QBjcWX
         /wiY0W+bDggg/xJ1m0tr/EABUXmBqfytTlBefGS19P84B6REUrUUvsAjHTrm3Q19ASgh
         45sUKdtUXQ7IBDyaQwsiIGkQt0OBO7NE2Fhzlr6gWO9bYENaG5J7zeqHV7W81QI7N4g2
         lNaVZUQ46VcGATeTuz3hh3wLlma1jMlxWkt03IBwB9PWSa4dPAt5k9NYGRFcj68JNakq
         7mKwbN7UH2cuA851zkphUldKz9WKGRLmsKsYer3NWdxTnled7F22/wHBdx4RhXTuOTHK
         ocTg==
X-Received: by 10.152.205.9 with SMTP id lc9mr14696011lac.45.1409364322723;
        Fri, 29 Aug 2014 19:05:22 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([188.113.6.134])
        by mx.google.com with ESMTPSA id l10sm2512262lbc.3.2014.08.29.19.05.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Aug 2014 19:05:21 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 1/5] MIPS: NILE4: remove odd locking in PCI config space access code
Date:   Sat, 30 Aug 2014 06:06:24 +0400
Message-Id: <1409364388-7108-2-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1409364388-7108-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1409364388-7108-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

Caller (generic PCI code) already do proper locking so no need to add
another one here.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Linux MIPS <linux-mips@linux-mips.org>
---
 arch/mips/pci/ops-nile4.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/mips/pci/ops-nile4.c b/arch/mips/pci/ops-nile4.c
index a1a7c9f..b9d1fd0 100644
--- a/arch/mips/pci/ops-nile4.c
+++ b/arch/mips/pci/ops-nile4.c
@@ -13,8 +13,6 @@
 
 volatile unsigned long *const vrc_pciregs = (void *) Vrc5074_BASE;
 
-static DEFINE_SPINLOCK(nile4_pci_lock);
-
 static int nile4_pcibios_config_access(unsigned char access_type,
 	struct pci_bus *bus, unsigned int devfn, int where, u32 *val)
 {
@@ -76,7 +74,6 @@ static int nile4_pcibios_config_access(unsigned char access_type,
 static int nile4_pcibios_read(struct pci_bus *bus, unsigned int devfn,
 	int where, int size, u32 *val)
 {
-	unsigned long flags;
 	u32 data = 0;
 	int err;
 
@@ -85,11 +82,8 @@ static int nile4_pcibios_read(struct pci_bus *bus, unsigned int devfn,
 	else if ((size == 4) && (where & 3))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	spin_lock_irqsave(&nile4_pci_lock, flags);
 	err = nile4_pcibios_config_access(PCI_ACCESS_READ, bus, devfn, where,
-					&data);
-	spin_unlock_irqrestore(&nile4_pci_lock, flags);
-
+					  &data);
 	if (err)
 		return err;
 
@@ -106,7 +100,6 @@ static int nile4_pcibios_read(struct pci_bus *bus, unsigned int devfn,
 static int nile4_pcibios_write(struct pci_bus *bus, unsigned int devfn,
 	int where, int size, u32 val)
 {
-	unsigned long flags;
 	u32 data = 0;
 	int err;
 
@@ -115,11 +108,8 @@ static int nile4_pcibios_write(struct pci_bus *bus, unsigned int devfn,
 	else if ((size == 4) && (where & 3))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	spin_lock_irqsave(&nile4_pci_lock, flags);
 	err = nile4_pcibios_config_access(PCI_ACCESS_READ, bus, devfn, where,
 					  &data);
-	spin_unlock_irqrestore(&nile4_pci_lock, flags);
-
 	if (err)
 		return err;
 
-- 
1.8.1.5
