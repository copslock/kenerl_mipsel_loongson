Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2008 14:42:13 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:26546 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20035206AbYFMNmL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Jun 2008 14:42:11 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5DDfkhq008204;
	Fri, 13 Jun 2008 14:41:46 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5DDfiYi008185;
	Fri, 13 Jun 2008 14:41:44 +0100
Date:	Fri, 13 Jun 2008 14:41:44 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Pelton, Dave" <dpelton@ciena.com>
Cc:	"J.Ma" <sync.jma@gmail.com>, Markus Gothe <markus.gothe@27m.se>,
	linux-mips@linux-mips.org
Subject: Re: [SPAM] linux-2.6.25.4 Porting OOPS
Message-ID: <20080613134143.GE703@linux-mips.org>
References: <dcf6addc0806082001m19d54184pc8ab42b0875c5238@mail.gmail.com> <20B109E2-594E-4329-95C7-F67E9A7882E2@27m.se> <dcf6addc0806120251t4785dc09tc4a6f0854c5cd425@mail.gmail.com> <A3BA2251DD85404FBBEF7478C29D8742F26EFE@onmxm01.ciena.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A3BA2251DD85404FBBEF7478C29D8742F26EFE@onmxm01.ciena.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 12, 2008 at 03:02:31PM -0400, Pelton, Dave wrote:

> --- linux-2.6.25.4-clean/include/asm-mips/fixmap.h      2008-05-15
> 11:00:12.000000000 -0400
> +++ linux-2.6.25.4/include/asm-mips/fixmap.h    2008-06-12
> 13:21:49.042673000 -0400
> @@ -69,6 +69,8 @@ enum fixed_addresses {
>   */
>  #if defined(CONFIG_CPU_TX39XX) || defined(CONFIG_CPU_TX49XX)
>  #define FIXADDR_TOP    ((unsigned long)(long)(int)(0xff000000 -
> 0x20000))
> +#elif defined(CONFIG_CPU_BMIPS3300)
> +#define FIXADDR_TOP    ((unsigned long)(long)(int)0xff200000 - 0x1000)
>  #else
>  #define FIXADDR_TOP    ((unsigned long)(long)(int)0xfffe0000)
>  #endif
> 
> You will need to define CONFIG_CPU_BMIPS3300 in your config file for
> this change to be applied.  I suspect that the same core is present in
> a number of Broadcom SOC designs, so this issue may exist for a number
> of different chips.

There are a few other processors such as some TX4900 family members which
use up some virtual address space without telling telling the OS.  In any
case I consider that a blatant violation fo the architecture and the
kernel should be tought about these special cases.

  Ralf
