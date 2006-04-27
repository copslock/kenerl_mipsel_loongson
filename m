Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Apr 2006 16:49:29 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:55742 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133415AbWD0PtU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Apr 2006 16:49:20 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FZ8gz-00089R-19
	for linux-mips@linux-mips.org; Thu, 27 Apr 2006 17:46:10 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FZ8kW-0006dn-B5
	for linux-mips@linux-mips.org; Thu, 27 Apr 2006 17:49:48 +0200
Date:	Thu, 27 Apr 2006 17:49:48 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060427154948.GI32278@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: trouble on serial console for au1100
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips

Hello,

finally I've started port of my code for an au1100 based board to the
last kernel version (2.6.17-rc3) and I've a problem on serial console!

I noticed that the serial lines management code is changed from
linux-2.6.12 and I'd like to know if someone is running the serial
console on ttyS0 on au1100...

Thanks,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
