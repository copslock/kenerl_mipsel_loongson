Received:  by oss.sgi.com id <S42280AbQFMKQY>;
	Tue, 13 Jun 2000 03:16:24 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:10599 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42186AbQFMKQG>; Tue, 13 Jun 2000 03:16:06 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id EAA06818
	for <linux-mips@oss.sgi.com>; Tue, 13 Jun 2000 04:21:07 -0700 (PDT)
	mail_from (Huseyin@sgi.com)
Received: from relay.istanbul.sgi.com (relay.istanbul.sgi.com [144.253.232.2])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA30010
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 13 Jun 2000 04:15:36 -0700 (PDT)
	mail_from (Huseyin@sgi.com)
Received: from nt-emea-trbdc.istanbul.sgi.com (nt-emea-trbdc.istanbul.sgi.com [144.253.232.21]) by relay.istanbul.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA04066 for <linux@cthulhu.engr.sgi.com>; Tue, 13 Jun 2000 14:15:30 +0300 (MDT)
Received: by nt-emea-trbdc.istanbul.sgi.com with Internet Mail Service (5.5.2650.21)
	id <L6RWPC7L>; Tue, 13 Jun 2000 14:15:39 +0300
Message-ID: <9496A27F9004D411AF890090278610F3017001@nt-emea-trbdc.istanbul.sgi.com>
From:   Huseyin Sasmaz <Huseyin@sgi.com>
To:     linux@cthulhu.engr.sgi.com
Subject: Problem on booting linux on Indy
Date:   Tue, 13 Jun 2000 14:15:38 +0300
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01BFD528.B42A6A70"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01BFD528.B42A6A70
Content-Type: text/plain;
	charset="windows-1254"



I would like to install the redhat 5.1 to my indy. I am getting the
following error messages after the vmlinux is booted ;

Looking up port of RPC 100003/2 on 144.253.232.3  <----- This my bootp
server and nfs server which is O2.
sendmsg returned error 128
..
..
..
portmap server 144.253.232.3 not responding, timed out.

Then Indy panics

Your help will be appreciated,


Thansk in advance


Huseyin

 <<Huseyin Sasmaz (E-mail).vcf>> 

------_=_NextPart_000_01BFD528.B42A6A70
Content-Type: application/octet-stream;
	name="Huseyin Sasmaz (E-mail).vcf"
Content-Disposition: attachment;
	filename="Huseyin Sasmaz (E-mail).vcf"

BEGIN:VCARD
VERSION:2.1
N:Sasmaz;Huseyin
FN:Huseyin Sasmaz (E-mail)
ORG:SGI
TITLE:Customer Support Manager
TEL;WORK;VOICE:+90 (216) 361 71 81
TEL;WORK;FAX:+90 (216) 361 71 76
ADR;WORK;ENCODING=QUOTED-PRINTABLE:;Istanbul;Ucgen Plaza, Cayiryolu Sokak.=0D=0ANo.7 Kat.13;Istanbul;;81120;Tur=
key
LABEL;WORK;ENCODING=QUOTED-PRINTABLE:Istanbul=0D=0AUcgen Plaza, Cayiryolu Sokak.=0D=0ANo.7 Kat.13=0D=0AIstanbul 8=
1120=0D=0ATurkey
EMAIL;PREF;INTERNET:Huseyin@sgi.com
REV:20000612T081952Z
END:VCARD

------_=_NextPart_000_01BFD528.B42A6A70--
