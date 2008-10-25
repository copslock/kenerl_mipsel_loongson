Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Oct 2008 09:30:53 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:1832 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S22341850AbYJYIao (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 25 Oct 2008 09:30:44 +0100
Received: by mo.po.2iij.net (mo32) id m9P8Ud28063569; Sat, 25 Oct 2008 17:30:39 +0900 (JST)
Received: from delta (187.24.30.125.dy.iij4u.or.jp [125.30.24.187])
	by mbox.po.2iij.net (po-mbox301) id m9P8UYGv003255
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Oct 2008 17:30:35 +0900
Date:	Sat, 25 Oct 2008 17:30:35 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp,
	linux-mips <linux-mips@linux-mips.org>,
	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH][MIPS] fix kgdb build error
Message-Id: <20081025173035.6e05f8dc.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20081024164241.GB21892@linux-mips.org>
References: <20081025001725.7ac18a1b.yoichi_yuasa@tripeaks.co.jp>
	<20081024164241.GB21892@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Fri, 24 Oct 2008 17:42:41 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> 
> <asm/ptrace.h> is exported to userland so we can't include these types.
> Basically <linux/types.h> or <stdint.h> are polluting the namespace.  So
> either we use some __* type and include only those or we get entirely
> rid of typedef'ed types - as in the patch that you've posted while I was
> writing this.

Thank you for your comment.
KGDB still has a problem. This is kernel part in ptrace.h.

---

Fix KGDB build error

In file included from include/linux/ptrace.h:49,
                 from arch/mips/kernel/kgdb.c:25:
/home/yuasa/src/linux/test/mips/linux/arch/mips/include/asm/ptrace.h:123: error: expected declaration specifiers or '...' before '__s64'
/home/yuasa/src/linux/test/mips/linux/arch/mips/include/asm/ptrace.h:124: error: expected declaration specifiers or '...' before '__s64'
/home/yuasa/src/linux/test/mips/linux/arch/mips/include/asm/ptrace.h:126: error: expected declaration specifiers or '...' before '__u32'
/home/yuasa/src/linux/test/mips/linux/arch/mips/include/asm/ptrace.h:127: error: expected declaration specifiers or '...' before '__u32'
make[1]: *** [arch/mips/kernel/kgdb.o] Error 1

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/include/asm/ptrace.h linux/arch/mips/include/asm/ptrace.h
--- linux-orig/arch/mips/include/asm/ptrace.h	2008-10-25 14:12:22.034139781 +0900
+++ linux/arch/mips/include/asm/ptrace.h	2008-10-25 16:39:36.031229216 +0900
@@ -116,6 +116,7 @@ struct pt_watch_regs {
 
 #include <linux/compiler.h>
 #include <linux/linkage.h>
+#include <linux/types.h>
 #include <asm/isadep.h>
 
 struct task_struct;
