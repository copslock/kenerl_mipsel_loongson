Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f65223T04324
	for linux-mips-outgoing; Wed, 4 Jul 2001 19:02:03 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f65221V04321
	for <linux-mips@oss.sgi.com>; Wed, 4 Jul 2001 19:02:01 -0700
Received: from viditec-netmedia.com.tw (61-220-240-70.HINET-IP.hinet.net [61.220.240.70]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA03600
	for <linux-mips@oss.sgi.com>; Wed, 4 Jul 2001 19:01:35 -0700 (PDT)
	mail_from (kj.lin@viditec-netmedia.com.tw)
Received: from kjlin ([61.220.240.66])
	by viditec-netmedia.com.tw (8.10.0/8.10.0) with SMTP id f653j4224457
	for <linux-mips@oss.sgi.com>; Thu, 5 Jul 2001 11:45:04 +0800
Message-ID: <013801c104f4$a807cf60$056aaac0@kjlin>
From: "kjlin" <kj.lin@viditec-netmedia.com.tw>
To: <linux-mips@oss.sgi.com>
Subject: Kernel panic: Attempted to kill init! 
Date: Thu, 5 Jul 2001 09:48:57 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0135_01C10537.B60055E0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

------=_NextPart_000_0135_01C10537.B60055E0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hi,

When the kernel boots up and mounts the root file system,=20
the kernel start to do "execve("/sbin/AP",argv_init,envp_init)" to run a =
AP.
But in my case, it panics when kernel tries to do the =
"execve("/sbin/AP",argv_init,envp_init)".
The kernel panic message shows " Kernel panic: Attempted to kill init! =
".
What situation will trigger such kernel panic?

Thanks,
KJ

------=_NextPart_000_0135_01C10537.B60055E0
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dbig5" http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.2919.6307" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
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
<DIV><FONT size=3D2>KJ</FONT></DIV></BODY></HTML>

------=_NextPart_000_0135_01C10537.B60055E0--
