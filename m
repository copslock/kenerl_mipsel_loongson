Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jun 2009 10:16:06 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:40372 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491937AbZFQIP7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Jun 2009 10:15:59 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5H8EEZG014753;
	Wed, 17 Jun 2009 09:14:14 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5H8ECmE014751;
	Wed, 17 Jun 2009 09:14:12 +0100
Date:	Wed, 17 Jun 2009 09:14:12 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Tim Anderson <tanderson@mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] Extend IPI handling to CPU number
Message-ID: <20090617081412.GB13467@linux-mips.org>
References: <20090616235828.GE6346@shomer.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090616235828.GE6346@shomer.az.mvista.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 16, 2009 at 04:58:28PM -0700, Tim Anderson wrote:

> diff --git a/arch/mips/kernel/irq-gic.c b/arch/mips/kernel/irq-gic.c
> index 1d6ac92..5cf003d 100644
> --- a/arch/mips/kernel/irq-gic.c
> +++ b/arch/mips/kernel/irq-gic.c
> @@ -245,6 +245,10 @@ static void __init gic_basic_init(void)
>  		if (cpu == X)
>  			continue;
>  
> +		if (cpu == 0 && i != 0 && _intrmap[i].intrnum == 0 &&
> +			 _intrmap[i].ipiflag == 0)
                        ^
                        wrong indentation

> +			continue;
> +

  Ralf
