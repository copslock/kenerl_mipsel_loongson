Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2018 17:33:09 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:43872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994555AbeKSQdDJI6bK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Nov 2018 17:33:03 +0100
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85C7A20831;
        Mon, 19 Nov 2018 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645182;
        bh=vcg4o2XYXaAa8eemJg3MaC2/B8bst1lrrcBRSRcopjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XCAjN6xCgxi/MBoz9sdX+0kc7ndS9N3B32dYrjzg9ku1DRLB0XyLl1PcffNIXFfoD
         rw2Z96g8QB1sH5Hq+r96pise49UtCSGia5vmlTp3UkxuqAbRgQ9GwEptPVNcXWHkK8
         jmbOOfYfMI/0UokL+a+o1UCXBr1yPYr4FmBtBafU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 028/205] MIPS/PCI: Call pcie_bus_configure_settings() to set MPS/MRRS
Date:   Mon, 19 Nov 2018 17:25:35 +0100
Message-Id: <20181119162622.568825315@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <SRS0=OXTl=N6=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/pci/pci-legacy.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/mips/pci/pci-legacy.c
+++ b/arch/mips/pci/pci-legacy.c
@@ -127,8 +127,12 @@ static void pcibios_scanbus(struct pci_c
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
