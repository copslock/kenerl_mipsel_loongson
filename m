Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 21:57:33 +0000 (GMT)
Received: from crack.them.org ([IPv6:::ffff:65.125.64.184]:22761 "EHLO
	crack.them.org") by linux-mips.org with ESMTP id <S8225208AbTBTV5d>;
	Thu, 20 Feb 2003 21:57:33 +0000
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 18m0aH-0001ur-00; Thu, 20 Feb 2003 17:58:33 -0600
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 18lyh4-00089E-00; Thu, 20 Feb 2003 16:57:26 -0500
Date: Thu, 20 Feb 2003 16:57:26 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] allow CROSS_COMPILE override
Message-ID: <20030220215725.GA31222@nevyn.them.org>
References: <20030220124703.H7466@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220124703.H7466@mvista.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 20, 2003 at 12:47:03PM -0800, Jun Sun wrote:
> Anybody would object this?  It allows one to override
> CROSS_COMPILE from command line or top-level Makefile.
> 
> Jun
> 

Silly question: why does this matter if CROSS_COMPILE is on the command
line?  Command line definitions override anything in the makefile.  Is
it falling off the command line in a recursive make?

> diff -Nru linux/arch/mips/Makefile.orig linux/arch/mips/Makefile
> --- linux/arch/mips/Makefile.orig	Thu Feb 20 10:49:18 2003
> +++ linux/arch/mips/Makefile	Thu Feb 20 12:18:53 2003
> @@ -23,7 +23,9 @@
>  endif
>  
>  ifdef CONFIG_CROSSCOMPILE
> -CROSS_COMPILE	= $(tool-prefix)
> +  ifndef CROSS_COMPILE
> +    CROSS_COMPILE	= $(tool-prefix)
> +  endif
>  endif
>  
>  #


-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
