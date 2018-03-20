Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2018 14:08:38 +0100 (CET)
Received: from mail.bootlin.com ([62.4.15.54]:59845 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992678AbeCTNISSQeB7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Mar 2018 14:08:18 +0100
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E1E80203E2; Tue, 20 Mar 2018 14:08:11 +0100 (CET)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8D92E20710;
        Tue, 20 Mar 2018 14:08:01 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     Allan Nielsen <Allan.Nielsen@microsemi.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v6 1/6] dt-bindings: Add vendor prefix for Microsemi Corporation
Date:   Tue, 20 Mar 2018 14:07:56 +0100
Message-Id: <20180320130801.9247-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320130801.9247-1-alexandre.belloni@bootlin.com>
References: <20180320130801.9247-1-alexandre.belloni@bootlin.com>
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ae850d6c0ad3..ffc959ef53e9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -224,6 +224,7 @@ motorola	Motorola, Inc.
 moxa	Moxa Inc.
 mpl	MPL AG
 mqmaker	mqmaker Inc.
+mscc	Microsemi Corporation
 msi	Micro-Star International Co. Ltd.
 mti	Imagination Technologies Ltd. (formerly MIPS Technologies Inc.)
 multi-inno	Multi-Inno Technology Co.,Ltd
-- 
2.16.2
