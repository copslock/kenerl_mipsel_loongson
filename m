Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jun 2004 03:10:33 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:14578 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8226048AbUFPCK3>;
	Wed, 16 Jun 2004 03:10:29 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i5G2AO4O029564;
	Tue, 15 Jun 2004 19:10:24 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i5G2ANvO029563;
	Tue, 15 Jun 2004 19:10:23 -0700
Date: Tue, 15 Jun 2004 19:10:23 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH] make ps2 mouse work ...
Message-ID: <20040615191023.G28403@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


I found this problem on a MIPS machine.  The problem is 
likely to happen on other register-rich RISC arches too.

cmdcnt needs to be volatile since it is modified by
irq routine and read by normal process context.

Jun

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="040615.a-psmouse-cmdcnt-volatile.patch"

diff -Nru linux/drivers/input/mouse/psmouse.h.orig linux/drivers/input/mouse/psmouse.h
--- linux/drivers/input/mouse/psmouse.h.orig	2004-04-16 15:28:47.000000000 -0700
+++ linux/drivers/input/mouse/psmouse.h	2004-06-15 18:51:53.000000000 -0700
@@ -40,7 +40,7 @@
 	char *name;
 	unsigned char cmdbuf[8];
 	unsigned char packet[8];
-	unsigned char cmdcnt;
+	volatile unsigned char cmdcnt;
 	unsigned char pktcnt;
 	unsigned char type;
 	unsigned char model;

--FCuugMFkClbJLl1L--
