Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jan 2013 08:38:06 +0100 (CET)
Received: from bear.ext.ti.com ([192.94.94.41]:37765 "EHLO bear.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822668Ab3A2HiEUEKel (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Jan 2013 08:38:04 +0100
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
        by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id r0T7btst020605;
        Tue, 29 Jan 2013 01:37:55 -0600
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
        by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id r0T7btrp012066;
        Tue, 29 Jan 2013 01:37:55 -0600
Received: from dlelxv22.itg.ti.com (172.17.1.197) by dfle73.ent.ti.com
 (128.247.5.110) with Microsoft SMTP Server id 14.1.323.3; Tue, 29 Jan 2013
 01:37:54 -0600
Received: from localhost (h78-16.vpn.ti.com [172.24.78.16])     by
 dlelxv22.itg.ti.com (8.13.8/8.13.8) with ESMTP id r0T7bsDR029931;      Tue, 29 Jan
 2013 01:37:54 -0600
Date:   Tue, 29 Jan 2013 09:37:35 +0200
From:   Felipe Balbi <balbi@ti.com>
To:     Florian Fainelli <florian@openwrt.org>
CC:     <linux-mips@linux-mips.org>, <balbi@ti.com>, <ralf@linux-mips.org>,
        <jogo@openwrt.org>, <mbizon@freebox.fr>, <cernekee@gmail.com>,
        <linux-usb@vger.kernel.org>, <stern@rowland.harvard.edu>,
        <gregkh@linuxfoundation.org>, <blogic@openwrt.org>
Subject: Re: [PATCH 03/13] MIPS: BCM63XX: move code touching the USB private
 register
Message-ID: <20130129073735.GE8708@arwen.pp.htv.fi>
Reply-To: <balbi@ti.com>
References: <1359399991-2236-1-git-send-email-florian@openwrt.org>
 <1359399991-2236-4-git-send-email-florian@openwrt.org>
 <20130128204114.GA5509@arwen.pp.htv.fi>
 <2622165.icySTsWGzL@bender>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline
In-Reply-To: <2622165.icySTsWGzL@bender>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: balbi@ti.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 28, 2013 at 10:17:15PM +0100, Florian Fainelli wrote:
> On Monday 28 January 2013 22:41:14 Felipe Balbi wrote:
> > Hi,
> >=20
> > On Mon, Jan 28, 2013 at 08:06:21PM +0100, Florian Fainelli wrote:
> > > diff --git a/drivers/usb/gadget/bcm63xx_udc.c b/drivers/usb/gadget/bc=
m63xx_udc.c
> > > index ad17533..af450c4 100644
> > > --- a/drivers/usb/gadget/bcm63xx_udc.c
> > > +++ b/drivers/usb/gadget/bcm63xx_udc.c
> > > @@ -41,6 +41,7 @@
> > >  #include <bcm63xx_dev_usb_usbd.h>
> > >  #include <bcm63xx_io.h>
> > >  #include <bcm63xx_regs.h>
> > > +#include <bcm63xx_usb_priv.h>
> >=20
> > actually, I want to see this arch dependency vanish. The whole
> > "phy_mode" stuff should be a PHY driver, care to implement this properly
> > using the PHY layer ?
>=20
> Ok, but then I won't be able to use the generic OHCI and EHCI platform dr=
ivers
> because they are not yet aware of clocks, PHY slave device etc... For now=
 I
> would like to stick with that since this is also very BCM63xx centric.
>=20
> Would that be ok with you?

sure, but we need to see a move towards making all of this generic and,
perhaps more importantly (at least to me), compilable on all arches so
we can make proper use of linux-next and Fengguang's build systems.

--=20
balbi

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRB3w+AAoJEIaOsuA1yqREaAIP/jdGWZWQAFC7MtHU+jpjLhO0
aInZS9AzJ0b7mH39WRspAo3wuxSmzT11qjJDeQE6VBCosjZaVNGh3gltQ0OR+cbV
3ZjXjpLXSYF4bSElhNy3M7uQid2HkYA5FJ0Ei2+PPqXwsi6Q0IvCG0FMmkGJqQ0d
Xyezuh8Iz0NFhVjJMoexnTtLsGzpS7jzmrlCr209Y74uenKlyddDefdONm/1VVtQ
xAdztQbVUzXjEwpVbt7pJvPFMoemjdhq1qNzdGmKZ3zzvhTwurdBfdS8jFqeHdgm
ojU9bQv8r8cGm7HOSrL8wMeLq0SjJyV9KtZkz/8BdaybcGdzXYXiZwL6f3PGzxk9
V++fISFqP7h5xMS+hq1zMhrW1FDjXuelw15yTW47nhd8cOBu6dWZWBJ3Rcb72B7L
ZQBNXXVTlXlU6++f60C6b7idP7fe7f+VasZGBcftmRLgVvo3+IZWJuiWhypwu9ZP
3hXDjwVxeKIF67BoCZ94U5eArLPfINUa60UgqZGzxeXVeTe5Fx2ch7wcqaiSUpvs
C0zlarLH+BGT7NQCa2jTPyuX8cNTTsNiXzKtMF923EQml5lT2dxOE/QO/0vyl8pb
NZ9hUvQjV+VC4A0UnHUnFsoKbKOnJby1JZEFvM9Uripw6dCFtQx35CWbuyPzc66/
jHjKEvJhkoLA+o+Mzcc/
=lQx9
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--
