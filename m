Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 01:54:31 +0100 (BST)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:41530 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225202AbTDOAya>;
	Tue, 15 Apr 2003 01:54:30 +0100
Received: by trasno.mitica (Postfix, from userid 1001)
	id D4D7C6EB; Tue, 15 Apr 2003 02:54:19 +0200 (CEST)
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] loosing time with CPU counter timer
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20030414171655.G1642@mvista.com> (Jun Sun's message of "Mon,
 14 Apr 2003 17:16:55 -0700")
References: <20030414171655.G1642@mvista.com>
Date: Tue, 15 Apr 2003 02:54:19 +0200
Message-ID: <86ades8ts4.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "jun" == Jun Sun <jsun@mvista.com> writes:

Hi
        only aesthetical fixes:

jun> diff -Nru linux/arch/mips/ddb5xxx/ddb5477/setup.c.orig linux/arch/mips/ddb5xxx/ddb5477/setup.c
jun> --- linux/arch/mips/ddb5xxx/ddb5477/setup.c.orig	Mon Apr 14 15:28:57 2003
jun> +++ linux/arch/mips/ddb5xxx/ddb5477/setup.c	Mon Apr 14 16:08:35 2003
jun> @@ -330,6 +348,16 @@
jun> * high-level timer interrupt service routines.  This function
jun> * is set as irqaction->handler and is invoked through do_IRQ.
jun> */
jun> +static inline int 
jun> +64bit_compare(unsigned hi1, unsigned lo1, unsigned hi2, unsigned lo2)

Please, use "unsigned int" /me notices that file is not consistent, in
some places it uses "unsigned" and in other "unsigned int".

jun> +{
jun> +	if (hi1 == hi2) {
jun> +		return lo1 - lo2;
jun> +	} else {
jun> +		return hi1 - hi2;
jun> +	}
jun> +}

Ralf tax on braces apply here.

jun> +		/* check to see if we have missed a timer interrupt */
jun> +		if (64bit_compare(timerhi, timerlo, expirehi, expirelo) < 0) {
jun> +			unsigned int old_expirelo=expirelo;
jun> +			expirelo += cycles_per_jiffy;
jun> +			expirehi += (expirelo < old_expirelo);

Tax on parens :)

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
