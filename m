Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jul 2010 17:53:52 +0200 (CEST)
Received: from mga01.intel.com ([192.55.52.88]:11740 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491837Ab0GEPxr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Jul 2010 17:53:47 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 05 Jul 2010 08:52:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.53,540,1272870000"; 
   d="scan'208";a="815011527"
Received: from unknown (HELO sortiz-mobl) ([10.255.17.75])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2010 08:53:21 -0700
Date:   Mon, 5 Jul 2010 17:53:27 +0200
From:   Samuel Ortiz <sameo@linux.intel.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 22/26] MFD: Add JZ4740 ADC driver
Message-ID: <20100705155326.GC3850@sortiz-mobl>
References: <1276924111-11158-1-git-send-email-lars@metafoo.de>
 <1276924111-11158-23-git-send-email-lars@metafoo.de>
 <20100705145306.GA3850@sortiz-mobl>
 <4C31FDA3.3040708@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C31FDA3.3040708@metafoo.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <sameo@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sameo@linux.intel.com
Precedence: bulk
X-list: linux-mips

On Mon, Jul 05, 2010 at 05:43:31PM +0200, Lars-Peter Clausen wrote:
> >> +static inline void jz4740_adc_clk_enable(struct jz4740_adc *adc)
> >> +{
> >> +	unsigned long flags;
> >> +
> >> +	spin_lock_irqsave(&adc->lock, flags);
> >> +	if (adc->clk_ref++ == 0)
> >> +		clk_enable(adc->clk);
> >> +	spin_unlock_irqrestore(&adc->lock, flags);
> >> +}
> > I'm not familiar with your platform clock framework, but shouldn't the
> > refcounting be handled there instead of spread over all your drivers ?
> 
> The ADC clock is the only clock on this platform which is shared between multiple
> devices so I refrained from adding the refcounting to the core for now. But to be
> strictly complaint with the clock API as defined in linux/clk.h the implementation
> should do refcounting. I'm still a bit uncertain what would be done best here.
>
I can't see what leaving the refcount handling to drivers could bring compared
to a centralized implementation. But that's your platform, either way is fine
with me as far as this MFD driver is concerned.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
