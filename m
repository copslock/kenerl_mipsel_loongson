Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2016 21:32:01 +0200 (CEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:36788 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992289AbcIMTbzBf7tp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Sep 2016 21:31:55 +0200
Received: from raspberrypi.musicnaut.iki.fi (85-76-14-194-nat.elisa-mobile.fi [85.76.14.194])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 30FCB23414D;
        Tue, 13 Sep 2016 22:31:54 +0300 (EEST)
Date:   Tue, 13 Sep 2016 22:31:54 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <asbjorn@asbjorn.st>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Octeon: Use defines instead of magic numbers
Message-ID: <20160913193154.GC1658@raspberrypi.musicnaut.iki.fi>
References: <20160912210314.GB1658@raspberrypi.musicnaut.iki.fi>
 <1473793494.15480.1@x201s.roaming.asbjorn.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1473793494.15480.1@x201s.roaming.asbjorn.biz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Tue, Sep 13, 2016 at 07:04:54PM +0000, Asbjørn Sloth Tønnesen wrote:
> On Tue, 13 Sep 2016 00:03:14 +0300, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > On Mon, Sep 12, 2016 at 08:33:43PM +0000, Asbjoern Sloth Toennesen wrote:
> > > The patch will be followed by a similar patch to
> > > drivers/staging/octeon/ethernet.c
> > 
> > I think you should:
> > 
> > 	1. Move this function to staging/octeon
> > 
> > 	2. Do required cleanups there
> > 
> > 	3. Finally delete the function under arch/mips
> > 
> > We shouldn't start making cleanups (except code removal) to ethernet code
> > under mips/cavium-octeon/executive as it really does not belong there...
> 
> I agree that this would make sense, however I just came across this looking
> at the general MTU code across drivers, and don't have a real interest in
> this particular driver nor mips, so I am not looking to fall that deep into
> the rabbit hole.

In that case please leave the code alone. NAK for this patch.

A.
