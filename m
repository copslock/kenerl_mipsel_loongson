Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2003 13:52:44 +0100 (BST)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:44700 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225289AbTDPMwM>;
	Wed, 16 Apr 2003 13:52:12 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h3GCq0Ue022298;
	Wed, 16 Apr 2003 05:52:01 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id FAA21795;
	Wed, 16 Apr 2003 05:51:58 -0700 (PDT)
Message-ID: <00c401c30418$0d9d1370$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Hartvig Ekner" <hartvig@ekner.info>,
	"Linux MIPS mailing list" <linux-mips@linux-mips.org>
References: <3E9D0C34.38FE2749@ekner.info>
Subject: Re: MIPS32 cache functions now using c-r4k?
Date: Wed, 16 Apr 2003 14:59:30 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00C1_01C30428.C88D6B20"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_00C1_01C30428.C88D6B20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The whole point of creating the generic MIPS32 MMU and cache
routines was to have something that would run on both 32-bit and
64-bit processors.  Who decided to throw them away and abandon=20
support for 32-bit-only CPUs other than the R3000, and why?

            Kevin K.
  ----- Original Message -----=20
  From: Hartvig Ekner=20
  To: Linux MIPS mailing list=20
  Sent: Wednesday, April 16, 2003 9:54 AM
  Subject: MIPS32 cache functions now using c-r4k?


  On a MIPS32 CPU (Au1500), I now end up in:=20
  Mount cache hash table entries: 512 (order: 0, 4096 bytes)=20
  Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)=20
  Page-cache hash table entries: 16384 (order: 4, 65536 bytes)=20
  Checking for 'wait' instruction...  available.=20
  POSIX conformance testing by UNIFIX=20
  Autoconfig PCI channel 0x802d0ab8=20
  Scanning bus 00, I/O 0x00000300:0x00100000, Mem 0x40000000:0x44000000=20
  Reserved instruction in kernel code in traps.c::do_ri, line 650:=20
  $0 : 00000000 810e4000 802d0000 80109654 810e3000 802c4754 00000000 =
80000000=20
  $8 : 8102e720 00000001 8010b98c c0000000 001fffff c0000000 fffffff4 =
00000010=20
  $16: 810e3000 802d1340 802b9800 802bc000 00000000 00000000 00101000 =
00000000=20
  $24: ffffffff 810ebde7                   810ea000 810ebd68 00000000 =
80121adc=20
  Hi : 00000000=20
  Lo : 000000c0=20
  epc  : 8010965c    Not tainted=20
  Status: 1000fc02=20
  Cause : 00800028=20
  Process swapper (pid: 1, stackpage=3D810ea000)=20

  Which is:=20

  80109654 <r4k_clear_page_d32>:=20
  80109654:       24811000        addiu   $at,$a0,4096=20
  80109658:       bc8d0000        cache   0xd,0($a0)=20
  8010965c:       fc800000        sdc3    $0,0($a0)=20
  80109660:       fc800008        sdc3    $0,8($a0)=20
  80109664:       fc800010        sdc3    $0,16($a0)=20
  80109668:       fc800018        sdc3    $0,24($a0)=20
  8010966c:       24840040        addiu   $a0,$a0,64=20
  80109670:       bc8dffe0        cache   0xd,-32($a0)=20
  80109674:       fc80ffe0        sdc3    $0,-32($a0)=20
  80109678:       fc80ffe8        sdc3    $0,-24($a0)=20
  8010967c:       fc80fff0        sdc3    $0,-16($a0)=20
  80109680:       1424fff5        bne     $at,$a0,80109658 =
<r4k_clear_page_d32+0x4>=20
  80109684:       fc80fff8        sdc3    $0,-8($a0)=20
  80109688:       03e00008        jr      $ra=20

  It seems much of the r4k cache code assumes the presence of SD - which =
breaks on all MIPS32 CPU's?=20

  /Hartvig=20
   =20

------=_NextPart_000_00C1_01C30428.C88D6B20
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 5.50.4919.2200" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>The whole point of&nbsp;creating the =
generic MIPS32=20
MMU and cache</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>routines was to have something that =
would run on=20
both 32-bit and</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>64-bit processors.&nbsp; Who decided to =
throw them=20
away and </FONT><FONT face=3DArial size=3D2>abandon </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>support for 32-bit-only CPUs other than =
the R3000,=20
and why?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp; Kevin K.</FONT></DIV>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Dhartvig@ekner.info =
href=3D"mailto:hartvig@ekner.info">Hartvig Ekner</A>=20
  </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A =
title=3Dlinux-mips@linux-mips.org=20
  href=3D"mailto:linux-mips@linux-mips.org">Linux MIPS mailing list</A> =
