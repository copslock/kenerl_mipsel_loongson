Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2006 18:20:36 +0100 (BST)
Received: from buzzloop.caiaq.de ([212.112.241.133]:63241 "EHLO
	buzzloop.caiaq.de") by ftp.linux-mips.org with ESMTP
	id S8133506AbWFWRU0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Jun 2006 18:20:26 +0100
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 944AA7F4028
	for <linux-mips@linux-mips.org>; Fri, 23 Jun 2006 19:20:23 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 31929-06 for <linux-mips@linux-mips.org>;
	Fri, 23 Jun 2006 19:20:23 +0200 (CEST)
Received: from [192.168.1.140] (port-83-236-238-37.static.qsc.de [83.236.238.37])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by buzzloop.caiaq.de (Postfix) with ESMTP id 465C27F4022
	for <linux-mips@linux-mips.org>; Fri, 23 Jun 2006 19:20:23 +0200 (CEST)
Mime-Version: 1.0 (Apple Message framework v750)
Content-Transfer-Encoding: 7bit
Message-Id: <5B414347-B938-4E68-812E-627AED1A38B0@caiaq.de>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To:	linux-mips@linux-mips.org
From:	Daniel Mack <daniel@caiaq.de>
Subject: smc91x ethernet an DBAU1200
Date:	Fri, 23 Jun 2006 19:20:19 +0200
X-Mailer: Apple Mail (2.750)
Return-Path: <daniel@caiaq.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@caiaq.de
Precedence: bulk
X-list: linux-mips

Hi list,

is there anyone out there successfully using the SMC 91C111 ethernet  
chip
on AMD's DBAU1200 eval kit? In my setup here, it's working fine from  
within
the YAMON boot loader so I can use it to download a kernel image via  
TFTP.
The kernel (bleeding edge linux-2.6 mips-GIT) detects the device as well

	smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
	eth0: SMC91C11xFD (rev 1) at b9000300 IRQ 65 [nowait]
	eth0: Ethernet addr: 00:00:1a:19:11:8c

and is able to mount its root filesystem via NFS. However, the  
communication
does not seem to be sufficiently stable, messages like this occur  
regularily:

	nfs: server 192.168.1.200 not responding, still trying
	nfs: server 192.168.1.200 not responding, still trying

As the machine acts as NFS server for several other linux embedded  
systems,
I don't suspect it to be the problem. Also, things like cables etc  
have been
properly checked.

Before I'm starting research, I'd like to know whether this is a known
issue or whether there are any mandatory settings I missed.

Thanks for any hint,
Daniel
