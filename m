Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Feb 2018 16:48:20 +0100 (CET)
Received: from mail.bootlin.com ([62.4.15.54]:43516 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990864AbeB0PsNUj-ZC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Feb 2018 16:48:13 +0100
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 605502087E; Tue, 27 Feb 2018 16:48:03 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0EA5E20722;
        Tue, 27 Feb 2018 16:47:53 +0100 (CET)
Date:   Tue, 27 Feb 2018 16:47:54 +0100
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     James Hogan <jhogan@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] MIPS: mscc: add ocelot dtsi
Message-ID: <20180227154754.GA15333@piout.net>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
 <20180116101240.5393-6-alexandre.belloni@free-electrons.com>
 <20180214165743.GD3986@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214165743.GD3986@saruman>
User-Agent: Mutt/1.9.3 (2018-01-21)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

On 14/02/2018 at 16:57:43 +0000, James Hogan wrote:
> On Tue, Jan 16, 2018 at 11:12:37AM +0100, Alexandre Belloni wrote:
> > Add a device tree include file for the Microsemi Ocelot SoC.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> May I suggest Cc'ing the DT folk on this patch.
> 

I can do that but I think that while they care about the bindings
themselves, they usually don't review the device trees.

So I wouldn't expect any review from Rob on such a patch, especially
since he reviewed the bndings.

> > diff --git a/arch/mips/boot/dts/mscc/Makefile b/arch/mips/boot/dts/mscc/Makefile
> > new file mode 100644
> > index 000000000000..f0a155a74e02
> > --- /dev/null
> > +++ b/arch/mips/boot/dts/mscc/Makefile
> > @@ -0,0 +1,4 @@
> > +obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> > +
> > +# Force kbuild to make empty built-in.o if necessary
> > +obj-				+= dummy.o
> 
> I don't think you need this since f7adc3124da0 ("kbuild: create
> built-in.o automatically if parent directory wants it"). It was removed
> from other places in bf070bb0e6c6 ("kbuild: remove all dummy assignments
> to obj-").
> 
> Cheers
> James



-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
