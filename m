Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Dec 2002 02:44:54 +0000 (GMT)
Received: from p508B5BE3.dip.t-dialin.net ([IPv6:::ffff:80.139.91.227]:44222
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225513AbSLTCox>; Fri, 20 Dec 2002 02:44:53 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBK2ioI21986;
	Fri, 20 Dec 2002 03:44:50 +0100
Date: Fri, 20 Dec 2002 03:44:50 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: for poor sools with old I2 & 64 bits kernel
Message-ID: <20021220034450.A21950@linux-mips.org>
References: <m2el8dixmr.fsf@demo.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m2el8dixmr.fsf@demo.mitica>; from quintela@mandrakesoft.com on Thu, Dec 19, 2002 at 09:04:12PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 19, 2002 at 09:04:12PM +0100, Juan Quintela wrote:

>         this small patch made possible to compile a 64bit kernel for
>         people that have old proms that only accept ecoff.  As usual
>         stolen from the 32 bits version.
> 
>         The easiest way is creating the file in arch/mips/boot,
>         otherwise we need to copy elf2ecoff.c to mips64.

Applied slightly modified.  I removed two other unused targets.

  Ralf
