Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2012 21:39:00 +0100 (CET)
Received: from comal.ext.ti.com ([198.47.26.152]:52451 "EHLO comal.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826027Ab2KFUi7A774v (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Nov 2012 21:38:59 +0100
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
        by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id qA6KcUCd028602;
        Tue, 6 Nov 2012 14:38:30 -0600
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
        by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id qA6KcU2p003516;
        Tue, 6 Nov 2012 14:38:30 -0600
Received: from dlelxv22.itg.ti.com (172.17.1.197) by dfle72.ent.ti.com
 (128.247.5.109) with Microsoft SMTP Server id 14.1.323.3; Tue, 6 Nov 2012
 14:38:30 -0600
Received: from localhost (h68-6.vpn.ti.com [172.24.68.6])       by
 dlelxv22.itg.ti.com (8.13.8/8.13.8) with ESMTP id qA6KcTx3004755;      Tue, 6 Nov
 2012 14:38:30 -0600
Date:   Tue, 6 Nov 2012 22:32:26 +0200
From:   Felipe Balbi <balbi@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Felipe Balbi <balbi@ti.com>, Michal Nazarewicz <mpn@google.com>,
        <linux-usb@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Michal Nazarewicz <mina86@mina86.com>,
        Russell King <linux@arm.linux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Mike Frysinger <vapier@gentoo.org>,
        <uclinux-dist-devel@blackfin.uclinux.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>,
        <linux-sh@vger.kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Subject: Re: [PATCHv2 1/6] arch: Change defconfigs to point to g_mass_storage.
Message-ID: <20121106203226.GB6291@arwen.pp.htv.fi>
Reply-To: <balbi@ti.com>
References: <cover.1351715302.v2.git.mina86@mina86.com>
 <46dde680f525562e9fd19567deb5247f0bf26842.1351715302.v2.git.mina86@mina86.com>
 <20121106113157.GE11931@arwen.pp.htv.fi>
 <20121106184117.GJ6801@atomide.com>
 <20121106184227.GK6801@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <20121106184227.GK6801@atomide.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34904
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

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 06, 2012 at 10:42:27AM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [121106 10:41]:
> > * Felipe Balbi <balbi@ti.com> [121106 03:40]:
> > > Hi,
> > >=20
> > > On Fri, Nov 02, 2012 at 02:31:50PM +0100, Michal Nazarewicz wrote:
> > > > From: Michal Nazarewicz <mina86@mina86.com>
> > > >=20
> > > > The File-backed Storage Gadget (g_file_storage) is being removed, s=
ince
> > > > it has been replaced by Mass Storage Gadget (g_mass_storage).  This=
 commit
> > > > changes defconfigs point to the new gadget.
> > > >=20
> > > > Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
> > >=20
> > > I need more Acks here. Only got one from Nicolas. Anyone else ?
> >=20
> > For omaps:
> >=20
> > Acked-by: Tony Lindgren <tony@atomide.com>
>=20
> Heh I guess no omap changes there, so probably not
> worth adding then.

omap1 is old, but it's still omap :-)

 arch/arm/configs/omap1_defconfig                   |    3 +--

--=20
balbi

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmXPaAAoJEIaOsuA1yqRE9UQP/3RM3dy40elQrZz+oU6HAlOb
UDXZh26hgc1SxfhuhwrteQow9zoUndtvLD/3hRc3j1UDBdI2HK85FzKf6pqBb/WW
fPCaJN1KO9Q66NwT20jLq6ic05XQOUiYU2O0cXg8Z8YdqeYUDvTa7o6VLsDzGiaJ
xeUH9RTfw5k6yYLk7iGNqvTf6JI+Q9Zw4o5J8U0opto08CHg5gjbKUNcVYT+FSpU
dlewlDSBmbZiPb1xfaToAEfIV+24jl40xEbzQcL20MyPz9u21B6BSEXCtptH22ep
Nv+rVq+9yotbM9/KIGzfV6z1YiF5tPO+oS2hgl9PB7DbBWUHmAe8bfSaaNKRBxw3
EsugS4ZS7IL1kPbzDgp/r2aeHzJo9UTiijd49WEkPyO6uK393ZcqR4oBY/kVhWY9
uVKpNMl9Gd+JWoGdYieubBT2SCIleJFWlHPVoANvu7aKPVH/ieXJQIozvLb+faMU
bQrzEBYemAOm31yMuJTgTi4MtJNj58nJlgydhqwvsbthD7zrygGgmbyyhd/Ml4Y4
l9LEYrDYJx6gS7/OT2U1C4yDUCg9mIj2hnBdG834ozlrjDvUHff6Sbf8vW2uXJIP
QLaM+19ZCERJ1GqX5Tpw15lBYjCULTZpItXM+qEYuqeqxE5Ef0EuD0j2tebxHHdq
FBTM74u2n9bpoLjwLO7a
=/Tqm
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
