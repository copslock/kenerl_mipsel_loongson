Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2006 10:44:21 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:36614 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133378AbWB0KoL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Feb 2006 10:44:11 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 946F664D3D; Mon, 27 Feb 2006 10:51:46 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 2AE608D59; Mon, 27 Feb 2006 11:51:33 +0100 (CET)
Date:	Mon, 27 Feb 2006 10:51:33 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org, jblache@debian.org,
	rmk+serial@arm.linux.org.uk
Subject: Re: IP22 doesn't shutdown properly
Message-ID: <20060227105132.GH12044@deprecation.cyrius.com>
References: <20060217225824.GE20785@deprecation.cyrius.com> <20060223221350.GA5239@deprecation.cyrius.com> <20060224190517.GA28013@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224190517.GA28013@lst.de>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Christoph Hellwig <hch@lst.de> [2006-02-24 20:05]:
> This patch was dropped when a real fix went into one of the sun serial
> drivers with which this issue was seen before.  Please look through
> the drivers/serial/sun* changelogs and see what fix needs to be
> ported to the ip22zilog driver.

Thanks for the hint, Christoph.  Russell, please apply the following
patch for 2.6.16.  Tested on IP22 (Indy).


[serial] ip22zilog: Fix oops on runlevel change with serial console

Incorrect uart_write_wakeup() calls cause reference to a NULL tty
pointer.  This has been fixed in the sunsab and sunzilog serial drivers
in October 2005.  Update the ip22zilog, which is based on sunzilog,
accordingly.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- a/drivers/serial/ip22zilog.c	2006-02-23 22:05:49.000000000 +0000
+++ b/drivers/serial/ip22zilog.c	2006-02-27 09:51:38.000000000 +0000
@@ -420,10 +420,8 @@
 	if (up->port.info == NULL)
 		goto ack_tx_int;
 	xmit = &up->port.info->xmit;
-	if (uart_circ_empty(xmit)) {
-		uart_write_wakeup(&up->port);
+	if (uart_circ_empty(xmit))
 		goto ack_tx_int;
-	}
 	if (uart_tx_stopped(&up->port))
 		goto ack_tx_int;
 

-- 
Martin Michlmayr
http://www.cyrius.com/
