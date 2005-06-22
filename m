Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jun 2005 16:25:28 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:30985 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225216AbVFVPZM>; Wed, 22 Jun 2005 16:25:12 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 8A3B7F596C; Wed, 22 Jun 2005 17:24:01 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03500-06; Wed, 22 Jun 2005 17:24:01 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 4BE0CE1C9D; Wed, 22 Jun 2005 17:24:01 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5MFNpbE020652;
	Wed, 22 Jun 2005 17:23:51 +0200
Date:	Wed, 22 Jun 2005 16:23:59 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	djohnson+linuxmips@sw.starentnetworks.com
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] various sibyte 2.6.x bugfixes
In-Reply-To: <17081.32401.574987.337795@cortez.sw.starentnetworks.com>
Message-ID: <Pine.LNX.4.61L.0506221616020.4849@blysk.ds.pg.gda.pl>
References: <17081.32401.574987.337795@cortez.sw.starentnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/951/Wed Jun 22 15:28:13 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 22 Jun 2005 djohnson+linuxmips@sw.starentnetworks.com wrote:

> -	if (mask) {
> -		printk("attempted to set irq affinity for irq %d to multiple CPUs\n", irq);
> +	if ((i == NR_CPUS) || (next_cpu(i, mask) != NR_CPUS)) {
> +		printk("attempted to set irq affinity for irq %d to zero/multiple CPUs\n", irq);

 This printk() should be split into two lines.

>  	d->sbdma_dscrtable = (sbdmadscr_t *) 
> -		kmalloc(d->sbdma_maxdescr*sizeof(sbdmadscr_t), GFP_KERNEL);
> +		kmalloc(d->sbdma_maxdescr*sizeof(sbdmadscr_t)+SMP_CACHE_BYTES, GFP_KERNEL);

 Formatting!

> +	/*
> +	 * The descriptor table must be aligned to at least 16 bytes or the
> +	 * MAC will corrupt it. Align it to 32 bytes.
> +	 */

 Why 32 bytes then?  Too much memory left?

> +	if ((unsigned long)d->sbdma_dscrtable & (SMP_CACHE_BYTES-1)) {
> +		(unsigned long)d->sbdma_dscrtable += SMP_CACHE_BYTES - ((unsigned long)d->sbdma_dscrtable & (SMP_CACHE_BYTES-1));
> +	}

 Hmm, there's that generic ALIGN() macro -- you should use it...  
Besides, casts as lvalues are not allowed anymore (and they are hideous 
anyway).

  Maciej
