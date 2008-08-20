Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Aug 2008 23:34:30 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:59781 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28586577AbYHTWeV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 Aug 2008 23:34:21 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KVwFv-0001dC-00; Thu, 21 Aug 2008 00:34:19 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id AEA8EC3F13; Thu, 21 Aug 2008 00:33:58 +0200 (CEST)
Date:	Thu, 21 Aug 2008 00:33:58 +0200
To:	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] OCTEON: Add processor-specific constants and detection of CPU variants
Message-ID: <20080820223358.GA9770@alpha.franken.de>
References: <48A9E6DA.8030208@caviumnetworks.com> <1219263605-21396-1-git-send-email-tpaoletti@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1219263605-21396-1-git-send-email-tpaoletti@caviumnetworks.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Wed, Aug 20, 2008 at 01:20:05PM -0700, Tomaso Paoletti wrote:
> --- a/include/asm-mips/bootinfo.h
> +++ b/include/asm-mips/bootinfo.h
> @@ -57,6 +57,11 @@
>  #define	MACH_MIKROTIK_RB532	0	/* Mikrotik RouterBoard 532 	*/
>  #define MACH_MIKROTIK_RB532A	1	/* Mikrotik RouterBoard 532A 	*/
>  
> +/*
> + * Valid machtype for group CAVIUM
> + */
> +#define  MACH_CAVIUM_OCTEON	1	/* Cavium Octeon */
> +

no new machtypes please.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
