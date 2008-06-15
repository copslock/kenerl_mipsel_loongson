Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jun 2008 17:14:47 +0100 (BST)
Received: from smtp4.pp.htv.fi ([213.243.153.38]:29165 "EHLO smtp4.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S20040252AbYFOQOl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 15 Jun 2008 17:14:41 +0100
Received: from cs181133002.pp.htv.fi (cs181140183.pp.htv.fi [82.181.140.183])
	by smtp4.pp.htv.fi (Postfix) with ESMTP id 763F45BC012;
	Sun, 15 Jun 2008 19:14:38 +0300 (EEST)
Date:	Sun, 15 Jun 2008 19:13:21 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [2.6 patch] malta_mtd.c: add MODULE_LICENSE
Message-ID: <20080615161321.GB7865@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

This patch adds the missing MODULE_LICENSE("GPL").

Reported-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 arch/mips/mips-boards/malta/malta_mtd.c |    3 +++
 1 file changed, 3 insertions(+)

da2e8fd47a57f6e5c48dc0781db3aa7a46365c38 diff --git a/arch/mips/mips-boards/malta/malta_mtd.c b/arch/mips/mips-boards/malta/malta_mtd.c
index 8ad9bdf..dd38c12 100644
--- a/arch/mips/mips-boards/malta/malta_mtd.c
+++ b/arch/mips/mips-boards/malta/malta_mtd.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
@@ -61,3 +62,5 @@ static int __init malta_mtd_init(void)
 }
 
 module_init(malta_mtd_init)
+
+MODULE_LICENSE("GPL");
