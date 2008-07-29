Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2008 09:29:39 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:42821 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20027091AbYG2I3b (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2008 09:29:31 +0100
Received: by mo.po.2iij.net (mo30) id m6T8THUi026988; Tue, 29 Jul 2008 17:29:17 +0900 (JST)
Received: from rally.tokyo.tripeaks.co.jp (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox300) id m6T8TDPi011215
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 29 Jul 2008 17:29:13 +0900
Date:	Tue, 29 Jul 2008 17:30:58 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	mchehab@infradead.org
Cc:	yoichi_yuasa@tripeaks.co.jp,
	linux-mips <linux-mips@linux-mips.org>, tmnousia@cc.hut.fi
Subject: [PATCH] fix vino driver build error
Message-Id: <20080729173058.bd221599.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

The vino driver needs #include <media/v4l2-ioctl.h>

drivers/media/video/vino.c: In function 'vino_ioctl':
drivers/media/video/vino.c:4364: error: implicit declaration of function 'video_usercopy'
make[3]: *** [drivers/media/video/vino.o] Error 1

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/drivers/media/video/vino.c linux/drivers/media/video/vino.c
--- linux-orig/drivers/media/video/vino.c	2008-07-29 15:54:24.412871297 +0900
+++ linux/drivers/media/video/vino.c	2008-07-29 15:54:05.375786436 +0900
@@ -40,6 +40,7 @@
 
 #include <linux/videodev2.h>
 #include <media/v4l2-common.h>
+#include <media/v4l2-ioctl.h>
 #include <linux/video_decoder.h>
 #include <linux/mutex.h>
 
