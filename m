Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Oct 2015 00:27:13 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60430 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007895AbbJFW1LPX33- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Oct 2015 00:27:11 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id BDFED41F8E08;
        Tue,  6 Oct 2015 23:27:05 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 06 Oct 2015 23:27:05 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 06 Oct 2015 23:27:05 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 52A562A1870DF;
        Tue,  6 Oct 2015 23:27:01 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 6 Oct 2015 23:27:05 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 6 Oct
 2015 23:27:05 +0100
Date:   Tue, 6 Oct 2015 23:26:59 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] ttyFDC: Fix build problems due to use of
 module_{init,exit}
Message-ID: <20151006222658.GA29862@jhogan-linux.le.imgtec.org>
References: <1444140726-5740-1-git-send-email-james.hogan@imgtec.com>
 <1444140726-5740-3-git-send-email-james.hogan@imgtec.com>
 <20151006222300.GI14103@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20151006222300.GI14103@windriver.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: f107b6f
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Tue, Oct 06, 2015 at 06:23:00PM -0400, Paul Gortmaker wrote:
> [[PATCH 2/2] ttyFDC: Fix build problems due to use of module_{init,exit}]=
 On 06/10/2015 (Tue 15:12) James Hogan wrote:
>=20
> > Commit 0fd972a7d91d (module: relocate module_init from init.h to
> > module.h) broke the build of ttyFDC driver due to that driver's (mis)use
> > of module_mips_cdmm_driver() without first including module.h, for
> > example:
>=20
> The driver must not be hooked into any mips defconfigs or my build
> coverage should have caught it (or it was merged after my change went on

Indeed, something I intend to fix (or at least get enabled in our
buildbot builds).

> in)  -- in any case this is only the 2nd that slipped through out of
> the big shuffle that came from that, so I think that is not bad.

embarrasingly I think the other was the metag_da driver which this one
was based on. I should have guessed it'd affect ttyFDC too :-).

>=20
> >=20
> > In file included from ./arch/mips/include/asm/cdmm.h +11 :0,
> >                  from drivers/tty/mips_ejtag_fdc.c +34 :
> > include/linux/device.h +1295 :1: warning: data definition has no type o=
r storage class
> > ./arch/mips/include/asm/cdmm.h +84 :2: note: in expansion of macro =E2=
=80=98module_driver=E2=80=99
> > drivers/tty/mips_ejtag_fdc.c +1157 :1: note: in expansion of macro =E2=
=80=98module_mips_cdmm_driver=E2=80=99
> > include/linux/device.h +1295 :1: error: type defaults to =E2=80=98int=
=E2=80=99 in declaration of =E2=80=98module_init=E2=80=99 [-Werror=3Dimplic=
it-int]
> > ./arch/mips/include/asm/cdmm.h +84 :2: note: in expansion of macro =E2=
=80=98module_driver=E2=80=99
> > drivers/tty/mips_ejtag_fdc.c +1157 :1: note: in expansion of macro =E2=
=80=98module_mips_cdmm_driver=E2=80=99
> > drivers/tty/mips_ejtag_fdc.c +1157 :1: warning: parameter names (withou=
t types) in function declaration
> >=20
> > Instead of just adding the module.h include, switch to using the new
> > builtin_mips_cdmm_driver() helper macro and drop the remove callback,
> > since it isn't needed. If module support is added later, the code can
> > always be resurrected.
>=20
> Thanks for taking the cleanup approach here and not the one line
> approach.  Saves me doing the cleanup work myself later.
>=20
> Acked-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Thanks
James

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWFEqyAAoJEGwLaZPeOHZ69H0P/ja2ASbB1S3m84Bq2UKl1BVk
ptc6Ay66Hn52fIyQsrwpTQoPbzxEkymuO3wpvah3D4gnzdlCQJE3jg6ZBGfMGAk6
SnWfXECMTCDYIG+l0UCngcWmItmZDObKJb5Wzyk8Aj6aTHJJZ5iz9wYZwWGymJLP
IIFJqtjHxlrneGKUwjFxgIBhC2Aw7zkgY8rR+nclAf9qXHlTHXyYT+D738ol0uSf
/Hdxt8lNYfH5jLYx5z4D9wXSoKHzdl1rRcoFiZaX3Ylc9+wjARrU85LZIxezvBnf
AF31c+TAsfqeSvi3lgYhhtANQFUpadiy9Ex8D/kpazt4tfi+/RK4XP7aGiZt9YPY
L7uRjIqRtKjguwMakZSfR2Aa+ALZqjRX09xygQpRmULZwlSYG7h+CsrkXllPC+wK
4GCgIi1MB8/rORAR3S6h/JAdnt/Ylr5TFfBuEOteUa0kdSG309sS7zmMW4EpCZwC
XiM0Ki+aJdZnT4TMWQtcPmGEbBItYz6SJJYkFcaFAwiRVnAiGhxSqk+uihlnoIuA
Vqe6UILkI2M2/9XHJuHM9ovJDVVJS/isIjRYgRyKfmKifgQbKZoTmgsgdQCJoGa0
TxEq2EMlM9XnRYvL0h9925ZBW73SSdH/rD/kSaN35e0jlL1oAKHr0/CsF2ApyHgo
kq7NEGzWci8x8oGygp5v
=Cw5f
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
