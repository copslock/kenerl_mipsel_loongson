Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2007 08:07:55 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:19245 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022966AbXJIHHq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 9 Oct 2007 08:07:46 +0100
Received: by mo.po.2iij.net (mo32) id l9977g5n003691; Tue, 9 Oct 2007 16:07:42 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox302) id l9977fj0003902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 9 Oct 2007 16:07:41 +0900
Date:	Tue, 9 Oct 2007 16:07:43 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: a garbage character in syscall.c
Message-Id: <20071009160743.5cba9b34.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This commit contains a garbage character. 

linux-queue.git:
http://www.linux-mips.org/git?p=linux-queue.git;a=commit;h=81c6bb39250146e5db5365f843ed9c4b7604f3bd

Please remove it from your patch, or apply this patch.

Yoichi

---

Remove a garbage character from arch/mips/kernel/syscall.c.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/kernel/syscall.c mips/arch/mips/kernel/syscall.c
--- mips-orig/arch/mips/kernel/syscall.c	2007-10-07 20:19:46.581632250 +0900
+++ mips/arch/mips/kernel/syscall.c	2007-10-08 13:41:03.265637500 +0900
@@ -361,7 +361,7 @@ asmlinkage int sys_ipc(unsigned int call
 		default:
 			return sys_msgrcv(first,
 					  (struct msgbuf __user *) ptr,
-					 ´  second, fifth, third);
+					  second, fifth, third);
 		}
 	case MSGGET:
 		return sys_msgget((key_t) first, second);
