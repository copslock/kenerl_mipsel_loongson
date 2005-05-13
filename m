Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2005 14:25:52 +0100 (BST)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:20727 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225742AbVEMNZg>;
	Fri, 13 May 2005 14:25:36 +0100
Received: MO(mo01)id j4DDPVqj002124; Fri, 13 May 2005 22:25:31 +0900 (JST)
Received: MDO(mdo01) id j4DDPUg7027263; Fri, 13 May 2005 22:25:30 +0900 (JST)
Received: from stratos (h042.p502.iij4u.or.jp [210.149.246.42])
	by mbox.iij4u.or.jp (4U-MR/mbox00) id j4DDPTir001801
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Fri, 13 May 2005 22:25:30 +0900 (JST)
Date:	Fri, 13 May 2005 22:25:28 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] vr41xx: remove old TB0219 driver
Message-Id: <20050513222528.010b2a4d.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi,

This patch had removed old TB0219 driver.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff b-orig/arch/mips/vr41xx/tanbac-tb0229/Makefile b/arch/mips/vr41xx/tanbac-tb0229/Makefile
--- b-orig/arch/mips/vr41xx/tanbac-tb0229/Makefile	Thu Apr 29 10:42:49 2004
+++ b/arch/mips/vr41xx/tanbac-tb0229/Makefile	Sun Apr 24 00:18:11 2005
@@ -3,5 +3,3 @@
 #
 
 obj-y				:= setup.o
-
-obj-$(CONFIG_TANBAC_TB0219)	+= tb0219.o
diff -urN -X dontdiff b-orig/arch/mips/vr41xx/tanbac-tb0229/tb0219.c b/arch/mips/vr41xx/tanbac-tb0229/tb0219.c
--- b-orig/arch/mips/vr41xx/tanbac-tb0229/tb0219.c	Thu May 27 08:14:29 2004
+++ b/arch/mips/vr41xx/tanbac-tb0229/tb0219.c	Thu Jan  1 09:00:00 1970
@@ -1,44 +0,0 @@
-/*
- *  tb0219.c, Setup for the TANBAC TB0219
- *
- *  Copyright (C) 2003  Megasolution Inc. <matsu@megasolution.jp>
- *  Copyright (C) 2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#include <linux/init.h>
-
-#include <asm/io.h>
-#include <asm/reboot.h>
-
-#define TB0219_RESET_REGS	KSEG1ADDR(0x0a00000e)
-
-#define tb0219_hard_reset()	writew(0, TB0219_RESET_REGS)
-
-static void tanbac_tb0219_restart(char *command)
-{
-	local_irq_disable();
-	tb0219_hard_reset();
-	while (1);
-}
-
-static int __init tanbac_tb0219_setup(void)
-{
-	_machine_restart = tanbac_tb0219_restart;
-
-	return 0;
-}
-
-early_initcall(tanbac_tb0219_setup);
