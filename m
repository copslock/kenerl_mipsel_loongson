Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA26955 for <linux-archive@neteng.engr.sgi.com>; Tue, 13 Oct 1998 06:44:32 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA03697
	for linux-list;
	Tue, 13 Oct 1998 06:43:41 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA15836
	for <linux@engr.sgi.com>;
	Tue, 13 Oct 1998 06:43:39 -0700 (PDT)
	mail_from (matomira@acm.org)
Received: from link.csem.ch (link.csemne.ch [138.131.145.25]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA08070
	for <linux@engr.sgi.com>; Tue, 13 Oct 1998 06:43:38 -0700 (PDT)
	mail_from (matomira@acm.org)
Received: from exchsrv.csem.ch by link.csem.ch; Tue, 13 Oct 1998 15:44:21 +0200 (MET DST)
X-Url: http://www.csem.ch
Message-Id: <199810131344.PAA20135@link.csem.ch>
Received: from salsa (salsa.csem.ch [138.131.170.33]) by exchsrv.csem.ch with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2232.9)
	id TZMFDD8K; Tue, 13 Oct 1998 15:42:10 +0100
X-Sender: fmm@exchsrv
X-Mailer: QUALCOMM Windows Eudora Pro Version 4.0
Date: Tue, 13 Oct 1998 15:44:13 +0200
To: linux@cthulhu.engr.sgi.com
From: "Fernando D. Mato Mira" <matomira@acm.org>
Subject: Re: I am interested in helping port to Indigo
In-Reply-To: <362274D9.7348FD5C@kotetsu.cubicsky.com>
References: <199810121822.UAA15293@link.csem.ch>
 <199810121822.UAA15293@link.csem.ch>
 <199810121858.UAA15444@link.csem.ch>
Mime-Version: 1.0
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

<html>
At 02:30 PM 10/12/98 -0700, darkaeon wrote:<br>
<br>
&gt;=A0 Perhaps you can supply us with a hinv output and picture of it, as
I<br>
&gt;have never heard of an Indigo with a R4400...<br>
<br>
<font face=3D"Courier New, Courier">1 150 MHZ IP20 Processor<br>
FPU: MIPS R4000 Floating Point Coprocessor Revision: 0.0<br>
CPU: MIPS R4400 Processor Chip Revision: 5.0<br>
On-board serial ports: 2<br>
On-board bi-directional parallel port<br>
Data cache size: 16 Kbytes<br>
Instruction cache size: 16 Kbytes<br>
Secondary unified instruction/data cache size: 1 Mbyte on Processor
0<br>
Main memory size: 256 Mbytes<br>
Integral Ethernet: ec0, version 1<br>
Integral SCSI controller 0: Version WD33C93B, revision C<br>
&nbsp; Tape drive: unit 7 on SCSI controller 0: DAT<br>
&nbsp; Tape drive: unit 6 on SCSI controller 0: QIC 150<br>
&nbsp; CDROM: unit 5 on SCSI controller 0<br>
&nbsp; Disk drive: unit 4 on SCSI controller 0<br>
&nbsp; Disk drive: unit 3 on SCSI controller 0<br>
&nbsp;&nbsp;&nbsp; Disk drive / removable media: unit 2 on SCSI
controller 0: 720K/1.44M floppy<br>
&nbsp; Disk drive: unit 1 on SCSI controller 0<br>
Iris Audio Processor: revision 10<br>
Graphics board: GR2-Elan<br>
<br>
<br>
There're a couple of old pictures att
<a href=3D"http://www.vrai.com/" eudora=3D"autourl">www.vrai.com</a>, but ho=
w
could you tell? :-)<br>
<br>
BTW, 6.2 disk is #3. Used to nvram OSLoadPartition to #1, slide 5.3
in<br>
and compile for MIPS ABI 1.0 . I should still get a big disk for 6.5 dual
boot..<br>
<br>
<br>
<br>
<br>
</font>
<BR>

<font face=3D"Courier New, Courier">Fernando D. Mato
Mira=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>
Real-Time SW Eng &amp; Networking=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>
Advanced Systems Engineering Division<br>
CSEM - Centre Suisse d'Electronique et de
Microtechnique=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>
Jaquet-Droz 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 email:=A0 matomira@acm.org<br>
CH-2007 Neuchatel=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 tel: +41 (32) 720-5157<br>
Switzerland=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 FAX: +41 (32) 720-5720<br>
<br>
</font><a href=3D"http://www.csemne.ch/"=
 eudora=3D"autourl">www.csem.ch</a>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0<a href=3D"http://www.vrai.com/" eudora=3D"autourl">www.vrai.=
com</a>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
<a href=3D"http://ligwww.epfl.ch/matomira.html" eudora=3D"autourl">http://li=
gwww.epfl.ch/matomira.html</a>
</html>
