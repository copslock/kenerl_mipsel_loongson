Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2012 20:44:24 +0100 (CET)
Received: from mail-bk0-f73.google.com ([209.85.214.73]:56770 "EHLO
        mail-bk0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903637Ab2BWTnt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Feb 2012 20:43:49 +0100
Received: by bkcji1 with SMTP id ji1so36720bkc.0
        for <linux-mips@linux-mips.org>; Thu, 23 Feb 2012 11:43:44 -0800 (PST)
Received-SPF: pass (google.com: domain of bhelgaas@google.com designates 10.14.186.9 as permitted sender) client-ip=10.14.186.9;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of bhelgaas@google.com designates 10.14.186.9 as permitted sender) smtp.mail=bhelgaas@google.com; dkim=pass header.i=bhelgaas@google.com
Received: from mr.google.com ([10.14.186.9])
        by 10.14.186.9 with SMTP id v9mr1504917eem.5.1330026224303 (num_hops = 1);
        Thu, 23 Feb 2012 11:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=gamma;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=+1Tg68MUrUdkYJBPf4zZzIhJOCahvnx2JOmPQ3BE2v4=;
        b=e/OSopWfcq4X8sQYJymOIFEaB/6pemq5TMiwbRUlf4rgJ4FTsmyR2QxR7hiA2BNTxf
         qgT5ksM5c4M1akN0lGK53Q4tSZ6nd5Ojg9Nj7zlJ4BGCHbbJKuAEwL4xj2KqwIMfIIPc
         iWznHEO0AeN8HYx37+eANlra2kZncBDJ8LiKU=
Received: by 10.14.186.9 with SMTP id v9mr1285946eem.5.1330026224235;
        Thu, 23 Feb 2012 11:43:44 -0800 (PST)
Received: by 10.14.186.9 with SMTP id v9mr1285927eem.5.1330026224078;
        Thu, 23 Feb 2012 11:43:44 -0800 (PST)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id p49si1764747eef.0.2012.02.23.11.43.44
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 23 Feb 2012 11:43:44 -0800 (PST)
Received: from bhelgaas.mtv.corp.google.com (bhelgaas.mtv.corp.google.com [172.18.96.155])
        by hpza10.eem.corp.google.com (Postfix) with ESMTP id DBDF020004E;
        Thu, 23 Feb 2012 11:43:43 -0800 (PST)
Received: from bhelgaas.mtv.corp.google.com (unknown [IPv6:::1])
        by bhelgaas.mtv.corp.google.com (Postfix) with ESMTP id 45E5A180059;
        Thu, 23 Feb 2012 11:43:43 -0800 (PST)
Subject: [PATCH v2 08/12] mips/PCI: removed unused pci_probe configurability
To:     linux-pci@vger.kernel.org
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Date:   Thu, 23 Feb 2012 12:43:43 -0700
Message-ID: <20120223194343.20708.34965.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120223194209.20708.54480.stgit@bhelgaas.mtv.corp.google.com>
References: <20120223194209.20708.54480.stgit@bhelgaas.mtv.corp.google.com>
User-Agent: StGit/0.15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkNRIQDzaoBS9AF0adhiZh47Y8o6XvFGSbK6GPCGYvwVFbwFyEb9WFjQksOubLuM3tC6HefgQkCKy6Fw9r3Qv/mQYu5zCg8XSfZSy5hOIxtM1jh6iqEFyc2GbzkJhUvdFTOi6RezdlezP4KpSfux1/3jQQXp6YRvO7HRbFsvqiArfEnJAo=
X-archive-position: 32530
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
