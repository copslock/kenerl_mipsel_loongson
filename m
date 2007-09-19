Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2007 14:26:44 +0100 (BST)
Received: from wip-cdc-wd.wipro.com ([203.91.201.26]:37541 "EHLO
	wip-cdc-wd.wipro.com") by ftp.linux-mips.org with ESMTP
	id S20022887AbXISN0g (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Sep 2007 14:26:36 +0100
Received: from wip-cdc-wd.wipro.com (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id 8012C180A6
	for <linux-mips@linux-mips.org>; Wed, 19 Sep 2007 18:56:51 +0530 (IST)
Received: from blr-ec-bh02.wipro.com (blr-ec-bh02.wipro.com [10.201.50.92])
	by wip-cdc-wd.wipro.com (Postfix) with ESMTP id 700A41807A
	for <linux-mips@linux-mips.org>; Wed, 19 Sep 2007 18:56:51 +0530 (IST)
Received: from BLR-EC-MBX05.wipro.com ([10.201.50.165]) by blr-ec-bh02.wipro.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 19 Sep 2007 18:57:03 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7FAC0.D34956AC"
Subject: Objcopy error
Date:	Wed, 19 Sep 2007 18:57:35 +0530
Message-ID: <67B72BAF01E9A540B4B1F7D031F6D989076B74B4@BLR-EC-MBX05.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Objcopy error
thread-index: Acf6wNcevTfUA/rgQpq9ew+P9S+L5w==
From:	<rahul.hari@wipro.com>
To:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 19 Sep 2007 13:27:03.0093 (UTC) FILETIME=[C3EA5E50:01C7FAC0]
Return-Path: <rahul.hari@wipro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rahul.hari@wipro.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7FAC0.D34956AC
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20
Hi,
I am getting an error while building flash_boot_ module  for  mips
platform. Please specify a solution for this..
the error log as follows:
=20
=20
make[2]: Leaving directory
`/export/rahul/perforce/client_myx26_Sep14/flash_boot_recvry/fusiv/apcod
e'
mips-linux-uclibc-gcc -Werror -c -Os -march=3Dlx4189 -mips1 =
-mno-abicalls
-fno-pic -fomit-frame-pointer -nostdinc -I. -I../fusiv/include
-I../include -I../inflate -I../shared -I../flash/cepflash -I../flash
-I../autoclock -DIN_BOOTSTRAP -D_LOADER_RECOVERY_  -Wa,-alh=3Dethap.lst =
-c
-o ethap.o ethap.c
mips-linux-uclibc-ld -Bstatic -EB -e romInit -N -X -Map loader1.map -T
loader1LinkerMap -o loader1.x loader1.o copyLoader.o lx4080.o itab.o
dispatch.o loadAP.o ethap.o ../flash/libFlashRCV.a
../shared/bootShared.a  ../misc/libMisc.a ../autoclock/libAuto.a
make[1]: Leaving directory
`/export/rahul/perforce/client_myx26_Sep14/flash_boot_recvry/loader1'
mips-linux-uclibc-objcopy -S -O binary loader1/loader1.x loader1.bin
BFD: Warning: Writing section `.text' to huge (ie negative) file offset
0xbefffe74.
BFD: Warning: Writing section `.data' to huge (ie negative) file offset
0xbf0020c4.
mips-linux-uclibc-objcopy: loader1.bin: File truncated
make: *** [loader1.bin] Error 1

=20
=20
Thanks,
Rahul

------_=_NextPart_001_01C7FAC0.D34956AC
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3086" name=3DGENERATOR></HEAD>
<BODY>
<DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D046042413-19092007>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D046042413-19092007>I am =
getting an=20
error while building flash_boot_ module&nbsp; for &nbsp;mips platform. =
Please=20
specify a solution for this..</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D046042413-19092007>the =
error log as=20
follows:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>make[2]: Leaving directory=20
`/export/rahul/perforce/client_myx26_Sep14/flash_boot_recvry/fusiv/apcode=
'<BR>mips-linux-uclibc-gcc=20
-Werror -c -Os -march=3Dlx4189 -mips1 -mno-abicalls -fno-pic =
-fomit-frame-pointer=20
-nostdinc -I. -I../fusiv/include -I../include -I../inflate -I../shared=20
-I../flash/cepflash -I../flash -I../autoclock -DIN_BOOTSTRAP=20
-D_LOADER_RECOVERY_&nbsp; -Wa,-alh=3Dethap.lst -c -o ethap.o=20
ethap.c<BR>mips-linux-uclibc-ld -Bstatic -EB -e romInit -N -X -Map =
loader1.map=20
-T loader1LinkerMap -o loader1.x loader1.o copyLoader.o lx4080.o itab.o=20
dispatch.o loadAP.o ethap.o ../flash/libFlashRCV.a =
../shared/bootShared.a&nbsp;=20
../misc/libMisc.a ../autoclock/libAuto.a<BR>make[1]: Leaving directory=20
`/export/rahul/perforce/client_myx26_Sep14/flash_boot_recvry/loader1'<BR>=
mips-linux-uclibc-objcopy=20
-S -O binary loader1/loader1.x loader1.bin<BR>BFD: Warning: Writing =
section=20
`.text' to huge (ie negative) file offset 0xbefffe74.<BR>BFD: Warning: =
Writing=20
section `.data' to huge (ie negative) file offset=20
0xbf0020c4.<BR>mips-linux-uclibc-objcopy: loader1.bin: File =
truncated<BR>make:=20
*** [loader1.bin] Error 1<BR></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT><SPAN class=3D046042413-19092007><FONT face=3DArial=20
size=3D2>Thanks,</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D046042413-19092007>Rahul</SPAN></FONT><FONT></DIV></FONT></DIV></=
BODY></HTML>

------_=_NextPart_001_01C7FAC0.D34956AC--
