Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2017 14:30:39 +0100 (CET)
Received: from fudo.makrotopia.org ([IPv6:2a07:2ec0:3002::71]:40194 "EHLO
        fudo.makrotopia.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993014AbdASNacPdxUL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Jan 2017 14:30:32 +0100
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
         (Exim 4.88)
        (envelope-from <daniel@makrotopia.org>)
        id 1cUCnG-0003wD-Ti; Thu, 19 Jan 2017 14:30:23 +0100
Date:   Thu, 19 Jan 2017 14:30:14 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        michel.stempin@wanadoo.fr, Kalle Valo <kvalo@codeaurora.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH v2 13/14] rt2x00: rt2800lib: add support for RT3352 with
 20MHz crystal
Message-ID: <20170119133010.GH1798@makrotopia.org>
References: <874m114lwq.fsf@codeaurora.org>
 <20170116031541.GA32313@makrotopia.org>
 <20170118142958.GA14573@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170118142958.GA14573@redhat.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <daniel@makrotopia.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@makrotopia.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Stanislaw,

On Wed, Jan 18, 2017 at 03:30:02PM +0100, Stanislaw Gruszka wrote:
> On Mon, Jan 16, 2017 at 04:15:56AM +0100, Daniel Golle wrote:
> > Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> > Signed-off-by: Mathias Kresin <dev@kresin.me>
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 50 +++++++++++++++++++++++++-
> >  drivers/net/wireless/ralink/rt2x00/rt2x00.h    |  2 ++
> >  2 files changed, 51 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > index 93c97eade334..cb1457595f05 100644
> > --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > @@ -36,6 +36,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> > +#include <linux/clk.h>
> >  
> >  #include "rt2x00.h"
> >  #include "rt2800lib.h"
> > @@ -7675,6 +7676,27 @@ static const struct rf_channel rf_vals_5592_xtal40[] = {
> >  	{196, 83, 0, 12, 1},
> >  };
> >  
> > +/*
> > + * RF value list for rt3xxx with Xtal20MHz
> > + * Supports: 2.4 GHz (all) (RF3322)
> > + */
> > +static const struct rf_channel rf_vals_xtal20mhz_3x[] = {
> Please locate this values in alphabetical order (i.e. after _3x and 
> before _5592 ).

Sure, sorry, that ended up in the wrong order when rebase the patches.

> 
> >  	struct hw_mode_spec *spec = &rt2x00dev->spec;
> > @@ -7764,7 +7786,10 @@ static int rt2800_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
> >  	case RF5390:
> >  	case RF5392:
> >  		spec->num_channels = 14;
> > -		spec->channels = rf_vals_3x;
> > +		if (spec->clk_is_20mhz)
> > +			spec->channels = rf_vals_xtal20mhz_3x;
> > +		else
> > +			spec->channels = rf_vals_3x;
> >  		break;
> 
> How does vendor drivers recognize xtal (I assume rf_vals_xtal20mhz_3x 
> values were taken from vendor driver) ? It should be possible to get
> clock frequency from device register like is is done on RF5592, without
> adding additional clock recognition code. But if such code is needed
> I prefer that low level board/platform routines do it and place clock
> frequency for rt2x00 in rt2x00dev->dev->platform_data.

Recent vendor drivers probe the clock by reading a SYSCTL register:
---
// Programming channel parameters
Value = (*((volatile u32 *)(RALINK_SYSCTL_BASE + 0x10)));
if(Value & (1<<20)) { //Xtal=40M
	RT30xxWriteRFRegister(pAd, RF_R08, FreqItems3020[index].N);
	RT30xxWriteRFRegister(pAd, RF_R09, FreqItems3020[index].K);
}else {
	RT30xxWriteRFRegister(pAd, RF_R08, FreqItems3020_Xtal20M[index].N);
	RT30xxWriteRFRegister(pAd, RF_R09, FreqItems3020_Xtal20M[index].K);
}
---

From what I can see, most other drivers which need to touch SYSCTL
currently do that by defining a local precompiler macro:
---
#ifdef CONFIG_SOC_MT7621
#define RALINK_SYSCTL_BASE             0xbe000000
#else
#define RALINK_SYSCTL_BASE             0xb0000000
#endif
---

That's obviously not very elegant and probably we should define SYSCTL
in the device tree of each SoC and we should write/adapt a syscon mfd
driver which other drivers may then use to read/write stuff to/from
SYSCTL. The clock could then be provided by a clk driver sitting on top
of that and rt2x00 would use that clock.
In the meantime, why not just define a static clock in the device-tree
and already have rt2x00 consume that clock? That would already be the
way things will most likely look like from rt2x00 point of view once
syscon and clk drivers are in place.


Cheers


Daniel
