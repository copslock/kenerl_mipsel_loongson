Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Feb 2011 14:52:58 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:49129 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491031Ab1BONwz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Feb 2011 14:52:55 +0100
Received: by fxm19 with SMTP id 19so198866fxm.36
        for <multiple recipients>; Tue, 15 Feb 2011 05:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=kmDjV50ss6vUMQ6w9RGNH1IkyyuDO9DHio39vh5Nr24=;
        b=Gt9TiBfE0anK1txlBeVpnWnYt31YRfB9SRREzjkQcX/dpjTCXRy+xO1tskKkeMc92w
         PFuBQSlIgGNr71/YEg8Z1y8JV51etpXTftZ8mR+Km+0qkAclRvbhRoPVx/O6txC1/EC6
         Q3rQomc3IJQGjWwHfffjGwzbHy0k+7t91OeoM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ovZGr7FLvtLqzdog3W/WfEil7u12HV9upvPMb9n4ACjtF6R6OOySzjbeMn1vC+V+b1
         +c+0XthU+xpq6rrqCrMeeleLauMpvmAE5bdKU2KPSBd4dHkLnD5rMyFn4ehnr/ezLq+K
         nQ7F11zx4rh8lErQUdQeRsPq4Pi1ehAEQUJBo=
Received: by 10.223.114.203 with SMTP id f11mr3925413faq.20.1297777969858;
        Tue, 15 Feb 2011 05:52:49 -0800 (PST)
Received: from localhost.localdomain ([59.160.135.215])
        by mx.google.com with ESMTPS id r24sm1652949fax.3.2011.02.15.05.52.45
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 05:52:48 -0800 (PST)
From:   "Anoop P.A" <anoop.pa@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Anoop P A <anoop.pa@gmail.com>
Subject: [PATCH 2/2] Fix pci id check.
Date:   Tue, 15 Feb 2011 19:44:10 +0530
Message-Id: <1297779250-26798-1-git-send-email-anoop.pa@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1297779151-26595-1-git-send-email-anoop.pa@gmail.com>
References: <1297779151-26595-1-git-send-email-anoop.pa@gmail.com>
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

From: Anoop P A <anoop.pa@gmail.com>

Pci id check was failing on most of the evaluation boards.

Signed-off-by: Anoop P A <anoop.pa@gmail.com>
---
 arch/mips/include/asm/pmc-sierra/msp71xx/msp_pci.h |    6 +++++-
 arch/mips/pci/ops-pmcmsp.c                         |    4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/pmc-sierra/msp71xx/msp_pci.h b/arch/mips/include/asm/pmc-sierra/msp71xx/msp_pci.h
index 4156069..c74daca 100644
--- a/arch/mips/include/asm/pmc-sierra/msp71xx/msp_pci.h
+++ b/arch/mips/include/asm/pmc-sierra/msp71xx/msp_pci.h
@@ -26,7 +26,11 @@
 #ifndef _MSP_PCI_H_
 #define _MSP_PCI_H_
 
-#define MSP_HAS_PCI(ID)	(((u32)(ID) <= 0x4236) && ((u32)(ID) >= 0x4220))
+#define MSP_HAS_PCI(ID)  ((((u32)(ID) <= (0x4236)) && \
+			((u32)(ID) >= (0x4220))) || \
+			((u32)(ID) == (0x7140)))
+#define MSP_PCI_READ_REG32(base, byte_offset) \
+	(*((volatile u32 *)((u8 *)(base) + (byte_offset))))
 
 /*
  * It is convenient to program the OATRAN register so that
diff --git a/arch/mips/pci/ops-pmcmsp.c b/arch/mips/pci/ops-pmcmsp.c
index caedf9a..8d5c2e6 100644
--- a/arch/mips/pci/ops-pmcmsp.c
+++ b/arch/mips/pci/ops-pmcmsp.c
@@ -966,9 +966,9 @@ void __init msp_pci_init(void)
 	u32 id;
 
 	/* Extract Device ID */
-	id = read_reg32(PCI_JTAG_DEVID_REG, 0xFFFF) >> 12;
+	id = (MSP_PCI_READ_REG32(PCI_JTAG_DEVID_REG, 0) >> 12) & 0x0FFFF;
 
-	/* Check if JTAG ID identifies MSP7120 */
+	/* Check if JTAG ID identifies MSP71xx */
 	if (!MSP_HAS_PCI(id)) {
 		printk(KERN_WARNING "PCI: No PCI; id reads as %x\n", id);
 		goto no_pci;
-- 
1.7.0.4
