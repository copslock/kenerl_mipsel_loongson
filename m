Received:  by oss.sgi.com id <S42349AbQHYWlB>;
	Fri, 25 Aug 2000 15:41:01 -0700
Received: from gatekeep.ti.com ([192.94.94.61]:50081 "EHLO gatekeep.ti.com")
	by oss.sgi.com with ESMTP id <S42310AbQHYWkg>;
	Fri, 25 Aug 2000 15:40:36 -0700
Received: from dlep7.itg.ti.com ([157.170.134.103])
	by gatekeep.ti.com (8.11.0/8.11.0) with ESMTP id e7PMdkD20982
	for <linux-mips@oss.sgi.com>; Fri, 25 Aug 2000 17:39:46 -0500 (CDT)
Received: from dlep7.itg.ti.com (localhost [127.0.0.1])
	by dlep7.itg.ti.com (8.9.3/8.9.3) with ESMTP id RAA03998
	for <linux-mips@oss.sgi.com>; Fri, 25 Aug 2000 17:39:38 -0500 (CDT)
Received: from dlep4.itg.ti.com (dlep4.itg.ti.com [157.170.188.63])
	by dlep7.itg.ti.com (8.9.3/8.9.3) with ESMTP id RAA03994
	for <linux-mips@oss.sgi.com>; Fri, 25 Aug 2000 17:39:38 -0500 (CDT)
Received: from ti.com (reddwarf.sc.ti.com [158.218.100.143])
	by dlep4.itg.ti.com (8.9.3/8.9.3) with ESMTP id RAA04323
	for <linux-mips@oss.sgi.com>; Fri, 25 Aug 2000 17:39:45 -0500 (CDT)
Message-ID: <39A6F826.D444E0@ti.com>
Date:   Fri, 25 Aug 2000 16:50:15 -0600
From:   Jeff Harrell <jharrell@ti.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Question concerning discontinuities in memory map.
Content-Type: multipart/mixed;
 boundary="------------E8D716CD92D021741AC0D7DA"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------E8D716CD92D021741AC0D7DA
Content-Type: multipart/alternative;
 boundary="------------BC3CC499A711E3C100153003"


--------------BC3CC499A711E3C100153003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I have a question concerning a discontinuity in my memory map.  The
development board that I am
working on currently has the start of its SDRAM at 0x14000000 (physical
memory).  It looks like a
lot of the code is written under the assumption that the base of the
kernel will be at 0x80000000.  I
have had to modify several sections of code to handle this discontinuity
with respect to max_low_pfn,
high_memory, num_physpages  max_mapnr, and low (/arch/mips/mm/init.c).
These variables seem
to use the PAGE_SHIFT variable to locate the start of that page in
physical memory: (e.g.,   max_mapnr
<< PAGE_SHIFT).  It looks like a lot of the problem stems from
max_low_pfn.  In init_bootmem_core:

