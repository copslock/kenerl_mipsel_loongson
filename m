Received:  by oss.sgi.com id <S305180AbQADXQu>;
	Tue, 4 Jan 2000 15:16:50 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:48935 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305166AbQADXQc>;
	Tue, 4 Jan 2000 15:16:32 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA09616; Tue, 4 Jan 2000 15:12:52 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA72000
	for linux-list;
	Tue, 4 Jan 2000 15:06:36 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA94602
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 4 Jan 2000 15:06:31 -0800 (PST)
	mail_from (kenwills@mailbag.com)
Received: from glacier.binc.net (glacier.binc.net [205.173.176.10]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA03306
	for <linux@cthulhu.engr.sgi.com>; Tue, 4 Jan 2000 15:06:29 -0800 (PST)
	mail_from (kenwills@mailbag.com)
Received: from buzz ([208.137.79.90])
	by glacier.binc.net (8.8.8/8.8.6) with SMTP id RAA06246
	for <linux@cthulhu.engr.sgi.com>; Tue, 4 Jan 2000 17:06:27 -0600
Message-ID: <000d01bf5708$40dbe150$5a4f89d0@tds.net>
Reply-To: "Ken Wills" <kenwills@tds.net>
From:   "Ken Wills" <kenwills@mailbag.com>
To:     <linux@cthulhu.engr.sgi.com>
Subject: general question on linux-mips
Date:   Tue, 4 Jan 2000 17:05:54 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hello everyone!

I have quite a general question, that I hope someone won't mind answering:-

I've installed hard-hat-5.1 on my indy, with few problems, and updated to a
kernel
that supports swap and everything seems fine. Next I decided to update gcc
and binutils,
in order to try later kernel builds (2.3.x). (I'm a long time UNIX user, but
quite new to linux).

My question is: I've had no sucess with gcc-2.95 or any version of binutils
I can lay my hands on.
binutils-2.95 builds with CFLAGS=-g , but then during the build of gcc, I
get an error from as.
Is the only option for software compilation a cross compiler on another
linux box?

I've poured over the web pages and have the cvs repo, which I am about to
start poking around in,
and don't find any specific dos or don'ts.

Thanks,

Ken
kenwills@mailbag.com
