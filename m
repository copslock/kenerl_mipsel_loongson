Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2015 20:16:11 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:38273 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010973AbbJ2TQGcTkRE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Oct 2015 20:16:06 +0100
Received: from hauke-desktop.fritz.box (p5DE94E6C.dip0.t-ipconnect.de [93.233.78.108])
        by hauke-m.de (Postfix) with ESMTPSA id 0801F100029;
        Thu, 29 Oct 2015 20:16:06 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     blogic@openwrt.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke.mehrtens@lantiq.com>
Subject: [PATCH please merge into original 03/15] MIPS: lantiq: rename CGU_SYS_VR9 register
Date:   Thu, 29 Oct 2015 20:15:59 +0100
Message-Id: <1446146159-17228-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1446071865-21936-4-git-send-email-hauke@hauke-m.de>
References: <1446071865-21936-4-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49765
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

From: Hauke Mehrtens <hauke.mehrtens@lantiq.com>

This register is also used on other SoCs.

Signed-off-by: Hauke Mehrtens <hauke.mehrtens@lantiq.com>
---
 arch/mips/lantiq/xway/clk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/lantiq/xway/clk.c b/arch/mips/lantiq/xway/clk.c
index 619bff7..7aa4387 100644
--- a/arch/mips/lantiq/xway/clk.c
+++ b/arch/mips/lantiq/xway/clk.c
@@ -4,6 +4,8 @@
  *  by the Free Software Foundation.
  *
  *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2013 Lei Chuanhua <Chuanhua.lei@lantiq.com>
+ *  Copyright (C) 2015 Hauke Mehrtens <hauke.mehrtens@lantiq.com>
  */
 
 #include <linux/io.h>
-- 
2.6.1
