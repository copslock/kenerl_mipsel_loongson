Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2014 10:01:41 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59900 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6855120AbaHSIAgQyXbZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Aug 2014 10:00:36 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7J80YBa020530;
        Tue, 19 Aug 2014 10:00:34 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7J80YMI020529;
        Tue, 19 Aug 2014 10:00:34 +0200
Date:   Tue, 19 Aug 2014 10:00:34 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: IP28: Correct IO_BASE in mach-ip28/spaces.h for
 proper ioremap
Message-ID: <20140819080034.GA11547@linux-mips.org>
References: <53F2BC86.8000506@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53F2BC86.8000506@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Mon, Aug 18, 2014 at 10:55:02PM -0400, Joshua Kinard wrote:

> --- a/arch/mips/include/asm/mach-ip28/spaces.h
> +++ b/arch/mips/include/asm/mach-ip28/spaces.h
> @@ -18,7 +18,7 @@
>  #define PHYS_OFFSET	_AC(0x20000000, UL)
> 
>  #define UNCAC_BASE	_AC(0xc0000000, UL)     /* 0xa0000000 + PHYS_OFFSET */
> -#define IO_BASE		UNCAC_BASE
> +#define IO_BASE		_AC(0x9000000000000000, UL)
> 
>  #include <asm/mach-generic/spaces.h>

I think the real culprit is not the definition of IO_BASE but of
UNCAC_BASE.  0xc0000000UL is KSEG2 for a 32 bit kernel - but for a 64 bit
kernel UNCAC_BASE should be defined as _AC(0x9000000000000000, UL).

Which are the defaults in <asm/mach-generic/spaces.h> so just deleting
both UNCAC_BASE and IO_BASE from mach-ip28/spaces.h should fix things?

  Ralf
