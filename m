Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Feb 2007 15:06:10 +0000 (GMT)
Received: from mx.mips.com ([63.167.95.198]:23508 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20038616AbXBVPGG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Feb 2007 15:06:06 +0000
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id l1MExJJX029260;
	Thu, 22 Feb 2007 06:59:19 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id l1MEwPCN014151;
	Thu, 22 Feb 2007 06:58:26 -0800 (PST)
Message-ID: <01fc01c75693$195858b0$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"sathesh babu" <sathesh_edara2003@yahoo.co.in>,
	"Rajat Jain" <rajat.noida.india@gmail.com>
Cc:	<linux-mips@linux-mips.org>
References: <80178.32924.qm@web7903.mail.in.yahoo.com>
Subject: Re: unaligned access
Date:	Thu, 22 Feb 2007 16:06:57 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_01F9_01C7569B.7A225B20"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1896
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_01F9_01C7569B.7A225B20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Default behavior in MIPS is to silently fix up and emulate.  A =
MIPS-specific
system call (sys_sysmips with the command argument of MIPS_FIXADE
and a parameter agument of zero) allows for this to be overridden, so =
that=20
such accesses will be fatal.  It looks as if there was once support to =
log the events=20
to syslog, independently of whether or not they were fixed up, but it =
doesn't look to me=20
as if that still works in 2.6.x kernels.

            Regards,

            Kevin K.
  ----- Original Message -----=20
  From: sathesh babu=20
  To: Rajat Jain=20
  Cc: linux-mips@linux-mips.org=20
  Sent: Thursday, February 22, 2007 10:18 AM
  Subject: Re: unaligned access


  Thanks Rajan.

  In case of arm processor, the alignment trap behavior can be changed =
by simply echo a number into  /proc/sys/debug/alignment=20

  bit             behavior when set
  ---             -----------------
  0               A user process performing an unaligned memory access
                  will cause the kernel to print a message indicating
                  process name, pid, pc, instruction, address, and the
                  fault code.
  1               The kernel will attempt to fix up the user process
                  performing the unaligned access.  This is of course
                  slow (think about the floating point emulator) and
                  not recommended for production use.
  2               The kernel will send a SIGBUS signal to the user =
process
                  performing the unaligned access.

  I would like to know  Is there similar type of implimentation =
avalilable for MIPS processor in linux-2.6.12 kernel to view or log the =
unaligned access addresses and corresponding processor ID.

  Regards,
  Sathesh


  Rajat Jain <rajat.noida.india@gmail.com> wrote:
    On 2/22/07, sathesh babu wrote:
    > Hi,
    > I have ported linux-2.6.12 kernel on MIPS processor.I would like =
to
    > print the warning messges whenenver kernel or user code try to =
access
    > unaligned address ( including proceor ID ).
    > Is there any configuration option avaliable in the kernel to view
    > the unaligned address?

    Ummm ... not sure about MIPS, but in i386, exception 17 is raised =
for
    every unaligned access. alignment_check() is invoked for every such
    access.

    Regards,

    Rajat






-------------------------------------------------------------------------=
-----
  Here's a new way to find what you're looking for - Yahoo! Answers 
------=_NextPart_000_01F9_01C7569B.7A225B20
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1586" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Default behavior in MIPS is to silently =
fix up and=20
emulate.&nbsp; A MIPS-specific</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>system call (sys_sysmips with the =
command argument=20
of MIPS_FIXADE</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>and a parameter agument of zero) =
</FONT><FONT=20
face=3DArial size=3D2>allows for this to be overridden, so =
that&nbsp;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>such accesses will be fatal.&nbsp; It =
looks as=20
</FONT><FONT face=3DArial size=3D2>if there was once support to log the =
events=20
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>to syslog, independently of whether =
</FONT><FONT=20
face=3DArial size=3D2>or not they were fixed up, but it doesn't look to =
me=20
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>as if that still works in 2.6.x =
</FONT><FONT=20
face=3DArial size=3D2>kernels.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp; Kevin K.</FONT></DIV>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Dsathesh_edara2003@yahoo.co.in=20
  href=3D"mailto:sathesh_edara2003@yahoo.co.in">sathesh babu</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A =
title=3Drajat.noida.india@gmail.com=20
  href=3D"mailto:rajat.noida.india@gmail.com">Rajat Jain</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Cc:</B> <A =
title=3Dlinux-mips@linux-mips.org=20
  =
href=3D"mailto:linux-mips@linux-mips.org">linux-mips@linux-mips.org</A> =
</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Thursday, February 22, =
2007 10:18=20
  AM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> Re: unaligned =
access</DIV>
  <DIV><BR></DIV>
  <DIV>Thanks Rajan.</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>In case of arm processor, the alignment trap behavior can be =
changed by=20
  simply echo a number into &nbsp;/proc/sys/debug/alignment&nbsp;</DIV>
  <DIV>&nbsp;</DIV>
  =
<DIV>bit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
  behavior when=20
  =
set<BR>---&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;=20
  -----------------</DIV>
  =
<DIV>0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;=20
  A user process performing an unaligned memory=20
  =
access<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  will cause the kernel to print a message=20
  =
indicating<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  process name, pid, pc, instruction, address, and=20
  =
the<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;=20
  fault code.</DIV>
  =
<DIV>1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;=20
  The kernel will attempt to fix up the user=20
  =
process<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  performing the unaligned access.&nbsp; This is of=20
  =
course<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  slow (think about the floating point emulator)=20
  =
and<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;=20
  not recommended for production use.</DIV>
  =
<DIV>2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;=20
  The kernel will send a SIGBUS signal to the user=20
  =
process<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  performing the unaligned access.<BR><BR>I would like to know&nbsp; Is =
there=20
  similar type of implimentation avalilable for MIPS processor in =
linux-2.6.12=20
  kernel to view or log the unaligned access addresses and corresponding =

  processor ID.</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>Regards,</DIV>
  <DIV>Sathesh</DIV>
  <DIV>&nbsp;</DIV>
  <DIV><BR><B><I>Rajat Jain &lt;rajat.noida.india@gmail.com&gt;</I></B>=20
  wrote:</DIV>
  <BLOCKQUOTE class=3Dreplbq=20
  style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px =
solid">On=20
    2/22/07, sathesh babu <SATHESH_EDARA2003@YAHOO.CO.IN>wrote:<BR>&gt;=20
    Hi,<BR>&gt; I have ported linux-2.6.12 kernel on MIPS processor.I =
would like=20
    to<BR>&gt; print the warning messges whenenver kernel or user code =
try to=20
    access<BR>&gt; unaligned address ( including proceor ID ).<BR>&gt; =
Is there=20
    any configuration option avaliable in the kernel to view<BR>&gt; the =

    unaligned address?<BR><BR>Ummm ... not sure about MIPS, but in i386, =

    exception 17 is raised for<BR>every unaligned access. =
alignment_check() is=20
    invoked for every=20
  such<BR>access.<BR><BR>Regards,<BR><BR>Rajat<BR><BR></BLOCKQUOTE><BR>
  <P>
  <HR SIZE=3D1>
  </HR>Here=92s a new way to find what you're looking for - <A=20
  =
href=3D"http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.=
com/">Yahoo!=20
  Answers</A> </BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_01F9_01C7569B.7A225B20--
