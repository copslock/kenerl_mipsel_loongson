Received:  by oss.sgi.com id <S305201AbPL2ToX>;
	Wed, 29 Dec 1999 11:44:23 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:18702 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305166AbPL2Tn6>; Wed, 29 Dec 1999 11:43:58 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id LAA04758; Wed, 29 Dec 1999 11:46:10 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA44713
	for linux-list;
	Wed, 29 Dec 1999 11:22:01 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA48886
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 29 Dec 1999 11:21:54 -0800 (PST)
	mail_from (jharrell@ti.com)
Received: from tower.ti.com (tower.ti.com [192.94.94.5]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA06018
	for <linux@cthulhu.engr.sgi.com>; Wed, 29 Dec 1999 11:21:53 -0800 (PST)
	mail_from (jharrell@ti.com)
Received: from dlep8.itg.ti.com ([157.170.134.88])
	by tower.ti.com (8.9.3/8.9.3) with ESMTP id NAA18525
	for <linux@cthulhu.engr.sgi.com>; Wed, 29 Dec 1999 13:21:52 -0600 (CST)
Received: from dlep8.itg.ti.com (localhost [127.0.0.1])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id NAA12556
	for <linux@cthulhu.engr.sgi.com>; Wed, 29 Dec 1999 13:21:29 -0600 (CST)
Received: from dlep4.itg.ti.com (dlep4.itg.ti.com [157.170.188.63])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id NAA12552
	for <linux@cthulhu.engr.sgi.com>; Wed, 29 Dec 1999 13:21:29 -0600 (CST)
Received: from ti.com (IDENT:jharrell@pcp97780pcs.sc.ti.com [158.218.100.100])
	by dlep4.itg.ti.com (8.9.3/8.9.3) with ESMTP id NAA08635
	for <linux@cthulhu.engr.sgi.com>; Wed, 29 Dec 1999 13:21:50 -0600 (CST)
Message-ID: <386A5F9B.50B4AFEF@ti.com>
Date:   Wed, 29 Dec 1999 12:23:07 -0700
From:   Jeff Harrell <jharrell@ti.com>
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux@cthulhu.engr.sgi.com
Subject: question concerning serial console setup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

I wonder if anybody might have some information concerning the setup of
a serial console device
on the MIPS/Linux platform.  I have been looking at the sgi (indy)
source code to determine how to
setup a serial console device.  The file arch/mips/sgi/kernel/setup.c
contains a call to "console_setup"
passing the parameters "ttys0" and NULL.  I have had some trouble
locating the routine that this is
actually calling (file, directory?).  It looks like there is a version
in printk.c and in one of  the char drivers (serial167.c).
These do not seem like the correct routines.  In our architecture we are
using the 85C30 (SCC) driver
(zs.c, zs.h),  can I use the serial_console_init routines from this code
to accomplish the same thing?  Is
serial_console setting up additional information that won't get setup
elsewhere?   Any help would be
greatly appreciated.

Thanks,
Jeff



--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell                    Work:  (801) 619-6104
Broadband Access group/TI
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
