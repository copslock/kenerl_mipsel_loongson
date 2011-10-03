Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Oct 2011 12:32:10 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52337 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491871Ab1JCKcG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Oct 2011 12:32:06 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p93AW47W012644;
        Mon, 3 Oct 2011 11:32:04 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p93AW4cX012642;
        Mon, 3 Oct 2011 11:32:04 +0100
Date:   Mon, 3 Oct 2011 11:32:04 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Hillf Danton <dhillf@gmail.com>
Cc:     "Jayachandran C." <jayachandranc@netlogicmicro.com>,
        linux-mips@linux-mips.org
Subject: Re: [RFC] mark Netlogic XLR chip as SMT capable
Message-ID: <20111003103204.GC6038@linux-mips.org>
References: <CAJd=RBAc8Zv1JZfrAx2Ajj7fdJv=oA+eYHVBLfcFNOoZNyG7fg@mail.gmail.com>
 <20111002083044.GA23668@jayachandranc.netlogicmicro.com>
 <CAJd=RBBt0xNgUrz9XnU0TcHo443t3j323zYg8jMPYRjXsV=EHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJd=RBBt0xNgUrz9XnU0TcHo443t3j323zYg8jMPYRjXsV=EHw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 952

On Mon, Oct 03, 2011 at 01:46:46PM +0800, Hillf Danton wrote:

> +	unsigned int cpu, core_id;
> +
> +	cpu = smp_processor_id();
> +	core_id = (cpu >> 2) & 0x7;
> +	cpu_data[cpu].core = core_id;

This is going to break in setups where Linux is not being booted on
what the hardware considers CPU core 0.  Which is not uncommon in embedded
setups.  You may want to probe the hardware for the core ID rather than
relying on smp_processor_id() here.

  Ralf
