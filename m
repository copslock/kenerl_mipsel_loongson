Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2018 13:18:42 +0100 (CET)
Received: from mail.bootlin.com ([62.4.15.54]:44917 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994690AbeCFMRNHYNwr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Mar 2018 13:17:13 +0100
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1C758207CC; Tue,  6 Mar 2018 13:17:01 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1ED80209F9;
        Tue,  6 Mar 2018 13:16:21 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     Allan Nielsen <Allan.Nielsen@microsemi.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v5 5/5] MAINTAINERS: Add entry for Microsemi MIPS SoCs
Date:   Tue,  6 Mar 2018 13:16:07 +0100
Message-Id: <20180306121607.1567-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306121607.1567-1-alexandre.belloni@bootlin.com>
References: <20180306121607.1567-1-alexandre.belloni@bootlin.com>
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62821
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

Add myself as a maintainer for the Microsemi MIPS SoCs.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bdc260e36b7..14ce8b290fea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9156,6 +9156,15 @@ S:	Maintained
 F:	drivers/usb/misc/usb251xb.c
 F:	Documentation/devicetree/bindings/usb/usb251xb.txt
 
+MICROSEMI MIPS SOCS
+M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
+L:	linux-mips@linux-mips.org
+S:	Maintained
+F:	arch/mips/generic/board-ocelot.c
+F:	arch/mips/configs/generic/board-ocelot.config
+F:	arch/mips/boot/dts/mscc/
+F:	Documentation/devicetree/bindings/mips/mscc.txt
+
 MICROSEMI SMART ARRAY SMARTPQI DRIVER (smartpqi)
 M:	Don Brace <don.brace@microsemi.com>
 L:	esc.storagedev@microsemi.com
-- 
2.16.2
