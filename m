Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 20:28:42 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:57901 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009727AbcADT2XPFdyy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Jan 2016 20:28:23 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 7325B280660;
        Mon,  4 Jan 2016 20:27:52 +0100 (CET)
Received: from localhost.localdomain (p548C87BE.dip0.t-ipconnect.de [84.140.135.190])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Mon,  4 Jan 2016 20:27:52 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 2/2] MAINTAINERS: add myself as Ralink MIPS architecture maintainer
Date:   Mon,  4 Jan 2016 20:28:13 +0100
Message-Id: <1451935693-40889-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1451935693-40889-1-git-send-email-blogic@openwrt.org>
References: <1451935693-40889-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 MAINTAINERS |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a54824b..156e1d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8829,6 +8829,12 @@ L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	drivers/video/fbdev/aty/aty128fb.c
 
+RALINK MIPS ARCHITECTURE
+M:	John Crispin <blogic@openwrt.org>
+L:	linux-mips@linux-mips.org
+S:	Maintained
+F:	arch/mips/ralink
+
 RALINK RT2X00 WIRELESS LAN DRIVER
 P:	rt2x00 project
 M:	Stanislaw Gruszka <sgruszka@redhat.com>
-- 
1.7.10.4
