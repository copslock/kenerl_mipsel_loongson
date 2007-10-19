Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Oct 2007 21:55:31 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:34760 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20045674AbXJSUzV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Oct 2007 21:55:21 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 9F964400D5;
	Fri, 19 Oct 2007 22:55:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id ZG+De2+joYnI; Fri, 19 Oct 2007 22:55:17 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id E2256400A4;
	Fri, 19 Oct 2007 22:55:17 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9JKtN6h028391;
	Fri, 19 Oct 2007 22:55:23 +0200
Date:	Fri, 19 Oct 2007 21:55:16 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
cc:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add self for the dz serial driver
Message-ID: <Pine.LNX.4.64N.0710192151480.13279@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4545/Wed Oct 17 23:05:57 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 Now that I have got the necessary piece of hardware (thanks, Thiemo!), I
may well offer myself as the maintainer for the dz serial driver.  I hope 
nobody objects.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Please apply,

  Maciej

patch-mips-2.6.23-rc5-20070904-dz-maint-0
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/MAINTAINERS linux-mips-2.6.23-rc5-20070904/MAINTAINERS
--- linux-mips-2.6.23-rc5-20070904.macro/MAINTAINERS	2007-09-04 04:55:16.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/MAINTAINERS	2007-10-13 23:49:58.000000000 +0000
@@ -1352,6 +1352,11 @@ W:	http://linuxtv.org/
 T:	git kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
 S:	Maintained
 
+DZ DECSTATION DZ11 SERIAL DRIVER
+P:	Maciej W. Rozycki
+M:	macro@linux-mips.org
+S:	Maintained
+
 EATA-DMA SCSI DRIVER
 P:	Michael Neuffer
 L:	linux-eata@i-connect.net, linux-scsi@vger.kernel.org
