Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id XAA13308
	for <pstadt@stud.fh-heilbronn.de>; Sun, 26 Sep 1999 23:58:22 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA21749; Sun, 26 Sep 1999 14:53:18 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA39779
	for linux-list;
	Sun, 26 Sep 1999 14:41:53 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA76831
	for <linux@engr.sgi.com>;
	Sun, 26 Sep 1999 14:41:49 -0700 (PDT)
	mail_from (sengelha@uiuc.edu)
Received: from frodo.isdn.uiuc.edu (frodo.isdn.uiuc.edu [192.17.20.74]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA2738298
	for <linux@engr.sgi.com>; Sun, 26 Sep 1999 14:41:47 -0700 (PDT)
	mail_from (sengelha@uiuc.edu)
Received: (from sengelha@localhost)
	by frodo.isdn.uiuc.edu (8.9.3/8.9.3/Debian/GNU) id QAA17807
	for linux@engr.sgi.com; Sun, 26 Sep 1999 16:41:47 -0500
Date: Sun, 26 Sep 1999 16:41:47 -0500
From: Steven Engelhardt <sengelha@uiuc.edu>
To: linux@cthulhu.engr.sgi.com
Subject: Problem Installing Hard Hat on an Indy
Message-ID: <19990926164147.A17799@uiuc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.6i
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

When attempting to install the Hard Hat distribution made available on
http://www.linux.sgi.com, we ran into the following problem when booting
the kernel:

Freeing unused kernel memory: 44k freed
Page fault from irq handler: 0000
$0: ....
$4: ....
$8: ....
$12: ....
$16: ....
$20: ....
$24: ....
$28: ....
epc : ...
status : ...
cause : ...
Aiee, killing interrupt handler
Kernel panic: Attempting to kill the idle task
In swapper task - not syncing

We were able to get the system to boot using other kernels from the test
directory on SGI's FTP site.  However, when the installation begins, we
were unable to find the correct SCSI controller in the list, and thus
Hard Hat was unable to find a hard drive to install to.

How can we get the original kernel to boot/how can we get newer kernels
to recognize the hard drive so we can install Linux?

Thanks.

-- 
 Steven Engelhardt <sengelha@uiuc.edu>
 http://www.uiuc.edu/ph/www/sengelha
