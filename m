Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Oct 2011 12:39:56 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:1362 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491881Ab1JCKjj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Oct 2011 12:39:39 +0200
X-TM-IMSS-Message-ID: <51c099400001312a@netlogicmicro.com>
Received: from hqcas01.netlogicmicro.com ([10.10.50.14]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0; TLS: TLSv1/SSLv3,128bits,AES128-SHA) id 51c099400001312a ; Mon, 3 Oct 2011 03:39:29 -0700
Date:   Mon, 3 Oct 2011 16:09:36 +0530
From:   Jayachandran C. <jayachandranc@netlogicmicro.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Hillf Danton <dhillf@gmail.com>, <linux-mips@linux-mips.org>
Subject: Re: [RFC] mark Netlogic XLR chip as SMT capable
Message-ID: <20111003103935.GA6016@jayachandranc.netlogicmicro.com>
References: <CAJd=RBAc8Zv1JZfrAx2Ajj7fdJv=oA+eYHVBLfcFNOoZNyG7fg@mail.gmail.com>
 <20111002083044.GA23668@jayachandranc.netlogicmicro.com>
 <CAJd=RBBt0xNgUrz9XnU0TcHo443t3j323zYg8jMPYRjXsV=EHw@mail.gmail.com>
 <20111003103204.GC6038@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20111003103204.GC6038@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 03 Oct 2011 10:39:29.0363 (UTC) FILETIME=[BABA2A30:01CC81B8]
X-archive-position: 31202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 955

On Mon, Oct 03, 2011 at 11:32:04AM +0100, Ralf Baechle wrote:
> On Mon, Oct 03, 2011 at 01:46:46PM +0800, Hillf Danton wrote:
> 
> > +	unsigned int cpu, core_id;
> > +
> > +	cpu = smp_processor_id();
> > +	core_id = (cpu >> 2) & 0x7;
> > +	cpu_data[cpu].core = core_id;
> 
> This is going to break in setups where Linux is not being booted on
> what the hardware considers CPU core 0.  Which is not uncommon in embedded
> setups.  You may want to probe the hardware for the core ID rather than
> relying on smp_processor_id() here.

Yes, the function hard_smp_processor_id() from netlogic/mips-extns.h has to
be used here.

This also conflicts with the recent patch-set for XLP support, but I don't
know the status of that yet.

JC.
