Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2012 12:55:01 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:32786 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903453Ab2G3Kyv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Jul 2012 12:54:51 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1Svncg-0007cs-00; Mon, 30 Jul 2012 12:54:50 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id DBB961D1CF; Mon, 30 Jul 2012 12:54:16 +0200 (CEST)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Fix newport con crashes
To:     linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org
cc:     ralf@linux-mips.org, FlorianSchandinat@gmx.de
Message-Id: <20120730105416.DBB961D1CF@solo.franken.de>
Date:   Mon, 30 Jul 2012 12:54:16 +0200 (CEST)
X-archive-position: 33995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Because of commit e84de0c61905030a0fe66b7210b6f1bb7c3e1eab
[MIPS: GIO bus support for SGI IP22/28] newport con is now taking over
console from dummy con, therefore it's necessary to resize the VC to
the correct size to avoid crashes and garbage on console

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 drivers/video/console/newport_con.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 6d15966..b05afd0 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -327,9 +327,16 @@ out_unmap:
 
 static void newport_init(struct vc_data *vc, int init)
 {
-	vc->vc_cols = newport_xsize / 8;
-	vc->vc_rows = newport_ysize / 16;
+	int cols, rows;
+
+	cols = newport_xsize / 8;
+	rows = newport_ysize / 16;
 	vc->vc_can_do_color = 1;
+	if (init) {
+		vc->vc_cols = cols;
+		vc->vc_rows = rows;
+	} else
+		vc_resize(vc, cols, rows);
 }
 
 static void newport_deinit(struct vc_data *c)
