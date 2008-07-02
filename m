Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2008 11:00:07 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:33258 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S62065451AbYGBKAB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Jul 2008 11:00:01 +0100
Received: from lagash (88-106-136-149.dynamic.dsl.as9105.com [88.106.136.149])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id B485B48916;
	Wed,  2 Jul 2008 11:59:57 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1KDz80-0001q7-4o; Wed, 02 Jul 2008 10:59:56 +0100
Date:	Wed, 2 Jul 2008 10:59:56 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Morten Larsen <mlarsen@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Bug in atomic_sub_if_positive
Message-ID: <20080702095955.GA7007@networkno.de>
References: <ADD7831BD377A74E9A1621D1EAAED18F0450AC61@NT-SJCA-0750.brcm.ad.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ADD7831BD377A74E9A1621D1EAAED18F0450AC61@NT-SJCA-0750.brcm.ad.broadcom.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Morten Larsen wrote:
> 
> > As far as I can tell the branch optimization fixes in 2.6.21 introduced
> > a bug in atomic_sub_if_positive that causes it to return even when the
> > sc instruction fails. The result is that e.g. down_trylock becomes
> > unreliable as the semaphore counter is not always decremented.
> 
> Previous patch was garbled by Outlook - this one should be clean:
> 
> --- a/include/asm-mips/atomic.h	2008-06-25 22:38:43.159739000 -0700
> +++ b/include/asm-mips/atomic.h	2008-06-25 22:39:07.552065000 -0700
> @@ -292,10 +292,10 @@ static __inline__ int atomic_sub_if_posi
>  		"	beqz	%0, 2f					\n"
>  		"	 subu	%0, %1, %3				\n"
>  		"	.set	reorder					\n"
> -		"1:							\n"
>  		"	.subsection 2					\n"
>  		"2:	b	1b					\n"
>  		"	.previous					\n"
> +		"1:							\n"

AFAICS this change should make no difference to the generated code. I
suspect you assembler handles .subsection incorrectly. Can you provide
a disassembled exapmle which gets altered by this patch? Also, please
tell us the exact version of the assembler you use.


Thiemo
