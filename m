Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2011 11:32:22 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:4990 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1493631Ab1HXJcS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Aug 2011 11:32:18 +0200
X-TM-IMSS-Message-ID: <612b10310000e922@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 612b10310000e922 ; Wed, 24 Aug 2011 02:30:21 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 24 Aug 2011 02:32:59 -0700
Date:   Wed, 24 Aug 2011 15:06:29 +0530
From:   "Jayachandran C." <jayachandranc@netlogicmicro.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/4] MIPS: Netlogic: XLP CPU support.
Message-ID: <20110824093628.GB2820@jayachandranc.netlogicmicro.com>
References: <cover.1312024106.git.jayachandranc@netlogicmicro.com>
 <22a3c5f618c9213bbf24c9564a82d94c831def4e.1312024108.git.jayachandranc@netlogicmicro.com>
 <20110823124606.GA20817@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110823124606.GA20817@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 24 Aug 2011 09:32:59.0482 (UTC) FILETIME=[D00CA3A0:01CC6240]
X-archive-position: 30976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17723

On Tue, Aug 23, 2011 at 02:46:06PM +0200, Ralf Baechle wrote:
> On Sat, Jul 30, 2011 at 06:58:08PM +0530, Jayachandran C wrote:
> 
> > +#if defined(CONFIG_CPU_XLR)
> > +#define cpu_has_userlocal	0
> > +#define cpu_has_dc_aliases	0
> > +#define cpu_has_mips32r2	0
> > +#define cpu_has_mips64r2	0
> > +#elif defined(CONFIG_CPU_XLP)
> > +#define cpu_has_userlocal	1
> > +#define cpu_has_mips32r2	1
> > +#define cpu_has_mips64r2	1
> > +#define cpu_has_dc_aliases	1
> > +#else
> > +#error "Unknown Netlogic CPU"
> > +#endif
> 
> If you remove this block altogether the kernel would do runtime probing.
> One step closer towards a generic kernel for XLP and XLR.  Is that of
> interest?

Not sure if we can have the same kernel. The XLP will have a different
initialization sequence and platform devices...

> 
> > --- a/arch/mips/mm/c-r4k.c
> > +++ b/arch/mips/mm/c-r4k.c
> > @@ -1235,6 +1235,10 @@ static void __cpuinit setup_scache(void)
> >  		loongson2_sc_init();
> >  		return;
> >  #endif
> > +	case CPU_XLP:
> > +		/* don't need to worry about L2 fully coherent */
> > +		sc_present = 0;
> > +		break;
> 
> No need to add this because sc_present defaults to zero.

I'll update it to:
	case CPU_XLP:
		/* don't need to worry about L2, fully coherent */
		return;

> Or even better, just fill all the variables like the R10000 (which also
> has a full coherent S-cache).  Due to the other cpu feature flags the
> code will know that it doesn't have to do any cache maintenance.
> 
> That way diagnostic code and possibly some performance optimizations
> can still use the cache data.

Ok.
 
> > diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> > index b6e1cff..0833a63 100644
> > --- a/arch/mips/mm/tlbex.c
> > +++ b/arch/mips/mm/tlbex.c
> > @@ -484,6 +484,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
> >  	case CPU_TX49XX:
> >  	case CPU_PR4450:
> >  	case CPU_XLR:
> > +	case CPU_XLP:
> >  		uasm_i_nop(p);
> 
> If the XLP is a MIPS64 R2 processor adding this code is unnecessary because
> the cpu_has_mips_r2 if near the top of this function will handle the CPU.

Missed this, thanks.

JC.
