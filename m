Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Mar 2010 04:04:26 +0100 (CET)
Received: from mail-ew0-f224.google.com ([209.85.219.224]:33978 "EHLO
        mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491867Ab0CKDEW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Mar 2010 04:04:22 +0100
Received: by ewy24 with SMTP id 24so1842821ewy.27
        for <multiple recipients>; Wed, 10 Mar 2010 19:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=jK+qhN8lHzICC6Jx7pteJ4qsmQU7yV8FGIQ2lYyUWAo=;
        b=AkgiG8Brv01xXc16ynycx3X4AKQrfEt8eKeAWKsItwNZeijNbg/CdTteWl/hb354t3
         +NQ+1q+7b/MFypmunDpdjI42fMw2+Il37MoutCj0h9aKIoO3yaS0m8k3Ahj+97aLKQz0
         pXvb0JjkAOYKgP8vN7EgL9IKYUgKc5zI65g6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hYMtEQs8/r5S8S04SVq1tmxK+ngz4ZK8s7S9PrKqPx5jd1IaCkrc0z9aaw9PPh/lbL
         tRxmhTRD6ToDWCQmRbk22V36GPUc6Q40Srb5ggk0XAuowmwjHeXKfT4v55/6+E5xZewk
         EyCZWRodkQHMjosxZm+v6KeFuEQLAy2mOGUwE=
Received: by 10.213.97.28 with SMTP id j28mr5823117ebn.44.1268276653827;
        Wed, 10 Mar 2010 19:04:13 -0800 (PST)
Received: from localhost.localdomain ([202.201.12.142])
        by mx.google.com with ESMTPS id 14sm4394844ewy.10.2010.03.10.19.04.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Mar 2010 19:04:12 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v2] Loongson: Lemote-2F: Fixup of _rdmsr and _wrmsr
Date:   Thu, 11 Mar 2010 10:57:33 +0800
Message-Id: <5c63967ed3f891da1f6bc1fc78c272d0407d5d25.1268276186.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Changes from the old version:
  o Using raw spinlock instead of spinlock as suggested by David Daney.

The _rdmsr, _wrmsr operation must be atomic to ensure the accessing to msr
address is what we want.

Without this patch, in some cases, the reboot operation(fs2f_reboot) defined in
arch/mips/loongson/lemote-2f/reset.c may fail for it called _rdmsr, _wrmsr but
may be interrupted/preempted by the other related operations and make the
_rdmsr get the wrong value or make the _wrmsr write a wrong value to an
unexpected target.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/pci/ops-loongson2.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/mips/pci/ops-loongson2.c b/arch/mips/pci/ops-loongson2.c
index 2bb4057..dc434ec 100644
--- a/arch/mips/pci/ops-loongson2.c
+++ b/arch/mips/pci/ops-loongson2.c
@@ -180,15 +180,21 @@ struct pci_ops loongson_pci_ops = {
 };
 
 #ifdef CONFIG_CS5536
+DEFINE_RAW_SPINLOCK(msr_lock);
+
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
 
@@ -198,9 +204,13 @@ void _wrmsr(u32 msr, u32 hi, u32 lo)
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
