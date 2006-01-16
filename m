Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 15:56:26 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:60689 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133495AbWAPP4I (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jan 2006 15:56:08 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 4D6EA64D54; Mon, 16 Jan 2006 15:59:40 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id A0AA98517; Mon, 16 Jan 2006 15:59:31 +0000 (GMT)
Date:	Mon, 16 Jan 2006 15:59:31 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ed Martini <martini@c2micro.com>
Cc:	linux-mips@linux-mips.org, macro@linux-mips.org
Subject: Re: inconsistent asm macro
Message-ID: <20060116155931.GF26771@deprecation.cyrius.com>
References: <424A04A9.9060703@c2micro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424A04A9.9060703@c2micro.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Ed Martini <martini@c2micro.com> [2005-03-29 17:45]:
> In include/asm-mips/interrupt.h, the definition for local_irq_restore is 
> inconsistent in its use of .reorder/.noreorder assembler directives.  
> Other asm macros in interrupt.h are wrapped with '.set push' and '.set pop'.
> 
> It doesn't seem to be a problem with the 2.96 mipsel-linux- assembler, 
> but it caused me a problem with my 4.0-based toolchain.  (As it was the 
> local_irq_restore left the assembler in 'reorder' mode and a stack 
> pointer post-inc was reordered out of the return delay slot where it 
> belonged.)  Luckily we have a sharp compiler guy who figured it out.  
> Thanks.
> 
> As usual, there may be a reason for this, but it took me a whole day to 
> find it, and I thought I'd point it out.

Maciej, since you use gcc 4, can you please review this patch?

> Ed Martini
> 
> $ diff -uN interrupt.h interrupt-new.h
> --- interrupt.h 2005-03-29 17:35:02.922362384 -0800
> +++ interrupt-new.h     2005-03-29 17:33:26.350770293 -0800
> @@ -100,6 +100,7 @@
> 
> __asm__ (
>        ".macro\tlocal_irq_restore flags\n\t"
> +       ".set\tpush\n\t"
>        ".set\tnoreorder\n\t"
>        ".set\tnoat\n\t"
>        "mfc0\t$1, $12\n\t"
> @@ -109,8 +110,7 @@
>        "or\t\\flags, $1\n\t"
>        "mtc0\t\\flags, $12\n\t"
>        "irq_disable_hazard\n\t"
> -       ".set\tat\n\t"
> -       ".set\treorder\n\t"
> +       ".set\tpop\n\t"
>        ".endm");
> 
> 
> 

-- 
Martin Michlmayr
http://www.cyrius.com/
