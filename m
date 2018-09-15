Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2018 08:00:17 +0200 (CEST)
Received: from mail-pl1-x641.google.com ([IPv6:2607:f8b0:4864:20::641]:42959
        "EHLO mail-pl1-x641.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbeIOGAOWrIcX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Sep 2018 08:00:14 +0200
Received: by mail-pl1-x641.google.com with SMTP id g23-v6so5101749plq.9;
        Fri, 14 Sep 2018 23:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=fEb7ifaRLul7V6cRhllRGzp6TCDHYH7aFfD+j7Lalq0=;
        b=hHbAbimWVucm5aOBvKUyFv9zSr8uhtuBMqBBd7LUODsi5o+5U9oMevxM5lbA7PkAQr
         shc2ih3noSU6mPLpbPt+NSj9wmLJf4Tqr06TyCrjPr5oXTKner3wu2bHT7rpGok0PJmp
         jHRJsscf472yZ8CzAcVCehEJaRFVnCTDaSzMDki1nMutRKIzy6QTP5N24DE9noiHVrdD
         r1kiDSrBmHXqCOg5lnZ4btlZzx4pCr6DfDhAlVW6K3PyDmLeUxmOQ7Mea/MABhUjG/41
         uJFpPTnJA4g2vgHnGETguHcAwNHsleXR25ILILZg6wKPw3WI5huHwA4d7QoPhUYzlHKO
         hqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=fEb7ifaRLul7V6cRhllRGzp6TCDHYH7aFfD+j7Lalq0=;
        b=BmJhYZnm/05zU+hJbaf1FcU8TCNlYNO3YiMH5Er40D1aUhBD4x7BXyOlaffBzmx4S0
         F5T+UaWmu2oXQNcQ8PF2oy6pQ6fS5WgUXwTDe3zOJ/5cqRriEjaTT/k7Rq1kfPHVGuFz
         YA/ZMeEVNhPcI/b1Zi7ULmUGYrOhLjLE0eadojp4poOIVJAf2M42jHt3HYII0v/72d6x
         jq1sjE7t4muwLibvc7I0VvrlqPHVebziqopEKnZ3NF9RjVgx3bKJm9iyrmSyHorJOfuR
         +vhEEiHanJR9pyvfXBA5NRHwGIF5u7nlZEA9wn/Q2kktVPGpTV/eFhRk1kBHtRGoCmyt
         A68g==
X-Gm-Message-State: APzg51CpFQ807ZCB8aAsOf/Xi2/yCR7/ZatoyfBuOCfHJc2/XJN/xS3z
        uSf2W8VuzRYOd9/6szgQW8LakQylFGU=
X-Google-Smtp-Source: ANB0VdaKqSFc+Ah3fkgIecLORHYmcBaCvE50mmgvG4JVUSFSeqeBsGU1QkiE+zrxBCDq0vfitU4i7Q==
X-Received: by 2002:a17:902:f209:: with SMTP id gn9mr15154073plb.173.1536991207665;
        Fri, 14 Sep 2018 23:00:07 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id 16-v6sm11862787pfp.6.2018.09.14.23.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Sep 2018 23:00:06 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 1/2] MIPS/PCI: Call pcie_bus_configure_settings() to set MPS/MRRS
Date:   Sat, 15 Sep 2018 14:01:12 +0800
Message-Id: <1536991273-20649-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66323
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

Call pcie_bus_configure_settings() on MIPS, like for other platforms.
The function pcie_bus_configure_settings() makes sure the MPS (Max
Payload Size) across the bus is uniform and provides the ability to
tune the MRSS (Max Read Request Size) and MPS (Max Payload Size) to
higher performance values. Some devices will not operate properly if
these aren't set correctly because the firmware doesn't always do it.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/pci/pci-legacy.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
index f1e92bf..3c3b1e6 100644
--- a/arch/mips/pci/pci-legacy.c
+++ b/arch/mips/pci/pci-legacy.c
@@ -127,8 +127,12 @@ static void pcibios_scanbus(struct pci_controller *hose)
 	if (pci_has_flag(PCI_PROBE_ONLY)) {
 		pci_bus_claim_resources(bus);
 	} else {
+		struct pci_bus *child;
+
 		pci_bus_size_bridges(bus);
 		pci_bus_assign_resources(bus);
+		list_for_each_entry(child, &bus->children, node)
+			pcie_bus_configure_settings(child);
 	}
 	pci_bus_add_devices(bus);
 }
-- 
2.7.0
