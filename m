Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6594BT11823
	for linux-mips-outgoing; Thu, 5 Jul 2001 02:04:11 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6594AV11820
	for <linux-mips@oss.sgi.com>; Thu, 5 Jul 2001 02:04:10 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id CAA29010;
	Thu, 5 Jul 2001 02:04:04 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id CAA28354;
	Thu, 5 Jul 2001 02:04:01 -0700 (PDT)
Message-ID: <006a01c10532$13d4c760$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "kjlin" <kj.lin@viditec-netmedia.com.tw>, <linux-mips@oss.sgi.com>
References: <013801c104f4$a807cf60$056aaac0@kjlin>
Subject: Re: Kernel panic: Attempted to kill init! 
Date: Thu, 5 Jul 2001 11:08:35 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0067_01C10542.D60F6C80"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

------=_NextPart_000_0067_01C10542.D60F6C80
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

  When the kernel boots up and mounts the root file system,=20
  the kernel start to do "execve("/sbin/AP",argv_init,envp_init)" to run =
a AP.
  But in my case, it panics when kernel tries to do the =
"execve("/sbin/AP",argv_init,envp_init)".
  The kernel panic message shows " Kernel panic: Attempted to kill init! =
".
  What situation will trigger such kernel panic?
Well, bogus values for argv_init and envp_init would be the first thing =
I would check...

            Kevin K.

------=_NextPart_000_0067_01C10542.D60F6C80
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dwindows-1252">
<META content=3D"MSHTML 5.50.4134.600" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV>
<DIV><FONT size=3D2></FONT></DIV></DIV>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
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
  <DIV><FONT size=3D2>What situation will trigger such kernel=20
panic?</FONT></DIV></BLOCKQUOTE>
<DIV dir=3Dltr><FONT size=3D2>Well, bogus values for argv_init and =
envp_init would=20
be the first thing I would check...</FONT></DIV>
<DIV dir=3Dltr><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV dir=3Dltr><FONT size=3D2>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp; Kevin K.</FONT></DIV></BODY></HTML>

------=_NextPart_000_0067_01C10542.D60F6C80--
