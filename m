Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2005 12:12:42 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:59922 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225407AbVIALMU>; Thu, 1 Sep 2005 12:12:20 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j81BIatH006356;
	Thu, 1 Sep 2005 12:18:36 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j81BIas9006355;
	Thu, 1 Sep 2005 12:18:36 +0100
Date:	Thu, 1 Sep 2005 12:18:36 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Cc:	linux-cvs-patches@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050901111836.GD2876@linux-mips.org>
References: <20050901085634Z8225385-3678+8053@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050901085634Z8225385-3678+8053@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 01, 2005 at 09:56:30AM +0100, ths@linux-mips.org wrote:

> diff -urN linux/include/asm-mips/mach-ip22/spaces.h linux/include/asm-mips/mach-ip22/spaces.h
> --- linux/include/asm-mips/mach-ip22/spaces.h	2005/07/14 12:05:11	1.3
> +++ linux/include/asm-mips/mach-ip22/spaces.h	2005/09/01 08:56:18	1.4
> @@ -44,7 +44,7 @@
>  #define CAC_BASE		0xffffffff80000000
>  #define IO_BASE			0xffffffffa0000000
>  #define UNCAC_BASE		0xffffffffa0000000
> -#define MAP_BASE		0xffffffffc0000000
> +#define MAP_BASE		0xc000000000000000

You just broke the R5000.

  Ralf
