Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2008 09:04:12 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:5014 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20025009AbYHOIEF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 Aug 2008 09:04:05 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KTuHq-0008OI-00; Fri, 15 Aug 2008 10:03:54 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 9FDD4C316F; Fri, 15 Aug 2008 10:03:31 +0200 (CEST)
Date:	Fri, 15 Aug 2008 10:03:31 +0200
To:	C Michael Sundius <Michael.sundius@sciatl.com>
Cc:	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	linux-mips@linux-mips.org, jfraser@broadcom.com,
	Andy Whitcroft <apw@shadowen.org>
Subject: Re: sparsemem support for mips with highmem
Message-ID: <20080815080331.GA6689@alpha.franken.de>
References: <48A4AC39.7020707@sciatl.com> <1218753308.23641.56.camel@nimitz> <48A4C542.5000308@sciatl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48A4C542.5000308@sciatl.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Thu, Aug 14, 2008 at 04:52:34PM -0700, C Michael Sundius wrote:
> +
> +#ifndef CONFIG_64BIT
> +#define SECTION_SIZE_BITS       27	/* 128 MiB */
> +#define MAX_PHYSMEM_BITS        31	/* 2 GiB   */
> +#else
>  #define SECTION_SIZE_BITS       28
>  #define MAX_PHYSMEM_BITS        35
> +#endif

why is this needed ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
