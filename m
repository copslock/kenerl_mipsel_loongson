Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 16:35:22 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:51147 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225329AbSLRQfV>; Wed, 18 Dec 2002 16:35:21 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA09424;
	Wed, 18 Dec 2002 17:35:26 +0100 (MET)
Date: Wed, 18 Dec 2002 17:35:26 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Juan Quintela <quintela@mandrakesoft.com>
cc: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH]: make highmem only things enclosed in the right #ifdef
In-Reply-To: <m2k7i8qezg.fsf@demo.mitica>
Message-ID: <Pine.GSO.3.96.1021218173132.5977B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 18 Dec 2002, Juan Quintela wrote:

> +#ifdef CONFIG_HIGHMEM
>  	unsigned long vaddr;
> -	pgd_t *pgd, *pgd_base;
>  	pmd_t *pmd;
>  	pte_t *pte;
> -
> +	pgd_t *pgd, pgd_base;
> +#endif
>  	/* Initialize the entire pgd.  */
>  	pgd_init((unsigned long)swapper_pg_dir);

 Please don't change the spacing this way -- it worsens readability. 
Check other pathes for cases like this, too. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
