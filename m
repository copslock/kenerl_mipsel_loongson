Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Sep 2004 23:31:41 +0100 (BST)
Received: from p508B68F0.dip.t-dialin.net ([IPv6:::ffff:80.139.104.240]:49456
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225220AbUIAW2l>; Wed, 1 Sep 2004 23:28:41 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i81MSe2V005809
	for <linux-mips@linux-mips.org>; Thu, 2 Sep 2004 00:28:40 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i81MSe3t005808
	for linux-mips@linux-mips.org; Thu, 2 Sep 2004 00:28:40 +0200
Resent-Message-Id: <200409012228.i81MSe3t005808@fluff.linux-mips.net>
Received: from baikonur.stro.at ([IPv6:::ffff:213.239.196.228]:51910 "EHLO
	baikonur.stro.at") by linux-mips.org with ESMTP id <S8225211AbUIAV2T>;
	Wed, 1 Sep 2004 22:28:19 +0100
Received: from localhost (localhost [127.0.0.1])
	by baikonur.stro.at (Postfix) with ESMTP id 98B635C065;
	Wed,  1 Sep 2004 23:28:15 +0200 (CEST)
Received: from baikonur.stro.at ([127.0.0.1])
	by localhost (baikonur [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 09433-01; Wed, 1 Sep 2004 23:28:15 +0200 (CEST)
Received: from sputnik (M830P021.adsl.highway.telekom.at [62.47.135.181])
	by baikonur.stro.at (Postfix) with ESMTP id 17AC55C008;
	Wed,  1 Sep 2004 23:28:15 +0200 (CEST)
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by sputnik with esmtp (Exim 4.34)
	id 1C2ceP-0000Me-GX; Wed, 01 Sep 2004 23:28:17 +0200
Subject: [patch 1/1]  minmax-removal 	arch/mips/au1000/common/usbdev.c
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 23:28:17 +0200
Message-ID: <E1C2ceP-0000Me-GX@sputnik>
X-Virus-Scanned: by Amavis (ClamAV) at stro.at
Resent-From: ralf@linux-mips.org
Resent-Date: Thu, 2 Sep 2004 00:28:40 +0200
Resent-To: linux-mips@linux-mips.org
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5764
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips




Patch (against 2.6.8.1) removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

Since I dont have the hardware those patches are not tested.

Best regards
Veeck

Signed-off-by: Michael Veeck <michael.veeck@gmx.net>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/arch/mips/au1000/common/usbdev.c |    2 --
 1 files changed, 2 deletions(-)

diff -puN arch/mips/au1000/common/usbdev.c~min-max-arch_mips_au1000_common_usbdev arch/mips/au1000/common/usbdev.c
--- linux-2.6.9-rc1-bk7/arch/mips/au1000/common/usbdev.c~min-max-arch_mips_au1000_common_usbdev	2004-09-01 19:38:23.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/arch/mips/au1000/common/usbdev.c	2004-09-01 19:38:23.000000000 +0200
@@ -61,8 +61,6 @@
 #define vdbg(fmt, arg...) do {} while (0)
 #endif
 
-#define MAX(a,b)	(((a)>(b))?(a):(b))
-
 #define ALLOC_FLAGS (in_interrupt () ? GFP_ATOMIC : GFP_KERNEL)
 
 #define EP_FIFO_DEPTH 8

_
