Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8K7Box14917
	for linux-mips-outgoing; Thu, 20 Sep 2001 00:11:50 -0700
Received: from viditec-netmedia.com.tw (61-220-240-70.HINET-IP.hinet.net [61.220.240.70])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8K7BQe14906
	for <linux-mips@oss.sgi.com>; Thu, 20 Sep 2001 00:11:28 -0700
Received: from kjlin ([61.220.240.66])
	by viditec-netmedia.com.tw (8.10.0/8.10.0) with SMTP id f8K9nUI04761
	for <linux-mips@oss.sgi.com>; Thu, 20 Sep 2001 17:49:30 +0800
Message-ID: <05e901c141a0$a03e6120$056aaac0@kjlin>
From: "kjlin" <kj.lin@viditec-netmedia.com.tw>
To: <linux-mips@oss.sgi.com>
Subject: fork() vs vfork()
Date: Thu, 20 Sep 2001 14:51:08 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_05E6_01C141E3.AE47B080"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

------=_NextPart_000_05E6_01C141E3.AE47B080
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hi all,

How does linux-mips treat the vfork() function?
I can see the fork() implemented in syscall.c as following:

save_static_function(sys_fork);
static_unused int _sys_fork(struct pt_regs regs)
{
        int res;
        res =3D do_fork(SIGCHLD, regs.regs[29], &regs, 0);
        return res;
}

But i can't see anything about vfork/sys_vfork in mips platform.
However, the vfork() was implemented as sys_vfork in other architecture.
Such as arm platform:
asmlinkage int sys_vfork(struct pt_regs *regs)
{
        return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs->ARM_sp, =
regs, 0);
}

Why not do the same "sys_vfork" in linux-mips?
Does it mean that MIPS does not support vfork() or vfork() is equal to =
fork() in MIPS platform?

Thanks,
KJ



------=_NextPart_000_05E6_01C141E3.AE47B080
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
<DIV><FONT size=3D2>Hi all,</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>How does linux-mips treat the vfork() =
function?</FONT></DIV>
<DIV><FONT size=3D2>I can see the fork() implemented in syscall.c as=20
following:</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>save_static_function(sys_fork);<BR>static_unused int =

_sys_fork(struct pt_regs=20
regs)<BR>{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
res;</FONT></DIV>
<DIV><FONT size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res =3D=20
do_fork(SIGCHLD, regs.regs[29], &amp;regs, 0);</FONT></DIV>
<DIV><FONT size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return=20
res;<BR>}</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>But i can't see&nbsp;anything&nbsp;about =
vfork/sys_vfork in=20
mips platform.</FONT></DIV>
<DIV><FONT size=3D2>However, the vfork() was implemented as sys_vfork in =
other=20
architecture.</FONT></DIV>
<DIV><FONT size=3D2>Such as arm platform:</FONT></DIV>
<DIV><FONT size=3D2>asmlinkage int sys_vfork(struct pt_regs=20
*regs)<BR>{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return=20
do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs-&gt;ARM_sp, regs,=20
0);<BR>}</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>Why not do the same "sys_vfork" in =
linux-mips?</FONT></DIV>
<DIV><FONT size=3D2>Does it mean that MIPS does not support vfork() or =
vfork() is=20
equal to fork() in MIPS platform?</FONT></DIV>
<DIV><FONT size=3D2><BR>Thanks,</FONT></DIV>
<DIV><FONT size=3D2>KJ<BR></DIV></FONT>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_05E6_01C141E3.AE47B080--
