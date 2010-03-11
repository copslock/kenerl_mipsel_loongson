Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Mar 2010 04:38:44 +0100 (CET)
Received: from mail-ew0-f224.google.com ([209.85.219.224]:63055 "EHLO
        mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491124Ab0CKDih (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Mar 2010 04:38:37 +0100
Received: by ewy24 with SMTP id 24so1849056ewy.27
        for <multiple recipients>; Wed, 10 Mar 2010 19:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=qjc/R9AHcZY4Jjx5KeBN8cgL43HJmwXdEVWQpnn3xeo=;
        b=QduLaEs4KjF1HPbcwY0cwWjb6mTTj3KOgbt9dFZ2cOYzUHzj6UXPI3vvjOBzjf6X2b
         48ehndpayajz12X5YKLGCu7f7UlvXKLLEVfyWkCDQKvWEO5e3VMYsMtgqkbAPB02aIp4
         SMP5Jq+9IV2Ua6B0ZC2og0mser0s6iJoNitnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=P07sxbN9TcE2mIGQf/ajWG/j5xc7BqosVSRX+Cmgu0lKIAJcPg9vs3ogNCQbU1l6Cj
         zv52oDKI03NjVL40h/Hdmnvadbh20XFusv5MYh8EXNUHTxNCpxRRRnGUlcpqUnDWgbEB
         j9+nfj1sG3QwSSmnummD4Rphf9q6t1DmLTQJo=
Received: by 10.213.8.26 with SMTP id f26mr5812818ebf.14.1268278712287;
        Wed, 10 Mar 2010 19:38:32 -0800 (PST)
Received: from localhost.localdomain ([202.201.12.142])
        by mx.google.com with ESMTPS id 14sm4495557ewy.6.2010.03.10.19.38.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Mar 2010 19:38:31 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v3] Loongson: Lemote-2F: Fixup of _rdmsr and _wrmsr
Date:   Thu, 11 Mar 2010 11:30:50 +0800
Message-Id: <fe322709a0f6b86545d26cd6fce4f9e271794efa.1268278141.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

v2 --> v3:
  o Using the right operations for the raw spinlock.
v1 --> v2:
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
index 2bb4057..d657ee0 100644
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
+	raw_spin_lock_irqsave(&msr_lock, flags);
 	loongson_pcibios_write(&bus, devfn, PCI_MSR_ADDR, 4, msr);
 	loongson_pcibios_read(&bus, devfn, PCI_MSR_DATA_LO, 4, lo);
 	loongson_pcibios_read(&bus, devfn, PCI_MSR_DATA_HI, 4, hi);
+	raw_spin_unlock_irqrestore(&msr_lock, flags);
 }
 EXPORT_SYMBOL(_rdmsr);
 
@@ -198,9 +204,13 @@ void _wrmsr(u32 msr, u32 hi, u32 lo)
 		.number = PCI_BUS_CS5536
 	};
 	u32 devfn = PCI_DEVFN(PCI_IDSEL_CS5536, 0);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&msr_lock, flags);
 	loongson_pcibios_write(&bus, devfn, PCI_MSR_ADDR, 4, msr);
 	loongson_pcibios_write(&bus, devfn, PCI_MSR_DATA_LO, 4, lo);
 	loongson_pcibios_write(&bus, devfn, PCI_MSR_DATA_HI, 4, hi);
+	raw_spin_unlock_irqrestore(&msr_lock, flags);
 }
 EXPORT_SYMBOL(_wrmsr);
 #endif
-- 
1.7.0.1
