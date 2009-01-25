Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Jan 2009 13:46:07 +0000 (GMT)
Received: from mow300.po.2iij.net ([210.128.50.200]:40415 "EHLO
	mow.po.2iij.net") by ftp.linux-mips.org with ESMTP
	id S21366184AbZAYNqD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 25 Jan 2009 13:46:03 +0000
Received: by mow.po.2iij.net (mow300) id n0PDk0Xv013713; Sun, 25 Jan 2009 22:46:00 +0900
Received: from delta (133.6.30.125.dy.iij4u.or.jp [125.30.6.133])
	by mbox.po.2iij.net (po-mbox301) id n0PDjvGh015083
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 25 Jan 2009 22:45:57 +0900
Date:	Sun, 25 Jan 2009 22:45:57 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] add return value check to
 user_termio_to_kernel_termios()
Message-Id: <20090125224557.8582051b.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/include/asm/termios.h linux/arch/mips/include/asm/termios.h
--- linux-orig/arch/mips/include/asm/termios.h	2008-10-19 22:33:14.114377349 +0900
+++ linux/arch/mips/include/asm/termios.h	2008-10-19 22:41:25.322369698 +0900
@@ -97,14 +97,14 @@ struct termio {
 #define user_termio_to_kernel_termios(termios, termio) \
 ({ \
 	unsigned short tmp; \
-	get_user(tmp, &(termio)->c_iflag); \
-	(termios)->c_iflag = (0xffff0000 & ((termios)->c_iflag)) | tmp; \
-	get_user(tmp, &(termio)->c_oflag); \
-	(termios)->c_oflag = (0xffff0000 & ((termios)->c_oflag)) | tmp; \
-	get_user(tmp, &(termio)->c_cflag); \
-	(termios)->c_cflag = (0xffff0000 & ((termios)->c_cflag)) | tmp; \
-	get_user(tmp, &(termio)->c_lflag); \
-	(termios)->c_lflag = (0xffff0000 & ((termios)->c_lflag)) | tmp; \
+	if (!get_user(tmp, &(termio)->c_iflag)) \
+		(termios)->c_iflag = (0xffff0000 & ((termios)->c_iflag)) | tmp; \
+	if (!get_user(tmp, &(termio)->c_oflag)) \
+		(termios)->c_oflag = (0xffff0000 & ((termios)->c_oflag)) | tmp; \
+	if (!get_user(tmp, &(termio)->c_cflag)) \
+		(termios)->c_cflag = (0xffff0000 & ((termios)->c_cflag)) | tmp; \
+	if (!get_user(tmp, &(termio)->c_lflag)) \
+		(termios)->c_lflag = (0xffff0000 & ((termios)->c_lflag)) | tmp; \
 	get_user((termios)->c_line, &(termio)->c_line); \
 	copy_from_user((termios)->c_cc, (termio)->c_cc, NCC); \
 })