----8<  snippet from init_bootmem_core ( mm/bootmem.c) 8<----------

     static unsigned long __init init_bootmem_core (bootmem_data_t
     *bdata,
               unsigned long mapstart, unsigned long start,
     unsigned long end)
       {
               unsigned long mapsize = ((end - start)+7)/8;

               mapsize = (mapsize + (sizeof(long) - 1UL)) &
     ~(sizeof(long) - 1UL);
               bdata->node_bootmem_map = phys_to_virt(mapstart <<
     PAGE_SHIFT);
               bdata->node_boot_start = (start << PAGE_SHIFT);
               bdata->node_low_pfn = end;
       ...

----------------------------------------------------

the mapsize is defined by end-start, where start is the _end
(kernel_end) + bootmap_size.
therefore it looks like end should represent the end of memory (i.e.
SDRAM).  In our case
this is 0x15FFFFFF (i.e. 32M).  If I let the rest of the kernel process
max_low_pfn and the
associated variable normally,  the paging routines will calculate that I
have 335M of memory!
I seem to be chasing this problem through the kernel.  Is there a
central place in the code that
would handle the offset properly?  I don't think I have caught all of
the implications of this change
yet because I am still failing in the paging routines.  Any information
that is available on how this
can be accomplished would be greatly appreciated.

Thanks,
Jeff

--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell                    Work:  (801) 619-6104
Broadband Access group/TI       Cell:  (801) 597-6268
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



--------------BC3CC499A711E3C100153003
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
I have a question concerning a discontinuity in my memory map.&nbsp; The
development board that I am
<br>working on currently has the start of its SDRAM at 0x14000000 (physical
memory).&nbsp; It looks like a
<br>lot of the code is written under the assumption that the base of the
kernel will be at 0x80000000.&nbsp; I
<br>have had to modify several sections of code to handle this discontinuity
with respect to max_low_pfn,
<br>high_memory, num_physpages&nbsp; max_mapnr, and low (/arch/mips/mm/init.c).&nbsp;
These variables seem
<br>to use the PAGE_SHIFT variable to locate the start of that page in
physical memory: (e.g.,&nbsp;&nbsp; max_mapnr
<br>&lt;&lt; PAGE_SHIFT).&nbsp; It looks like a lot of the problem stems
from max_low_pfn.&nbsp; In init_bootmem_core:
<p>----8&lt;&nbsp; snippet from init_bootmem_core ( mm/bootmem.c) 8&lt;----------
<blockquote><font size=-1>static unsigned long __init init_bootmem_core
(bootmem_data_t *bdata,</font>
<br><font size=-1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
unsigned long mapstart, unsigned long start, unsigned long end)</font>
<br><font size=-1>&nbsp; {</font>
<br><font size=-1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
unsigned long mapsize = ((end - start)+7)/8;</font>
<br><font size=-1>&nbsp;</font>
<br><font size=-1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
mapsize = (mapsize + (sizeof(long) - 1UL)) &amp; ~(sizeof(long) - 1UL);</font>
<br><font size=-1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
bdata->node_bootmem_map = phys_to_virt(mapstart &lt;&lt; PAGE_SHIFT);</font>
<br><font size=-1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
bdata->node_boot_start = (start &lt;&lt; PAGE_SHIFT);</font>
<br><font size=-1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
bdata->node_low_pfn = end;</font>
<br><font size=-1>&nbsp; ...</font></blockquote>
----------------------------------------------------
<p>the mapsize is defined by end-start, where start is the _end (kernel_end)
+ bootmap_size.
<br>therefore it looks like end should represent the end of memory (i.e.
SDRAM).&nbsp; In our case
<br>this is 0x15FFFFFF (i.e. 32M).&nbsp; If I let the rest of the kernel
process max_low_pfn and the
<br>associated variable normally,&nbsp; the paging routines will calculate
that I have 335M of memory!
<br>I seem to be chasing this problem through the kernel.&nbsp; Is there
a central place in the code that
<br>would handle the offset properly?&nbsp; I don't think I have caught
all of the implications of this change
<br>yet because I am still failing in the paging routines.&nbsp; Any information
that is available on how this
<br>can be accomplished would be greatly appreciated.
<p>Thanks,
<br>Jeff
<pre>--&nbsp;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Work:&nbsp; (801) 619-6104&nbsp;
Broadband Access group/TI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Cell:&nbsp; (801) 597-6268&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</pre>
&nbsp;</html>

--------------BC3CC499A711E3C100153003--

--------------E8D716CD92D021741AC0D7DA
Content-Type: text/x-vcard; charset=us-ascii;
 name="jharrell.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Jeff Harrell
Content-Disposition: attachment;
 filename="jharrell.vcf"

begin:vcard 
n:Harrell;Jeff
tel;cell:(801) 597-6268
tel;fax:(801) 619-6150
tel;work:(801) 619-6104
x-mozilla-html:TRUE
url:http://www.ti.com
org:Broadband Access Group
version:2.1
email;internet:jharrell@ti.com
title:Texas Instruments
adr;quoted-printable:;;170 West Election Rd. Suite 100	=0D=0AMS 4106		;Draper;Utah;84020-6410;USA
x-mozilla-cpt:;0
fn:Jeff Harrell
end:vcard

--------------E8D716CD92D021741AC0D7DA--
