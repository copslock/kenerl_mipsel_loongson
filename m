Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2006 20:58:47 +0000 (GMT)
Received: from mxout.mainstreet.net ([199.245.73.25]:39676 "EHLO
	mxout.mainstreet.net") by ftp.linux-mips.org with ESMTP
	id S8133524AbWCMU6i (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Mar 2006 20:58:38 +0000
Received: from mail.idt.com (mail.idt.com [157.165.5.20])
	by mxout.mainstreet.net (8.13.4/8.13.4) with ESMTP id k2DL75H2004751;
	Mon, 13 Mar 2006 13:07:07 -0800 (PST)
Received: from corpml1.corp.idt.com (corpml1.corp.idt.com [157.165.140.20])
	by mail.idt.com (8.13.4/8.13.4) with ESMTP id k2DL72QN029131;
	Mon, 13 Mar 2006 13:07:02 -0800 (PST)
Received: from CORPBRIDGE.corp.idt.com (localhost [127.0.0.1])
	by corpml1.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id k2DL71g06125;
	Mon, 13 Mar 2006 13:07:01 -0800 (PST)
Received: by corpbridge.corp.idt.com with Internet Mail Service (5.5.2658.3)
	id <1X0CAQ2M>; Mon, 13 Mar 2006 13:07:01 -0800
Message-ID: <73943A6B3BEAA1468EE1A4A090129F4316B15A79@corpbridge.corp.idt.com>
From:	"Tiwari, Rakesh" <Rakesh.Tiwari@idt.com>
To:	"'Chris Wedgwood'" <cw@f00f.org>,
	"Tiwari, Rakesh" <Rakesh.Tiwari@idt.com>
Cc:	"'Ralf Baechle'" <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: RE: [PATCH] IDT Interprise Processor Support for Linux  2.6.x
Date:	Mon, 13 Mar 2006 13:06:52 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.3)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C646E2.0D5A6AC6"
X-Scanned-By: MIMEDefang 2.43
Return-Path: <Rakesh.Tiwari@idt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Rakesh.Tiwari@idt.com
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C646E2.0D5A6AC6
Content-Type: text/plain

Hi Chris,

Appreciate your feedback.
Please see my comments below, inline prefixed by [rkt]

Look forward for additional comments/suggestions, if any.

Thanks
Rakesh


-----Original Message-----
From: Chris Wedgwood [mailto:cw@f00f.org <mailto:cw@f00f.org> ] 
Sent: Friday, March 10, 2006 9:46 AM
To: Tiwari, Rakesh
Cc: 'Ralf Baechle'; linux-mips@linux-mips.org
Subject: Re: [PATCH] IDT Interprise Processor Support for Linux 2.6.x


Additional comments:

  * Firstly, it's really great to see this!

  * A single 1.6MB patch is far from ideal, please try to break it
    into a series of smaller logically separate patches.  It's hard to
    comment on a giant patch.  Perhaps something like:
      - a patch for each CPU
      - a patch for each driver
      - a patch for each platform/eval-board
    and see what you have left. Each patch should have a suitable
    description.  Also put "Signed-off-by:" lines on your patches.

    [rkt] Agreed, 1.6MB is a huge patch. I will try to break it down into
          multiple patches (ard 5) based on platform/eval board and will
          send it out soon.

  * You shouldn't be removing .gitignore :-)

    [rkt] I think these are still there.
 	
  * The Ethernet drivers should probably go jeff@garzik.org and cc
    netdev@vger.kernel.org

    [rkt] The Ethernet interface/driver is integral to each processor
    and dependent upon other system header files, unlike a regular NIC.
    I can try posting the patches (probably sub-patch) to Jeff and netdev,
    in order to get feedback on the driver.

	
  * The code contains unreferenced functions?  Without even looking
    hard I can see rc32434_mii_handler is declared and not used for
    example.

    [rkt] Chris you hit the bulls eye. This is the only function which
    I missed out... Will clean it up.
	
  * It might be that some of the CPU-level code should be platform
    level.  For example having two UARTs is a feature of the EB434 not
    the rc32434 so EB434_UART1_IRQ is misplaced I would argue.

    [rkt] Since all the IDT's processors are primarily SoC's, the UARTS are
     part of the processor. In case on rc32434 there is only 1 UART. However
     rc32438 has 2 UARTS

 	
  * Some init code should probably be declared __init and similar

  * There is quite a bit of extraneous white-space that could be
    cleaned up and some minor indentation cleanups to match what is
    elsewhere in the kernel.

   [rkt] Will try to clean up as much as possible...

Sorry this is a little vague and 'hand-wavy', if you post smaller logically
complete patches I think you'll get better feedback where people can comment
more easily.  Ideally inline to the email if you can, m$ lookout/$exchange
as that just makes a mess, if you have to use that then attach them as you
did.

------_=_NextPart_001_01C646E2.0D5A6AC6
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2658.2">
<TITLE>RE: [PATCH] IDT Interprise Processor Support for Linux  =
2.6.x</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi Chris,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Appreciate your feedback.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">Please see my comments below, inline =
prefixed by [rkt]</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Look forward for additional =
comments/suggestions, if any.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">Rakesh</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">-----Original Message-----</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">From: Chris Wedgwood [</FONT><A =
HREF=3D"mailto:cw@f00f.org"><U><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">mailto:cw@f00f.org</FONT></U></A><FONT SIZE=3D2 =
FACE=3D"Arial">] </FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">Sent: Friday, March 10, 2006 9:46 =
AM</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">To: Tiwari, Rakesh</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">Cc: 'Ralf Baechle'; =
linux-mips@linux-mips.org</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">Subject: Re: [PATCH] IDT Interprise =
Processor Support for Linux 2.6.x</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Additional comments:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; * Firstly, it's really great to =
see this!</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; * A single 1.6MB patch is far =
from ideal, please try to break it</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; into a series of =
smaller logically separate patches.&nbsp; It's hard to</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; comment on a giant =
patch.&nbsp; Perhaps something like:</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - a =
patch for each CPU</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - a =
patch for each driver</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - a =
patch for each platform/eval-board</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; and see what you =
have left. Each patch should have a suitable</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; description.&nbsp; =
Also put &quot;Signed-off-by:&quot; lines on your =
patches.<I></I></FONT>
</P>

