Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 10:53:52 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:58521 "EHLO
	gundam.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133624AbWEDJxn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 May 2006 10:53:43 +0100
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1FbaWj-00016M-00
	for <linux-mips@linux-mips.org>; Thu, 04 May 2006 11:53:41 +0200
Date:	Thu, 4 May 2006 11:53:41 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Subject: Porting Au1x000 USB host controller on u-boot
Message-ID: <20060504095341.GB19913@gundam.enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips

Hello,

I'm trying to implement support for USB host into u-boot. I
initialized the USB controller just as linux does, the EDs and the TDs
look like good in memory but the controller seems not well reading
them and on the bus I see random USB messages...

I think that there could be some problem on memory coherency... some
suggestion?

Thanks,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
