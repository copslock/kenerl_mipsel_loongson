Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6B6sdm18507
	for linux-mips-outgoing; Tue, 10 Jul 2001 23:54:39 -0700
Received: from cool.coventive.com (cool.coventive.com [211.79.9.188])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6B6sbV18495
	for <linux-mips@oss.sgi.com>; Tue, 10 Jul 2001 23:54:38 -0700
Received: from jefflee (jungle.coventive.com [211.79.9.189])
	by cool.coventive.com (8.10.2/8.10.2) with SMTP id f6B6nPW04069;
	Wed, 11 Jul 2001 14:49:25 +0800
Message-ID: <00ef01c109d6$c7b39150$9400a8c0@jefflee>
From: "jeff_lee" <jeff_lee@coventive.com>
To: <linux-mips@oss.sgi.com>
Cc: "CIH" <cih@coventive.com>,
   =?big5?B?SmFsZW4gt6iqRqan?= <jalen@coventive.com>
Subject: DHCP problem
Date: Wed, 11 Jul 2001 14:57:41 +0800
Organization: hardware
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00EC_01C10A19.D5AD9E70"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

------=_NextPart_000_00EC_01C10A19.D5AD9E70
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hi all, I got some question about the DHCP. We have a mipsel machine and =
running HomeRF wireless module on it. The CPU is Vr4121, HomeRF bus is =
ISA-like bus. Now the module can work fine with fixed-ip. We want to get =
the IP when system boot-up. We had tried two way: cross compiler the =
pump and dhclient applications, but when we execute the pump, it show =
the "operation failed". When we execute dhclient, it show "segment =
fault" ....... I don't know what's going on .Can someone tell me what's =
going on ?? Or where can I get the binary code for pump and dhclient ??

Thanks and best regs,

Jeff


------=_NextPart_000_00EC_01C10A19.D5AD9E70
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dbig5" http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.2920.0" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DVerdana size=3D2>Hi all, I got some question about the =
DHCP. We=20
have a mipsel machine and running HomeRF wireless module on it. The CPU =
is=20
Vr4121, HomeRF bus is ISA-like bus. Now the module can work fine with =
fixed-ip.=20
We want to get the IP when system boot-up. We had tried two way: cross =
compiler=20
the pump and dhclient applications, but when we execute the pump, it =
show the=20
"operation failed". When we execute dhclient, it show "segment fault" =
....... I=20
don't know what's going on .Can someone tell me what's going on ?? Or =
where can=20
I get the binary code for pump and dhclient ??<BR></FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2>Thanks and best regs,</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DVerdana size=3D2>Jeff<BR></DIV></FONT></BODY></HTML>

------=_NextPart_000_00EC_01C10A19.D5AD9E70--
