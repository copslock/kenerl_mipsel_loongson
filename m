Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2004 01:32:12 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:50448 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225209AbUJKAcI>; Mon, 11 Oct 2004 01:32:08 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 2F8C6F5945; Mon, 11 Oct 2004 02:32:05 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12010-09; Mon, 11 Oct 2004 02:32:05 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id E4BE1E1D01; Mon, 11 Oct 2004 02:32:04 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.12.11) with ESMTP id i9B0WKlV012154;
	Mon, 11 Oct 2004 02:32:20 +0200
Date: Mon, 11 Oct 2004 01:32:06 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Pete Popov <ppopov@embeddedalley.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: PATCH
In-Reply-To: <1097452888.4627.25.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58L.0410110126120.4217@blysk.ds.pg.gda.pl>
References: <1097452888.4627.25.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 10 Oct 2004, Pete Popov wrote:

> diff -u -r1.13 addrspace.h
> --- include/asm-mips/addrspace.h	30 Nov 2003 01:52:25 -0000	1.13
> +++ include/asm-mips/addrspace.h	19 Sep 2004 22:51:28 -0000
> @@ -80,7 +80,11 @@
>  #define XKSSEG			0x4000000000000000
>  #define XKPHYS			0x8000000000000000
>  #define XKSEG			0xc000000000000000
> +#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
> +#define CKSEG0			0x80000000
> +#else
>  #define CKSEG0			0xffffffff80000000
> +#endif
>  #define CKSEG1			0xffffffffa0000000
>  #define CKSSEG			0xffffffffc0000000
>  #define CKSEG3			0xffffffffe0000000

 This looks suspicious, please explain.

  Maciej
