Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 May 2005 03:20:52 +0100 (BST)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:12246 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225234AbVEVCUh>;
	Sun, 22 May 2005 03:20:37 +0100
Received: MO(mo01)id j4M2KWCl010683; Sun, 22 May 2005 11:20:32 +0900 (JST)
Received: MDO(mdo00) id j4M2KWZk007392; Sun, 22 May 2005 11:20:32 +0900 (JST)
Received: from stratos (h042.p502.iij4u.or.jp [210.149.246.42])
	by mbox.iij4u.or.jp (4U-MR/mbox01) id j4M2KVk8013775
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Sun, 22 May 2005 11:20:31 +0900 (JST)
Date:	Sun, 22 May 2005 11:20:30 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] vr41xx: update setup functions
Message-Id: <20050522112030.59e103ec.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi,

This patch had updated vr41xx setup functions.
o add __init
o change from early_initcall to arch_initcall

Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff b-orig/arch/mips/vr41xx/casio-e55/setup.c b/arch/mips/vr41xx/casio-e55/setup.c
--- b-orig/arch/mips/vr41xx/casio-e55/setup.c	Sat Apr 23 22:59:07 2005
+++ b/arch/mips/vr41xx/casio-e55/setup.c	Sat Apr 23 23:32:33 2005
@@ -17,6 +17,7 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+#include <linux/init.h>
 #include <linux/ioport.h>
 
 #include <asm/io.h>
@@ -27,7 +28,7 @@
 	return "CASIO CASSIOPEIA E-11/15/55/65";
 }
 
-static int casio_e55_setup(void)
+static int __init casio_e55_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
 	ioport_resource.start = IO_PORT_RESOURCE_START;
@@ -36,4 +37,4 @@
 	return 0;
 }
 
-early_initcall(casio_e55_setup);
+arch_initcall(casio_e55_setup);
diff -urN -X dontdiff b-orig/arch/mips/vr41xx/ibm-workpad/setup.c b/arch/mips/vr41xx/ibm-workpad/setup.c
--- b-orig/arch/mips/vr41xx/ibm-workpad/setup.c	Sat Apr 23 22:59:08 2005
+++ b/arch/mips/vr41xx/ibm-workpad/setup.c	Sat Apr 23 23:32:33 2005
@@ -17,6 +17,7 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+#include <linux/init.h>
 #include <linux/ioport.h>
 
 #include <asm/io.h>
@@ -27,7 +28,7 @@
 	return "IBM WorkPad z50";
 }
 
-static int ibm_workpad_setup(void)
+static int __init ibm_workpad_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
 	ioport_resource.start = IO_PORT_RESOURCE_START;
@@ -36,4 +37,4 @@
 	return 0;
 }
 
-early_initcall(ibm_workpad_setup);
+arch_initcall(ibm_workpad_setup);
