Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jan 2005 21:18:16 +0000 (GMT)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:31637 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225216AbVAaVSB>; Mon, 31 Jan 2005 21:18:01 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j0VLE7tp012298;
	Mon, 31 Jan 2005 21:14:07 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j0VLE4mB012297;
	Mon, 31 Jan 2005 21:14:04 GMT
Date:	Mon, 31 Jan 2005 21:14:04 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Rishabh@soc-soft.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Problem with HIGHMEM implementation for 32 bit mips-el port
Message-ID: <20050131211404.GC11238@linux-mips.org>
References: <4BF47D56A0DD2346A1B8D622C5C5902C472FE1@soc-mail.soc-soft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BF47D56A0DD2346A1B8D622C5C5902C472FE1@soc-mail.soc-soft.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 31, 2005 at 12:49:53PM +0530, Rishabh@soc-soft.com wrote:

> I am working on MIPS32 port of linux (kernel version 2.4.18) for R4000
> processor. While compilation was fine but the kernel boot up panics in
> "init".

I doubt you're really using an R4000, a 1991 processor which's successor,
the R4400 started shipping in 1993.  Probably you're talking about the
MIPS 4K series instead?

> I have 128MB RAM on the system where 64MB is located at 0x00000000
> physical address and the other 64MB is located at 0x20000000.
> 
> Also how is the address map for mips defined (highmem)?

See <asm/fixmap.h>.  It's basically identical to 32-bit Intel.

  Ralf
