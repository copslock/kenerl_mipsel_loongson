Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2004 15:53:52 +0000 (GMT)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:37886 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225352AbULAPxs>;
	Wed, 1 Dec 2004 15:53:48 +0000
Received: MO(mo01)id iB1Frj3G012051; Thu, 2 Dec 2004 00:53:45 +0900 (JST)
Received: MDO(mdo00) id iB1Friib017402; Thu, 2 Dec 2004 00:53:44 +0900 (JST)
Received: 4UMRO00 id iB1FrhLj016268; Thu, 2 Dec 2004 00:53:44 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date: Thu, 2 Dec 2004 00:53:41 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] moved TANBAC_TB0219
Message-Id: <20041202005341.685ab658.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

TANBAC_TB0219 depends on TANBAC_TB0229 only.
This patch moves TANBAC_TB0219 next to TANBAC_TB0229.
Please apply this patch to 2.6.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/Kconfig a/arch/mips/Kconfig
--- a-orig/arch/mips/Kconfig	Thu Nov 25 15:37:27 2004
+++ a/arch/mips/Kconfig	Thu Dec  2 00:30:26 2004
@@ -103,6 +103,10 @@
 	  The TANBAC TB0229 (VR4131DIMM) is a MIPS-based platform manufactured by TANBAC.
 	  Please refer to <http://www.tanbac.co.jp/> about VR4131DIMM.
 
+config TANBAC_TB0219
+	bool "Added TANBAC TB0219 Base board support"
+	depends on TANBAC_TB0229
+
 config VICTOR_MPC30X
 	bool "Support for Victor MP-C303/304"
 	select DMA_NONCOHERENT
@@ -1106,10 +1110,6 @@
 	bool
 	depends on TOSHIBA_JMR3927 || TOSHIBA_RBTX4927
 	default y
-
-config TANBAC_TB0219
-	bool "Added TANBAC TB0219 Base board support"
-	depends on TANBAC_TB0229
 
 endmenu
 
