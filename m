Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jan 2007 14:44:10 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:10248 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S28580535AbXAKOoF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Jan 2007 14:44:05 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id DB212F59AE;
	Thu, 11 Jan 2007 15:43:50 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oW9hcat-jlTW; Thu, 11 Jan 2007 15:43:50 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 7ACBCF59AA;
	Thu, 11 Jan 2007 15:43:50 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l0BEhxZn026442;
	Thu, 11 Jan 2007 15:44:00 +0100
Date:	Thu, 11 Jan 2007 14:43:54 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@osdl.org>
cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.20-rc1 11/10] TURBOchannel resources off-by-one fix 
Message-ID: <Pine.LNX.4.64N.0701111439070.11394@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.7/2435/Thu Jan 11 09:34:23 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 This is a trivial fix to resource reservation of TURBOchannel areas, 
where the end is one byte too far.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-tc-sysfs-resource-0
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/tc/tc.c linux-mips-2.6.18-20060920/drivers/tc/tc.c
--- linux-mips-2.6.18-20060920.macro/drivers/tc/tc.c	2006-12-19 23:03:11.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/tc/tc.c	2006-12-28 18:51:49.000000000 +0000
@@ -160,7 +160,7 @@ static int __init tc_init(void)
 		tc_bus.resource[0].start = tc_bus.slot_base;
 		tc_bus.resource[0].end = tc_bus.slot_base +
 					 (tc_bus.info.slot_size << 20) *
-					 tc_bus.num_tcslots;
+					 tc_bus.num_tcslots - 1;
 		tc_bus.resource[0].name = tc_bus.name;
 		tc_bus.resource[0].flags = IORESOURCE_MEM;
 		if (request_resource(&iomem_resource,
@@ -172,7 +172,7 @@ static int __init tc_init(void)
 			tc_bus.resource[1].start = tc_bus.ext_slot_base;
 			tc_bus.resource[1].end = tc_bus.ext_slot_base +
 						 tc_bus.ext_slot_size *
-						 tc_bus.num_tcslots;
+						 tc_bus.num_tcslots - 1;
 			tc_bus.resource[1].name = tc_bus.name;
 			tc_bus.resource[1].flags = IORESOURCE_MEM;
 			if (request_resource(&iomem_resource,
