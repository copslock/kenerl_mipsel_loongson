Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 13:53:22 +0000 (GMT)
Received: from p508B5DCD.dip.t-dialin.net ([IPv6:::ffff:80.139.93.205]:54708
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225446AbSLSNxV>; Thu, 19 Dec 2002 13:53:21 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBJDrHo25296;
	Thu, 19 Dec 2002 14:53:17 +0100
Date: Thu, 19 Dec 2002 14:53:17 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: unaligned
Message-ID: <20021219145317.A25281@linux-mips.org>
References: <m27ke6mgux.fsf@demo.mitica> <20021219143115.A24914@linux-mips.org> <m27ke6jemo.fsf@demo.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m27ke6jemo.fsf@demo.mitica>; from quintela@mandrakesoft.com on Thu, Dec 19, 2002 at 02:57:03PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 19, 2002 at 02:57:03PM +0100, Juan Quintela wrote:

> ralf> Making emulate_load_store take a void * as the address argument was much
> ralf> nicer instead.
> 
> I didn't wanted to touch asm() parts yet :)

No need to touch them.  My patch was just a two line change to unaligned.c.

  Ralf