</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Wednesday, April 16, 2003 =
9:54=20
  AM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> MIPS32 cache functions =
now using=20
  c-r4k?</DIV>
  <DIV><BR></DIV><TT>On a MIPS32 CPU (Au1500), I&nbsp;now end up=20
  in:</TT><TT></TT>=20
  <P><TT>Mount cache hash table entries: 512 (order: 0, 4096 bytes)</TT> =

  <BR><TT>Buffer-cache hash table entries: 4096 (order: 2, 16384 =
bytes)</TT>=20
  <BR><TT>Page-cache hash table entries: 16384 (order: 4, 65536 =
bytes)</TT>=20
  <BR><TT>Checking for 'wait' instruction...&nbsp; available.</TT> =
<BR><TT>POSIX=20
  conformance testing by UNIFIX</TT> <BR><TT>Autoconfig PCI channel=20
  0x802d0ab8</TT> <BR><TT>Scanning bus 00, I/O 0x00000300:0x00100000, =
Mem=20
  0x40000000:0x44000000</TT> <BR><TT>Reserved instruction in kernel code =
in=20
  traps.c::do_ri, line 650:</TT> <BR><TT>$0 : 00000000 810e4000 802d0000 =

  80109654 810e3000 802c4754 00000000 80000000</TT> <BR><TT>$8 : =
8102e720=20
  00000001 8010b98c c0000000 001fffff c0000000 fffffff4 00000010</TT>=20
  <BR><TT>$16: 810e3000 802d1340 802b9800 802bc000 00000000 00000000 =
00101000=20
  00000000</TT> <BR><TT>$24: ffffffff=20
  =
810ebde7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  810ea000 810ebd68 00000000 80121adc</TT> <BR><TT>Hi : 00000000</TT> =
<BR><TT>Lo=20
  : 000000c0</TT> <BR><TT>epc&nbsp; : 8010965c&nbsp;&nbsp;&nbsp; Not=20
  tainted</TT> <BR><TT>Status: 1000fc02</TT> <BR><TT>Cause : =
00800028</TT>=20
  <BR><TT>Process swapper (pid: 1, stackpage=3D810ea000)</TT><TT></TT>=20
  <P><TT>Which is:</TT><TT></TT>=20
  <P><TT>80109654 &lt;r4k_clear_page_d32&gt;:</TT>=20
  <BR><TT>80109654:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  24811000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addiu&nbsp;&nbsp;=20
  $at,$a0,4096</TT> =
<BR><TT>80109658:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  bc8d0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cache&nbsp;&nbsp;=20
  0xd,0($a0)</TT> <BR><TT>8010965c:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  fc800000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sdc3&nbsp;&nbsp;&nbsp;=20
  $0,0($a0)</TT> <BR><TT>80109660:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  fc800008&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sdc3&nbsp;&nbsp;&nbsp;=20
  $0,8($a0)</TT> <BR><TT>80109664:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  fc800010&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sdc3&nbsp;&nbsp;&nbsp;=20
  $0,16($a0)</TT> <BR><TT>80109668:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  fc800018&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sdc3&nbsp;&nbsp;&nbsp;=20
  $0,24($a0)</TT> <BR><TT>8010966c:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  24840040&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addiu&nbsp;&nbsp;=20
  $a0,$a0,64</TT> <BR><TT>80109670:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  bc8dffe0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cache&nbsp;&nbsp;=20
  0xd,-32($a0)</TT> =
<BR><TT>80109674:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  fc80ffe0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sdc3&nbsp;&nbsp;&nbsp;=20
  $0,-32($a0)</TT> <BR><TT>80109678:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

  fc80ffe8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sdc3&nbsp;&nbsp;&nbsp;=20
  $0,-24($a0)</TT> <BR><TT>8010967c:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

  fc80fff0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sdc3&nbsp;&nbsp;&nbsp;=20
  $0,-16($a0)</TT> <BR><TT>80109680:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

  1424fff5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
bne&nbsp;&nbsp;&nbsp;&nbsp;=20
  $at,$a0,80109658 &lt;r4k_clear_page_d32+0x4&gt;</TT>=20
  <BR><TT>80109684:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  fc80fff8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sdc3&nbsp;&nbsp;&nbsp;=20
  $0,-8($a0)</TT> <BR><TT>80109688:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  03e00008&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  jr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $ra</TT><TT></TT>=20
  <P><TT>It seems much of the r4k cache code assumes the presence of =
SD&nbsp;-=20
  which breaks on all MIPS32 CPU's?</TT><TT></TT>=20
  <P><TT>/Hartvig</TT> <BR><TT></TT>&nbsp; =
</P></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_00C1_01C30428.C88D6B20--
