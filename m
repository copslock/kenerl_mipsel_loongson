Received:  by oss.sgi.com id <S305166AbQBARGQ>;
	Tue, 1 Feb 2000 09:06:16 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:19975 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305160AbQBARGI>;
	Tue, 1 Feb 2000 09:06:08 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA00617; Tue, 1 Feb 2000 09:09:07 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA65150
	for linux-list;
	Tue, 1 Feb 2000 08:43:19 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA66574
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 1 Feb 2000 08:43:14 -0800 (PST)
	mail_from (jharrell@ti.com)
Received: from gatekeep.ti.com (gatekeep.ti.com [192.94.94.61]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA02852
	for <linux@cthulhu.engr.sgi.com>; Tue, 1 Feb 2000 08:43:13 -0800 (PST)
	mail_from (jharrell@ti.com)
Received: from dlep6.itg.ti.com ([157.170.188.9])
	by gatekeep.ti.com (8.9.3/8.9.3) with ESMTP id KAA05495
	for <linux@cthulhu.engr.sgi.com>; Tue, 1 Feb 2000 10:43:12 -0600 (CST)
Received: from dlep6.itg.ti.com (localhost [127.0.0.1])
	by dlep6.itg.ti.com (8.9.3/8.9.3) with ESMTP id KAA17154
	for <linux@cthulhu.engr.sgi.com>; Tue, 1 Feb 2000 10:43:07 -0600 (CST)
Received: from dlep4.itg.ti.com (dlep4.itg.ti.com [157.170.188.63])
	by dlep6.itg.ti.com (8.9.3/8.9.3) with ESMTP id KAA17133
	for <linux@cthulhu.engr.sgi.com>; Tue, 1 Feb 2000 10:43:06 -0600 (CST)
Received: from ti.com (IDENT:jharrell@pcp97780pcs.sc.ti.com [158.218.100.100])
	by dlep4.itg.ti.com (8.9.3/8.9.3) with ESMTP id KAA09445
	for <linux@cthulhu.engr.sgi.com>; Tue, 1 Feb 2000 10:43:10 -0600 (CST)
Message-ID: <38970DA5.165EDA0F@ti.com>
Date:   Tue, 01 Feb 2000 09:45:25 -0700
From:   Jeff Harrell <jharrell@ti.com>
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     sgi-mips <linux@cthulhu.engr.sgi.com>
Subject: Question concerning memory configuration variables
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

I have been looking at 2.2.23 and noticed that a few things concerning
memory
paging has changed.  I wonder if anybody could give me a definition of a
couple
of the variables that are defined.  The first is the max_low_pfn
variable.  It looks
like the first time that I see this called is during the paging_init()
function and
passed to free_area_init().   The memory map size is determined from
this variable.
It memory map will extend to the end of physical memory (what used to be
mips_memory_
upper).  Do I determine the max_low_pfn by calculating the available
memory and subtract
the size of the kernel?  How does the variable "start" play into this
equation?  Are they
the same?  Any help would be greatly appreciated.

Thanks,
Jeff

--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell                    Work:  (801) 619-6104
Broadband Access group/TI
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
