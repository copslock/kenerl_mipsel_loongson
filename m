Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2012 23:33:37 +0100 (CET)
Received: from mail-gy0-f201.google.com ([209.85.160.201]:47950 "EHLO
        mail-gy0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903700Ab2CGWcv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Mar 2012 23:32:51 +0100
Received: by ghbg15 with SMTP id g15so844108ghb.0
        for <linux-mips@linux-mips.org>; Wed, 07 Mar 2012 14:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=+1Tg68MUrUdkYJBPf4zZzIhJOCahvnx2JOmPQ3BE2v4=;
        b=jV+gRFxUxQ2LdKfGf37aSgyV2gVsyAhqMajHTtuiV+jwfLTmS5BdB8XFQg2FKIfPGV
         ALX9QXxEPP0tF7PYdeUYaqAlTv01eru6AyZI8NvpsXbCzKOJvDjeQGVVoxHdnDK0MU75
         U2TJlIHvBiZDxiJenKkTzgF8Ff6V68auurGRKy+8WArkU9O2sJf7wriqtsNehPKYuM/u
         N3TCHCM/wB+pDJrds2iVYTruTKvulgjOPT2Ani4D2BOvC7ERsd2MQpJsKd4BfoKs7T7A
         tpiCw+irU73bxJv5qWopJ90RC/Kf7CKkaPlJKT8Z46GfKv4/FUnmvgj+Te6QUPm8WfSR
         aIAQ==
Received: by 10.101.112.3 with SMTP id p3mr1488077anm.0.1331159565359;
        Wed, 07 Mar 2012 14:32:45 -0800 (PST)
Received: by 10.101.112.3 with SMTP id p3mr1488055anm.0.1331159565214;
        Wed, 07 Mar 2012 14:32:45 -0800 (PST)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id e44si13396157yhk.0.2012.03.07.14.32.45
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 07 Mar 2012 14:32:45 -0800 (PST)
Received: from bhelgaas.mtv.corp.google.com (bhelgaas.mtv.corp.google.com [172.18.96.155])
        by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 1D92A1E004D;
        Wed,  7 Mar 2012 14:32:45 -0800 (PST)
Received: from bhelgaas.mtv.corp.google.com (unknown [IPv6:::1])
        by bhelgaas.mtv.corp.google.com (Postfix) with ESMTP id C1C1B180146;
        Wed,  7 Mar 2012 14:32:44 -0800 (PST)
Subject: [PATCH v3 08/34] mips/PCI: removed unused pci_probe configurability
To:     Jesse Barnes <jbarnes@virtuousgeek.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Date:   Wed, 07 Mar 2012 15:32:44 -0700
Message-ID: <20120307223244.25669.85258.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
User-Agent: StGit/0.15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQmg8AXmo33Fge+vxlvmsDIOqMyPnuAokI4CCGuAD0FwPfItJLXOGK6ISqfU/OIqYQbM/dwPuwQHgqQgdh4C+IP33RMoor3spv2grhppFcqtTK1Ngb7FwJyg1lO7LwVnNi/4zvItuqSoLhFmURTLBVMYGN+UFThB/n4VGPRyOGfX5HP/Vl0=
X-archive-position: 32619
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
