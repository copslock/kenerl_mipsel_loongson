Received:  by oss.sgi.com id <S305159AbQBIUr6>;
	Wed, 9 Feb 2000 12:47:58 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:29263 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305155AbQBIUrt>; Wed, 9 Feb 2000 12:47:49 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id MAA04508; Wed, 9 Feb 2000 12:50:33 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA46461
	for linux-list;
	Wed, 9 Feb 2000 12:34:41 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA71603
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 9 Feb 2000 12:34:12 -0800 (PST)
	mail_from (jharrell@ti.com)
Received: from gatekeep.ti.com (gatekeep.ti.com [192.94.94.61]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA07445
	for <linux@cthulhu.engr.sgi.com>; Wed, 9 Feb 2000 12:33:52 -0800 (PST)
	mail_from (jharrell@ti.com)
Received: from dlep7.itg.ti.com ([157.170.134.103])
	by gatekeep.ti.com (8.9.3/8.9.3) with ESMTP id OAA08445;
	Wed, 9 Feb 2000 14:32:59 -0600 (CST)
Received: from dlep7.itg.ti.com (localhost [127.0.0.1])
	by dlep7.itg.ti.com (8.9.3/8.9.3) with ESMTP id OAA21227;
	Wed, 9 Feb 2000 14:32:54 -0600 (CST)
Received: from dlep4.itg.ti.com (dlep4.itg.ti.com [157.170.188.63])
	by dlep7.itg.ti.com (8.9.3/8.9.3) with ESMTP id OAA21216;
	Wed, 9 Feb 2000 14:32:53 -0600 (CST)
Received: from ti.com (IDENT:jharrell@pcp97780pcs.sc.ti.com [158.218.100.100])
	by dlep4.itg.ti.com (8.9.3/8.9.3) with ESMTP id OAA22208;
	Wed, 9 Feb 2000 14:32:57 -0600 (CST)
Message-ID: <38A1CFAE.EFA429BA@ti.com>
Date:   Wed, 09 Feb 2000 13:35:58 -0700
From:   Jeff Harrell <jharrell@ti.com>
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     sgi-mips <linux@cthulhu.engr.sgi.com>,
        linux-mips <linux-mips@fnet.fr>,
        linux-mips <linux-mips@vger.rutgers.edu>
Subject: Question concerning memory initialization (4M->64M)
Content-Type: multipart/alternative;
 boundary="------------0BB6A84381EA7F784BD03864"
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


--------------0BB6A84381EA7F784BD03864
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


I have run into an interesting problem and would like to run it past
this newsgroup
to see if anyone has any experience in these areas.  I am running kernel
2.3.22 and
have upgraded my memory space from ~4M (0x400000) to ~64M (0x4000000).
I run the 4M
version of the kernel and have no problems but when I run the 64M
version, I run
into problems during the mem_init() portion of the code.  Specifically
during the
free_page(tmp) call during the determination of totalram, codepages and
datapages.
It looks like it is failing during the call to remove_mem_queue() within
free_pages_ok().
I am seeing the next->prev and prev->next  set to 0 causing a page
fault.   Is there
anything that anyone is aware of that I would need to change (beyond
mips_memory_upper)
that would enable me to increase available memory to 64M.  Any insights
would be greatly appreciated.

Thanks
Jeff

Additional information:
------------------

high memory: 0x83fff000  start memory: 0x80433000

--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell                    Work:  (801) 619-6104
Broadband Access group/TI
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





--------------0BB6A84381EA7F784BD03864
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
&nbsp;
<br>I have run into an interesting problem and would like to run it past
this newsgroup
<br>to see if anyone has any experience in these areas.&nbsp; I am running
kernel 2.3.22 and
<br>have upgraded my memory space from ~4M (0x400000) to ~64M (0x4000000).&nbsp;
I run the 4M
<br>version of the kernel and have no problems but when I run the 64M version,
I run
<br>into problems during the mem_init() portion of the code.&nbsp; Specifically
during the
<br>free_page(tmp) call during the determination of totalram, codepages
and datapages.
<br>It looks like it is failing during the call to remove_mem_queue() within
free_pages_ok().
<br>I am seeing the next->prev and prev->next&nbsp; set to 0 causing a
page fault.&nbsp;&nbsp; Is there
<br>anything that anyone is aware of that I would need to change (beyond
mips_memory_upper)
<br>that would enable me to increase available memory to 64M.&nbsp; Any
insights would be greatly appreciated.
<p>Thanks
<br>Jeff
<p>Additional information:
<br>------------------
<p>high memory: 0x83fff000&nbsp; start memory: 0x80433000
<pre>--&nbsp;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Work:&nbsp; (801) 619-6104&nbsp;
Broadband Access group/TI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</pre>
&nbsp;
<p>&nbsp;</html>

--------------0BB6A84381EA7F784BD03864--
