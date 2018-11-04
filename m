Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Nov 2018 14:52:33 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:33554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992819AbeKDNw1XcW-g (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 4 Nov 2018 14:52:27 +0100
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 580DB20862;
        Sun,  4 Nov 2018 13:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339546;
        bh=+VqJiRuqhuFqZxBNR+S9XgdQ3dPefuhldPmWjGVD00U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Meb/XKQuROYWeVJ2haIxs3fr8kUCTG4r2yV1ROodnP99/1QBoBmDaPyKAZI+BHAba
         W/cQrzlnYy27ybFsyGwaw6h1uOdM9oJw2hT0EAxu7/hHLmm3W0kjSXI0K4YlzA2nGe
         JKozIeBPsZGkyc8BZufD7U0GKC0ABIxmCLsAKmmo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 41/57] MIPS/PCI: Call pcie_bus_configure_settings() to set MPS/MRRS
Date:   Sun,  4 Nov 2018 08:51:28 -0500
Message-Id: <20181104135144.88324-41-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135144.88324-1-sashal@kernel.org>
References: <20181104135144.88324-1-sashal@kernel.org>
Return-Path: <sashal@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sashal@kernel.org
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

From: Huacai Chen <chenhc@lemote.com>

[ Upstream commit 2794f688b2c336e0da85e9f91fed33febbd9f54a ]

Call pcie_bus_configure_settings() on MIPS, like for other platforms.
The function pcie_bus_configure_settings() makes sure the MPS (Max
Payload Size) across the bus is uniform and provides the ability to
tune the MRSS (Max Read Request Size) and MPS (Max Payload Size) to
higher performance values. Some devices will not operate properly if
these aren't set correctly because the firmware doesn't always do it.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20649/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: Huacai Chen <chenhuacai@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/pci/pci-legacy.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
index f1e92bf743c2..3c3b1e6abb53 100644
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
2.17.1
