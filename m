Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5OD0inC028090
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 06:00:44 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5OD0hV6028089
	for linux-mips-outgoing; Mon, 24 Jun 2002 06:00:43 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dprn03.deltartp.com (mail.deltartp.com [216.166.210.181])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5OD0cnC028085
	for <linux-mips@oss.sgi.com>; Mon, 24 Jun 2002 06:00:39 -0700
Received: by dprn03.deltartp.com with Internet Mail Service (5.5.2653.19)
	id <MV64VPCF>; Mon, 24 Jun 2002 08:54:01 -0400
Message-ID: <A4E787A2467EF849B00585F14C900559068906@dprn03.deltartp.com>
From: Chien-Lung Wu <cwu@deltartp.com>
To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Cc: Chien-Lung Wu <cwu@deltartp.com>
Subject: cross-compiler
Date: Mon, 24 Jun 2002 08:54:00 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,
I try to buils a cross-comipler in my linux box (build=i386-mips) with
host=windowNT, and target=linux-mips. But it is not successful.

I use the following tar-ball as base: (The newest one)
	a. binutils (2.11.2)
	b. gcc 3.1
	c. glibc 2.2.5

As a newbie in linux embedded system, could anyone kindly show me "HOWTO"
build up a cross-compiler in general and specifically for MIPS (IDT
R32334/32332)?

If you know any good stuffs in building cross-compiler and porting Linux to
MIPS, please send me the web-side or pointers. Thanks in advance.

Regards,

Chien-Lung

***********************************************************************
Chien-Lung Wu                                 TEL: 919-767-3903
Sr. Software Engineer                        FAX: 919-767-2458
DataCom Lab of Delta Network Inc..    e-mail: cwu@deltartp.com
***********************************************************
