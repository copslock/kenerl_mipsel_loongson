Received:  by oss.sgi.com id <S305171AbQA1Wy4>;
	Fri, 28 Jan 2000 14:54:56 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:9542 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305169AbQA1Wyg>;
	Fri, 28 Jan 2000 14:54:36 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA10463; Fri, 28 Jan 2000 14:52:50 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA21363
	for linux-list;
	Fri, 28 Jan 2000 14:30:07 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA07536
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 28 Jan 2000 14:30:04 -0800 (PST)
	mail_from (jharrell@ti.com)
Received: from jester.ti.com (jester.ti.com [192.94.94.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA03048
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Jan 2000 14:30:02 -0800 (PST)
	mail_from (jharrell@ti.com)
Received: from dlep6.itg.ti.com ([157.170.188.9])
	by jester.ti.com (8.9.3/8.9.3) with ESMTP id QAA04989
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Jan 2000 16:29:17 -0600 (CST)
Received: from dlep6.itg.ti.com (localhost [127.0.0.1])
	by dlep6.itg.ti.com (8.9.3/8.9.3) with ESMTP id QAA01101
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Jan 2000 16:29:51 -0600 (CST)
Received: from dlep4.itg.ti.com (dlep4.itg.ti.com [157.170.188.63])
	by dlep6.itg.ti.com (8.9.3/8.9.3) with ESMTP id QAA01089
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Jan 2000 16:29:50 -0600 (CST)
Received: from ti.com (IDENT:jharrell@pcp97780pcs.sc.ti.com [158.218.100.100])
	by dlep4.itg.ti.com (8.9.3/8.9.3) with ESMTP id QAA12777
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Jan 2000 16:29:55 -0600 (CST)
Message-ID: <389218F6.7CAD27A5@ti.com>
Date:   Fri, 28 Jan 2000 15:32:22 -0700
From:   Jeff Harrell <jharrell@ti.com>
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     sgi-mips <linux@cthulhu.engr.sgi.com>
Subject: Question concerning memory configuration
Content-Type: multipart/alternative;
 boundary="------------F3D7B55FFD548980CE46B13B"
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


--------------F3D7B55FFD548980CE46B13B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I have question concerning the memory configuration variables in the
MIPS/Linux
codebase.  I am working on a board that has 64Mbytes (0x400 0000) of
SDRAM.  We
are using an R4000 core and have the memory map setup so that KSEG0 &
KSEG1 both
map to address 0x0 in physical memory.  On our embedded system we are
going to hard
code the variable mips_memory_upper (This eventually is stored in
memory_end).  My
question is what I should initialize the value to?  Do I treat the top
of memory as KSEG1
+ 64Mbytes? (i.e., 0xA400 0000) or do I initialize it realative to 0?
If anybody has any
insights in this area, any information would be greatly appreciated.

Thanks,
Jeff

--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell                    Work:  (801) 619-6104
Broadband Access group/TI
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



--------------F3D7B55FFD548980CE46B13B
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
I&nbsp;have question concerning the memory configuration variables in the
MIPS/Linux
<br>codebase.&nbsp; I am working on a board that has 64Mbytes (0x400 0000)
of SDRAM.&nbsp; We
<br>are using an R4000 core and have the memory map setup so that KSEG0
&amp; KSEG1 both
<br>map to address 0x0 in physical memory.&nbsp; On our embedded system
we are going to hard
<br>code the variable mips_memory_upper (This eventually is stored in memory_end).&nbsp;
My
<br>question is what I should initialize the value to?&nbsp; Do I treat
the top of memory as KSEG1
<br>+ 64Mbytes? (i.e., 0xA400 0000) or do I initialize it realative to
0?&nbsp; If anybody has any
<br>insights in this area, any information would be greatly appreciated.
<p>Thanks,
<br>Jeff
<pre>--&nbsp;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Work:&nbsp; (801) 619-6104&nbsp;
Broadband Access group/TI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</pre>
&nbsp;</html>

--------------F3D7B55FFD548980CE46B13B--
