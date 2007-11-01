Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2007 16:07:29 +0000 (GMT)
Received: from mail.domino-printing.com ([64.212.99.82]:20488 "EHLO
	uk-hc-ps3.domino-printing.com") by ftp.linux-mips.org with ESMTP
	id S20025665AbXKAQHV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 1 Nov 2007 16:07:21 +0000
Received: from emea-exchange3.emea.dps.local (unverified) by 
    uk-hc-ps3.domino-printing.com (Clearswift SMTPRS 5.2.9) with ESMTP id 
    <T83086e0e3d40d4635239c@uk-hc-ps3.domino-printing.com> for 
    <linux-mips@linux-mips.org>; Thu, 1 Nov 2007 16:22:26 +0000
Received: from tuxator2.emea.dps.local ([192.168.55.75]) by 
    emea-exchange3.emea.dps.local with Microsoft SMTPSVC(6.0.3790.1830); 
    Thu, 1 Nov 2007 17:04:01 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Put cast inside macro instead of all the callers
Date:	Thu, 1 Nov 2007 17:04:01 +0100
User-Agent: KMail/1.9.7
References: <20071031141124.185599da@ripper.onstor.net>
In-Reply-To: <20071031141124.185599da@ripper.onstor.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200711011704.01079.eckhardt@satorlaser.com>
X-OriginalArrivalTime: 01 Nov 2007 16:04:01.0946 (UTC) 
    FILETIME=[D1C087A0:01C81CA0]
Return-Path: <Eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

I'm by far not a MIPS expert, but I'm puzzled by the code and how it uses 
signed integers for addresses. I just added some comments below, but I'm not 
sure if they are valid. Thank you for any clarification!

On Wednesday 31 October 2007, Andrew Sharp wrote:
> Since all the callers of the PHYS_TO_XKPHYS macro call with a constant,
> put the cast to LL inside the macro where it really should be rather
> than in all the callers.  This makes macros like PHYS_TO_XKSEG_UNCACHED
> work without gcc whining.

I'm not sure if this is always a compile-time constant so that you can adorn 
it with a LL. However, note that this is not a cast, a cast is at runtime.

>  	if (sp >= (long)CKSEG0 && sp < (long)CKSEG2)
>  		usp = CKSEG1ADDR(sp);
>  #ifdef CONFIG_64BIT
> -	else if ((long long)sp >= (long long)PHYS_TO_XKPHYS(0LL, 0) &&
> -		 (long long)sp < (long long)PHYS_TO_XKPHYS(8LL, 0))
> -		usp = PHYS_TO_XKPHYS((long long)K_CALG_UNCACHED,
> +	else if ((long long)sp >= (long long)PHYS_TO_XKPHYS(0, 0) &&
> +		 (long long)sp < (long long)PHYS_TO_XKPHYS(8, 0))
> +		usp = PHYS_TO_XKPHYS(K_CALG_UNCACHED,
>  				     XKPHYS_TO_PHYS((long long)sp));

I'd say this code is broken in way too many aspects:
1. A plethora of casts. PHYS_TO_XKPHYS() should return a physical address 
(i.e. 32 or 64 bits unsigned integer) already, so casting its result should 
not be necessary.
2. Using a signed integer of undefined size for an address. At least use an 
explicit 64 bit unsigned integer (__u64).
3. The use of signed types makes me wonder about intended overflow semantics. 
Just for the record, signed overflow in C causes undefined behaviour, no 
diagnostic required, and recent GCC even assume that no overflow occurs as an 
optimisation!

>  #define PHYS_TO_XKSEG_CACHED(p)		PHYS_TO_XKPHYS(K_CALG_COH_SHAREABLE,(p))
>  #define XKPHYS_TO_PHYS(p)		((p) & TO_PHYS_MASK)
>  #define PHYS_TO_XKPHYS(cm,a)		(_CONST64_(0x8000000000000000) | \
> -					 ((cm)<<59) | (a))
> +					 (_CONST64_(cm)<<59) | (a))

This macro will always(!!!) generate a negative number, is that intended?

Uli
- slightly puzzled -

-- 
Sator Laser GmbH
Geschäftsführer: Michael Wöhrmann, Amtsgericht Hamburg HR B62 932

**************************************************************************************
           Visit our website at <http://www.satorlaser.de/>
**************************************************************************************
Diese E-Mail einschließlich sämtlicher Anhänge ist nur für den Adressaten bestimmt und kann vertrauliche Informationen enthalten. Bitte benachrichtigen Sie den Absender umgehend, falls Sie nicht der beabsichtigte Empfänger sein sollten. Die E-Mail ist in diesem Fall zu löschen und darf weder gelesen, weitergeleitet, veröffentlicht oder anderweitig benutzt werden.
E-Mails können durch Dritte gelesen werden und Viren sowie nichtautorisierte Änderungen enthalten. Sator Laser GmbH ist für diese Folgen nicht verantwortlich.

**************************************************************************************
