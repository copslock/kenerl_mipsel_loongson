Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Mar 2006 11:19:59 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:54927 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133524AbWCaKTv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 31 Mar 2006 11:19:51 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FPGrb-0005pT-1F; Fri, 31 Mar 2006 12:28:19 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FPGtn-0005bE-Jq; Fri, 31 Mar 2006 12:30:35 +0200
Date:	Fri, 31 Mar 2006 12:30:35 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Linux MIPS <linux-mips@linux-mips.org>
Cc:	ppopov@mvista.com
Message-ID: <20060331103035.GH7029@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: PM support for au1000_eth.c
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips

Hello,

I'd like to add a power management support to this driver. That is I'd
like to suspend and resume this device during sleep.Which should be
the better way to do it?

I think it should be correct adding this driver into file
arch/mips/au1000/common/platform.c and then definying the suspend()
and resume() functions, but I'm not sure...

Suggestions?

Thanks,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
