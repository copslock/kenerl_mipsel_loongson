Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA23072 for <linux-archive@neteng.engr.sgi.com>; Sun, 14 Feb 1999 16:07:21 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA29143
	for linux-list;
	Sun, 14 Feb 1999 16:06:44 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA72932
	for <linux@engr.sgi.com>;
	Sun, 14 Feb 1999 16:06:41 -0800 (PST)
	mail_from (m_thrope@rigelfore.com)
Received: from slug.rigelfore.com (c69494-a.plstn1.sfba.home.com [24.2.21.88]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id QAA00165
	for <linux@engr.sgi.com>; Sun, 14 Feb 1999 16:06:41 -0800 (PST)
	mail_from (m_thrope@rigelfore.com)
Received: (qmail 5840 invoked from network); 15 Feb 1999 00:14:45 -0000
Received: from unknown (HELO rigelfore.com) (192.168.42.2)
  by 192.168.42.1 with SMTP; 15 Feb 1999 00:14:45 -0000
Message-ID: <36C76479.62B097D2@rigelfore.com>
Date: Sun, 14 Feb 1999 16:04:09 -0800
From: Eric Melville <m_thrope@rigelfore.com>
Organization: iLL
X-Mailer: Mozilla 4.5 [en] (Win95; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: problem booting sgi linux
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ok, i fixed my problem with /dev/console ... but now it stops just a few
lines after that. this is printed to the screen:

Adv: done running setup()
Freeing unused kernel memory: 44k freed
page fault from irq handler: 0000
$0: blah blah blah
$4: blah blah blah
$8: blah blah blah
$12: blah blah blah
$16: blah blah blah
$20: blah blah blah
$24: blah blah blah
epc: 880e3e47
Status: 1004fc02
Cause: 00000008
Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
In swapper task: not syncing

then it's stuck... i could write down the "blah blah blah" numbers if
they would be helpfull. any ideas?

-E