<P><I><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; [rkt] Agreed, =
1.6MB is a huge patch. I will try to break it down into</FONT></I>
<BR><I><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
multiple patches (ard 5) based on platform/eval board and =
will</FONT></I>
<BR><I><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
send it out soon.</FONT></I>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; * You shouldn't be removing =
.gitignore :-)</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;</FONT><I> <FONT =
SIZE=3D2 FACE=3D"Arial">[rkt] I think these are still there.</FONT></I>
<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; * The Ethernet drivers should =
probably go jeff@garzik.org and cc</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; =
netdev@vger.kernel.org</FONT>
</P>

<P><I><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; [rkt] The =
Ethernet interface/driver is integral to each processor</FONT></I>
<BR><I><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; and dependent =
upon other system header files, unlike a regular NIC.</FONT></I>
<BR><I><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; I can try =
posting the patches (</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">probably</FONT><FONT SIZE=3D2 FACE=3D"Arial"> sub-patch) =
to Jeff and netdev,</FONT></I>
<BR><I><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; in order to get =
feedback on the driver.</FONT></I>
</P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; * The code contains =
unreferenced functions?&nbsp; Without even looking</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; hard I can see =
rc32434_mii_handler is declared and not used for</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; example.</FONT>
</P>

<P><I><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; [rkt] Chris you =
hit the bulls eye. This is the only function which</FONT></I>
<BR><I><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; I missed out... =
Will clean it up.</FONT></I>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; * It might be that some of the =
CPU-level code should be platform</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; level.&nbsp; For =
example having two UARTs is a feature of the EB434 not</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; the rc32434 so =
EB434_UART1_IRQ is misplaced I would argue.</FONT>
</P>

<P><I><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; [rkt] Since all =
the IDT's processors are primarily SoC's, the UARTS are</FONT></I>
<BR><I><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp; part of =
the processor. In case on rc32434 there is only 1 UART. =
However</FONT></I>
<BR><I><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp; rc32438 =
has 2 UARTS</FONT></I>
</P>

<P><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; * Some init code should =
probably be declared __init and similar</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; * There is quite a bit of =
extraneous white-space that could be</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; cleaned up and =
some minor indentation cleanups to match what is</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; elsewhere in the =
kernel.</FONT>
</P>

<P><I><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; [rkt] Will try to =
clean up as much as possible...</FONT></I>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Sorry this is a little vague and =
'hand-wavy', if you post smaller logically complete patches I think =
you'll get better feedback where people can comment more easily.&nbsp; =
Ideally inline to the email if you can, m$ lookout/$exchange as that =
just makes a mess, if you have to use that then attach them as you =
did.</FONT></P>

</BODY>
</HTML>
------_=_NextPart_001_01C646E2.0D5A6AC6--
