Received:  by oss.sgi.com id <S553711AbRCHQTj>;
	Thu, 8 Mar 2001 08:19:39 -0800
Received: from jester.ti.com ([192.94.94.1]:34704 "EHLO jester.ti.com")
	by oss.sgi.com with ESMTP id <S553679AbRCHQTS>;
	Thu, 8 Mar 2001 08:19:18 -0800
Received: from dlep7.itg.ti.com ([157.170.134.103])
	by jester.ti.com (8.11.1/8.11.1) with ESMTP id f28GJCD03514
	for <linux-mips@oss.sgi.com>; Thu, 8 Mar 2001 10:19:12 -0600 (CST)
Received: from dlep7.itg.ti.com (localhost [127.0.0.1])
	by dlep7.itg.ti.com (8.9.3/8.9.3) with ESMTP id KAA13440
	for <linux-mips@oss.sgi.com>; Thu, 8 Mar 2001 10:19:12 -0600 (CST)
Received: from dlep4.itg.ti.com (dlep4-maint.itg.ti.com [157.170.133.17])
	by dlep7.itg.ti.com (8.9.3/8.9.3) with ESMTP id KAA13395
	for <linux-mips@oss.sgi.com>; Thu, 8 Mar 2001 10:19:11 -0600 (CST)
Received: from ti.com (reddwarf.sc.ti.com [158.218.100.143])
	by dlep4.itg.ti.com (8.9.3/8.9.3) with ESMTP id KAA22243
	for <linux-mips@oss.sgi.com>; Thu, 8 Mar 2001 10:19:10 -0600 (CST)
Message-ID: <3AA7B13F.F918E1F8@ti.com>
Date:   Thu, 08 Mar 2001 09:20:15 -0700
From:   Jeff Harrell <jharrell@ti.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Question concerning Assembler error
Content-Type: multipart/mixed;
 boundary="------------45CDACA24C63474FA77065DA"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------45CDACA24C63474FA77065DA
Content-Type: multipart/alternative;
 boundary="------------B15A6BD89F9960B889747A5E"


--------------B15A6BD89F9960B889747A5E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I am getting a strange error from the assembler that I am not quite sure
what to make of it.  Here
is the  Error and code snippet:


     >make
     mipsel-linux-gcc -D_ASSEMBLER_ -mcpu=r4600 -mips2 -Wall
     -Wstrict-prototypes -O2 -fomit-frame-pointer -G -0
     -mno-abicalls -fno-pic -pipe -mlong-calls -Wimplicit -c
     avreset.S
     avreset.S: Assembler messages:
     avreset.S:262: Error: Rest of line ignored. First ignored
     character is `0'.
     avreset.S:1006: Error: Rest of line ignored. First ignored
     character is `0'.
     gmake: *** [avreset.o] Error 1
     gmake: Target `all' not remade because of errors.


     And here is the code that seems to be causing the problem:

        /* Interrupt : For now we simply disable interrupts and
     return */

             MFC0(   k0, C0_STATUS)
             srl     k0, 1
             sll     k0, 1
             MTC0(   k0, C0_STATUS)
             nop
             .set    mips3
     ==>  eret   <==
             .set    mips2
             nop


Any information that anyone might have would be greatly appreciated.

Regards,
Jeff Harrell

--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell                    Work:  (801) 619-6104
Broadband Access group/TI
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



--------------B15A6BD89F9960B889747A5E
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
I am getting a strange error from the assembler that I am not quite sure
what to make of it.&nbsp; Here
<br>is the&nbsp; Error and code snippet:
<br>&nbsp;
<blockquote>>make
<br>mipsel-linux-gcc -D_ASSEMBLER_ -mcpu=r4600 -mips2 -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -G -0 -mno-abicalls -fno-pic -pipe -mlong-calls
-Wimplicit -c avreset.S
<br>avreset.S: Assembler messages:
<br>avreset.S:262: Error: Rest of line ignored. First ignored character
is `0'.
<br>avreset.S:1006: Error: Rest of line ignored. First ignored character
is `0'.
<br>gmake: *** [avreset.o] Error 1
<br>gmake: Target `all' not remade because of errors.
<br>&nbsp;
<p>And here is the code that seems to be causing the problem:
<p>&nbsp;&nbsp; /* Interrupt : For now we simply disable interrupts and
return */
<br>&nbsp;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MFC0(&nbsp;&nbsp; k0, C0_STATUS)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; srl&nbsp;&nbsp;&nbsp;&nbsp;
k0, 1
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sll&nbsp;&nbsp;&nbsp;&nbsp;
k0, 1
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTC0(&nbsp;&nbsp; k0, C0_STATUS)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nop
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set&nbsp;&nbsp;&nbsp; mips3
<br>==>&nbsp; eret&nbsp;&nbsp; &lt;==
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set&nbsp;&nbsp;&nbsp; mips2
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nop
<br>&nbsp;</blockquote>
Any information that anyone might have would be greatly appreciated.
<p>Regards,
<br>Jeff Harrell
<pre>--&nbsp;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Work:&nbsp; (801) 619-6104&nbsp;
Broadband Access group/TI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</pre>
&nbsp;</html>

--------------B15A6BD89F9960B889747A5E--

--------------45CDACA24C63474FA77065DA
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

--------------45CDACA24C63474FA77065DA--
