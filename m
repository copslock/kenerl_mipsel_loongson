Received:  by oss.sgi.com id <S553819AbQKWVW2>;
	Thu, 23 Nov 2000 13:22:28 -0800
Received: from [203.42.24.46] ([203.42.24.46]:41488 "EHLO
        sydis001.grouppsi.com.au") by oss.sgi.com with ESMTP
	id <S553750AbQKWVWG>; Thu, 23 Nov 2000 13:22:06 -0800
Received: by sydis001.grouppsi.com.au with Internet Mail Service (5.5.2650.21)
	id <XANZ7M7Z>; Fri, 24 Nov 2000 08:25:04 +1100
Message-ID: <B10D6CEFCC90D411B6F20000E84E7AF80E1E@sydmx001.grouppsi.com.au>
From:   Christopher Martin <Christopher.Martin@grouppsi.com.au>
To:     "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Linux on an Indy
Date:   Fri, 24 Nov 2000 08:21:53 +1100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C05593.D8353E40"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C05593.D8353E40
Content-Type: text/plain;
	charset="iso-8859-1"

Hello hello hello!

I just got my Indy to bootp /vmlinux for the first time! Let merriment
reign!

I am having some problems getting it to mount root, though, and getting some
kernel panics because of it.

I'm not currently running Linux on any other machines, but I'm using the
Windows 2000 DHCP server to provide the boot info and Cisco's tftp server to
serve up the vmlinux file.

My vmlinux file is located in the root of my tftp server, with the complete,
extracted hardhat-sgi-5.1.tar file, and the same directory
(e:\shares\tftproot) exported by Omni NFS server. So, I have configured my
BOOTP like this

912 Host Name - indy01
017 Root Path - /e/shares/tftproot
066 Boot Server Host Name - 10.254.0.18
067 Bootfilename - /vmlinux
003 Router - 10.254.0.254

10.254.0.18 is a Windows 2000 server running Cisco's tftp server and Omni
NFS server.

I also have my domain name, DNS servers, etc defined, but I'm assuming they
won't interfere. I have also tried with the 017 Root Path - / and no luck
there.

Now, with this configuration I get the normal kernel boot, but just after
the hard disk info, just as it goes to mount root, I get:
<
Looking up port of RFC 100003/2 on 10.254.0.18
Looking up port of RFC 100005/1 on 10.254.0.18
Root-NFS: Server returned error -13 while mounting /tftpboot/indy
>

then it tries to boot off floppy and then it kernel panics. I have also
noticed that the error "Fri Nov 24 08:11:28 2000: Failed ( State Error )" is
displayed at the end of the tftp /vmlinux file transfer.

Anyone got any ideas? I am aware that I should be using a Linux NFS server,
but I haven't got a machine to spare to set it up on. Please help!

Thanks for any help,

Chris Martin

------_=_NextPart_001_01C05593.D8353E40
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2650.12">
<TITLE>Linux on an Indy</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Hello hello hello!</FONT>
</P>

<P><FONT SIZE=3D2>I just got my Indy to bootp /vmlinux for the first =
time! Let merriment reign!</FONT>
</P>

<P><FONT SIZE=3D2>I am having some problems getting it to mount root, =
though, and getting some kernel panics because of it.</FONT>
</P>

<P><FONT SIZE=3D2>I'm not currently running Linux on any other =
machines, but I'm using the Windows 2000 DHCP server to provide the =
boot info and Cisco's tftp server to serve up the vmlinux =
file.</FONT></P>

<P><FONT SIZE=3D2>My vmlinux file is located in the root of my tftp =
server, with the complete, extracted hardhat-sgi-5.1.tar file, and the =
same directory (e:\shares\tftproot) exported by Omni NFS server. So, I =
have configured my BOOTP like this</FONT></P>

<P><FONT SIZE=3D2>912 Host Name - indy01</FONT>
<BR><FONT SIZE=3D2>017 Root Path - /e/shares/tftproot</FONT>
<BR><FONT SIZE=3D2>066 Boot Server Host Name - 10.254.0.18</FONT>
<BR><FONT SIZE=3D2>067 Bootfilename - /vmlinux</FONT>
<BR><FONT SIZE=3D2>003 Router - 10.254.0.254</FONT>
</P>

<P><FONT SIZE=3D2>10.254.0.18 is a Windows 2000 server running Cisco's =
tftp server and Omni NFS server.</FONT>
</P>

<P><FONT SIZE=3D2>I also have my domain name, DNS servers, etc defined, =
but I'm assuming they won't interfere. I have also tried with the 017 =
Root Path - / and no luck there.</FONT></P>

<P><FONT SIZE=3D2>Now, with this configuration I get the normal kernel =
boot, but just after the hard disk info, just as it goes to mount root, =
I get:</FONT></P>

<P><FONT SIZE=3D2>&lt;</FONT>
<BR><FONT SIZE=3D2>Looking up port of RFC 100003/2 on =
10.254.0.18</FONT>
<BR><FONT SIZE=3D2>Looking up port of RFC 100005/1 on =
10.254.0.18</FONT>
<BR><FONT SIZE=3D2>Root-NFS: Server returned error -13 while mounting =
/tftpboot/indy</FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
</P>

<P><FONT SIZE=3D2>then it tries to boot off floppy and then it kernel =
panics. I have also noticed that the error &quot;Fri Nov 24 08:11:28 =
2000: Failed ( State Error )&quot; is displayed at the end of the tftp =
/vmlinux file transfer.</FONT></P>

<P><FONT SIZE=3D2>Anyone got any ideas? I am aware that I should be =
using a Linux NFS server, but I haven't got a machine to spare to set =
it up on. Please help!</FONT></P>

<P><FONT SIZE=3D2>Thanks for any help,</FONT>
</P>

<P><FONT SIZE=3D2>Chris Martin</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C05593.D8353E40--
