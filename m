Received:  by oss.sgi.com id <S42209AbQGFRMt>;
	Thu, 6 Jul 2000 10:12:49 -0700
Received: from tower.ti.com ([192.94.94.5]:22004 "EHLO tower.ti.com")
	by oss.sgi.com with ESMTP id <S42203AbQGFRMj>;
	Thu, 6 Jul 2000 10:12:39 -0700
Received: from dlep7.itg.ti.com ([157.170.134.103])
	by tower.ti.com (8.10.1/8.10.1) with ESMTP id e66HChH12412
	for <linux-mips@oss.sgi.com>; Thu, 6 Jul 2000 12:12:43 -0500 (CDT)
Received: from dlep7.itg.ti.com (localhost [127.0.0.1])
	by dlep7.itg.ti.com (8.9.3/8.9.3) with ESMTP id MAA27964
	for <linux-mips@oss.sgi.com>; Thu, 6 Jul 2000 12:12:36 -0500 (CDT)
Received: from dlep4.itg.ti.com (dlep4.itg.ti.com [157.170.188.63])
	by dlep7.itg.ti.com (8.9.3/8.9.3) with ESMTP id MAA27958
	for <linux-mips@oss.sgi.com>; Thu, 6 Jul 2000 12:12:35 -0500 (CDT)
Received: from ti.com (jharrell.sc.ti.com [158.218.100.143])
	by dlep4.itg.ti.com (8.9.3/8.9.3) with ESMTP id MAA13460;
	Thu, 6 Jul 2000 12:12:42 -0500 (CDT)
Message-ID: <3964C025.623F7F5@ti.com>
Date:   Thu, 06 Jul 2000 11:21:41 -0600
From:   Jeff Harrell <jharrell@ti.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
CC:     bbrown@ti.com
Subject: Question concerning necessary libraries for 2.4.x kernel upgrade
Content-Type: multipart/mixed;
 boundary="------------8CD11C396949D39314900462"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------8CD11C396949D39314900462
Content-Type: multipart/alternative;
 boundary="------------0909E811D85527F63F2E0482"


--------------0909E811D85527F63F2E0482
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I am currently upgrading my MIPS development board (Atlas) that contains
a R4Kc (jade core)
and version 2.2.12 of the Linux kernel to a 2.4.x series kernel.   I
believe the  libraries and applications
were built off of the hardhat distribution.  We are able to run the
2.4.x version of the kernel on the Atlas
board but are seeing problems with some of the executables.  I examined
the Changes file and am in the
process of upgrading the following binaries/libraries..

GNU C  2.7.2.3
binutils 2.9.1.0.22
util-linux 2.10g
modutils 2.3.0
e2fsprogs 1.18
pcmcia-cs 3.1.13
ppp 2.4.0b1

I am seeing problems with executables such as awk, groff, troff, etc.
Will I need to rebuild each of these
applications  against the new libraries to run or should they still
function after I have upgraded the previously
mentioned packages?  Are there mipsel version of these packages (either
source or binaries) available somewhere?
Any information would be greatly appreciated.

Jeff



--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell                    Work:  (801) 619-6104
Broadband Access group/TI
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

--------------0909E811D85527F63F2E0482
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
I am currently upgrading my MIPS development board (Atlas) that contains
a R4Kc (jade core)
<br>and version 2.2.12 of the Linux kernel to a 2.4.x series kernel.&nbsp;&nbsp;
I believe the&nbsp; libraries and applications
<br>were built off of the hardhat distribution.&nbsp; We are able to run
the 2.4.x version of the kernel on the Atlas
<br>board but are seeing problems with some of the executables.&nbsp; I
examined the Changes file and am in the
<br>process of upgrading the following binaries/libraries..
<p>GNU C&nbsp; 2.7.2.3
<br>binutils 2.9.1.0.22
<br>util-linux 2.10g
<br>modutils 2.3.0
<br>e2fsprogs 1.18
<br>pcmcia-cs 3.1.13
<br>ppp 2.4.0b1
<p>I am seeing problems with executables such as awk, groff, troff, etc.&nbsp;&nbsp;
Will I need to rebuild each of these
<br>applications&nbsp; against the new libraries to run or should they
still function after I have upgraded the previously
<br>mentioned packages?&nbsp; Are there mipsel version of these packages
(either source or binaries) available somewhere?
<br>Any information would be greatly appreciated.
<p>Jeff
<br>&nbsp;
<br>&nbsp;
<pre>--&nbsp;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Work:&nbsp; (801) 619-6104&nbsp;
Broadband Access group/TI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</pre>
</html>

--------------0909E811D85527F63F2E0482--

--------------8CD11C396949D39314900462
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

--------------8CD11C396949D39314900462--
