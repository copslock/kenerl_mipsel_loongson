Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 21:37:48 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:27089 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20023069AbXJBUhk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Oct 2007 21:37:40 +0100
Received: from volta.aurel32.net ([2001:618:400:fc13:216:d3ff:fe17:fd00])
	by hall.aurel32.net with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1IcoUp-0006Ad-66; Tue, 02 Oct 2007 22:37:35 +0200
Received: from localhost.localdomain ([127.0.0.1] ident=aurel32)
	by volta.aurel32.net with esmtp (Exim 4.67)
	(envelope-from <aurelien@aurel32.net>)
	id 1IcoUq-0004sY-AR; Tue, 02 Oct 2007 22:37:36 +0200
Message-ID: <4702AC0F.1000906@aurel32.net>
Date:	Tue, 02 Oct 2007 22:37:35 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
User-Agent: IceDove 1.5.0.10 (X11/20070328)
MIME-Version: 1.0
To:	qemu-devel@nongnu.org
CC:	linux-mips@linux-mips.org
Subject: Re: [Qemu-devel] QEMU/MIPS & dyntick kernel
References: <20071002200644.GA19140@hall.aurel32.net> <4702A99B.7020008@qumranet.com>
In-Reply-To: <4702A99B.7020008@qumranet.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Avi Kivity a écrit :
> Aurelien Jarno wrote:
>> Hi,
>>
>> As announced by Ralf Baechle, dyntick is now available on MIPS. I gave a
>> try on QEMU/MIPS, and unfortunately it doesn't work correctly.
>>
>> In some cases the kernel schedules an event very near in the future, 
>> which means the timer is scheduled a few cycles only from its current
>> value. Unfortunately under QEMU, the timer runs too fast compared to the
>> speed at which instructions are execution.
> 
> Sounds like a kernel bug.  Can't there conceivably exist real hardware 
> (or a real timeout) that exhibits the same timing?
> 
> Especially today with variable clock frequencies, I don't see how the 
> kernel can rely on exact timing.
> 

Well on real hardware, the instruction rate and the timer are linked:
the timer run at half the speed of the CPU. As the corresponding
assembly code is very small, only uses registers and is run in kernel
mode, you know for sure that 48 cycles is more than enough.

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
