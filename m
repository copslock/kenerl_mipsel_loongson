Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id PAA23110
	for <pstadt@stud.fh-heilbronn.de>; Mon, 30 Aug 1999 15:56:34 +0200
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id GAA07117; Mon, 30 Aug 1999 06:51:59 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA85226
	for linux-list;
	Mon, 30 Aug 1999 06:43:47 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA18403
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 30 Aug 1999 06:43:43 -0700 (PDT)
	mail_from (thomas@baltic-ins-services.net)
Received: from gatekeeper.baltic-ins-services.net (gatekeeper.baltic-ins-services.net [195.100.160.130]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA00610
	for <linux@cthulhu.engr.sgi.com>; Mon, 30 Aug 1999 06:43:21 -0700 (PDT)
	mail_from (thomas@baltic-ins-services.net)
Received: from zoo ([192.168.0.200])
	by gatekeeper.baltic-ins-services.net (8.9.3/8.9.3) with SMTP id QAA16624
	for <linux@cthulhu.engr.sgi.com>; Mon, 30 Aug 1999 16:39:52 +0200 (CEST)
Message-ID: <000901bef2ed$cab2d0c0$c800a8c0@balticinsservices.net>
From: "Thomas Berg" <thomas@baltic-ins-services.net>
To: <linux@cthulhu.engr.sgi.com>
Subject: crosscompiler
Date: Mon, 30 Aug 1999 15:44:32 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Hello everyone!

I've been trying to set up a crosscompiler but it seems I've run out of
luck..

binutils(2.8.1 + recommended patch) builds and installs fine
egcs(1.0.3a + recommended patch) first installation builds and installs

glibc(2.0.6 + addon libs) doesnt come close to building
( [root@sushi build]# CC=mips-linux-gcc BUILD_CC=gcc AR=mips-linux-ar
RANLIB=mips-linux-ranlib
../configure --prefix=/usr --host=mips -linux --enable-add-ons=crypt,linuxth
reads,localedata --enable-profile )

I have tried this setup on a i386 redhat box (6.0) and on sparc running
solaris 7, and taken great care to follow the instructions in the howto.

The patch that is used on glibc-2.0.6 in the Linux/MIPS HOWTO is no where to
be found ? ie glibc-2.0.6-mips.patch

Anyone got a clue what im doing wrong ? (also tried to use the precompiled
packages of binutils/egcs etc, no luck there either)

best regards,
Thomas Berg
thomas@baltic-ins-services.net
