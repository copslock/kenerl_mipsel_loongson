Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Dec 2015 11:34:42 +0100 (CET)
Received: from baptiste.telenet-ops.be ([195.130.132.51]:53046 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008272AbbLUKeFlW0gL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Dec 2015 11:34:05 +0100
Received: from ayla.of.borg ([84.195.106.123])
        by baptiste.telenet-ops.be with bizsmtp
        id wAZw1r00o2fm56U01AZwx4; Mon, 21 Dec 2015 11:34:05 +0100
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1aAxmu-0004SV-L0; Mon, 21 Dec 2015 11:33:56 +0100
Received: from geert by ramsan with local (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1aAxmz-0007EG-Lv; Mon, 21 Dec 2015 11:34:01 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     arm@kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 6/9] ARM: shmobile: porter dts: Add compatible property to "partitions" node
Date:   Mon, 21 Dec 2015 11:33:50 +0100
Message-Id: <1450694033-27717-7-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
References: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert+renesas@glider.be
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

As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
property to "partitions" node"), the "partitions" subnode of an SPI
FLASH device node must have a compatible property. The partitions are no
longer detected if it is not present.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Brian Norris <computersforpeace@gmail.com>
---
v2:
  - Add Acked-by.
---
 arch/arm/boot/dts/r8a7791-porter.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index b93016896378c350..f8d8e2e2169a9c40 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -213,6 +213,7 @@
 		m25p,fast-read;
 
 		partitions {
+			compatible = "fixed-partitions";
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-- 
1.9.1
