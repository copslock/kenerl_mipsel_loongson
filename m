Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 15:36:55 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:1766 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022091AbXHBOgd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Aug 2007 15:36:33 +0100
Received: from localhost (p2209-ipad28funabasi.chiba.ocn.ne.jp [220.107.201.209])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9FB0FA606; Thu,  2 Aug 2007 23:35:09 +0900 (JST)
Date:	Thu, 02 Aug 2007 23:36:17 +0900 (JST)
Message-Id: <20070802.233617.70476666.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 4/5] Use -Werror on TX39/TX49 boards
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Now these directories can be built cleanly.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/tx4927/common/Makefile           |    2 ++
 arch/mips/tx4927/toshiba_rbtx4927/Makefile |    2 ++
 arch/mips/tx4938/common/Makefile           |    1 +
 arch/mips/tx4938/toshiba_rbtx4938/Makefile |    2 ++
 4 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/mips/tx4927/common/Makefile b/arch/mips/tx4927/common/Makefile
index 9cb9535..1837578 100644
--- a/arch/mips/tx4927/common/Makefile
+++ b/arch/mips/tx4927/common/Makefile
@@ -10,3 +10,5 @@ obj-y	+= tx4927_prom.o tx4927_setup.o tx4927_irq.o
 
 obj-$(CONFIG_TOSHIBA_FPCIB0)	   += smsc_fdc37m81x.o
 obj-$(CONFIG_KGDB)                 += tx4927_dbgio.o
+
+EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/Makefile b/arch/mips/tx4927/toshiba_rbtx4927/Makefile
index 8a991f3..13f9672 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/Makefile
+++ b/arch/mips/tx4927/toshiba_rbtx4927/Makefile
@@ -1,3 +1,5 @@
 obj-y	+= toshiba_rbtx4927_prom.o
 obj-y	+= toshiba_rbtx4927_setup.o
 obj-y	+= toshiba_rbtx4927_irq.o
+
+EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/tx4938/common/Makefile b/arch/mips/tx4938/common/Makefile
index 83cda51..8352eca 100644
--- a/arch/mips/tx4938/common/Makefile
+++ b/arch/mips/tx4938/common/Makefile
@@ -9,3 +9,4 @@
 obj-y	+= prom.o setup.o irq.o
 obj-$(CONFIG_KGDB) += dbgio.o
 
+EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/Makefile b/arch/mips/tx4938/toshiba_rbtx4938/Makefile
index 10c94e6..675bb1c 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/Makefile
+++ b/arch/mips/tx4938/toshiba_rbtx4938/Makefile
@@ -7,3 +7,5 @@
 #
 
 obj-y	+= prom.o setup.o irq.o spi_eeprom.o
+
+EXTRA_CFLAGS += -Werror
