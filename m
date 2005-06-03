Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2005 17:00:13 +0100 (BST)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:54980 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8226175AbVFCP7x>;
	Fri, 3 Jun 2005 16:59:53 +0100
Received: MO(mo00)id j53FxnXr023885; Sat, 4 Jun 2005 00:59:49 +0900 (JST)
Received: MDO(mdo01) id j53Fxms7010110; Sat, 4 Jun 2005 00:59:48 +0900 (JST)
Received: from stratos (h042.p502.iij4u.or.jp [210.149.246.42])
	by mbox.iij4u.or.jp (4U-MR/mbox01) id j53FxlZ2025863
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Sat, 4 Jun 2005 00:59:48 +0900 (JST)
Date:	Sat, 4 Jun 2005 00:59:45 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] vr41xx: update vr41xx commons
Message-Id: <20050604005945.278809f7.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi,

This patch had updated vr41xx commons.
o Cleaning of include files
o add EXPORT_SYMBOL to irq.c

diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/icu.c a/arch/mips/vr41xx/common/icu.c
--- a-orig/arch/mips/vr41xx/common/icu.c	Fri Jun  3 00:59:04 2005
+++ a/arch/mips/vr41xx/common/icu.c	Fri Jun  3 23:56:25 2005
@@ -30,7 +30,6 @@
  */
 #include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
 #include <linux/module.h>
@@ -39,8 +38,6 @@
 
 #include <asm/cpu.h>
 #include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/irq_cpu.h>
 #include <asm/vr41xx/vr41xx.h>
 
 static void __iomem *icu1_base;
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/irq.c a/arch/mips/vr41xx/common/irq.c
--- a-orig/arch/mips/vr41xx/common/irq.c	Thu Jun  2 23:37:13 2005
+++ a/arch/mips/vr41xx/common/irq.c	Fri Jun  3 23:58:17 2005
@@ -18,6 +18,7 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/interrupt.h>
+#include <linux/module.h>
 
 #include <asm/irq_cpu.h>
 #include <asm/system.h>
@@ -55,6 +56,8 @@
 
 	return retval;
 }
+
+EXPORT_SYMBOL_GPL(cascade_irq);
 
 asmlinkage void irq_dispatch(unsigned int irq, struct pt_regs *regs)
 {
