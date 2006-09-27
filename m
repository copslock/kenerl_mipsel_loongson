Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2006 23:05:54 +0100 (BST)
Received: from smtp-out.sigp.net ([63.237.78.44]:63460 "EHLO smtp-out.sigp.net")
	by ftp.linux-mips.org with ESMTP id S20039046AbWI0WFw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 27 Sep 2006 23:05:52 +0100
Received: from gamd-ex-001.ss.drs.master (gamd-ex-001.ss.drs.master [172.22.132.94])
	by smtp-out.sigp.net (8.13.1/8.13.6) with ESMTP id k8RM5l5q010195;
	Wed, 27 Sep 2006 18:05:51 -0400 (EDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6E281.15D85B6E"
Subject: RE: oprofile configure?
Date:	Wed, 27 Sep 2006 18:05:47 -0400
Message-ID: <DEB94D90ABFC8240851346CFD4ACFF149E1C89@gamd-ex-001.ss.drs.master>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: oprofile configure?
Thread-Index: AcbifuGZyBwxKkIkQiGCYi9rFx48QQAAClmb
References:  <DEB94D90ABFC8240851346CFD4ACFF149E1C7F@gamd-ex-001.ss.drs.master> <1159393758.3181.26.camel@localhost.localdomain>
From:	"Azer, William" <Bill.Azer@drs-ss.com>
To:	"Jim Wilson" <wilson@specifix.com>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <Bill.Azer@drs-ss.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Bill.Azer@drs-ss.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6E281.15D85B6E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Yes, i was using oprofile 0.9.2cvs.  I can provide the code.  The =
-Werror is enabled by default.

i have also been having trouble running it with trying to debug a =
executable program.  i used the opcontrol to tell it the =
image,start,dump,stop  then i used opreport -l <image>.  i couldn't get =
the sample data.  i tried opannotate and that didn't work either.

i have had better luck with gprof.

# Define the identity of the package.
 PACKAGE=3Doprofile
 VERSION=3D0.9.2cvs

i am using 2.6.17.7 from linux-mips.org with gcc 3.4.3


thx,

Bill Azer

-----Original Message-----
From: Jim Wilson [mailto:wilson@specifix.com]
Sent: Wed 9/27/2006 5:49 PM
To: Azer, William
Cc: linux-mips@linux-mips.org
Subject: Re: oprofile configure?
=20
On Tue, 2006-09-26 at 10:34 -0400, Azer, William wrote:
> i have natively built oprofile for sb1 platform and i get a lot of
> warnings from the compiler.  i had to use --disable-werror in order to
> build.  has anyone encountered this?  am i doing something wrong?

You didn't mention the oprofile version, the gcc version, or the kernel
version, which are the important bits here.  I can see from the error
messages that you have gcc-3.4.3, and a montavista kernel.
>=20
I tried oprofile-0.9.2.  I was unable to get -Werror used in the
compiler.  Looking at the configure script, I see that -Werror is
disabled unless you have a snapshot from the cvs tree.  Not even
--enable-werror can turn it on.  I'm guessing that you are using the cvs
tree.

This looks like a bug in the gcc that you are using.  I can't reproduce
it on other systems, but I can reproduce it on a similar MontaVista
system.  I can't reproduce it with later FSF gcc releases on the same
MontaVista system.  It isn't immediately obvious what changed to fix
this.
--=20
Jim Wilson, GNU Tools Support, http://www.specifix.com



------_=_NextPart_001_01C6E281.15D85B6E
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7233.28">
<TITLE>RE: oprofile configure?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Yes, i was using oprofile 0.9.2cvs.&nbsp; I can =
provide the code.&nbsp; The -Werror is enabled by default.<BR>
<BR>
i have also been having trouble running it with trying to debug a =
executable program.&nbsp; i used the opcontrol to tell it the =
image,start,dump,stop&nbsp; then i used opreport -l &lt;image&gt;.&nbsp; =
i couldn't get the sample data.&nbsp; i tried opannotate and that didn't =
work either.<BR>
<BR>
i have had better luck with gprof.<BR>
<BR>
# Define the identity of the package.<BR>
&nbsp;PACKAGE=3Doprofile<BR>
&nbsp;VERSION=3D0.9.2cvs<BR>
<BR>
i am using 2.6.17.7 from linux-mips.org with gcc 3.4.3<BR>
<BR>
<BR>
thx,<BR>
<BR>
Bill Azer<BR>
<BR>
-----Original Message-----<BR>
From: Jim Wilson [<A =
HREF=3D"mailto:wilson@specifix.com">mailto:wilson@specifix.com</A>]<BR>
Sent: Wed 9/27/2006 5:49 PM<BR>
To: Azer, William<BR>
Cc: linux-mips@linux-mips.org<BR>
Subject: Re: oprofile configure?<BR>
<BR>
On Tue, 2006-09-26 at 10:34 -0400, Azer, William wrote:<BR>
&gt; i have natively built oprofile for sb1 platform and i get a lot =
of<BR>
&gt; warnings from the compiler.&nbsp; i had to use --disable-werror in =
order to<BR>
&gt; build.&nbsp; has anyone encountered this?&nbsp; am i doing =
something wrong?<BR>
<BR>
You didn't mention the oprofile version, the gcc version, or the =
kernel<BR>
version, which are the important bits here.&nbsp; I can see from the =
error<BR>
messages that you have gcc-3.4.3, and a montavista kernel.<BR>
&gt;<BR>
I tried oprofile-0.9.2.&nbsp; I was unable to get -Werror used in =
the<BR>
compiler.&nbsp; Looking at the configure script, I see that -Werror =
is<BR>
disabled unless you have a snapshot from the cvs tree.&nbsp; Not =
even<BR>
--enable-werror can turn it on.&nbsp; I'm guessing that you are using =
the cvs<BR>
tree.<BR>
<BR>
This looks like a bug in the gcc that you are using.&nbsp; I can't =
reproduce<BR>
it on other systems, but I can reproduce it on a similar MontaVista<BR>
system.&nbsp; I can't reproduce it with later FSF gcc releases on the =
same<BR>
MontaVista system.&nbsp; It isn't immediately obvious what changed to =
fix<BR>
this.<BR>
--<BR>
Jim Wilson, GNU Tools Support, <A =
HREF=3D"http://www.specifix.com">http://www.specifix.com</A><BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C6E281.15D85B6E--
