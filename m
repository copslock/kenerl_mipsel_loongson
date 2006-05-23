Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2006 15:24:11 +0200 (CEST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:58268 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133737AbWEWNYD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 May 2006 15:24:03 +0200
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FiWo2-00076g-4O
	for linux-mips@linux-mips.org; Tue, 23 May 2006 15:20:14 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FiWry-0000o1-Ls
	for linux-mips@linux-mips.org; Tue, 23 May 2006 15:24:18 +0200
Date:	Tue, 23 May 2006 15:24:18 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060523132418.GA28124@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: USB sleep & mount
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips

Hello,

I'm working on sleep for USB host on au1x00 CPUs and I have the
following problem.

When I put the system to sleep and then it wakes up everything works
well _if_ the USB key is not mounted before the sleep. For instance,
if I mount partition "/dev/sda1" (first USB key partition) and then go
to sleep, at wake up the system forgets device "/dev/sda" and
registers a new device "/dev/sdb" so, obviously, the filesystem
previously mounted is not accessible anymore.

My question is: is that correct since the userland, before going to
sleep, should umount all external filesystems or it's a bug? :)

Thanks,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
