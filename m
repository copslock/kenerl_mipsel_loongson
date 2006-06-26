Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jun 2006 23:14:56 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:54972 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133884AbWFZWOn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Jun 2006 23:14:43 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FuzHD-0002Ql-UN
	for linux-mips@linux-mips.org; Tue, 27 Jun 2006 00:09:52 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FuzLt-00054S-F4
	for linux-mips@linux-mips.org; Tue, 27 Jun 2006 00:14:41 +0200
Date:	Tue, 27 Jun 2006 00:14:41 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060626221441.GA10595@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: au1000_lowlevel_probe on au1000_eth.c
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips

Hello,

I notice that during sleep/wakeup au1000_lowlevel_probe() tries to
access to variables arcs_cmdline,prom_envp & Co.. This sometime does
an oops.

What I like to understand is if I simply have to skip accessing to
these variables during wake up or I have to save them during system
boot or what...?

Thanks,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
