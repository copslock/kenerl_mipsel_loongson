Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2012 17:57:29 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:51227 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903827Ab2HAP5X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Aug 2012 17:57:23 +0200
Received: by pbbrq13 with SMTP id rq13so1360053pbb.36
        for <multiple recipients>; Wed, 01 Aug 2012 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=HLLsKpX6V1+4Y+kCEiIET68+RYvBNpA3FpaQrFmWuRA=;
        b=uBF4cIXH/hAJBkUfxTFb90y8/qVfW6nx4zYDjKszjtDGqZd24kqptU5h3LPsmuJi/Y
         hCPOmNtEGe78UUcEvmG1AEzyUhjw1C/YvoacWSrzoaw8BloYzdiju3WZnskcb380Y05c
         qDPOUcg9sxHAy4J3JS1Bd95L4vIqlttEnVZy8+ONYea3EDaRGa7Ko3FV5QHNTLqgHD7u
         /fdFn4DrGKBhYnvZitml2S4W37VzRE7zZdWgpd0ZSWaahrF6wQjIplb3b8yVNOYiPGKC
         JPzEBVnKdbWeRGmssbRNePz9smsmNRdvc8dXZyOBWsHQ2/l/Oxn+9lSvs3PWFdzBUEP/
         j8Ag==
Received: by 10.68.239.103 with SMTP id vr7mr54379063pbc.0.1343836636566;
        Wed, 01 Aug 2012 08:57:16 -0700 (PDT)
Received: from localhost.localdomain ([58.250.81.2])
        by mx.google.com with ESMTPS id pe8sm2816231pbc.76.2012.08.01.08.57.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Aug 2012 08:57:15 -0700 (PDT)
From:   Jiang Liu <liuj97@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Don Dutile <ddutile@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Jiang Liu <jiang.liu@huawei.com>, Yinghai Lu <yinghai@kernel.org>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        "Rafael J . Wysocki" <rjw@sisk.pl>,
        Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
        Yijing Wang <wangyijing@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-pci@vger.kernel.org, Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v3 13/32] PCI/MIPS: use PCIe capabilities access functions to simplify implementation
Date:   Wed,  1 Aug 2012 23:54:18 +0800
Message-Id: <1343836477-7287-14-git-send-email-jiang.liu@huawei.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343836477-7287-1-git-send-email-jiang.liu@huawei.com>
References: <1343836477-7287-1-git-send-email-jiang.liu@huawei.com>
X-archive-position: 34015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: liuj97@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Jiang Liu <jiang.liu@huawei.com>

Use PCIe capabilities access functions to simplify PCIe MIPS implementation.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 arch/mips/pci/pci-octeon.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index 52a1ba7..aaed2ad 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -117,16 +117,11 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	}
 
 	/* Enable the PCIe normal error reporting */
-	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
-	if (pos) {
-		/* Update Device Control */
-		pci_read_config_word(dev, pos + PCI_EXP_DEVCTL, &config);
-		config |= PCI_EXP_DEVCTL_CERE; /* Correctable Error Reporting */
-		config |= PCI_EXP_DEVCTL_NFERE; /* Non-Fatal Error Reporting */
-		config |= PCI_EXP_DEVCTL_FERE;  /* Fatal Error Reporting */
-		config |= PCI_EXP_DEVCTL_URRE;  /* Unsupported Request */
-		pci_write_config_word(dev, pos + PCI_EXP_DEVCTL, config);
-	}
+	config = PCI_EXP_DEVCTL_CERE; /* Correctable Error Reporting */
+	config |= PCI_EXP_DEVCTL_NFERE; /* Non-Fatal Error Reporting */
+	config |= PCI_EXP_DEVCTL_FERE;  /* Fatal Error Reporting */
+	config |= PCI_EXP_DEVCTL_URRE;  /* Unsupported Request */
+	pci_pcie_capability_change_word(dev, PCI_EXP_DEVCTL, config, 0);
 
 	/* Find the Advanced Error Reporting capability */
 	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
-- 
1.7.9.5
