Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 22:59:32 +0000 (GMT)
Received: from p508B5DCD.dip.t-dialin.net ([IPv6:::ffff:80.139.93.205]:30378
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225382AbSLRW7b>; Wed, 18 Dec 2002 22:59:31 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBIMxRU01245;
	Wed, 18 Dec 2002 23:59:27 +0100
Date: Wed, 18 Dec 2002 23:59:27 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: linux mips mailing list <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: correct format string in dump_tlb
Message-ID: <20021218235927.A1132@linux-mips.org>
References: <m2wum8p0dy.fsf@demo.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m2wum8p0dy.fsf@demo.mitica>; from quintela@mandrakesoft.com on Wed, Dec 18, 2002 at 02:43:37AM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 18, 2002 at 02:43:37AM +0100, Juan Quintela wrote:

>         if we cast to unsigned it, print it as a long is a no-no :(

Correct but I didn't like your patch ...

> -	printk("page == %08lx\n", (unsigned int) pte_val(page));
> +	printk("page == %08x\n", (unsigned int) pte_val(page));

pte_val() returns unsigned long.  So I applied a different fix.

  Ralf
