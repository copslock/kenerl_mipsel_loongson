Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f65EGPb18016
	for linux-mips-outgoing; Thu, 5 Jul 2001 07:16:25 -0700
Received: from arianne.in.ishoni.com ([164.164.83.132])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f65EGKV18013
	for <linux-mips@oss.sgi.com>; Thu, 5 Jul 2001 07:16:21 -0700
Received: from deepak ([192.168.1.197])
	by arianne.in.ishoni.com (8.11.1/8.11.4/Ishonir2) with SMTP id f65EGvD13257;
	Thu, 5 Jul 2001 19:46:57 +0530
Reply-To: <deepak@ishoni.com>
From: "Deepak Shenoy" <deepak@ishoni.com>
To: "'kjlin'" <kj.lin@viditec-netmedia.com.tw>, <linux-mips@oss.sgi.com>
Subject: RE: Kernel panic: Attempted to kill init! 
Date: Thu, 5 Jul 2001 19:50:43 +0530
Message-ID: <E0FDC90A9031D511915D00C04F0CCD25688A@leonoid.in.ishoni.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_001D_01C1058D.04322F90"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <E0FDC90A9031D511915D00C04F0CCD25393942@leonoid.in.ishoni.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

------=_NextPart_000_001D_01C1058D.04322F90
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit

"init" is started with pid 1. If this process is killed you get this
message.
it could be possible that your init kernel thread is returning, exiting etc.

deepak

-----Original Message-----
From: owner-linux-mips@oss.sgi.com [mailto:owner-linux-mips@oss.sgi.com]On
Behalf Of kjlin
Sent: Thursday, July 05, 2001 7:19 AM
To: linux-mips@oss.sgi.com
Subject: Kernel panic: Attempted to kill init!


Hi,

When the kernel boots up and mounts the root file system,
the kernel start to do "execve("/sbin/AP",argv_init,envp_init)" to run a AP.
But in my case, it panics when kernel tries to do the
"execve("/sbin/AP",argv_init,envp_init)".
The kernel panic message shows " Kernel panic: Attempted to kill init! ".
What situation will trigger such kernel panic?

Thanks,
KJ


------=_NextPart_000_001D_01C1058D.04322F90
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dbig5">


<META content=3D"MSHTML 5.00.2314.1000" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT color=3D#0000ff face=3D"Courier New" size=3D2><SPAN=20
class=3D665412214-05072001>"init" is started with pid 1. If this process =
is killed=20
you get this message.</SPAN></FONT></DIV>
<DIV><FONT color=3D#0000ff face=3D"Courier New" size=3D2><SPAN=20
class=3D665412214-05072001>it could be possible that your init kernel =
thread is=20
returning, exiting etc.</SPAN></FONT></DIV>
<DIV><FONT color=3D#0000ff face=3D"Courier New" size=3D2><SPAN=20
class=3D665412214-05072001></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#0000ff face=3D"Courier New" size=3D2><SPAN=20
class=3D665412214-05072001>deepak</SPAN></FONT></DIV>
<BLOCKQUOTE=20
style=3D"BORDER-LEFT: #0000ff 2px solid; MARGIN-LEFT: 5px; MARGIN-RIGHT: =
0px; PADDING-LEFT: 5px">
  <DIV align=3Dleft class=3DOutlookMessageHeader dir=3Dltr><FONT =
face=3DTahoma=20
  size=3D2>-----Original Message-----<BR><B>From:</B> =
owner-linux-mips@oss.sgi.com=20
  [mailto:owner-linux-mips@oss.sgi.com]<B>On Behalf Of =
</B>kjlin<BR><B>Sent:</B>=20
  Thursday, July 05, 2001 7:19 AM<BR><B>To:</B>=20
  linux-mips@oss.sgi.com<BR><B>Subject:</B> Kernel panic: Attempted to =
kill=20
  init! <BR><BR></DIV></FONT>
  <DIV><FONT size=3D2>Hi,</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT size=3D2>When the kernel boots up and mounts the root file =
system,=20
  </FONT></DIV>
  <DIV><FONT size=3D2>the kernel start to do=20
  "execve("/sbin/AP",argv_init,envp_init)" to run a AP.</FONT></DIV>
  <DIV><FONT size=3D2>But in my case, it panics when kernel tries to do =
the=20
  "execve("/sbin/AP",argv_init,envp_init)".</FONT></DIV>
  <DIV><FONT size=3D2>The kernel panic message shows " Kernel panic: =
Attempted to=20
  kill init! ".</FONT></DIV>
  <DIV><FONT size=3D2>What situation will trigger such kernel =
panic?</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT size=3D2>Thanks,</FONT></DIV>
  <DIV><FONT size=3D2>KJ</FONT></DIV></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_001D_01C1058D.04322F90--
