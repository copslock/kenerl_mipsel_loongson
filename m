Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jan 2005 00:27:16 +0000 (GMT)
Received: from e3.ny.us.ibm.com ([IPv6:::ffff:32.97.182.143]:37765 "EHLO
	e3.ny.us.ibm.com") by linux-mips.org with ESMTP id <S8225215AbVAZA1B>;
	Wed, 26 Jan 2005 00:27:01 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.12.10/8.12.10) with ESMTP id j0Q0Qt7j023905;
	Tue, 25 Jan 2005 19:26:55 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j0Q0QtEr060868;
	Tue, 25 Jan 2005 19:26:55 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j0Q0Qsau027232;
	Tue, 25 Jan 2005 19:26:54 -0500
Received: from joust (DYN317993BLD.beaverton.ibm.com [9.47.17.65])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j0Q0Qsq3026975;
	Tue, 25 Jan 2005 19:26:54 -0500
Received: by joust (Postfix, from userid 1000)
	id 9BAB84F99A; Tue, 25 Jan 2005 16:26:48 -0800 (PST)
Date:	Tue, 25 Jan 2005 16:26:48 -0800
From:	Nishanth Aravamudan <nacc@us.ibm.com>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, kernel-janitors@lists.osdl.org
Subject: [PATCH 26/34] mips/mirage_ts: replace interruptible_sleep_on_timeout() with wait_event_timeout()
Message-ID: <20050126002648.GR12649@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <nacc@us.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nacc@us.ibm.com
Precedence: bulk
X-list: linux-mips

Hi,

Please consider applying.

Description: Use wait_event_timeout() instead of the deprecated
interruptible_sleep_on_timeout(). The current code does not seem to
care about signals, so interruptible seems unnecessary.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc2-kj-v/arch/mips/au1000/db1x00/mirage_ts.c	2005-01-24 09:28:12.000000000 -0800
+++ 2.6.11-rc2-kj/arch/mips/au1000/db1x00/mirage_ts.c	2005-01-24 16:43:25.000000000 -0800
@@ -42,6 +42,7 @@
 #include <linux/proc_fs.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
+#include <linux/wait.h>
 
 #include <asm/segment.h>
 #include <asm/irq.h>
@@ -147,10 +148,7 @@ static int ts_thread(void *id)
 	ts = wm97xx_ts_get_handle(0);
 
 	/* proceed only after everybody is ready */
-	while ( ! wm97xx_ts_ready(ts) ) {
-		/* give a little time for initializations to complete */
-		interruptible_sleep_on_timeout(&pendown_wait, HZ / 4);
-	}
+	wait_event_timeout(pendown_wait, wm97xx_ts_ready(ts), HZ/4);
 
 	/* board-specific calibration */
 	wm97xx_ts_set_cal(ts,
