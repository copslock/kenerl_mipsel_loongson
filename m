Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2005 16:19:37 +0100 (BST)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:1486 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8226453AbVGKPTT>;
	Mon, 11 Jul 2005 16:19:19 +0100
Received: MO(mo00)id j6BFKBPO018699; Tue, 12 Jul 2005 00:20:11 +0900 (JST)
Received: MDO(mdo00) id j6BFKB45022885; Tue, 12 Jul 2005 00:20:11 +0900 (JST)
Received: from stratos (h086.p498.iij4u.or.jp [210.149.242.86])
	by mbox.iij4u.or.jp (4U-MR/mbox01) id j6BFKAl3016031
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Tue, 12 Jul 2005 00:20:10 +0900 (JST)
Date:	Tue, 12 Jul 2005 00:20:08 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] vr41xx: remove obsolete ksyms.c
Message-Id: <20050712002008.613323b7.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has removed a obsolete ksyms.c file for vr41xx.
Please apply this patch.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/ksyms.c a/arch/mips/vr41xx/common/ksyms.c
--- a-orig/arch/mips/vr41xx/common/ksyms.c	2005-01-15 10:31:06.000000000 +0900
+++ a/arch/mips/vr41xx/common/ksyms.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,33 +0,0 @@
-/*
- *   ksyms.c, Export NEC VR4100 series specific functions needed for loadable modules.
- *
- *  Copyright (C) 2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *  Copyright (C) 2005 Ralf Baechle (ralf@linux-mips.org)
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
-#include <linux/module.h>
-
-#include <asm/vr41xx/vr41xx.h>
-
-EXPORT_SYMBOL(vr41xx_get_vtclock_frequency);
-EXPORT_SYMBOL(vr41xx_get_tclock_frequency);
-
-EXPORT_SYMBOL(vr41xx_set_rtclong1_cycle);
-EXPORT_SYMBOL(vr41xx_read_rtclong1_counter);
-EXPORT_SYMBOL(vr41xx_set_rtclong2_cycle);
-EXPORT_SYMBOL(vr41xx_read_rtclong2_counter);
-EXPORT_SYMBOL(vr41xx_set_tclock_cycle);
-EXPORT_SYMBOL(vr41xx_read_tclock_counter);
