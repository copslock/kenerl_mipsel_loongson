Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Nov 2008 09:58:41 +0000 (GMT)
Received: from mx3.mail.elte.hu ([157.181.1.138]:63398 "EHLO mx3.mail.elte.hu")
	by ftp.linux-mips.org with ESMTP id S23849237AbYKWJ6e (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 23 Nov 2008 09:58:34 +0000
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1L4BjQ-00078M-Rz
	from <mingo@elte.hu>; Sun, 23 Nov 2008 10:58:21 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id D47FD3E21A5; Sun, 23 Nov 2008 10:58:14 +0100 (CET)
Date:	Sun, 23 Nov 2008 10:58:18 +0100
From:	Ingo Molnar <mingo@elte.hu>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Make BUG() __noreturn.
Message-ID: <20081123095818.GU30453@elte.hu>
References: <49260E4C.8080500@caviumnetworks.com> <20081121150023.032f7b5b.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081121150023.032f7b5b.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Return-Path: <mingo@elte.hu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Andrew Morton <akpm@linux-foundation.org> wrote:

> > +static inline void __noreturn BUG(void)
> > +{
> > +	__asm__ __volatile__("break %0" : : "i" (BRK_BUG));
> > +	/* Fool GCC into thinking the function doesn't return. */
> > +	while (1)
> > +		;
> > +}
> 
> This kind of sucks, doesn't it?  It adds instructions into the 
> kernel text, very frequently on fast paths.  Those instructions are 
> never executed, and we're blowing away i-cache just to quash 
> compiler warnings.
> 
> For example, this:
> 
> --- a/arch/x86/include/asm/bug.h~a
> +++ a/arch/x86/include/asm/bug.h
> @@ -22,14 +22,12 @@ do {								\
>  		     ".popsection"				\
>  		     : : "i" (__FILE__), "i" (__LINE__),	\
>  		     "i" (sizeof(struct bug_entry)));		\
> -	for (;;) ;						\
>  } while (0)
>  
>  #else
>  #define BUG()							\
>  do {								\
>  	asm volatile("ud2");					\
> -	for (;;) ;						\
>  } while (0)
>  #endif
>  
> _
> 
> reduces the size of i386 mm/vmalloc.o text by 56 bytes.

yes - the total image effect is significantly - recently looked at how 
much larger !CONFIG_BUG builds would get if we inserted an infinite 
loop into them - it was in the 50K text range (!).

but in the x86 ud2 case we could guarantee that we wont ever return 
from that exception. Mind sending a patch with a signoff, a 
description and an infinite loop in the u2d handler?

	Ingo
