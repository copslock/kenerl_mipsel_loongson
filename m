Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2006 18:40:34 +0200 (CEST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:31648 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133928AbWEWQkY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 May 2006 18:40:24 +0200
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FiZs3-0008AX-FE
	for linux-mips@linux-mips.org; Tue, 23 May 2006 18:36:35 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FiZw0-00032w-8O
	for linux-mips@linux-mips.org; Tue, 23 May 2006 18:40:40 +0200
Date:	Tue, 23 May 2006 18:40:40 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060523164040.GC28124@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH] New power management and sysfs support for au1x00
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips

Hello,

here:

   http://ftp.enneenne.com/pub/misc/au1100-patches/linux/patch-pm-sysfs

my new patch for power management and sysfs support for au1x00
CPUs. This patch is against linux 2.6.17-rc4 and has been tested with
an au1100 based board.

To suspend your system for 3 seconds use:

   # echo mem > /sys/power/state

the default behaviour can be changed per board basis by defining a
special function as follow:

   #ifdef CONFIG_PM
   int my_board_before_sleep(void)
   {
   	/* do whatever you want before sleeping */

   	/* then return the wake up reason */
           return 1<<6; /* wait for GPIO 6 changes */
   }

   void my_board_after_sleep(int reason)
   {
	/* do whatever you want after sleeping */
   }
   #endif
      
   void __init board_setup(void)
   {


   ...
   #ifdef CONFIG_PM
           /* Setup sleeping functions */
           board_before_sleep = my_board_before_sleep;
           board_after_sleep = my_board_after_sleep;
   #endif
   ...

Ciao,

Rodolfo       

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
