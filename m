Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2003 22:11:01 +0000 (GMT)
Received: from mail.deltartp.com ([IPv6:::ffff:216.166.210.181]:62474 "EHLO
	dprn03.deltartp.com") by linux-mips.org with ESMTP
	id <S8225211AbTA0WLA>; Mon, 27 Jan 2003 22:11:00 +0000
Received: by dprn03.deltartp.com with Internet Mail Service (5.5.2653.19)
	id <DM946DJH>; Mon, 27 Jan 2003 16:53:38 -0500
Message-ID: <A4E787A2467EF849B00585F14C9005590689D3@dprn03.deltartp.com>
From: Chien-Lung Wu <cwu@deltartp.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: mips cross-compiler
Date: Mon, 27 Jan 2003 16:53:38 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <cwu@deltartp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cwu@deltartp.com
Precedence: bulk
X-list: linux-mips

Hi,
I am trying to install a mips-linux cross compiler on my linux box with
	target=mips-linux
	host=i686-linux

 I download the rpm files
	binutils-mips-linux-2.8.1-1-i386.rpm
	egcs-mips-linux-1.0.3a-2.i386.rpm
	glibc-2.1.95.1.mips.rpm
from ftp://oss.sgi.com/pub/linux/mips

When I use rpm comand to install binutils and egcs, they work fine.
	rpm -i binutils-mips-linux-2.8.1-1-i386.rpm
	rpm -i egcs-mips-linux-1.0.3a-2.i386.rpm

However, as I intsall the glibc with the rpm command:
	rpm -i glibc-2.1.95.1.mips.rpm

I got a confliction with glibc-common-2.2.4-13, since my native glibc is
2.2.4-13. Thus I cannot install glibc.

Can anybody show me how to install the cross-compiler correctly? (what is
the correct rpm command?)

More questions:
If I have native glibc, can I install another glibc for cross-compiler?
Can I install the binutils-mips-linux-2.8.1-1 to a specific path?  How?
( when I install them with rpm -i command, the executable files will go to
/usr/bin as default. Can I change that?)

Thanks for your help.

Chien-Lung
