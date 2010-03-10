Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Mar 2010 16:48:18 +0100 (CET)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:65486 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492106Ab0CJPsN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Mar 2010 16:48:13 +0100
Received: by pvd12 with SMTP id 12so607605pvd.36
        for <multiple recipients>; Wed, 10 Mar 2010 07:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=JWLzpnpYPckrebmogDGle3A8wRCbjnPKmL8yFWzzO+Q=;
        b=T6ddnDT2LCVdrSfo+FSXHkvFTse7/zipYcYHxyxwQi4RdzM1DrTb0fRQcBmJWf3Vok
         fiEPXxfoSI8u5CWahkvQCx2DtuhfMVdJTtu/jzY2nmOwB6JEB+29na9pnP4GvSC6Z+cf
         pKaV4hhGNheutzg39cwo1hVHxt69o8XLiBCDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Z67tBXXXXPRmqVP+G25BGfcDMb2mzSeToAag6i1z8M0TvENi9343F6F9B2MaPuJCJm
         6p4W9CUjAFoZ743/DTaHScI8vkzxO8tfPuhiuL5ZYrRqNNT9JBltFHv3NT0OW81vBOuF
         jHhOkrHrFuCtD0y6WSZhmbf0vSx4WPZj5T/Rk=
Received: by 10.115.100.18 with SMTP id c18mr912427wam.62.1268236086647;
        Wed, 10 Mar 2010 07:48:06 -0800 (PST)
Received: from localhost.localdomain ([202.201.12.142])
        by mx.google.com with ESMTPS id 23sm7483770pzk.10.2010.03.10.07.48.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Mar 2010 07:48:05 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] Loongson: Lemote-2F: Fixup of _rdmsr and _wrmsr
Date:   Wed, 10 Mar 2010 23:41:34 +0800
Message-Id: <7c2dec50764082fafa83895b740f644fc592afa4.1268235182.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

The _rdmsr, _wrmsr operation must be atomic to ensure the accessing to msr
address is what we want.

Without this patch, in some cases, the reboot operation(fs2f_reboot) defined in
arch/mips/loongson/lemote-2f/reset.c may fail for it called _rdmsr, _wrmsr but
may be interrupted/preempted by the other related operations and make the
_rdmsr get the wrong value or make the _wrmsr write a wrong value to an
unexpected target.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/pci/ops-loongson2.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/mips/pci/ops-loongson2.c b/arch/mips/pci/ops-loongson2.c
index 2bb4057..1f93dfb 100644
--- a/arch/mips/pci/ops-loongson2.c
+++ b/arch/mips/pci/ops-loongson2.c
@@ -180,15 +180,20 @@ struct pci_ops loongson_pci_ops = {
 };
 
 #ifdef CONFIG_CS5536
+DEFINE_SPINLOCK(msr_lock);
 void _rdmsr(u32 msr, u32 *hi, u32 *lo)
 {
 	struct pci_bus bus = {
 		.number = PCI_BUS_CS5536
 	};
 	u32 devfn = PCI_DEVFN(PCI_IDSEL_CS5536, 0);
+	unsigned long flags;
+
+	spin_lock_irqsave(&msr_lock, flags);
 	loongson_pcibios_write(&bus, devfn, PCI_MSR_ADDR, 4, msr);
 	loongson_pcibios_read(&bus, devfn, PCI_MSR_DATA_LO, 4, lo);
 	loongson_pcibios_read(&bus, devfn, PCI_MSR_DATA_HI, 4, hi);
+	spin_unlock_irqrestore(&msr_lock, flags);
 }
 EXPORT_SYMBOL(_rdmsr);
 
@@ -198,9 +203,13 @@ void _wrmsr(u32 msr, u32 hi, u32 lo)
 		.number = PCI_BUS_CS5536
 	};
 	u32 devfn = PCI_DEVFN(PCI_IDSEL_CS5536, 0);
+	unsigned long flags;
+
+	spin_lock_irqsave(&msr_lock, flags);
 	loongson_pcibios_write(&bus, devfn, PCI_MSR_ADDR, 4, msr);
 	loongson_pcibios_write(&bus, devfn, PCI_MSR_DATA_LO, 4, lo);
 	loongson_pcibios_write(&bus, devfn, PCI_MSR_DATA_HI, 4, hi);
+	spin_unlock_irqrestore(&msr_lock, flags);
 }
 EXPORT_SYMBOL(_wrmsr);
 #endif
-- 
1.7.0.1
