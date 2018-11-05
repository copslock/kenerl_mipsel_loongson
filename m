Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2018 21:20:15 +0100 (CET)
Received: from fudo.makrotopia.org ([IPv6:2a07:2ec0:3002::71]:44523 "EHLO
        fudo.makrotopia.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992796AbeKEUTmKYLsd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2018 21:19:42 +0100
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
         (Exim 4.91)
        (envelope-from <daniel@makrotopia.org>)
        id 1gJlLW-0002MA-00; Mon, 05 Nov 2018 21:19:38 +0100
Date:   Mon, 5 Nov 2018 21:19:35 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Tom Psyborg <pozega.tomislav@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gabor Juhos <juhosg@freemail.hu>
Subject: Re: [PATCH] mips: ralink: add accessors for MT7620 chipver and pkg
Message-ID: <20181105201935.GF1389@makrotopia.org>
References: <20181016103806.GA1544@makrotopia.org>
 <20181102020713.GA880@makrotopia.org>
 <20181105183615.nbvnfapug6zm42pg@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105183615.nbvnfapug6zm42pg@pburton-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <daniel@makrotopia.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67091
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

Hi Paul,

thank you for the review!

On Mon, Nov 05, 2018 at 06:36:16PM +0000, Paul Burton wrote:
> Hi Daniel,
> 
> On Fri, Nov 02, 2018 at 03:07:19AM +0100, Daniel Golle wrote:
> > The RT6352 wireless core included in all MT7620 chips is implemented
> > differently in MT7620A (TFBGA) and MT7620N (DR-QFN).
> > Hence provide accessor functions similar to the already existing
> > mt7620_get_eco() function which allow the rt2x00 wireless driver to
> > figure out which WiSoC it is being run on.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  arch/mips/include/asm/mach-ralink/mt7620.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/arch/mips/include/asm/mach-ralink/mt7620.h b/arch/mips/include/asm/mach-ralink/mt7620.h
> > index 66af4ccb5c6c..d0310a92a63f 100644
> > --- a/arch/mips/include/asm/mach-ralink/mt7620.h
> > +++ b/arch/mips/include/asm/mach-ralink/mt7620.h
> > @@ -137,4 +137,16 @@ static inline int mt7620_get_eco(void)
> >  	return rt_sysc_r32(SYSC_REG_CHIP_REV) & CHIP_REV_ECO_MASK;
> >  }
> >  
> > +static inline int mt7620_get_chipver(void)
> > +{
> > +	return (rt_sysc_r32(SYSC_REG_CHIP_REV) >> CHIP_REV_VER_SHIFT) &
> > +		CHIP_REV_VER_MASK;
> > +}
> > +
> > +static inline int mt7620_get_pkg(void)
> > +{
> > +	return (rt_sysc_r32(SYSC_REG_CHIP_REV) >> CHIP_REV_PKG_SHIFT) &
> > +		CHIP_REV_PKG_MASK;
> > +}
> > +
> >  #endif
> 
> Is there an in-tree user for these?

Not yet, OpenWrt's out-of-tree Ethernet driver needs the already
existing int mt7620_get_eco(void) and is going to be upstreamed once
MT7530 DSA for has been completed to work with MT7621. See the driver
in [1].

The two newly introduced accessors are going to be used by the in-tree
rt2x00 driver which gained support for the RT6352 wireless core
included in that SoC recently. In order to be able to carry out tuning
in the same way the vendor driver does, rt2x00 will need to access the
pkg and chipver fields. See [2] for example.

> 
> Looking at it I don't see any in-tree code which uses the existing
> mt7620_get_eco() function. I'm not fond of adding code which isn't used
> at all in-tree, I'd much rather we either:
> 
>  1) Get the driver that needs these upstreamed, and these functions
>     could be added at the same time.
> 
> or
> 
>  2) Keep functions only used by out-of-tree code out-of-tree.

I understand your concerns with regard to the mt7620_get_eco(void)
function which is currently only used by the out-of-tree Ethernet
driver. However, the to-be-introduced functions mt7620_get_pkg(void)
and mt7620_get_chipver(void) are to be used in-tree by
drivers/net/wireless/ralink/rt2x00 in the very near future. I just
wanted to consult whether the introductions of such accessors is
generally acceptable before implementing the changes in rt2x00.


Best regards


Daniel


[1]: git://git.openwrt.org/openwrt.git:/target/linux/ramips/files-4.14/drivers/net/ethernet/mediatek/soc_mt7620.c

[2]: https://github.com/i80s/mtk-sources/blob/master/mt7620/src/chips/rt6352.c#L1019

> 
> Thanks,
>     Paul
