Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2011 16:03:39 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:60965 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903663Ab1KHPDf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Nov 2011 16:03:35 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA8F3X5Y003865;
        Tue, 8 Nov 2011 15:03:33 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA8F3XGA003864;
        Tue, 8 Nov 2011 15:03:33 GMT
Date:   Tue, 8 Nov 2011 15:03:33 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 7/9] MIPS: BMIPS: Introduce bmips.h
Message-ID: <20111108150333.GA1491@linux-mips.org>
References: <c2c8833593cb8eeef5c102468e105497@localhost>
 <1c70a0e0f9e1a3967b60c4c2d1ec99bd@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c70a0e0f9e1a3967b60c4c2d1ec99bd@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6794

On Sat, Nov 05, 2011 at 02:21:16PM -0700, Kevin Cernekee wrote:

> +static inline unsigned long bmips_read_zscm_reg(unsigned int offset)
> +{
> +	unsigned long ret;
> +
> +	cache_op(Index_Load_Tag_S, ZSCM_REG_BASE + offset);
> +
> +	__asm__ __volatile__(
> +		".set push\n"
> +		".set noreorder\n"
> +		"sync\n"
> +		"ssnop\n"
> +		"ssnop\n"
> +		"ssnop\n"
> +		"ssnop\n"
> +		"ssnop\n"
> +		"ssnop\n"
> +		"ssnop\n"
> +		"mfc0 %0, $28, 3\n"
> +		"ssnop\n"
> +		".set pop\n"
> +		: "=&r" (ret) : : "memory");

Is it critical that the C compiler or assembler can't reorder anything to
in between the cache_op and the inline asm statement?  If so, I'd
recommend to put the cache instruction into the asm as well.

> +static inline void bmips_write_zscm_reg(unsigned int offset, unsigned long data)
> +{
> +	__write_32bit_c0_register($28, 3, data);
> +	back_to_back_c0_hazard();
> +	cache_op(Index_Store_Tag_S, ZSCM_REG_BASE + offset);
> +	back_to_back_c0_hazard();

back_to_back_c0_hazard() is meant as the hazard barrier between a write
followed immediately by a read from the same cp0 register:

	mtc0	$reg1, $12
	mfc0	$reg2, $12

On various MIPS processors this instruction sequence would result in
undefined operation such as the mfc0 instruction reading the value of
$12 before the mtc0 or even next week's lucky lottery numbers..

I think we don't really have a type of hazard barrier defined in hazard.h
and this seems a rather special purpose use so I suggest you just open
code whatever needs to be done.

  Ralf
