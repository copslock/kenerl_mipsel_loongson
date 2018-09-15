Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2018 14:09:27 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:60008 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991923AbeIOMJOqYaQ2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 15 Sep 2018 14:09:14 +0200
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 2E2E749803;
        Sat, 15 Sep 2018 14:09:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id SQrWovLrUZC6; Sat, 15 Sep 2018 14:09:07 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH net-next 1/5] dt-bindings: net: lantiq,xrx200-net: Use lower case in hex
Date:   Sat, 15 Sep 2018 14:08:45 +0200
Message-Id: <20180915120849.24630-2-hauke@hauke-m.de>
In-Reply-To: <20180915120849.24630-1-hauke@hauke-m.de>
References: <20180915120849.24630-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

Use lower case letters in the addresses of the device tree binding.
In addition replace eth with ethernet and fix the size of the reg
element in the example. The additional range does not contain any
registers but is used for the IP block on the this SoC.

Fixes: 839790e88a3c ("dt-bindings: net: Add lantiq, xrx200-net DT bindings")
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt b/Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt
index 8a2fe5200cdc..5ff5e68bbbb6 100644
--- a/Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt
+++ b/Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt
@@ -11,11 +11,11 @@ Required properties:
 
 Example:
 
-eth0: eth@E10B308 {
+ethernet@e10b308 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	compatible = "lantiq,xrx200-net";
-	reg = <0xE10B308 0x30>;
+	reg = <0xe10b308 0xcf8>;
 	interrupts = <73>, <72>;
 	interrupt-names = "tx", "rx";
 };
-- 
2.11.0
