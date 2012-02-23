Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2012 20:45:06 +0100 (CET)
Received: from mail-qy0-f201.google.com ([209.85.216.201]:53737 "EHLO
        mail-qy0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903765Ab2BWTo6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Feb 2012 20:44:58 +0100
Received: by qcse1 with SMTP id e1so16153qcs.0
        for <linux-mips@linux-mips.org>; Thu, 23 Feb 2012 11:44:52 -0800 (PST)
Received-SPF: pass (google.com: domain of bhelgaas@google.com designates 10.236.145.135 as permitted sender) client-ip=10.236.145.135;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of bhelgaas@google.com designates 10.236.145.135 as permitted sender) smtp.mail=bhelgaas@google.com; dkim=pass header.i=bhelgaas@google.com
Received: from mr.google.com ([10.236.145.135])
        by 10.236.145.135 with SMTP id p7mr5860537yhj.2.1330026292571 (num_hops = 1);
        Thu, 23 Feb 2012 11:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=gamma;
        h=subject:to:from:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=3v+Vq7jR52YAmjuiL3SApGgl5idh2KVHimKhDkvo7wk=;
        b=mpsIiIMdoScfD7MQit2gTQY4LDVQ9yGis/iW/cI3unwBOJ3+/fCErmH7KOOuTAdcEO
         qPpa7cPG6zkDDyDm8fF0iQzPG23u49M+kaoN1cuQBnv0R25ksCn3GKT3XB2sQWz17SW8
         3l0QAWaVqqLwjYlISc1oxOS/g3A3w89+bcgpY=
Received: by 10.236.145.135 with SMTP id p7mr4163925yhj.2.1330026292547;
        Thu, 23 Feb 2012 11:44:52 -0800 (PST)
Received: by 10.236.145.135 with SMTP id p7mr4163910yhj.2.1330026292499;
        Thu, 23 Feb 2012 11:44:52 -0800 (PST)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id z63si1343749yhg.5.2012.02.23.11.44.52
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 23 Feb 2012 11:44:52 -0800 (PST)
Received: from bhelgaas.mtv.corp.google.com (bhelgaas.mtv.corp.google.com [172.18.96.155])
        by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 649771E004D;
        Thu, 23 Feb 2012 11:44:52 -0800 (PST)
Received: from bhelgaas.mtv.corp.google.com (unknown [IPv6:::1])
        by bhelgaas.mtv.corp.google.com (Postfix) with ESMTP id 1FA24180059;
        Thu, 23 Feb 2012 11:44:52 -0800 (PST)
Subject: [PATCH] mips/PCI: remove titan_ht_pcibios_fixup_bus() code that does
        nothing
To:     linux-pci@vger.kernel.org
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Date:   Thu, 23 Feb 2012 12:44:52 -0700
Message-ID: <20120223194452.21202.13905.stgit@bhelgaas.mtv.corp.google.com>
User-Agent: StGit/0.15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkjWe0Z5NDS/aV33CzZy9Sr1c7Kk+dNRmCBOZ9BhV503ujy4UDlJK2VbBHr6vz7h9tFloE/Yg8cYQ0vCJSm48DqnurqP35SHtdjZxwy1MYzSA8QOIukoZYff1kCCiWejnKT8MSwhuQAnsSLz5uvnhFLW/5uGsbP09zuzDLTurEbCQYluzY=
X-archive-position: 32531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This list traversal seems pointless.

CC: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mips/pmc-sierra/yosemite/ht-irq.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/mips/pmc-sierra/yosemite/ht-irq.c b/arch/mips/pmc-sierra/yosemite/ht-irq.c
index 86b98e9..62ead66 100644
--- a/arch/mips/pmc-sierra/yosemite/ht-irq.c
+++ b/arch/mips/pmc-sierra/yosemite/ht-irq.c
@@ -35,16 +35,6 @@
  */
 void __init titan_ht_pcibios_fixup_bus(struct pci_bus *bus)
 {
-	struct pci_bus *current_bus = bus;
-	struct pci_dev *devices;
-	struct list_head *devices_link;
-
-	list_for_each(devices_link, &(current_bus->devices)) {
-		devices = pci_dev_b(devices_link);
-		if (devices == NULL)
-			continue;
-	}
-
 	/*
 	 * PLX and SPKT related changes go here
 	 */
