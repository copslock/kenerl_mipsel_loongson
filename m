Received:  by oss.sgi.com id <S42185AbQJKQ3v>;
	Wed, 11 Oct 2000 09:29:51 -0700
Received: from gatekeep.ti.com ([192.94.94.61]:17626 "EHLO gatekeep.ti.com")
	by oss.sgi.com with ESMTP id <S42180AbQJKQ3P>;
	Wed, 11 Oct 2000 09:29:15 -0700
Received: from dlep6.itg.ti.com ([157.170.188.9])
	by gatekeep.ti.com (8.11.0/8.11.0) with ESMTP id e9BGSTT25824
	for <linux-mips@oss.sgi.com>; Wed, 11 Oct 2000 11:28:29 -0500 (CDT)
Received: from dlep6.itg.ti.com (localhost [127.0.0.1])
	by dlep6.itg.ti.com (8.9.3/8.9.3) with ESMTP id LAA15157
	for <linux-mips@oss.sgi.com>; Wed, 11 Oct 2000 11:28:29 -0500 (CDT)
Received: from dlep4.itg.ti.com (dlep4.itg.ti.com [157.170.188.63])
	by dlep6.itg.ti.com (8.9.3/8.9.3) with ESMTP id LAA15147
	for <linux-mips@oss.sgi.com>; Wed, 11 Oct 2000 11:28:29 -0500 (CDT)
Received: from ti.com (reddwarf.sc.ti.com [158.218.100.143])
	by dlep4.itg.ti.com (8.9.3/8.9.3) with ESMTP id LAA02772
	for <linux-mips@oss.sgi.com>; Wed, 11 Oct 2000 11:28:28 -0500 (CDT)
Message-ID: <39E49824.92128925@ti.com>
Date:   Wed, 11 Oct 2000 10:41:08 -0600
From:   Jeff Harrell <jharrell@ti.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Macro error in 2.4.0-test9 (unaligned.h)
Content-Type: multipart/mixed;
 boundary="------------2250C10270256EBD3BF65E78"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------2250C10270256EBD3BF65E78
Content-Type: multipart/alternative;
 boundary="------------151D339996ECF005152E113D"


--------------151D339996ECF005152E113D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This caused a problem when loading the ppp module...


~~~~~~~~~~~~8< snippet from  /include/asm-mips/unaligned.h --------

#define put_unaligned(x,ptr)      \                   <<== shouldn't  x
actually be val here?
    do {         \
         switch (sizeof(*(ptr))) {     \
             case 1:        \
              *(unsigned char *)ptr = (val);    \
               break;       \
             case 2:        \

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell                    Work:  (801) 619-6104
Broadband Access group/TI
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



--------------151D339996ECF005152E113D
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
This caused a problem when loading the ppp module...
<br>&nbsp;
<p>~~~~~~~~~~~~8&lt; snippet from&nbsp; /include/asm-mips/unaligned.h --------
<p>#define put_unaligned(x,ptr)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;&lt;== shouldn't&nbsp; x actually be val here?
<br>&nbsp;&nbsp;&nbsp; do {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
\
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (sizeof(*(ptr)))
{&nbsp;&nbsp;&nbsp;&nbsp; \
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
case 1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
*(unsigned char *)ptr = (val);&nbsp;&nbsp;&nbsp; \
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
break;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
case 2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
<p>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<pre>--&nbsp;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Work:&nbsp; (801) 619-6104&nbsp;
Broadband Access group/TI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</pre>
&nbsp;</html>

--------------151D339996ECF005152E113D--

--------------2250C10270256EBD3BF65E78
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

--------------2250C10270256EBD3BF65E78--
