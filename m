Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 13:31:21 +0000 (GMT)
Received: from p508B5DCD.dip.t-dialin.net ([IPv6:::ffff:80.139.93.205]:35508
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225443AbSLSNbU>; Thu, 19 Dec 2002 13:31:20 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBJDVFT24939;
	Thu, 19 Dec 2002 14:31:15 +0100
Date: Thu, 19 Dec 2002 14:31:15 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: unaligned
Message-ID: <20021219143115.A24914@linux-mips.org>
References: <m27ke6mgux.fsf@demo.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m27ke6mgux.fsf@demo.mitica>; from quintela@mandrakesoft.com on Thu, Dec 19, 2002 at 11:40:38AM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 19, 2002 at 11:40:38AM +0100, Juan Quintela wrote:

>         - asm wants a unsigned long
>         - verify_area wants a void *
> one of the two places need a cast.

Making emulate_load_store take a void * as the address argument was much
nicer instead.

> Once there, ralf? forgot that emulate_load_store returns void, then
> nuke the return 1 part.

Already did that.

  Ralf
