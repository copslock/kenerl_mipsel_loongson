Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6GF30Rw032273
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 16 Jul 2002 08:03:00 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6GF30Ia032272
	for linux-mips-outgoing; Tue, 16 Jul 2002 08:03:00 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft17-f125.dialo.tiscali.de [62.246.17.125])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6GF2rRw032263
	for <linux-mips@oss.sgi.com>; Tue, 16 Jul 2002 08:02:55 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6GF7f419786;
	Tue, 16 Jul 2002 17:07:41 +0200
Date: Tue, 16 Jul 2002 17:07:41 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Pete Popov <ppopov@mvista.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: PATCH
Message-ID: <20020716170741.E31186@dea.linux-mips.net>
References: <1026772150.15665.145.camel@zeus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1026772150.15665.145.camel@zeus.mvista.com>; from ppopov@mvista.com on Mon, Jul 15, 2002 at 03:29:10PM -0700
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 15, 2002 at 03:29:10PM -0700, Pete Popov wrote:

> --- include/asm-mips/pgtable.h.old	Fri Jul 12 17:25:19 2002
> +++ include/asm-mips/pgtable.h	Fri Jul 12 17:25:36 2002
> @@ -332,7 +332,9 @@
>  
>  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  {
> -	return __pte(((pte).pte_low & _PAGE_CHG_MASK) | pgprot_val(newprot));
> +	pte.pte_low &= _PAGE_CHG_MASK;
> +	pte.pte_low |= pgprot_val(newprot);
> +	return pte;
>  }

This patch certainly doesn't apply to oss.  Seems somebody did copy all
the x86 pte_t and stuff into your tree without too much thinking ...

  Ralf
