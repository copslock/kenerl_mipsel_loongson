Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jul 2015 12:35:45 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36720 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009776AbbGQKfnT2UdO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jul 2015 12:35:43 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t6HAZf27012961;
        Fri, 17 Jul 2015 12:35:41 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t6HAZfBZ012960;
        Fri, 17 Jul 2015 12:35:41 +0200
Date:   Fri, 17 Jul 2015 12:35:41 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: math-emu: ieee754int.h: Fix indentation
Message-ID: <20150717103541.GE9084@linux-mips.org>
References: <1437049656-4436-1-git-send-email-markos.chandras@imgtec.com>
 <1437061413-8385-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1437061413-8385-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thu, Jul 16, 2015 at 04:43:33PM +0100, Markos Chandras wrote:

> diff --git a/arch/mips/math-emu/ieee754int.h b/arch/mips/math-emu/ieee754int.h
> index 05389d5e3a93..6383e2c5c1ad 100644
> --- a/arch/mips/math-emu/ieee754int.h
> +++ b/arch/mips/math-emu/ieee754int.h
> @@ -65,8 +65,8 @@ static inline int ieee754_class_nan(int xc)
>  			vc = IEEE754_CLASS_INF;				\
>  		else if (vm & SP_MBIT(SP_FBITS-1))			\
>  			vc = IEEE754_CLASS_SNAN;			\
> -	else								\
> -		vc = IEEE754_CLASS_QNAN;				\
> +		else							\
> +			vc = IEEE754_CLASS_QNAN;			\
>  	} else if (ve == SP_EMIN-1+SP_EBIAS) {				\
>  		if (vm) {						\
>  			ve = SP_EMIN;					\
> @@ -105,8 +105,8 @@ static inline int ieee754_class_nan(int xc)
>  		if (vm) {						\
>  			ve = DP_EMIN;					\
>  			vc = IEEE754_CLASS_DNORM;			\
> -	} else								\
> -		vc = IEEE754_CLASS_ZERO;				\
> +		} else							\
> +			vc = IEEE754_CLASS_ZERO;			\
>  	} else {							\
>  		ve -= DP_EBIAS;						\
>  		vm |= DP_HIDDEN_BIT;					\

Looks correct but the the first segment duplicates
https://patchwork.linux-mips.org/patch/10732/ so I'm applying only
the 2nd segment.

Thanks,

  Ralf
