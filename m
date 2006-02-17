Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2006 22:52:04 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:62474 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133648AbWBQWvv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Feb 2006 22:51:51 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 0330664D59; Fri, 17 Feb 2006 22:58:31 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id B86588F77; Fri, 17 Feb 2006 22:58:24 +0000 (GMT)
Date:	Fri, 17 Feb 2006 22:58:24 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Cc:	jblache@debian.org
Subject: IP22 doesn't shutdown properly
Message-ID: <20060217225824.GE20785@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

When you try to shutdown or reboot an IP22 with 2.6.15 or 2.6.16-rc2,
you see that the TERM signal is sent but then nothing happens.  At the
beginning, the light on the Indy is green but after about 20 seconds
it turns red.  Nothing happens on the console and the machine doesn't
turn off.  Seen on Indy and Indigo2.

Anyone got a fix?


sgi:~# shutdown -r now

Broadcast message from root (ttyS0) (Fri Feb 17 22:52:47 2006):

The system is going down for reboot NOW!
INIT: Sending processes the TERM signal
INIT: Sending proces

[and nothing more]

Or, according to an Indigo2 users, "The machine hangs on shutdown -r
now after init sends the TERM signal; the LED stays green for a few
seconds, then turns orange which definitely isn't good."
-- 
Martin Michlmayr
http://www.cyrius.com/
