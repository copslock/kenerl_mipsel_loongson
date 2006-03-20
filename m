Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 04:29:30 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:38415 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8127231AbWCTE1M (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 04:27:12 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 630A764D3E; Mon, 20 Mar 2006 04:36:49 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 8035D66ED5; Mon, 20 Mar 2006 04:36:33 +0000 (GMT)
Date:	Mon, 20 Mar 2006 04:36:33 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, akpm@osdl.org
Subject: [PATCH 5/6] [MIPS] vr41xx: remove timex.h
Message-ID: <20060320043633.GE20200@deprecation.cyrius.com>
References: <20060320043445.GA20171@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320043445.GA20171@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

vr41xx doesn't need mach-vr41xx/timex.h so remove it.  This also
brings the linux-mips tree in sync with Linus' tree.

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- mips.git/include/asm-mips/mach-vr41xx/timex.h	2006-03-05 18:51:19.000000000 +0000
+++ linux-2.6/include/asm-mips/mach-vr41xx/timex.h	1970-01-01 01:00:00.000000000 +0100
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
- *  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
- *  - CLOCK_TICK_RATE is changed into 32768 from 6144000.
- */
-#ifndef __ASM_MACH_VR41XX_TIMEX_H
-#define __ASM_MACH_VR41XX_TIMEX_H
-
-#define CLOCK_TICK_RATE		32768
-
-#endif /* __ASM_MACH_VR41XX_TIMEX_H */
-- 
Martin Michlmayr
http://www.cyrius.com/
