Received:  by oss.sgi.com id <S553781AbQK3Fro>;
	Wed, 29 Nov 2000 21:47:44 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:57889 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S553771AbQK3FrT>;
	Wed, 29 Nov 2000 21:47:19 -0800
Received: from sgisgp.singapore.sgi.com (sgisgp.singapore.sgi.com [134.14.84.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id VAA08449
	for <linux-mips@oss.sgi.com>; Wed, 29 Nov 2000 21:47:17 -0800 (PST)
	mail_from (calvine@sgi.com)
Received: from sgp-apsa001e--n.singapore.sgi.com by sgisgp.singapore.sgi.com via ESMTP (950413.SGI.8.6.12/930416.SGI)
	for <linux-mips@oss.sgi.com> id NAA11287; Thu, 30 Nov 2000 13:56:58 +0800
Received: by sgp-apsa001e--n.singapore.sgi.com with Internet Mail Service (5.5.2650.21)
	id <XQ01WLTK>; Thu, 30 Nov 2000 13:50:36 +0800
Message-ID: <43FECA7CDC4CD411A4A3009027999112267CAA@sgp-apsa001e--n.singapore.sgi.com>
From:   Calvine Chew <calvine@sgi.com>
To:     "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: I'm stuck...
Date:   Thu, 30 Nov 2000 13:50:35 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi folks.

I'm trying to get Linux up on an Indy. I'm using an old laptop to act as the
tftp/bootp/nfs server. I've installed
SuSE 6.4 on it and I am not sure if I've configured the server properly. I
try tftp'ing and bootp'ing from the server
side, and both seem to respond to requests, however, when I try from the
Indy client, the Indy just shoots back
a "server not found for vmlinux" when I do "boot -f bootp():vmlinux".

How do I ensure that things on the server side are indeed configured
properly? Are there proper tests I can do?
For example, if I run "bootpd -s -d4" then run "bootptest", bootpd reports
back a large number of things like
sending the linux kernel I exported via NFS, and something about a magic
number, then bootptest quits. tftp
at the server side allows me to download files from the NFS directory.

I already have numerous copies of readmes teaching me how to install Linux
on MIPS, but somehow all of them
vary in many ways, especially the config parts. Is there some install readme
for super-idiots like myself who need
to be told word for word what to do?

If anyone can help, I'll gladly offer more detailed info, like config data
and such. Thanks alot!

--
Calvine Chew, Technical Consultant
Technology & Industry Consulting Group (Asia South), SGI.
***************************************************************
Inter spem curamque, timores inter et iras, omnem crede diem tibi
diluxisse supremum: grata superveniet quae sperabitur hora.
http://www.cyberjunkie.com/arcana
***************************************************************
