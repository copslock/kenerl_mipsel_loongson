Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 May 2011 11:24:39 +0200 (CEST)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60808 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491144Ab1EHJYg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 May 2011 11:24:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=IUndsoD6xAL7Vws6YsrpZkfoP8BKP4c8hIlYddhG+5o=;
        b=LNjmFi8a8Cnz3iX1r1c8ceb0fiYeeOh6q2cwTc2mTQ/TpE0cVao3K6bVV9AigxrObkIds47KJCnHwr0zwKUOTefUbN2s8UsSIkqcJQ8qiihsYGXoiuBYocoRwC5RdpOA/BplZKNzhivy2Eee9IQXXfCLDD2vaXVB35WHb4Hbfhw=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1QJ0De-0003fn-FA; Sun, 08 May 2011 10:24:07 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.72)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1QJ0Dc-0007XK-Ds; Sun, 08 May 2011 10:24:04 +0100
Date:   Sun, 8 May 2011 10:24:03 +0100
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org, linux-m32r@ml.linux-m32r.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-cris-kernel@axis.com, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, x86@kernel.org,
        Chris Metcalf <cmetcalf@tilera.com>,
        David Howells <dhowells@redhat.com>,
        linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] atomic: add *_dec_not_zero
Message-ID: <20110508092403.GB27807@n2100.arm.linux.org.uk>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Tue, May 03, 2011 at 11:30:35PM +0200, Sven Eckelmann wrote:
> Introduce an *_dec_not_zero operation.  Make this a special case of
> *_add_unless because batman-adv uses atomic_dec_not_zero in different
> places like re-broadcast queue or aggregation queue management. There
> are other non-final patches which may also want to use this macro.
...
> diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
> index 7e79503..a005265 100644
> --- a/arch/arm/include/asm/atomic.h
> +++ b/arch/arm/include/asm/atomic.h
> @@ -218,6 +218,7 @@ static inline int atomic_add_unless(atomic_t *v, int a, int u)
>  	return c != u;
>  }
>  #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
> +#define atomic_dec_not_zero(v) atomic_add_unless((v), -1, 0)
>  
>  #define atomic_inc(v)		atomic_add(1, v)
>  #define atomic_dec(v)		atomic_sub(1, v)
> @@ -459,6 +460,7 @@ static inline int atomic64_add_unless(atomic64_t *v, u64 a, u64 u)
>  #define atomic64_dec_return(v)		atomic64_sub_return(1LL, (v))
>  #define atomic64_dec_and_test(v)	(atomic64_dec_return((v)) == 0)
>  #define atomic64_inc_not_zero(v)	atomic64_add_unless((v), 1LL, 0LL)
> +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1LL, 0LL)
>  
>  #else /* !CONFIG_GENERIC_ATOMIC64 */
>  #include <asm-generic/atomic64.h>

Do we need atomic_dec_not_zero() et.al. in every arch header - is there no
generic header which it could be added to?
