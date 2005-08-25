Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2005 15:41:26 +0100 (BST)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:39900 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225330AbVHYOlG>;
	Thu, 25 Aug 2005 15:41:06 +0100
Received: MO(mo01)id j7PEke45003499; Thu, 25 Aug 2005 23:46:40 +0900 (JST)
Received: MDO(mdo00) id j7PEkdK7024650; Thu, 25 Aug 2005 23:46:40 +0900 (JST)
Received: from stratos (h009.p499.iij4u.or.jp [210.149.243.9])
	by mbox.iij4u.or.jp (4U-MR/mbox00) id j7PEkcsT011685
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Thu, 25 Aug 2005 23:46:39 +0900 (JST)
Date:	Thu, 25 Aug 2005 23:46:37 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATH 2.6] vr41xx: remove timex.h
Message-Id: <20050825234637.27fe3f35.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

vr41xx doesn't need mach-vr41xx/timex.h.
This patch has removed mach-vr41xx/timex.h.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/include/asm-mips/mach-vr41xx/timex.h a/include/asm-mips/mach-vr41xx/timex.h
--- a-orig/include/asm-mips/mach-vr41xx/timex.h	2003-12-02 04:32:01.000000000 +0900
+++ a/include/asm-mips/mach-vr41xx/timex.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,18 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2003 by Ralf Baechle
- */
-/*
- * Changes:
- *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *  - CLOCK_TICK_RATE is changed into 32768 from 6144000.
- */
-#ifndef __ASM_MACH_VR41XX_TIMEX_H
-#define __ASM_MACH_VR41XX_TIMEX_H
-
-#define CLOCK_TICK_RATE		32768
-
-#endif /* __ASM_MACH_VR41XX_TIMEX_H */
