Received:  by oss.sgi.com id <S42240AbQEYQV4>;
	Thu, 25 May 2000 09:21:56 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:33918 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42238AbQEYQVb>; Thu, 25 May 2000 09:21:31 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id KAA01852; Thu, 25 May 2000 10:26:11 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA59657
	for linux-list;
	Thu, 25 May 2000 10:14:39 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA63783
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 25 May 2000 10:14:33 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA00348
	for <linux@cthulhu.engr.sgi.com>; Thu, 25 May 2000 10:14:31 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port2.duesseldorf.ivm.de [195.247.65.2])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id TAA07680;
	Thu, 25 May 2000 19:14:22 +0200
X-To:   linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.000525191403.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20000525015843.A7991@uni-koblenz.de>
Date:   Thu, 25 May 2000 19:14:03 +0200 (CEST)
Reply-To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: CVS Update@oss.sgi.com: linux
Cc:     SGI Linux <linux@cthulhu.engr.sgi.com>,
        Linux MIPS <linux-mips@fnet.fr>, Klaus Naumann <spock@mgnet.de>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


On 24-May-00 Ralf Baechle wrote:
[offset.h]

> A good solution is important now that we have SMP.  Toggling CONFIG_SMP
> affects offset.h and not for all variations of make invocations we
> actually have the guarantee that offset.h is being rebuilt before using
> it.

What about making offset.h to depend on $(TOPDIR)/.config?

This may cause unneccessary rebuilds of objects depending on offset.h after
configuration changes but it forces offset.h to be rebuilt when CONFIG_SMP is
toggled.

For example:
--- Makefile.old        Thu May 25 19:05:08 2000
+++ Makefile    Thu May 25 19:08:48 2000
@@ -18,7 +18,7 @@
 offset.h: offset.s
        sed -n '/^@@@/s///p' $^ >$@
 
-offset.s: offset.c
+offset.s: offset.c $(TOPDIR)/.config
 
 clean:
        rm -f offset.[hs] $(TARGET).new                                         

-- 
Regards,
Harald
