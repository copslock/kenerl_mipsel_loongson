Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 16:48:16 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:40680 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbdLHPrjrVw4P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Dec 2017 16:47:39 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 3BF0220972; Fri,  8 Dec 2017 16:47:34 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 157B42037F;
        Fri,  8 Dec 2017 16:47:24 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 01/13] dt-bindings: Add vendor prefix for Microsemi Corporation
Date:   Fri,  8 Dec 2017 16:46:06 +0100
Message-Id: <20171208154618.20105-2-alexandre.belloni@free-electrons.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

Microsemi Corporation provides semiconductor and system solutions for
aerospace & defense, communications, data center and industrial markets.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 0994bdd82cd3..7b880084fd37 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -219,6 +219,7 @@ motorola	Motorola, Inc.
 moxa	Moxa Inc.
 mpl	MPL AG
 mqmaker	mqmaker Inc.
+mscc	Microsemi Corporation
 msi	Micro-Star International Co. Ltd.
 mti	Imagination Technologies Ltd. (formerly MIPS Technologies Inc.)
 multi-inno	Multi-Inno Technology Co.,Ltd
-- 
2.15.1
