Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id EAA31885
	for <pstadt@stud.fh-heilbronn.de>; Mon, 30 Aug 1999 04:17:30 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA02323; Sun, 29 Aug 1999 19:14:36 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA47429
	for linux-list;
	Sun, 29 Aug 1999 19:05:13 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA65491
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 29 Aug 1999 19:05:10 -0700 (PDT)
	mail_from (simba@secns.sec.samsung.co.kr)
Received: from network.sec.samsung.co.kr (secns.sec.samsung.co.kr [168.219.201.3]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA07616
	for <linux@cthulhu.engr.sgi.com>; Sun, 29 Aug 1999 19:05:08 -0700 (PDT)
	mail_from (simba@secns.sec.samsung.co.kr)
Received: from simba.samsung.co.kr ([168.219.244.175])
	by network.sec.samsung.co.kr (8.8.8H1/8.8.8) with SMTP id LAA21892
	for <linux@cthulhu.engr.sgi.com>; Mon, 30 Aug 1999 11:14:16 +0900 (KST)
Received: by simba.samsung.co.kr with Microsoft Mail
	id <01BEF2D8.16818FC0@simba.samsung.co.kr>; Mon, 30 Aug 1999 11:09:11 +0900
Message-ID: <01BEF2D8.16818FC0@simba.samsung.co.kr>
From: simba <simba@secns.sec.samsung.co.kr>
To: "'linux@cthulhu.engr.sgi.com'" <linux@cthulhu.engr.sgi.com>
Subject: rpm: precompiled binary install error
Date: Mon, 30 Aug 1999 11:09:10 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 8bit

I downloaded precompiled binary for Linux/i386 from ftp.linux.sgi.com the mips-howto refer to.
When I install that dependency error occured.

#rpm -ivh binutils-mips-linux-2.8.2-1.i386.rpm
failed dependencies
	libc.so.6(GLIBC_2.1) is needed by binutils-mips-linux-2.8.1-1
	libc.so.6(GLIBC_2.0) is needed by binutils-mips-linux-2.8.1-1

how can I install?
