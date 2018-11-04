Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Nov 2018 14:56:18 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:37134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992482AbeKDNyOIuIQg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 4 Nov 2018 14:54:14 +0100
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 329A22086D;
        Sun,  4 Nov 2018 13:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339653;
        bh=F7cF5diOr471gj/+ujfHcwjlMSALIYO+9TdpshtL+D4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SRJZZUJF20d5vEqiY9qjfTiyJQuvaTW/qbIjL7nZduYSiKzvwv65kCxkQtct9wUTN
         7mGDMZee/stUPIudlOEVfcmblLWoj5qNt6ABnl7qtXrqYule1CvMcQJbNI6h4JKPlF
         Lvb2BYPG4JU2M7RDV9XYXuwMFWDDW1hsZQAfpOVA=
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
Subject: [PATCH AUTOSEL 4.9 16/21] MIPS/PCI: Call pcie_bus_configure_settings() to set MPS/MRRS
Date:   Sun,  4 Nov 2018 08:53:50 -0500
Message-Id: <20181104135355.88602-16-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135355.88602-1-sashal@kernel.org>
References: <20181104135355.88602-1-sashal@kernel.org>
Return-Path: <sashal@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67076
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
index 014649be158d..2d6886f09ba3 100644
--- a/arch/mips/pci/pci-legacy.c
+++ b/arch/mips/pci/pci-legacy.c
@@ -116,8 +116,12 @@ static void pcibios_scanbus(struct pci_controller *hose)
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
