Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2003 12:16:14 +0100 (BST)
Received: from p508B58ED.dip.t-dialin.net ([IPv6:::ffff:80.139.88.237]:4562
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225233AbTD1LQM>; Mon, 28 Apr 2003 12:16:12 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3SBG5c31693;
	Mon, 28 Apr 2003 13:16:05 +0200
Date: Mon, 28 Apr 2003 13:16:05 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, nemoto@toshiba-tops.co.jp
Subject: Re: c-tx39.c build fix
Message-ID: <20030428131605.A23461@linux-mips.org>
References: <20030428.191304.71084037.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030428.191304.71084037.nemoto@toshiba-tops.co.jp>; from anemo@mba.ocn.ne.jp on Mon, Apr 28, 2003 at 07:13:04PM +0900
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 28, 2003 at 07:13:04PM +0900, Atsushi Nemoto wrote:

> --- linux-mips-cvs/arch/mips/mm/c-tx39.c	Mon Apr 28 09:44:52 2003
> +++ linux.new/arch/mips/mm/c-tx39.c	Mon Apr 28 19:07:45 2003
> @@ -26,7 +26,8 @@
>  /* For R3000 cores with R4000 style caches */
>  static unsigned long icache_size, dcache_size;		/* Size in bytes */
>  static unsigned long icache_way_size, dcache_way_size;	/* Size divided by ways */
> -extern long scache_size;
> +#define scache_size 0
> +#define scache_way_size 0

Not beautyful ...  but as you can imagine c-tx39.c is another candidate
for eventual integration into c-r4k.c, so applied.

  Ralf
