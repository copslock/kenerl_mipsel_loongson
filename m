Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Apr 2007 08:30:57 +0100 (BST)
Received: from mo31.po.2iij.NET ([210.128.50.54]:51002 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021574AbXDDHaz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Apr 2007 08:30:55 +0100
Received: by mo.po.2iij.net (mo31) id l347TaNM069340; Wed, 4 Apr 2007 16:29:36 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox31) id l347TYpk098838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 4 Apr 2007 16:29:34 +0900 (JST)
Date:	Wed, 4 Apr 2007 16:29:34 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Andrew Morton <akpm@osdl.org>
Cc:	yoichi_yuasa@tripeaks.co.jp,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] Fixed build error on zs serial driver
Message-Id: <20070404162934.2635ef95.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

This patch has fixed build error on zs serial driver.

drivers/tc/zs.c:73:24: error: asm/dec/tc.h: No such file or directory
make[2]: *** [drivers/tc/zs.o] Error 1

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/tc/zs.c mips/drivers/tc/zs.c
--- mips-orig/drivers/tc/zs.c	2007-04-04 15:01:22.952507000 +0900
+++ mips/drivers/tc/zs.c	2007-04-04 15:15:37.861935500 +0900
@@ -70,7 +70,6 @@
 #include <asm/dec/machtype.h>
 #include <asm/dec/serial.h>
 #include <asm/dec/system.h>
-#include <asm/dec/tc.h>
 
 #ifdef CONFIG_KGDB
 #include <asm/kgdb.h>
