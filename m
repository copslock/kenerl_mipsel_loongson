Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Dec 2003 13:36:47 +0000 (GMT)
Received: from mail.mpc-ogw.co.uk ([IPv6:::ffff:81.2.99.170]:44872 "EHLO
	burton.mpc-data.co.uk") by linux-mips.org with ESMTP
	id <S8225323AbTLINgq>; Tue, 9 Dec 2003 13:36:46 +0000
Received: from lion.mpc-data.co.uk (IDENT:root@lion.mpc-data.co.uk [192.150.92.1])
	by burton.mpc-data.co.uk (8.12.8/8.12.7) with ESMTP id hB9DaLpc027020
	for <linux-mips@linux-mips.org>; Tue, 9 Dec 2003 13:36:23 GMT
Received: from [192.150.92.72] (duvel.mpc-data.co.uk [192.150.92.72])
	by lion.mpc-data.co.uk (8.9.3/8.8.5) with ESMTP id NAA06500
	for <linux-mips@linux-mips.org>; Tue, 9 Dec 2003 13:36:23 GMT
Mime-Version: 1.0 (Apple Message framework v606)
Content-Transfer-Encoding: 7bit
Message-Id: <E3E525EC-2A4C-11D8-AC44-000A959E1510@mpc-data.co.uk>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-mips@linux-mips.org
From: James Cope <jcope@mpc-data.co.uk>
Subject: PCMCIA on AMD Alchemy Au1100 boards
Date: Tue, 9 Dec 2003 13:37:53 +0000
X-Mailer: Apple Mail (2.606)
Return-Path: <jcope@mpc-data.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jcope@mpc-data.co.uk
Precedence: bulk
X-list: linux-mips

Hello,

I was wondering if anyone here can help. I am trying to get PCMCIA 
support working on a board that is very much like the AMD DB1100. Can 
anyone confirm if PCMCIA works on the DB1100? I do not have access to 
one at the moment.

I am using the linux_2_4 tagged kernel from CVS with the
pcmcia-cs-3.1.22 card services package. I have applied the 64bit_pcmcia 
patch to both the kernel and card services code and I have part of the 
PCMCIA system running. I can use the `cardctl' utility to detect the 
presence of PCMCIA cards successfully, however the `cardmgr' daemon 
fails to bind to a socket.

I have a SanDisk Compact Flash card that I'm trying to access. cardmgr 
correctly detects this as an ATA/IDE Fixed Disk and calls `modprobe 
ide_cs.o' which is loading okay. cardmgr then reports the error ``get 
dev info on socket 0 failed: Transport endpoint is not connected'' 
(ENOTCONN).

I can supply more detailed logging and status information if needed, 
but for now I'm wondering if this path has been trodden before? I have 
searched through the linux-mips mail archive, but I have only been able 
to confirm the state of Au1500 PCMCIA support.

Regards,

James Cope
