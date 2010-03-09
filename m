Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Mar 2010 20:17:57 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:44010 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492542Ab0CITRw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Mar 2010 20:17:52 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o29JHotC002083;
        Tue, 9 Mar 2010 20:17:51 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o29JHoU5002080;
        Tue, 9 Mar 2010 20:17:50 +0100
Date:   Tue, 9 Mar 2010 20:17:50 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Yang Shi <yang.shi@windriver.com>
Cc:     ddaney@caviumnetworks.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: Fix wrong variable type in smp.c
Message-ID: <20100309191750.GA1960@linux-mips.org>
References: <1268115862-25976-1-git-send-email-yang.shi@windriver.com>
 <20100309190309.GA301@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100309190309.GA301@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 09, 2010 at 08:03:09PM +0100, Ralf Baechle wrote:

> > @@ -281,7 +281,7 @@ static void octeon_cpu_die(unsigned int cpu)
> >  
> >  #ifdef CONFIG_CAVIUM_OCTEON_WATCHDOG
> >  	/* Disable the watchdog */
> > -	cvmx_ciu_wdogx_t ciu_wdog;
> > +	union cvmx_ciu_wdogx ciu_wdog;
> >  	ciu_wdog.u64 = cvmx_read_csr(CVMX_CIU_WDOGX(cpu));
> >  	ciu_wdog.s.mode = 0;
> >  	cvmx_write_csr(CVMX_CIU_WDOGX(cpu), ciu_wdog.u64);
> 
> David,
> 
> I think this ifdef should be replaced by a notifier called from
> __cpu_die().

Since this is unused I'll just remove it for now.

  Ralf
