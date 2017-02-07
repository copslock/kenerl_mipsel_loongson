Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 07:17:05 +0100 (CET)
Received: from smtp.gentoo.org ([IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4]:37309
        "EHLO smtp.gentoo.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992221AbdBGGORTnXfr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Feb 2017 07:14:17 +0100
Received: from helcaraxe.arda (c-73-201-78-97.hsd1.md.comcast.net [73.201.78.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kumba)
        by smtp.gentoo.org (Postfix) with ESMTPSA id C9CBA3416A8;
        Tue,  7 Feb 2017 06:14:09 +0000 (UTC)
From:   Joshua Kinard <kumba@gentoo.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>
Subject: [PATCH 09/12] MIPS: BRIDGE: Use !pci_is_root_bus(bus) to check for bus->number > 0
Date:   Tue,  7 Feb 2017 01:13:53 -0500
Message-Id: <20170207061356.8270-10-kumba@gentoo.org>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170207061356.8270-1-kumba@gentoo.org>
References: <20170207061356.8270-1-kumba@gentoo.org>
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

This is a manual cherrypick of commit c7ddc3d137b7 from Alastair
Bridgewater's IP35 tree.  In arch/mips/pci/ops-bridge.c, replace:
    if (bus->number > 0)
        foo();

With:
    if (!pci_is_root_bus(bus))
        foo();

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
Cc: Alastair Bridgewater <alastair.bridgewater@gmail.com>
---
 arch/mips/pci/ops-bridge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/ops-bridge.c b/arch/mips/pci/ops-bridge.c
index 6793a72edec2..28efce2dcb7d 100644
--- a/arch/mips/pci/ops-bridge.c
+++ b/arch/mips/pci/ops-bridge.c
@@ -170,7 +170,7 @@ static int
 pci_read_config(struct pci_bus *bus, u32 devfn, int where, int size,
 		u32 *value)
 {
-	if (bus->number > 0)
+	if (!pci_is_root_bus(bus))
 		return pci_conf1_read_config(bus, devfn, where, size, value);
 
 	return pci_conf0_read_config(bus, devfn, where, size, value);
@@ -314,7 +314,7 @@ static int
 pci_write_config(struct pci_bus *bus, u32 devfn, int where, int size,
 		 u32 value)
 {
-	if (bus->number > 0)
+	if (!pci_is_root_bus(bus))
 		return pci_conf1_write_config(bus, devfn, where, size, value);
 
 	return pci_conf0_write_config(bus, devfn, where, size, value);
-- 
2.11.1
