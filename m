Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 May 2006 04:26:18 +0200 (CEST)
Received: from mail.gmx.de ([213.165.64.21]:48601 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S8133393AbWE0C0K (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 27 May 2006 04:26:10 +0200
Received: (qmail invoked by alias); 27 May 2006 02:26:04 -0000
Received: from 5354180C.cable.casema.nl (EHLO [192.168.1.60]) [83.84.24.12]
  by mail.gmx.net (mp040) with SMTP; 27 May 2006 04:26:04 +0200
X-Authenticated: #11016536
Message-ID: <4477B8C9.3050909@gmx.net>
Date:	Sat, 27 May 2006 04:26:17 +0200
From:	Tom Weustink <freshy98@gmx.net>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: SGI O2+ RM7000 set_uncached_handler error during kernel built
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Return-Path: <freshy98@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freshy98@gmx.net
Precedence: bulk
X-list: linux-mips

Hello,

I finally got a round building a toolchain for creating kernels for my 
SGI O2+ RM7000 machine.

I did a ip32_defconfig and used menuconfig to edit some small options.
One was to set it too RM7000 obviously.

When I build it, I get the following error:

  CC      arch/mips/kernel/traps.o
arch/mips/kernel/traps.c: In function `set_uncached_handler':
arch/mips/kernel/traps.c:1360: error: `TO_PHYS_MASK' undeclared (first 
use in this function)

When I build it for R5000 (only that changed in menuconfig) the compile 
runs without a problem.

Checking arch/mips/kernel/traps.c:1360 shows that installs the uncached 
CPU exception handler to UNCAC.
Now I know the RM7000 is kinda weird, but shouldn't it just work on it 
since it does work on R5000 since it's MIPS64?

I also heard from `Kumba that the kernel won't boot at all due to a bug 
in IP32 so that it hangs extremely early, but having it to just built 
would be nice for me atm.

Regards,

Tom

PS: if I need to supply any additional information, let me know!
