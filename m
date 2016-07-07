Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2016 17:00:49 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34489 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992247AbcGGPAlfW5Ag (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jul 2016 17:00:41 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 69B0ED59FC419;
        Thu,  7 Jul 2016 16:00:31 +0100 (IST)
Received: from leopard.hh.imgtec.org (192.168.167.31) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 7 Jul 2016 16:00:35 +0100
From:   James Hartley <james.hartley@imgtec.com>
To:     <davem@davemloft.net>
CC:     <geert@linux-m68k.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <ionela.voinescu@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>
Subject: [PATCH] MAINTAINERS: Add pistachio SoC Support
Date:   Thu, 7 Jul 2016 16:00:21 +0100
Message-ID: <1467903621-3175-1-git-send-email-james.hartley@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.167.31]
Return-Path: <James.Hartley@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hartley@imgtec.com
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

The Pistachio SoC from Imagination Technologies currently has no
entry in the MAINTAINERS file, so add one.

Signed-off-by: James Hartley <james.hartley@imgtec.com>
Reviewed-by: Ionela Voinescu <ionela.voinescu@imgtec.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b532c8d..ba20ad8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9188,6 +9188,16 @@ W:	http://www.st.com/spear
 S:	Maintained
 F:	drivers/pinctrl/spear/
 
+PISTACHIO SOC SUPPORT
+M:      James Hartley <james.hartley@imgtec.com>
+M:      Ionela Voinescu <ionela.voinescu@imgtec.com>
+L:      linux-mips@linux-mips.org
+S:      Maintained
+F:      arch/mips/pistachio/
+F:      arch/mips/include/asm/mach-pistachio/
+F:      arch/mips/boot/dts/pistachio/
+F:      arch/mips/configs/pistachio*_defconfig
+
 PKTCDVD DRIVER
 M:	Jiri Kosina <jikos@kernel.org>
 S:	Maintained
-- 
2.7.4
