Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2015 20:17:15 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:38282 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010973AbbJ2TRN5CqkE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Oct 2015 20:17:13 +0100
Received: from hauke-desktop.fritz.box (p5DE94E6C.dip0.t-ipconnect.de [93.233.78.108])
        by hauke-m.de (Postfix) with ESMTPSA id 4CF13100029;
        Thu, 29 Oct 2015 20:17:13 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     blogic@openwrt.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke.mehrtens@lantiq.com>
Subject: [PATCH please merge into original 10/15] MIPS: lantiq: add SoC detection for ar10 and grx390
Date:   Thu, 29 Oct 2015 20:17:10 +0100
Message-Id: <1446146230-17331-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1446071865-21936-11-git-send-email-hauke@hauke-m.de>
References: <1446071865-21936-11-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49767
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

Signed-off-by: Hauke Mehrtens <hauke.mehrtens@lantiq.com>
---
 arch/mips/lantiq/xway/prom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/lantiq/xway/prom.c b/arch/mips/lantiq/xway/prom.c
index a23b77ae..32994a9 100644
--- a/arch/mips/lantiq/xway/prom.c
+++ b/arch/mips/lantiq/xway/prom.c
@@ -4,6 +4,8 @@
  *  by the Free Software Foundation.
  *
  *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2013 Lei Chuanhua <Chuanhua.lei@lantiq.com>
+ *  Copyright (C) 2015 Hauke Mehrtens <hauke.mehrtens@lantiq.com>
  */
 
 #include <linux/export.h>
-- 
2.6.1
