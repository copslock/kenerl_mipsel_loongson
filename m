Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jan 2011 01:30:32 +0100 (CET)
Received: from kroah.org ([198.145.64.141]:54461 "EHLO coco.kroah.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490979Ab1AFAa3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Jan 2011 01:30:29 +0100
Received: from localhost (c-71-227-141-191.hsd1.wa.comcast.net [71.227.141.191])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by coco.kroah.org (Postfix) with ESMTPSA id C30AE4898F;
        Wed,  5 Jan 2011 16:30:24 -0800 (PST)
X-Mailbox-Line: From gregkh@clark.site Wed Jan  5 16:23:05 2011
Message-Id: <20110106002304.923508592@clark.site>
User-Agent: quilt/0.48-11.2
Date:   Wed, 05 Jan 2011 16:23:05 -0800
From:   Greg KH <gregkh@suse.de>
To:     linux-kernel@vger.kernel.org, stable@kernel.org
Cc:     stable-review@kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [086/152] MIPS: jz4740: qi_lb60: Fix gpio for the 6th row of the keyboard matrix
In-Reply-To: <20110106002500.GA3172@kroah.com>
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips

2.6.36-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Lars-Peter Clausen <lars@metafoo.de>

commit fe749aab1d21cbb4d87527a7df8799583c233496 upstream.

This patch fixes the gpio number for the 6th row of the keyboard matrix.

(And fixes a typo in my name...)

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-mips@linux-mips.org
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/mips/jz4740/board-qi_lb60.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -5,7 +5,7 @@
  *
  * Copyright (c) 2009 Qi Hardware inc.,
  * Author: Xiangfu Liu <xiangfu@qi-hardware.com>
- * Copyright 2010, Lars-Petrer Clausen <lars@metafoo.de>
+ * Copyright 2010, Lars-Peter Clausen <lars@metafoo.de>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 or later
@@ -235,7 +235,7 @@ static const unsigned int qi_lb60_keypad
 	QI_LB60_GPIO_KEYIN(3),
 	QI_LB60_GPIO_KEYIN(4),
 	QI_LB60_GPIO_KEYIN(5),
-	QI_LB60_GPIO_KEYIN(7),
+	QI_LB60_GPIO_KEYIN(6),
 	QI_LB60_GPIO_KEYIN8,
 };
 
