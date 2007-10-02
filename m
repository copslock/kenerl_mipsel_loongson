Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 21:57:37 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:35767 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20023478AbXJBU53 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Oct 2007 21:57:29 +0100
Received: from volta.aurel32.net ([2001:618:400:fc13:216:d3ff:fe17:fd00])
	by hall.aurel32.net with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1Iconz-0006Rx-GP; Tue, 02 Oct 2007 22:57:23 +0200
Received: from localhost.localdomain ([127.0.0.1] ident=aurel32)
	by volta.aurel32.net with esmtp (Exim 4.67)
	(envelope-from <aurelien@aurel32.net>)
	id 1Icoo0-0004vB-Fi; Tue, 02 Oct 2007 22:57:24 +0200
Message-ID: <4702B0B4.6080909@aurel32.net>
Date:	Tue, 02 Oct 2007 22:57:24 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
User-Agent: IceDove 1.5.0.10 (X11/20070328)
MIME-Version: 1.0
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
CC:	qemu-devel@nongnu.org, linux-mips@linux-mips.org
Subject: Re: [Qemu-devel] QEMU/MIPS & dyntick kernel
References: <20071002200644.GA19140@hall.aurel32.net>	<4702A99B.7020008@qumranet.com>	<4702AC0F.1000906@aurel32.net> <20071002214826.7ee2fae8@the-village.bc.nu>
In-Reply-To: <20071002214826.7ee2fae8@the-village.bc.nu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Alan Cox a écrit :
>> Well on real hardware, the instruction rate and the timer are linked:
>> the timer run at half the speed of the CPU. As the corresponding
>> assembly code is very small, only uses registers and is run in kernel
>> mode, you know for sure that 48 cycles is more than enough.
> 
> What happens on NMI or if you take an ECC exception and scrubbing stall
> off the memory controller while loading part of that cache line of code
> into memory ?
> 

The code returns -ETIME, and the function is run again with the minimum
delay.

So as long as you don't have an exception every time, the code works.

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
