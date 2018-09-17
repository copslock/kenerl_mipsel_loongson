Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Sep 2018 01:15:28 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:41876 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994719AbeIQXPNuQ0OY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Sep 2018 01:15:13 +0200
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F06CFC9D;
        Mon, 17 Sep 2018 23:15:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Paul Burton <paul.burton@mips.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, ralf@linux-mips.org, jhogan@kernel.org,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 154/158] MIPS: mscc: ocelot: fix length of memory address space for MIIM
Date:   Tue, 18 Sep 2018 00:43:04 +0200
Message-Id: <20180917211718.210530654@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66391
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

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quentin Schulz <quentin.schulz@bootlin.com>

[ Upstream commit 49e5bb13adc11fe6e2e40f65c04f3a461aea1fec ]

The length of memory address space for MIIM0 is from 0x7107009c to
0x710700bf included which is 36 bytes long in decimal, or 0x24 bytes in
hexadecimal and not 0x36.

Fixes: 49b031690abe ("MIPS: mscc: Add switch to ocelot")

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20013/
Cc: robh+dt@kernel.org
Cc: mark.rutland@arm.com
Cc: ralf@linux-mips.org
Cc: jhogan@kernel.org
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/boot/dts/mscc/ocelot.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/boot/dts/mscc/ocelot.dtsi
+++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
@@ -184,7 +184,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "mscc,ocelot-miim";
-			reg = <0x107009c 0x36>, <0x10700f0 0x8>;
+			reg = <0x107009c 0x24>, <0x10700f0 0x8>;
 			interrupts = <14>;
 			status = "disabled";
 
