Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2018 03:11:18 +0200 (CEST)
Received: from mail-pg1-x543.google.com ([IPv6:2607:f8b0:4864:20::543]:36353
        "EHLO mail-pg1-x543.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994647AbeITBLPNd0C8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Sep 2018 03:11:15 +0200
Received: by mail-pg1-x543.google.com with SMTP id d1-v6so3572735pgo.3;
        Wed, 19 Sep 2018 18:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=lHW1Zlf6phvU3ocHGZkCDM9zdhKihHsq24H8fSL8vBE=;
        b=sAIzUsef5LMCtGfHULFfH0fTWIYNM5ys2+aPmw7fRZnwKYQkKK6mQQ+ZyjuEK/Ojg+
         eb9TcfrSzeBl50+2P1ZZW1vkIpH2XZ5oUh9jLKcnUa7Nm/DDzG+ZgQCVqvM6vKD3OGXA
         CzrMIHXCmrnaGugHVvMq1CxCy8GAhZa3U3kgcy/UksMnhLaiwXc3RqG4q7vnsiUIQy+c
         Mz9K+ZCNHoA9p+8ADH/nzZ9CRapYbiwmXZD4IXgVydhw8+VmpfJoaMi2WScG2f0D4eCL
         9v61FBw2YwU2H5Jo62WFJ21zc5oP2kmmvfzwDP1RCqDDg3eSGMf1hRDCb8Knub9gXALI
         TcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=lHW1Zlf6phvU3ocHGZkCDM9zdhKihHsq24H8fSL8vBE=;
        b=kmbAuuhfiglMzRozbI62XejvaoxRHImjVLsgkrqALiMSHqGyqwXwm1GW9oS3P/VQxO
         oyuS/1AAugIrI+lIf3xkm18sD+eaM/r8lQ61Zd98hB9SEma8TJ3i6IqsQHfph2nSG+9g
         tS/B5qy23itnuFxbQ0wTXWmAJNBDfMkXfe6OI1teftbz75n1/ocySfTzomN2fytzNQ0e
         xK8cb8LgHZ6akPJ5u37v4e9vJe25tGjX23m/SdtssHchQ6VNq7++hWED55yw4u80LkSV
         T1hEM7Z1BOLYA6+6Iezwjesr0RaTjgZQmgqNTWcb3lCrejcmNytL4vpEzGZDrree99ky
         /wZg==
X-Gm-Message-State: APzg51AS3LEcexkh2mfE8Ez8Y20uHFOxP0RWtqtu4/q+prTlNC8KlBW1
        4QmLMq+CBOkta3TMaXnS5y5fKCaN6/Y=
X-Google-Smtp-Source: ANB0VdbKWHARneVlxsL1JQlBeeE7zSJo+F0jCiWBqwTw92JkMBDzDtclgaPnfKR3ISAJUiEG55Tfpw==
X-Received: by 2002:a63:d10c:: with SMTP id k12-v6mr35034116pgg.49.1537405868239;
        Wed, 19 Sep 2018 18:11:08 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id n79-v6sm45395656pfh.2.2018.09.19.18.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 18:11:07 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2] MIPS/PCI: Let Loongson-3 pci_ops access extended config space
Date:   Thu, 20 Sep 2018 09:11:03 +0800
Message-Id: <1537405863-31484-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Original Loongson-3 pci_ops can only access standard pci config space,
this patch let it be able to access extended pci config space.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/pci/ops-loongson3.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/arch/mips/pci/ops-loongson3.c b/arch/mips/pci/ops-loongson3.c
index 9e11843..9588769 100644
--- a/arch/mips/pci/ops-loongson3.c
+++ b/arch/mips/pci/ops-loongson3.c
@@ -17,24 +17,36 @@ static int loongson3_pci_config_access(unsigned char access_type,
 		struct pci_bus *bus, unsigned int devfn,
 		int where, u32 *data)
 {
-	unsigned char busnum = bus->number;
-	u_int64_t addr, type;
+	u_int64_t addr;
 	void *addrp;
+	unsigned char busnum = bus->number;
 	int device = PCI_SLOT(devfn);
 	int function = PCI_FUNC(devfn);
 	int reg = where & ~3;
 
-	addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
-	if (busnum == 0) {
-		if (device > 31)
+	if (where < PCI_CFG_SPACE_SIZE) { /* standard config */
+		addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
+		if (busnum == 0) {
+			if (device > 31)
+				return PCIBIOS_DEVICE_NOT_FOUND;
+			addrp = (void *)TO_UNCAC(HT1LO_PCICFG_BASE | addr);
+		} else {
+			addrp = (void *)TO_UNCAC(HT1LO_PCICFG_BASE_TP1 | addr);
+		}
+	} else if (where < PCI_CFG_SPACE_EXP_SIZE) {  /* extended config */
+		struct pci_dev *rootdev;
+
+		rootdev = pci_get_domain_bus_and_slot(0, 0, 0);
+		if (!rootdev)
 			return PCIBIOS_DEVICE_NOT_FOUND;
-		addrp = (void *)(TO_UNCAC(HT1LO_PCICFG_BASE) | (addr & 0xffff));
-		type = 0;
 
-	} else {
-		addrp = (void *)(TO_UNCAC(HT1LO_PCICFG_BASE_TP1) | (addr));
-		type = 0x10000;
-	}
+		addr = pci_resource_start(rootdev, 3);
+		if (!addr)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+		addrp = (void *)TO_UNCAC(addr | busnum << 20 | device << 15 | function << 12 | reg);
+	} else
+		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (access_type == PCI_ACCESS_WRITE)
 		writel(*data, addrp);
-- 
2.7.0
