Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jun 2009 10:23:11 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45270 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491937AbZFQIXD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Jun 2009 10:23:03 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5H8LITW014913;
	Wed, 17 Jun 2009 09:21:18 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5H8LIvu014911;
	Wed, 17 Jun 2009 09:21:18 +0100
Date:	Wed, 17 Jun 2009 09:21:18 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Tim Anderson <tanderson@mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 4/5] Move gcmp_probe to before the SMP ops
Message-ID: <20090617082118.GC13467@linux-mips.org>
References: <20090617000035.GG6346@shomer.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090617000035.GG6346@shomer.az.mvista.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 16, 2009 at 05:00:35PM -0700, Tim Anderson wrote:

> @@ -358,10 +361,16 @@ void __init prom_init(void)
>  #ifdef CONFIG_SERIAL_8250_CONSOLE
>  	console_config();
>  #endif
> +	/* Early detection of CMP support */
> +	result = gcmp_probe(GCMP_BASE_ADDR, GCMP_ADDRSPACE_SZ);
> +
>  #ifdef CONFIG_MIPS_CMP
> -	register_smp_ops(&cmp_smp_ops);
> +	if (result) register_smp_ops(&cmp_smp_ops);

Keep the register_smp_ops on a separate line.

>  #endif
>  #ifdef CONFIG_MIPS_MT_SMP
> +#ifdef CONFIG_MIPS_CMP
> +	if (!result)
> +#endif
>  	register_smp_ops(&vsmp_smp_ops);

Suggested rewrite for readability and to silence checkpatch:

#ifdef CONFIG_MIPS_CMP
	if (!result)
		register_smp_ops(&vsmp_smp_ops);
#else
	register_smp_ops(&vsmp_smp_ops);
#endif

  Ralf
