Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jun 2003 09:05:50 +0100 (BST)
Received: from ol.freeshell.org ([IPv6:::ffff:192.94.73.20]:63725 "EHLO
	sdf.lonestar.org") by linux-mips.org with ESMTP id <S8224802AbTFSJXr>;
	Thu, 19 Jun 2003 10:23:47 +0100
Received: from webmail.freeshell.org (IDENT:nobody@norge.freeshell.org [192.94.73.3])
	by sdf.lonestar.org (8.12.9/8.12.8) with SMTP id h5J9NR8O018283
	for <linux-mips@linux-mips.org>; Thu, 19 Jun 2003 09:23:27 GMT
Received: from ac8e253e.ipt.aol.com ([172.142.37.62])
        (SquirrelMail authenticated user nicholse)
        by webmail.freeshell.org with HTTP;
        Thu, 19 Jun 2003 02:23:27 -0700 (PDT)
Message-ID: <33820.172.142.37.62.1056014607.squirrel@webmail.freeshell.org>
Date: Thu, 19 Jun 2003 02:23:27 -0700 (PDT)
Subject: Sony WebTV Nevada rm5230-167q
From: nicholse@sdf.lonestar.org
To: linux-mips@linux-mips.org
Reply-To: nicholse@sdf.lonestar.org
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Return-Path: <nicholse@sdf.lonestar.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2682
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nicholse@sdf.lonestar.org
Precedence: bulk
X-list: linux-mips

Spelling/Grammer
If your serious, here is some feedback on spelling grammer.
http://linux.junsun.net/porting-howto/
do a grep diff on these lines
--
You can find much help on this if you are not very comfortable.
Most of the stuff is being moved
may leave bugs there for quite a long time
 and the machine used to
Kgdb can be enormously helpful for your development. Definitely recommended.
--
I can start at chapter two tomorrow if you really want the practice.

My needs:
linux-mips@linux-mips.org
Sony WebTV Nevada rm5230-167q
What kind of work would it require to bootstrap the kernel from Sony WebTV
Pro Model INT-W200, 167MHz, the modem is a 56K flex, 8megs of RAM, a IDE
Seagate 1.1 GB hardrive and there is a cable/TV tuner. This unit has a
WebTV Port (SCSI?). The drives partitions are not recognized by fdisk. The
keyboard is IRDA, no external ps2 port but solder connections to put one
in. Should I try to read the bootsector hexdata? Could we burn a new ROM?
How would I do a ROM dump? QED Quantum website inst avaliable, are there
docs and specs?
This should be fun...
Eric
