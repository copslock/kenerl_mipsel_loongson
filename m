Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9CBdY518425
	for linux-mips-outgoing; Fri, 12 Oct 2001 04:39:34 -0700
Received: from tnint06.telogy.com (mail.telogy.com [209.116.120.7] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9CBdPD18421
	for <linux-mips@oss.sgi.com>; Fri, 12 Oct 2001 04:39:25 -0700
Received: by tnint06.telogy.design.ti.com with Internet Mail Service (5.5.2653.19)
	id <4QAKX893>; Fri, 12 Oct 2001 07:38:32 -0400
Received: from telogy.com (reddwarf.telogy.design.ti.com [158.218.105.148]) by tnint06.telogy.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id 4QAKX89N; Fri, 12 Oct 2001 07:38:27 -0400
From: Jeff Harrell <jharrell@telogy.com>
To: Gerald Champagne <gerald.champagne@esstech.com>
Cc: linux-mips@oss.sgi.com
Message-ID: <3BC6F26B.E386F412@telogy.com>
Date: Fri, 12 Oct 2001 07:38:51 -0600
Organization: Telogy
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
Subject: Re: VisionClick debugger with Linux kernel
References: <3BC36684.6020609@esstech.com>
Content-Type: multipart/alternative;
 boundary="------------705C5FDFF000B036A3817AAD"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--------------705C5FDFF000B036A3817AAD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Gerald Champagne wrote: 

Has anyone used the Wind River VisionClick debugger with the Linux
kernel? 
I'm using this debugger and works great except it thinks that the
symbols 
for some files start at address zero instead of the proper offset.  Has
anyone 
else seen this and were you able to get it to work?  I'm using the
latest tools 
from: 

ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/RPMS/i386/toolchain-mips-200
10830-1.i386.rpm
<ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/RPMS/i386/toolchain-mips-20
010830-1.i386.rpm>  


I can't find any differences between the files that work and the files
that 
don't work and the symbols look correct in the System.map file. 


Yeah, I'm working with Wind River, but I haven't gotten a solution yet. 
You know how that 8-5 centralized corporate support is though. :) 


Thanks! 


Gerald


We are using a VisionIce debugger from the linux-mips kernel, although I
am using the 
MontaVista Hardhat 2.0 tools.   I am able to load the symbols after they
have been 
generated from the Convert utility.  It seems to work fine except for
modules...haven't 
had much luck with that.  Had to get a patch to view TLB mapped memory
properly 
though. 

Jeff 

-- 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

\ Jeff Harrell  (jharrell@telogy.com)               \

\ Telogy Networks                                   \

\ Broadband Access Group                            \

\                                                   \

\ Work: (301) 515-6537                              \

\ Fax:  (301) 515-6637                              \

\~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 

--------------705C5FDFF000B036A3817AAD
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
Gerald Champagne wrote:
<blockquote TYPE=CITE>Has anyone used the Wind River VisionClick debugger
with the Linux kernel?
<br>I'm using this debugger and works great except it thinks that the symbols
<br>for some files start at address zero instead of the proper offset.&nbsp;
Has anyone
<br>else seen this and were you able to get it to work?&nbsp; I'm using
the latest tools
<br>from:
<p><a href="ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/RPMS/i386/toolchain-mips-20010830-1.i386.rpm">ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/RPMS/i386/toolchain-mips-20010830-1.i386.rpm</a>
<p>I can't find any differences between the files that work and the files
that
<br>don't work and the symbols look correct in the System.map file.
<p>Yeah, I'm working with Wind River, but I haven't gotten a solution yet.
<br>You know how that 8-5 centralized corporate support is though. :)
<p>Thanks!
<p>Gerald</blockquote>
We are using a VisionIce debugger from the linux-mips kernel, although
I am using the
<br>MontaVista Hardhat 2.0 tools.&nbsp;&nbsp; I am able to load the symbols
after they have been
<br>generated from the Convert utility.&nbsp; It seems to work fine except
for modules...haven't
<br>had much luck with that.&nbsp; Had to get a patch to view TLB mapped
memory properly
<br>though.
<p>Jeff
<pre>--&nbsp;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
\ Jeff Harrell&nbsp; (jharrell@telogy.com)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
\ Telogy Networks&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
\ Broadband Access Group&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
\&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
\ Work: (301) 515-6537&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
\ Fax:&nbsp; (301) 515-6637&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
\~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</pre>
&nbsp;</html>

--------------705C5FDFF000B036A3817AAD--
