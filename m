Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Dec 2005 15:34:20 +0000 (GMT)
Received: from mail.gmx.de ([213.165.64.21]:45233 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S8133454AbVLPPeB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Dec 2005 15:34:01 +0000
Received: (qmail 12550 invoked by uid 0); 16 Dec 2005 15:34:36 -0000
Received: from 129.13.186.1 by www10.gmx.net with HTTP;
	Fri, 16 Dec 2005 16:34:36 +0100 (MET)
Date:	Fri, 16 Dec 2005 16:34:36 +0100 (MET)
From:	madprops@gmx.net
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Subject: Timer interrupts
X-Priority: 3 (Normal)
X-Authenticated: #24801140
Message-ID: <2987.1134747276@www10.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-Path: <madprops@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: madprops@gmx.net
Precedence: bulk
X-list: linux-mips

Hi,

i'm using CP0_Count/CP0_Compare to get timer interrupts. They should be
turned off while being in kernel mode (performing syscalls / handling
tlb-misses etc) and enabled in user mode. 

Whenever a timer interrupt happens in kernel mode, the exception should be
delayed until it is switched back to the user. Up to now I set
CP0_Status(IE) to zero when entering the kernel. Does this allow pending
interrupts or are incoming interrupts totally ignored then ??

The problem that might arise (in the second case) is that CP0_Count reaches
and passes CP0_Compare while interrupts are turned off. Back in user mode,
the running user process would get an unacceptable excessive time slice.

Thanks,

Thomas





-- 
Telefonieren Sie schon oder sparen Sie noch?
NEU: GMX Phone_Flat http://www.gmx.net/de/go/telefonie
