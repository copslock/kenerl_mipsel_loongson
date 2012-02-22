Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Feb 2012 19:20:20 +0100 (CET)
Received: from mail-gy0-f201.google.com ([209.85.160.201]:37275 "EHLO
        mail-gy0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903745Ab2BVSTt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Feb 2012 19:19:49 +0100
Received: by ghy10 with SMTP id 10so46699ghy.0
        for <linux-mips@linux-mips.org>; Wed, 22 Feb 2012 10:19:43 -0800 (PST)
Received-SPF: pass (google.com: domain of bhelgaas@google.com designates 10.236.192.164 as permitted sender) client-ip=10.236.192.164;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of bhelgaas@google.com designates 10.236.192.164 as permitted sender) smtp.mail=bhelgaas@google.com; dkim=pass header.i=bhelgaas@google.com
Received: from mr.google.com ([10.236.192.164])
        by 10.236.192.164 with SMTP id i24mr67790093yhn.8.1329934783658 (num_hops = 1);
        Wed, 22 Feb 2012 10:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=gamma;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=+1Tg68MUrUdkYJBPf4zZzIhJOCahvnx2JOmPQ3BE2v4=;
        b=Nn97a7sichbh/W2ZK+ZEVISHC7I6pjr3vV77bkyhE2V7wtA0RR/CzlsyulnFnIbtWr
         2KzsCx00tYO5oSUq6XpJbKEDWvI3R+/SAMwCUnSOU2p5p8f4EMTDBv4VFJwZcsOCTvTt
         85x1YVuvD2uX9p8pzbCyX4DLmtSRFcla8d/Jo=
Received: by 10.236.192.164 with SMTP id i24mr48331804yhn.8.1329934783644;
        Wed, 22 Feb 2012 10:19:43 -0800 (PST)
Received: by 10.236.192.164 with SMTP id i24mr48331781yhn.8.1329934783576;
        Wed, 22 Feb 2012 10:19:43 -0800 (PST)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id i36si2273774anp.0.2012.02.22.10.19.43
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 22 Feb 2012 10:19:43 -0800 (PST)
Received: from bhelgaas.mtv.corp.google.com (bhelgaas.mtv.corp.google.com [172.18.96.155])
        by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 75897100052;
        Wed, 22 Feb 2012 10:19:43 -0800 (PST)
Received: from bhelgaas.mtv.corp.google.com (unknown [IPv6:::1])
        by bhelgaas.mtv.corp.google.com (Postfix) with ESMTP id 2B062180085;
        Wed, 22 Feb 2012 10:19:43 -0800 (PST)
Subject: [PATCH v1 08/11] mips/PCI: removed unused pci_probe configurability
To:     linux-pci@vger.kernel.org
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Date:   Wed, 22 Feb 2012 11:19:43 -0700
Message-ID: <20120222181943.27513.19771.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120222181556.27513.9413.stgit@bhelgaas.mtv.corp.google.com>
References: <20120222181556.27513.9413.stgit@bhelgaas.mtv.corp.google.com>
User-Agent: StGit/0.15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQmgrbRztsnTkVjiI6fmwSsNFrAfRvMETG+jXjTV7yE4481telE1/RoVeek348w/mZZxXkdMDUsf2+DmwrQAD+QT7/DUnSmMb8NNBICzSjgT3Rus5e9GyAcygzie62oYUYMbPdhqt3HJjp1EvJWZWMAak3+TULzzpUT9SkuqdLURi6y+C9U=
X-archive-position: 32498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

We never assign anything other than PCI_ASSIGN_ALL_BUSSES to pci_probe,
so just remove the indirection.  If configurability is required in the
future, please use the pci_flags/PCI_REASSIGN_ALL_BUS functionality
as is done for powerpc.

CC: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mips/pci/pci.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 2a11045..19f6d19 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -24,10 +24,6 @@
  * assignments.
  */
 
-#define PCI_ASSIGN_ALL_BUSSES	1
-
-unsigned int pci_probe = PCI_ASSIGN_ALL_BUSSES;
-
 /*
  * The PCI controller list.
  */
@@ -238,7 +234,7 @@ static int pcibios_enable_resources(struct pci_dev *dev, int mask)
 
 unsigned int pcibios_assign_all_busses(void)
 {
-	return (pci_probe & PCI_ASSIGN_ALL_BUSSES) ? 1 : 0;
+	return 1;
 }
 
 int pcibios_enable_device(struct pci_dev *dev, int mask)
