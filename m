Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 21:23:15 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:62451 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225198AbTBTVXP>;
	Thu, 20 Feb 2003 21:23:15 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h1KLN0227558;
	Thu, 20 Feb 2003 13:23:00 -0800
Date: Thu, 20 Feb 2003 13:23:00 -0800
From: Jun Sun <jsun@mvista.com>
To: Brian Murphy <brian@murphy.dk>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [PATCH] allow CROSS_COMPILE override
Message-ID: <20030220132300.I7466@mvista.com>
References: <20030220124703.H7466@mvista.com> <3E55455A.8080403@murphy.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E55455A.8080403@murphy.dk>; from brian@murphy.dk on Thu, Feb 20, 2003 at 10:15:06PM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


Is this allowed?  Can't find any such usage in kernel other
than the worrisome comment below:

arch/arm/Makefile:# Grr, ?= doesn't work as all the other assignment operators do.  Make bug?


Jun

On Thu, Feb 20, 2003 at 10:15:06PM +0100, Brian Murphy wrote:
> Jun Sun wrote:
> 
> >Anybody would object this?  It allows one to override
> >
> Why not but this is less messy:
> 
> --- arch/mips/Makefile  13 Dec 2002 23:41:09 -0000      1.1.1.8
> +++ arch/mips/Makefile  20 Feb 2003 21:10:30 -0000
> @@ -23,7 +23,7 @@
>  endif
>  
>  ifdef CONFIG_CROSSCOMPILE
> -CROSS_COMPILE  = $(tool-prefix)
> +CROSS_COMPILE ?= $(tool-prefix)
>  endif
>  
>  #
> 
> /Brian
> 
