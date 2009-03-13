Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Mar 2009 09:29:22 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:55473 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20807695AbZCMJ3P (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Mar 2009 09:29:15 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1Li3ha-0001YX-00; Fri, 13 Mar 2009 10:29:14 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 2B1F2DE3ED; Fri, 13 Mar 2009 10:29:07 +0100 (CET)
Date:	Fri, 13 Mar 2009 10:29:07 +0100
To:	VomLehn <dvomlehn@cisco.com>
Cc:	Linux MIPS Mailing List <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH][MIPS] Use CP0 Count register to implement more granular ndelay
Message-ID: <20090313092906.GA6526@alpha.franken.de>
References: <20090312032850.GA9379@cuplxvomd02.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090312032850.GA9379@cuplxvomd02.corp.sa.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Wed, Mar 11, 2009 at 08:28:50PM -0700, VomLehn wrote:
>  #
> +# Collect various processors by instruction family
> +#
> +config MIPS1
> +	bool
> +	default y if CPU_R3000 || CPU_TX39XX
> +
> +config MIPS2
> +	bool
> +	default y if CPU_R6000
> +
> +config MIPS3
> +	bool
> +	default y if CPU_LOONGSON2 || CPU_R4300 || CPU_R4X00 || CPU_TX49XX || \
> +		CPU_VR41XX
> +
> +config MIPS4
> +	bool
> +	default y if CPU_R8000 || CPU_R10000
> +

what about all the R5k CPUs ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
