Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Oct 2009 18:14:46 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45047 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492947AbZJLQOn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Oct 2009 18:14:43 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9CGFvH1021288;
	Mon, 12 Oct 2009 18:15:57 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9CGFuDP021286;
	Mon, 12 Oct 2009 18:15:56 +0200
Date:	Mon, 12 Oct 2009 18:15:56 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Raghu Gandham <raghu@mips.com>
Cc:	linux-mips@linux-mips.org, chris@mips.com
Subject: Re: [PATCH] Fix absd emulation
Message-ID: <20091012161556.GA21183@linux-mips.org>
References: <20090710085057.25841.33067.stgit@linux-raghu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090710085057.25841.33067.stgit@linux-raghu>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 10, 2009 at 01:50:58AM -0700, Raghu Gandham wrote:

> From: Robin Randhawa <robin@mips.com>
> 
> Signed-off-by: Chris Dearman <chris@mips.com>
> ---
> 
>  arch/mips/math-emu/dp_simple.c |   11 ++++-------
>  arch/mips/math-emu/sp_simple.c |    3 ---
>  2 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/mips/math-emu/dp_simple.c b/arch/mips/math-emu/dp_simple.c
> index 1c555e6..6ff4655 100644
> --- a/arch/mips/math-emu/dp_simple.c
> +++ b/arch/mips/math-emu/dp_simple.c
> @@ -76,15 +76,12 @@ ieee754dp ieee754dp_abs(ieee754dp x)
>  	CLEARCX;
>  	FLUSHXDP;
>  
> +	/* Clear sign ALWAYS, irrespective of NaN */
> +	DPSIGN(x) = 0;
> +
>  	if (xc == IEEE754_CLASS_SNAN) {
>  		SETCX(IEEE754_INVALID_OPERATION);
> -		return ieee754dp_nanxcpt(ieee754dp_indef(), "neg");
> +		return ieee754dp_nanxcpt(ieee754dp_indef(), "abs");
>  	}
> -
> -	if (ieee754dp_isnan(x))	/* but not infinity */
> -		return ieee754dp_nanxcpt(x, "abs", x);
> -
> -	/* quick fix up */
> -	DPSIGN(x) = 0;
>  	return x;
>  }

It seems that abs.s needs the same changes except the string constant.  Or
why was only abs.d changed?

(And what is the official behaviour anyway.  It seems I can spend another
quality night over IEEE 754 ...)

> diff --git a/arch/mips/math-emu/sp_simple.c b/arch/mips/math-emu/sp_simple.c
> index 770f0f4..cdec1a2 100644
> --- a/arch/mips/math-emu/sp_simple.c
> +++ b/arch/mips/math-emu/sp_simple.c
> @@ -61,9 +61,6 @@ ieee754sp ieee754sp_neg(ieee754sp x)
>  		SPSIGN(y) = SPSIGN(x);
>  		return ieee754sp_nanxcpt(y, "neg");
>  	}
> -
> -	if (ieee754sp_isnan(x))	/* but not infinity */
> -		return ieee754sp_nanxcpt(x, "neg", x);
>  	return x;
>  }

The subject of the patch was claiming a fix to abs.d but this is fiddling
with neg.s.  And why not the equivalent change to neg.d?

  Ralf
