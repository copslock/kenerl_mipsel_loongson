Received:  by oss.sgi.com id <S305160AbQAYXK4>;
	Tue, 25 Jan 2000 15:10:56 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:42808 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305158AbQAYXKc>;
	Tue, 25 Jan 2000 15:10:32 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA19068; Tue, 25 Jan 2000 15:08:31 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA07024
	for linux-list;
	Tue, 25 Jan 2000 14:49:13 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA43477
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 25 Jan 2000 14:49:10 -0800 (PST)
	mail_from (vwells@ti.com)
Received: from tower.ti.com (tower.ti.com [192.94.94.5]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA04207
	for <linux@cthulhu.engr.sgi.com>; Tue, 25 Jan 2000 14:49:08 -0800 (PST)
	mail_from (vwells@ti.com)
Received: from dlep9.itg.ti.com ([157.170.135.38])
	by tower.ti.com (8.9.3/8.9.3) with ESMTP id QAA04736
	for <linux@cthulhu.engr.sgi.com>; Tue, 25 Jan 2000 16:49:07 -0600 (CST)
Received: from dlep9.itg.ti.com (localhost [127.0.0.1])
	by dlep9.itg.ti.com (8.9.3/8.9.3) with ESMTP id QAA24060
	for <linux@cthulhu.engr.sgi.com>; Tue, 25 Jan 2000 16:49:01 -0600 (CST)
Received: from dlep3.itg.ti.com (dlep3.itg.ti.com [157.170.188.62])
	by dlep9.itg.ti.com (8.9.3/8.9.3) with ESMTP id QAA24049
	for <linux@cthulhu.engr.sgi.com>; Tue, 25 Jan 2000 16:49:01 -0600 (CST)
Received: from ti.com (IDENT:vwells@pcp97796pcs.sc.ti.com [158.218.100.116])
	by dlep3.itg.ti.com (8.9.3/8.9.3) with ESMTP id QAA22173
	for <linux@cthulhu.engr.sgi.com>; Tue, 25 Jan 2000 16:49:00 -0600 (CST)
Message-ID: <388E2920.10597068@ti.com>
Date:   Tue, 25 Jan 2000 15:52:16 -0700
From:   Victor Wells <vwells@ti.com>
Organization: Texas Instruments
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux@cthulhu.engr.sgi.com
Subject: Embedded system with RAM Disk
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

*** Please excuse if you have received multiple copies of this message.
I was not
        correctly subscribed to the news group.    Thanks for everyones
patience.  ****

I am developing an embedded system that will boot from flash.
I would like to load a RAM based file system to physical memory
and then have the kernel mount the RAM disk as the Root
file system.

This is fairly straight forward using "initrd" because normal kernel
functions can accomplish it.  I would like to skip loading initrd and go



right to the final RAM disk if this is possible.

Our boot process is to:
1.) Load the kernel
2.) Load the RAM disk/Root file system
3.) Mount the RAM disk as the Root file system within the kernel

How can I hard code the kernel to know where the RAM disk will
exist in physical memory?   We do not have JTAG or any other means
to create the file system on the target platform prior to saving the
file
system to Flash.

Thanks,

Victor
