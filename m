Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2003 22:47:42 +0100 (BST)
Received: from p508B6792.dip.t-dialin.net ([IPv6:::ffff:80.139.103.146]:46566
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225072AbTDHVrm>; Tue, 8 Apr 2003 22:47:42 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h38LlZV09029;
	Tue, 8 Apr 2003 23:47:35 +0200
Date: Tue, 8 Apr 2003 23:47:35 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Hartvig Ekner <hartvig@ekner.info>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Aliasing in pgtable-bits.h (CONFIG_64BIT_PHYS_ADDR)
Message-ID: <20030408234735.A7363@linux-mips.org>
References: <3E9274F0.227008F7@ekner.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E9274F0.227008F7@ekner.info>; from hartvig@ekner.info on Tue, Apr 08, 2003 at 09:06:24AM +0200
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 08, 2003 at 09:06:24AM +0200, Hartvig Ekner wrote:

> #define _PAGE_R4KBUG                (1<<0)  /* workaround for r4k bug  */
> #define _PAGE_GLOBAL                (1<<0)
> 
> Is the aliasing between R4KBUG & GLOBAL intentional? This is the only CONFIG case where it
> is done. Superficially, I can't see R4KBUG used anywhere, so maybe it doesn't matter. But
> if R4KBUG truly isn't used, why not consider removing it entirely from all PTE layouts?

It's there for a R4000 bug workaround waiting to be finally written by
somebody ...

  Ralf
