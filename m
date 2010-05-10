Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 May 2010 16:50:02 +0200 (CEST)
Received: from mv-drv-hcb003.ocn.ad.jp ([118.23.109.133]:53064 "EHLO
        mv-drv-hcb003.ocn.ad.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492283Ab0EJOtz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 May 2010 16:49:55 +0200
Received: from vcmba.ocn.ne.jp (localhost.localdomain [127.0.0.1])
        by mv-drv-hcb003.ocn.ad.jp (Postfix) with ESMTP id 987E256421D;
        Mon, 10 May 2010 23:49:49 +0900 (JST)
Received: from localhost (softbank221040169135.bbtec.net [221.40.169.135])
        by vcmba.ocn.ne.jp (Postfix) with ESMTP;
        Mon, 10 May 2010 23:49:49 +0900 (JST)
Date:   Mon, 10 May 2010 23:49:46 +0900 (JST)
Message-Id: <20100510.234946.229279777.anemo@mba.ocn.ne.jp>
To:     chris@mips.com
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix abs.[sd] and neg.[sd] emulation for NaN operands
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20091012215718.30362.67068.stgit@localhost.localdomain>
References: <20091012215522.30362.49399.stgit@localhost.localdomain>
        <20091012215718.30362.67068.stgit@localhost.localdomain>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Excuse me for too late comment.

On Mon, 12 Oct 2009 14:57:18 -0700, Chris Dearman <chris@mips.com> wrote:
> From: Nigel Stephens <nigel@mips.com>
> 
> This patch ensures that the sign bit is always updated
> for NaN operands.
...
> @@ -76,15 +74,12 @@ ieee754dp ieee754dp_abs(ieee754dp x)
>  	CLEARCX;
>  	FLUSHXDP;
>  
> +	/* Clear sign ALWAYS, irrespective of NaN */
> +	DPSIGN(x) = 0;
> +
>  	if (xc == IEEE754_CLASS_SNAN) {
> -		SETCX(IEEE754_INVALID_OPERATION);
> -		return ieee754dp_nanxcpt(ieee754dp_indef(), "neg");
> +		return ieee754dp_nanxcpt(ieee754dp_indef(), "abs");
>  	}
>  
> -	if (ieee754dp_isnan(x))	/* but not infinity */
> -		return ieee754dp_nanxcpt(x, "abs", x);
> -
> -	/* quick fix up */
> -	DPSIGN(x) = 0;
>  	return x;
>  }

Is there any reason for removal of SETCX(IEEE754_INVALID_OPERATION)
line here?

The older version of this fix ("Fix absd emulation" by Raghu Gandham)
did not remove the line.

Without this line, a signaling NaN will not raise a signal.  It seems
not expected behaviour.

---
Atsushi Nemoto
