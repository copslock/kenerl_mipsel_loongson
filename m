Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2008 16:39:04 +0000 (GMT)
Received: from zrtps0kp.nortel.com ([47.140.192.56]:60814 "EHLO
	zrtps0kp.nortel.com") by ftp.linux-mips.org with ESMTP
	id S23658847AbYKMQjB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Nov 2008 16:39:01 +0000
Received: from zcarhxm0.corp.nortel.com (zcarhxm0.corp.nortel.com [47.129.230.95])
	by zrtps0kp.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id mADGcre12700
	for <linux-mips@linux-mips.org>; Thu, 13 Nov 2008 16:38:53 GMT
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C945AE.4F941034"
Subject: MIPS Unaligned Access Question
Date:	Thu, 13 Nov 2008 11:38:51 -0500
Message-ID: <238C6E77EA42504DA038BAEE6D1C11ECADB661@zcarhxm0.corp.nortel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: MIPS Unaligned Access Question
Thread-Index: AclFrk8tu9T1ir9+QHCv8mMEOEIW4g==
From:	"Ken Hicks" <hicks@nortel.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <HICKS@nortel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hicks@nortel.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C945AE.4F941034
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

This is my first post. I hope I'm following correct etiquette.  Here we
go....

I'm investigating why an Unaligned Access exception is generated on MIPS
from an accesses which are not misaligned.

The issue is that a kernel access two different unmapped addresses
results in different exceptions:
Address                Exception
0x0001000000000000:    page fault
0x0010000000000000:    unaligned access

I'm using a Cavium CPU with a custom linux based on 2.6.14 but the code
in question hasn't changed widly in more recent kernels.
I have observed this several times, so I have manually recreated the
behaviour by intentionally accessing known unmapped addresses.

In this first case, I forced an access to 0x0001000000000000:

Oops in arch/mips/mm/fault.c::do_page_fault, line 232[#15]:
Cpu 5
$ 0   : 0000000000000000 ffffffff81680000 000000000eb5fe30
00000029e2cb9823
$ 4   : 00000000000003e8 00000029e2c02673 000000002cb41780
0000000000000000
$ 8   : 000000000000ed97 0000000000004001 0000000000000001
ffffffff8167d547
$12   : ffffffffffffffff 0000000000000010 ffffffff8167d927
ffffffff81541730
$16   : 0001000000000000 0001000000000000 0000000000000007
ffffffff81619828
$20   : a80000000eb5fe30 a80000000eb5f0a0 a80000000eb5f0a0
ffffffff815a3400
$24   : 0000000000000000 0000000000000030

$28   : a80000000eb5c000 a80000000eb5fb30 ffffffffffffff80
ffffffff81101eb0
Hi    : 0000002dc6c00000
Lo    : 0000001e9c578400
epc   : ffffffff81101fd0 kernel_ken+0x2f8/0x310     Tainted: P   =20
ra    : ffffffff81101eb0 kernel_ken+0x1d8/0x310
Status: 10007fe2    KX SX UX KERNEL EXL
Cause : 4080800c
BadVA : 0001000000000000

In this second case, I forced an access to 0x0010000000000000:

Unhandled kernel unaligned access in
arch/mips/kernel/unaligned.c::emulate_load_store_insn, line 507[#11]:
Cpu 3
$ 0   : 0000000000000000 ffffffff81680000 000000000eb0be30
00000017a7f4fdc1
$ 4   : 00000000000003e8 00000017a7e98c11 000000002cb41780
0000000000000000
$ 8   : 0000000000003272 0000000000004001 0000000000000001
ffffffff8167d547
$12   : ffffffffffffffff 0000000000000010 ffffffff8167d927
ffffffff81541730
$16   : a8000000e62c0980 0010000000000000 0000000000000007
ffffffff81619828
$20   : a80000000eb0be30 000000007fc000e0 000000007fc00190
ffffffff815a3400
$24   : 0000000000000000 0000000000000030

$28   : a80000000eb08000 a80000000eb0bb30 0000000000512c54
ffffffff81101eb0
Hi    : 0000002dc6c00000
Lo    : 0000001e9c578400
epc   : ffffffff81101fd0 kernel_ken+0x2f8/0x310     Tainted: P   =20
ra    : ffffffff81101eb0 kernel_ken+0x1d8/0x310
Status: 10007fe2    KX SX UX KERNEL EXL
Cause : 40808014
BadVA : 0010000000000000

In the second case, the address is not unaligned, but it is reported as
an unaligned access error.

Is this behaviour related to some memory mapping?

Here's copy of cat /proc/iomem:
016c0000-08ebffff : System RAM
09010000-0fc0ffff : System RAM
20000000-ffffffff : System RAM
412000000-41fffffff : System RAM
1180000000800-118000000083f : serial
11b0008001000-11b0048001000 : Octeon PCI MEM
  11b0008020000-11b000803ffff : 0000:00:00.0
    11b0008020000-11b000803ffff : e1000
  11b0008040000-11b000805ffff : 0000:00:00.1
    11b0008040000-11b000805ffff : e1000

Is this a bug, or intentional behaviour?

In any case, would anyone be able to explain why the two accesses are
reported differently.
I'd just like to understand it.

Thanks,
Ken

Ken Hicks


------_=_NextPart_001_01C945AE.4F941034
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7653.38">
<TITLE>MIPS Unaligned Access Question</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">This is my first post. I hope I'm =
following correct etiquette.&nbsp; Here we go....</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I'm investigating why an Unaligned =
Access exception is generated on MIPS from an accesses which are not =
misaligned.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">The issue is that a kernel access two =
different unmapped addresses results in different exceptions:</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">Address&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Exception</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">0x0001000000000000:&nbsp;&nbsp;&nbsp; =
page fault</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">0x0010000000000000:&nbsp;&nbsp;&nbsp; =
unaligned access</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I'm using a Cavium CPU with a custom =
linux based on 2.6.14 but the code in question hasn't changed widly in =
more recent kernels.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I have observed this several times, so =
I have manually recreated the behaviour by intentionally accessing known =
unmapped addresses.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">In this first case, I forced an access =
to 0x0001000000000000:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Oops in =
arch/mips/mm/fault.c::do_page_fault, line 232[#15]:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Cpu 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$ 0&nbsp;&nbsp; : 0000000000000000 =
ffffffff81680000 000000000eb5fe30 00000029e2cb9823</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$ 4&nbsp;&nbsp; : 00000000000003e8 =
00000029e2c02673 000000002cb41780 0000000000000000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$ 8&nbsp;&nbsp; : 000000000000ed97 =
0000000000004001 0000000000000001 ffffffff8167d547</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$12&nbsp;&nbsp; : ffffffffffffffff =
0000000000000010 ffffffff8167d927 ffffffff81541730</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$16&nbsp;&nbsp; : 0001000000000000 =
0001000000000000 0000000000000007 ffffffff81619828</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$20&nbsp;&nbsp; : a80000000eb5fe30 =
a80000000eb5f0a0 a80000000eb5f0a0 ffffffff815a3400</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$24&nbsp;&nbsp; : 0000000000000000 =
0000000000000030&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$28&nbsp;&nbsp; : a80000000eb5c000 =
a80000000eb5fb30 ffffffffffffff80 ffffffff81101eb0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Hi&nbsp;&nbsp;&nbsp; : =
0000002dc6c00000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Lo&nbsp;&nbsp;&nbsp; : =
0000001e9c578400</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">epc&nbsp;&nbsp; : ffffffff81101fd0 =
kernel_ken+0x2f8/0x310&nbsp;&nbsp;&nbsp;&nbsp; Tainted: =
P&nbsp;&nbsp;&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ra&nbsp;&nbsp;&nbsp; : =
ffffffff81101eb0 kernel_ken+0x1d8/0x310</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Status: 10007fe2&nbsp;&nbsp;&nbsp; KX =
SX UX KERNEL EXL</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Cause : 4080800c</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">BadVA : 0001000000000000</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">In this second case, I forced an access =
to 0x0010000000000000:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Unhandled kernel unaligned access =
in</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">arch/mips/kernel/unaligned.c::emulate_load_store_insn, =
line 507[#11]:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Cpu 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$ 0&nbsp;&nbsp; : 0000000000000000 =
ffffffff81680000 000000000eb0be30 00000017a7f4fdc1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$ 4&nbsp;&nbsp; : 00000000000003e8 =
00000017a7e98c11 000000002cb41780 0000000000000000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$ 8&nbsp;&nbsp; : 0000000000003272 =
0000000000004001 0000000000000001 ffffffff8167d547</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$12&nbsp;&nbsp; : ffffffffffffffff =
0000000000000010 ffffffff8167d927 ffffffff81541730</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$16&nbsp;&nbsp; : a8000000e62c0980 =
0010000000000000 0000000000000007 ffffffff81619828</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$20&nbsp;&nbsp; : a80000000eb0be30 =
000000007fc000e0 000000007fc00190 ffffffff815a3400</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$24&nbsp;&nbsp; : 0000000000000000 =
0000000000000030&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$28&nbsp;&nbsp; : a80000000eb08000 =
a80000000eb0bb30 0000000000512c54 ffffffff81101eb0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Hi&nbsp;&nbsp;&nbsp; : =
0000002dc6c00000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Lo&nbsp;&nbsp;&nbsp; : =
0000001e9c578400</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">epc&nbsp;&nbsp; : ffffffff81101fd0 =
kernel_ken+0x2f8/0x310&nbsp;&nbsp;&nbsp;&nbsp; Tainted: =
P&nbsp;&nbsp;&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ra&nbsp;&nbsp;&nbsp; : =
ffffffff81101eb0 kernel_ken+0x1d8/0x310</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Status: 10007fe2&nbsp;&nbsp;&nbsp; KX =
SX UX KERNEL EXL</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Cause : 40808014</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">BadVA : 0010000000000000</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">In the second case, the address is not =
unaligned, but it is reported as an unaligned access error.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Is this behaviour related to some =
memory mapping?</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Here's copy of cat /proc/iomem:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">016c0000-08ebffff : System RAM</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">09010000-0fc0ffff : System RAM</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">20000000-ffffffff : System RAM</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">412000000-41fffffff : System =
RAM</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">1180000000800-118000000083f : =
serial</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">11b0008001000-11b0048001000 : Octeon =
PCI MEM</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; 11b0008020000-11b000803ffff : =
0000:00:00.0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; =
11b0008020000-11b000803ffff : e1000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; 11b0008040000-11b000805ffff : =
0000:00:00.1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; =
11b0008040000-11b000805ffff : e1000</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Is this a bug, or intentional =
behaviour?</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">In any case, would anyone be able to =
explain why the two accesses are reported differently.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">I'd just like to understand it.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Ken</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Ken Hicks</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C945AE.4F941034--
