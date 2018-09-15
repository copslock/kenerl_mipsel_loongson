Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2018 08:00:57 +0200 (CEST)
Received: from mail-pg1-x541.google.com ([IPv6:2607:f8b0:4864:20::541]:40864
        "EHLO mail-pg1-x541.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbeIOGApaEVvX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Sep 2018 08:00:45 +0200
Received: by mail-pg1-x541.google.com with SMTP id l63-v6so5329781pga.7;
        Fri, 14 Sep 2018 23:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MGi+6LeWGY0ZB0UBu55uPS6B4IZicWe1T4PNLAIWDw8=;
        b=VH/MuZOCXiMpq9U2UmpMk6X0c53vi75Rc7DlLS+PqDr+lUt6+Pd//CRR1cTCjKJ3Kg
         A0HlTpVNws7nPcfOh0a49IwxsWsQbzMVkzXa85wUZDV81+FytadH/UoXxWiGTtGHqy8N
         p8+2ofW/VUE2geFtbbjzAhAvUqQoYhUYuJ1GlHJqQtzoISvr1+C7IvEJijuvHdfqaVrO
         2hxMbbkoDWa0XMRgvMUi24A2XZ908oBsUCBeWlo8tcVEEfqAio7dti2EqCAIgg6rCZ4v
         ++zu4DBudKUcFv2x+FHT/dSlAZdyho0QS640I79odyFc813JiZHqVrJw7lQ/f/TFlzvi
         Q8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=MGi+6LeWGY0ZB0UBu55uPS6B4IZicWe1T4PNLAIWDw8=;
        b=f0jz0sI9lKht6kLNxfmyVK8DMOuwmMuphPQked+hC2q1JYj/5Q/tNpc2RkydNDSvwC
         l+x84jLuiUsQXNBh2J8ixQZqQYQ6AUsdXYVvsQIdP1Od85ZU4A1MTI68ttNIrVSQVZ7j
         B5pKJ+FYZN3EJGN43Qewbcrefb9+amNwlxNL6xDjzucb2FWadjH1/+d4fQdS411SrDY6
         +paZ2tzROlSmgvQRK/vzsb0I1u2TfDMLV1EwjcXm67bjSkNXTwxo5wTd+Au4weq4C7am
         Fx47Ra2A9gi0ACurytXuHrXuUwWTHlMId8sIhlCv5zm5rzeZBLTIUnqqo0osgtnyle2z
         Sozg==
X-Gm-Message-State: APzg51CA5vpeRg+1I2vHNpCrvuIVbJbwGem7sUGMr0j37BQR90VY5IKy
        f6JT00cQvBuTKGbSlbg2OIwrveBIBuk=
X-Google-Smtp-Source: ANB0VdbzW2WxZa2tZPVX/eX51RXfUAmX0tqyg2/PVLAamkCfkG3gK7rmPsJVDEVMRazpCbEd+XK1Ng==
X-Received: by 2002:a62:e08b:: with SMTP id d11-v6mr15728054pfm.214.1536991238936;
        Fri, 14 Sep 2018 23:00:38 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id 16-v6sm11862787pfp.6.2018.09.14.23.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Sep 2018 23:00:38 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 2/2] MIPS/PCI: Let Loongson-3 pci_ops access extended config space
Date:   Sat, 15 Sep 2018 14:01:13 +0800
Message-Id: <1536991273-20649-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1536991273-20649-1-git-send-email-chenhc@lemote.com>
References: <1536991273-20649-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66324
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

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/pci/ops-loongson3.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/mips/pci/ops-loongson3.c b/arch/mips/pci/ops-loongson3.c
index 9e11843..3100117 100644
--- a/arch/mips/pci/ops-loongson3.c
+++ b/arch/mips/pci/ops-loongson3.c
@@ -24,16 +24,29 @@ static int loongson3_pci_config_access(unsigned char access_type,
 	int function = PCI_FUNC(devfn);
 	int reg = where & ~3;
 
-	addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
-	if (busnum == 0) {
-		if (device > 31)
+	if (where < 256) { /* standard config */
+		addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
+		if (busnum == 0) {
+			if (device > 31)
+				return PCIBIOS_DEVICE_NOT_FOUND;
+			addrp = (void *)(TO_UNCAC(HT1LO_PCICFG_BASE) | (addr & 0xffff));
+			type = 0;
+		} else {
+			addrp = (void *)(TO_UNCAC(HT1LO_PCICFG_BASE_TP1) | (addr));
+			type = 0x10000;
+		}
+	} else {  /* extended config */
+		struct pci_dev *rootdev;
+
+		rootdev = pci_get_domain_bus_and_slot(0, 0, 0);
+		if (!rootdev)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+		addr = pci_resource_start(rootdev, 3);
+		if (!addr)
 			return PCIBIOS_DEVICE_NOT_FOUND;
-		addrp = (void *)(TO_UNCAC(HT1LO_PCICFG_BASE) | (addr & 0xffff));
-		type = 0;
 
-	} else {
-		addrp = (void *)(TO_UNCAC(HT1LO_PCICFG_BASE_TP1) | (addr));
-		type = 0x10000;
+		addrp = (void *)TO_UNCAC(addr | busnum << 20 | device << 15 | function << 12 | reg);
 	}
 
 	if (access_type == PCI_ACCESS_WRITE)
-- 
2.7.0
