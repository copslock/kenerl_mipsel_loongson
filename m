Received:  by oss.sgi.com id <S305162AbQAaNsq>;
	Mon, 31 Jan 2000 05:48:46 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:33047 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305160AbQAaNsU>;
	Mon, 31 Jan 2000 05:48:20 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id FAA16882; Mon, 31 Jan 2000 05:46:44 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA74066
	for linux-list;
	Mon, 31 Jan 2000 05:38:57 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA11739
	for <linux@engr.sgi.com>;
	Mon, 31 Jan 2000 05:38:53 -0800 (PST)
	mail_from (jori@lumumba.luc.ac.be)
Received: from lumumba.luc.ac.be (lumumba.luc.ac.be [193.190.9.252]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id FAA07723
	for <linux@engr.sgi.com>; Mon, 31 Jan 2000 05:38:48 -0800 (PST)
	mail_from (jori@lumumba.luc.ac.be)
Received: (qmail 15094 invoked from network); 31 Jan 2000 13:38:32 -0000
Received: from lumumba.luc.ac.be (jori@193.190.9.252)
  by lumumba.luc.ac.be with SMTP; 31 Jan 2000 13:38:32 -0000
Date:   Mon, 31 Jan 2000 14:38:32 +0100 (CET)
From:   Jori <jori@lumumba.luc.ac.be>
To:     linux@cthulhu.engr.sgi.com
Subject: Kernel
Message-ID: <Pine.LNX.4.10.10001311432260.14943-100000@lumumba.luc.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hello,

I've recently downloaded the hardhat distribution and installed it without
much problems. But the kernel (2.1.100) which comes with the distribution
seems to crash after a day or so. So I tried to compile some other
kernels, but this seems to be a lot trickier than on a i386: I've only
succeeded in compiling a few kernels, of which only one actually worked
(linux-19991209.tar.gz from ftp.linux.sgi.com). Well, 'worked' doens't
really describe what it does, since it seems to be pretty buggy kernel:
Page faults, bus errors,... 
Now, my question is: can I get a stable kernel somewhere ?

Bye,
Jori
