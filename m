Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2MILwd05906
	for linux-mips-outgoing; Thu, 22 Mar 2001 10:21:58 -0800
Received: from jester.ti.com (jester.ti.com [192.94.94.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2MILvM05903
	for <linux-mips@oss.sgi.com>; Thu, 22 Mar 2001 10:21:57 -0800
Received: from dlep8.itg.ti.com ([157.170.134.88])
	by jester.ti.com (8.11.1/8.11.1) with ESMTP id f2MILpD17605;
	Thu, 22 Mar 2001 12:21:51 -0600 (CST)
Received: from dlep8.itg.ti.com (localhost [127.0.0.1])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id MAA00109;
	Thu, 22 Mar 2001 12:21:51 -0600 (CST)
Received: from dlep4.itg.ti.com (dlep4-maint.itg.ti.com [157.170.133.17])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id MAA00099;
	Thu, 22 Mar 2001 12:21:50 -0600 (CST)
Received: from ti.com (reddwarf.sc.ti.com [158.218.100.143])
	by dlep4.itg.ti.com (8.9.3/8.9.3) with ESMTP id MAA07794;
	Thu, 22 Mar 2001 12:21:50 -0600 (CST)
Message-ID: <3ABA430E.BDC095E@ti.com>
Date: Thu, 22 Mar 2001 11:23:10 -0700
From: Jeff Harrell <jharrell@ti.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Embedded MIPS/Linux Needs
References: <00eb01c0b2c6$02c7ef60$0deca8c0@Ulysses>
Content-Type: multipart/mixed;
 boundary="------------067786785BCB493D506E86D4"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------067786785BCB493D506E86D4
Content-Type: multipart/alternative;
 boundary="------------9A7CE958C2C774B590AC4627"


--------------9A7CE958C2C774B590AC4627
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"Kevin D. Kissell" wrote:

> Here at MIPS Technologies, we use Linux internally
> for design verification, experiments, benchmarking,
> etc., and as a consequence Carsten Langgaard and
> myself have both been active in this forum, and have
> tried to help the general Linux/MIPS community as
> best we can with the limited time that we can dedicate
> to the problem, in terms of suggested patches, bug
> fixes, cleanups, integration of needed components
> like the FPU emulator, etc.
>

I think that  one of the larger hurdles that we have had
to overcome is a common set of tools that can build a current
kernel and userland application set from a cross-developed
environment.  There seems to have been a
divergence between kernel tools and userland tools specifically in
the area of recent kernel 2.4.x and GLIBC 2.2.x that is a major
headache for delivering a toolchain that is on par with the
intel equivalent designs.  It is tough to offer a linux design that
requires multiple toolchains one to build the kernel, one to build
userland apps.


>
> I have a question for those of you who are doing
> Linux work for *new* platforms (as opposed to the
> SGI/DEC legacy box support people).  IF, and I
> emphasize the word *if*, MIPS Technologies were
> make a bigger investment in MIPS/Linux technology,
> be it kernel enhancements, cross/native tools,
> userland ports, libraries, or whatever, what would
> be your prioritized "wish list"?
>

    1. A toolchain that will build 2.4.x version of the kernel as well
        as GLIBC 2.2 dependent applications.  Preferrably this would
        be a cross-development environment.  (This would require
         GLIBC 2.2 accessable as a cross-compiled environment

    2.  Userland app ports


>
> Feel free to respond by point-to-point email, though
> responses that are also copied to the mailing list
> might provoke some interesting and enlightening
> debate.
>
>             Regards,
>
>             Kevin K.

>From past experience it's easy to see that without a
solid set of development tools, it is hard to justify using
a particular CPU or hardware.



--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell                    Work:  (801) 619-6104
Broadband Access group/TI
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



--------------9A7CE958C2C774B590AC4627
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
"Kevin D. Kissell" wrote:
<blockquote TYPE=CITE>Here at MIPS Technologies, we use Linux internally
<br>for design verification, experiments, benchmarking,
<br>etc., and as a consequence Carsten Langgaard and
<br>myself have both been active in this forum, and have
<br>tried to help the general Linux/MIPS community as
<br>best we can with the limited time that we can dedicate
<br>to the problem, in terms of suggested patches, bug
<br>fixes, cleanups, integration of needed components
<br>like the FPU emulator, etc.
<br>&nbsp;</blockquote>
I think that&nbsp; one of the larger hurdles that we have had
<br>to overcome is a common set of tools that can build a current
<br>kernel and userland application set from a cross-developed
<br>environment.&nbsp; There seems to have been a
<br>divergence between kernel tools and userland tools specifically in
<br>the area of recent kernel 2.4.x and GLIBC&nbsp;2.2.x that is a major
<br>headache for delivering a toolchain that is on par with the
<br>intel equivalent designs.&nbsp; It is tough to offer a linux design
that
<br>requires multiple toolchains one to build the kernel, one to build
<br>userland apps.
<br>&nbsp;
<blockquote TYPE=CITE>&nbsp;
<br>I have a question for those of you who are doing
<br>Linux work for *new* platforms (as opposed to the
<br>SGI/DEC legacy box support people).&nbsp; IF, and I
<br>emphasize the word *if*, MIPS Technologies were
<br>make a bigger investment in MIPS/Linux technology,
<br>be it kernel enhancements, cross/native tools,
<br>userland ports, libraries, or whatever, what would
<br>be your prioritized "wish list"?
<br>&nbsp;</blockquote>
&nbsp;&nbsp;&nbsp; 1.&nbsp;A toolchain that will build 2.4.x version of
the kernel as well
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; as GLIBC 2.2 dependent applications.&nbsp;
Preferrably this would
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; be a cross-development environment.&nbsp;
(This would require
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GLIBC 2.2 accessable
as a cross-compiled environment
<p>&nbsp;&nbsp;&nbsp; 2.&nbsp; Userland app ports
<br>&nbsp;
<blockquote TYPE=CITE>&nbsp;
<br>Feel free to respond by point-to-point email, though
<br>responses that are also copied to the mailing list
<br>might provoke some interesting and enlightening
<br>debate.
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Regards,
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kevin
K.</blockquote>

<p><br>From past experience it's easy to see that without a
<br>solid set of development tools, it is hard to justify using
<br>a particular CPU or hardware.
<br>&nbsp;
<br>&nbsp;
<pre>--&nbsp;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Work:&nbsp; (801) 619-6104&nbsp;
Broadband Access group/TI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</pre>
&nbsp;</html>

--------------9A7CE958C2C774B590AC4627--

--------------067786785BCB493D506E86D4
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

--------------067786785BCB493D506E86D4--
