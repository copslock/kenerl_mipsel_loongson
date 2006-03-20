Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 04:32:39 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:48655 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133776AbWCTEaG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 04:30:06 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id BD45C64D3D; Mon, 20 Mar 2006 04:39:42 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id D073066EDF; Mon, 20 Mar 2006 04:39:15 +0000 (GMT)
Date:	Mon, 20 Mar 2006 04:39:15 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	akpm@osdl.org
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 2/12] [MIPS] Cosmetic updates to sync with linux-mips
Message-ID: <20060320043915.GB20416@deprecation.cyrius.com>
References: <20060320043802.GA20389@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320043802.GA20389@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Make some cosmetic changes in order to bring mainline in sync
with the linux-mips tree.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- linux-2.6/arch/mips/Makefile	2006-03-13 18:45:54.000000000 +0000
+++ mips.git/arch/mips/Makefile	2006-03-13 18:43:52.000000000 +0000
@@ -498,6 +499,7 @@
 cflags-$(CONFIG_PMC_YOSEMITE)	+= -Iinclude/asm-mips/mach-yosemite
 load-$(CONFIG_PMC_YOSEMITE)	+= 0xffffffff80100000
 
+#
 # Qemu simulating MIPS32 4Kc
 #
 core-$(CONFIG_QEMU)		+= arch/mips/qemu/
@@ -584,7 +586,7 @@
 load-$(CONFIG_CASIO_E55)	+= 0xffffffff80004000
 
 #
-# TANBAC VR4131 multichip module(TB0225) and TANBAC VR4131DIMM(TB0229) (VR4131)
+# TANBAC TB0225 VR4131 Multi-chip module/TB0229 VR4131DIMM (VR4131)
 #
 load-$(CONFIG_TANBAC_TB022X)	+= 0xffffffff80000000
 
--- linux-2.6/arch/mips/pci/fixup-tb0219.c	2006-03-05 19:35:02.000000000 +0000
+++ mips.git/arch/mips/pci/fixup-tb0219.c	2006-03-05 18:51:14.000000000 +0000
@@ -2,7 +2,7 @@
  *  fixup-tb0219.c, The TANBAC TB0219 specific PCI fixups.
  *
  *  Copyright (C) 2003  Megasolution Inc. <matsu@megasolution.jp>
- *  Copyright (C) 2004  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *  Copyright (C) 2004-2005  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by

-- 
Martin Michlmayr
http://www.cyrius.com/
