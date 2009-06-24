Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jun 2009 14:27:36 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:40344 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492685AbZFXM13 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jun 2009 14:27:29 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5OCNl42029219;
	Wed, 24 Jun 2009 13:23:47 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5OCNlaD029217;
	Wed, 24 Jun 2009 13:23:47 +0100
Date:	Wed, 24 Jun 2009 13:23:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Alexander Clouter <alex@digriz.org.uk>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 5/8] add Texas Instruments AR7 support
Message-ID: <20090624122347.GA28583@linux-mips.org>
References: <200906041619.25359.florian@openwrt.org> <200906231128.29760.florian@openwrt.org> <20090623181509.GA9966@linux-mips.org> <200906241112.58301.florian@openwrt.org> <o8f9h6-v4l.ln1@woodchuck.wormnet.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <o8f9h6-v4l.ln1@woodchuck.wormnet.eu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 24, 2009 at 12:28:56PM +0100, Alexander Clouter wrote:

> Florian Fainelli <florian@openwrt.org> wrote:
> > Le Tuesday 23 June 2009 20:15:09 Ralf Baechle, vous avez écrit :
> >> On Tue, Jun 23, 2009 at 11:28:27AM +0200, Florian Fainelli wrote:
> >>
> >> AR7 time again - the platform pending longest ...  Let's see:
> > 
> > Thank you very much for your comments Ralf, please find below an updated
> > version which addresses all of your comments. I hope this time we are going
> > to make it ;)
> >
> I am hoping someone can have a tackle of the lzma/bzip2 kernel/initramfs 
> generic compression code myself, but I guess one thing at a time. :)  If 
> you have a simple way for me to produce a LZMA'd image, I'll test it 
> this on my WAG54Gv2 (I need the image to be less than 700kB).
> 
> My comments, for what they are worth, below:
> 
> > From: Florian Fainelli <florian@openwrt.org>
> > Subject: Add support for Texas Instruments AR7 System-on-a-Chip
> > 
> > This patch adds support for the Texas Instruments AR7 System-on-a-Chip.
> > It supports the TNETD7100, 7200 and 7300 versions of the SoC.
> > 
> > Changes from v4:
> > [snipped]
> > 
> > Signed-off-by: Matteo Croce <matteo@openwrt.org>
> > Signed-off-by: Felix Fietkau <nbd@openwrt.org>
> > Signed-off-by: Eugene Konev <ejka@openwrt.org>
> > Signed-off-by: Nicolas Thill <nico@openwrt.org>
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > -- 
> > [snipped]
> >
> > diff --git a/arch/mips/ar7/clock.c b/arch/mips/ar7/clock.c
> > new file mode 100644
> > index 0000000..7ce5f07
> > --- /dev/null
> > +++ b/arch/mips/ar7/clock.c
> > @@ -0,0 +1,450 @@
> > [snipped]
> > +static void __init tnetd7300_init_clocks(void)
> > +{
> > +       u32 *bootcr = (u32 *)ioremap_nocache(AR7_REGS_DCL, 4);
> > +       struct tnetd7300_clocks *clocks =
> > +                                       (struct tnetd7300_clocks *)
> > +                                       ioremap_nocache(AR7_REGS_POWER + 0x20,
> > +                                       sizeof(struct tnetd7300_clocks));
> > +
> >
> Needless cast'ing and also should you not check that NULL is not 
> returned for both of these ioremap's?

That's because we "know" it can't ever fail for addresses < 0x20000000.
Downside - sparse will bitch about it.

But yes, the cast indeed is unnecessary.

  Ralf
