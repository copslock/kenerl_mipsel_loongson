Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2004 15:05:40 +0000 (GMT)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:52979 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225345AbULAPFf>;
	Wed, 1 Dec 2004 15:05:35 +0000
Received: MO(mo01)id iB1F5WKl003590; Thu, 2 Dec 2004 00:05:32 +0900 (JST)
Received: MDO(mdo00) id iB1F5VeB016563; Thu, 2 Dec 2004 00:05:32 +0900 (JST)
Received: 4UMRO01 id iB1F5VOD006285; Thu, 2 Dec 2004 00:05:31 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date: Thu, 2 Dec 2004 00:05:30 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] fix build error about NEC VR4100 series.
Message-Id: <20041202000530.33020293.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch had fixed build error about NEC VR4100 series.
Please apply this patch to 2.6.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/bcu.c a/arch/mips/vr41xx/common/bcu.c
--- a-orig/arch/mips/vr41xx/common/bcu.c	Thu May 27 02:11:11 2004
+++ a/arch/mips/vr41xx/common/bcu.c	Wed Dec  1 23:50:40 2004
@@ -30,6 +30,7 @@
  */
 #include <linux/init.h>
 #include <linux/ioport.h>
+#include <linux/kernel.h>
 #include <linux/smp.h>
 #include <linux/types.h>
 
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/pmu.c a/arch/mips/vr41xx/common/pmu.c
--- a-orig/arch/mips/vr41xx/common/pmu.c	Thu May 27 02:11:11 2004
+++ a/arch/mips/vr41xx/common/pmu.c	Wed Dec  1 23:50:40 2004
@@ -18,6 +18,7 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/smp.h>
 #include <linux/types.h>
 
