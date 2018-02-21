Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Feb 2018 12:43:47 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:38068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990405AbeBULnjHlrEd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Feb 2018 12:43:39 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49EE52178F;
        Wed, 21 Feb 2018 11:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49EE52178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 21 Feb 2018 11:43:26 +0000
From:   James Hogan <jhogan@kernel.org>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 12/12] MIPS: Loongson: Introduce and use WAR_LLSC_MB
Message-ID: <20180221114326.GJ6245@saruman>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
 <1517023381-17624-1-git-send-email-chenhc@lemote.com>
 <1517023381-17624-3-git-send-email-chenhc@lemote.com>
 <20180220222153.GG6245@saruman>
 <alpine.DEB.2.00.1802202339250.3553@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2VXyA7JGja7B50zs"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1802202339250.3553@tp.orcam.me.uk>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--2VXyA7JGja7B50zs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2018 at 10:09:06AM +0000, Maciej W. Rozycki wrote:
> On Tue, 20 Feb 2018, James Hogan wrote:
>=20
> > > diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Pla=
tform
> > > index 0fce460..3700dcf 100644
> > > --- a/arch/mips/loongson64/Platform
> > > +++ b/arch/mips/loongson64/Platform
> > > @@ -23,6 +23,9 @@ ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
> > >  endif
> > > =20
> > >  cflags-$(CONFIG_CPU_LOONGSON3)	+=3D -Wa,--trap
> > > +ifneq ($(call as-option,-Wa$(comma)-mfix-loongson3-llsc,),)
> > > +  cflags-$(CONFIG_CPU_LOONGSON3) +=3D -Wa$(comma)-mno-fix-loongson3-=
llsc
> > > +endif
> >=20
> > Could this be a separate patch?
> >=20
> > This needs more explanation.
> > - What does this do exactly?
> > - Why are you turning *OFF* the compiler fix?
> > - Was some fix we don't want already in use by default?
>=20
>  FYI, support for `-mfix-loongson3-llsc' in GAS has only recently been=20
> proposed: <https://sourceware.org/ml/binutils/2018-01/msg00303.html> and=
=20
> is still pending review.

Thanks for that link Maciej. GNU changelogs are useless, so this is the
interesting bit:
> +@item -mfix-loongson3-llsc
> +@itemx -mno-fix-loongson3-llsc
> +Insert @code{sync} instruction before @samp{ll} or @samp{lld} instrction
> +to work around Loongson3 @samp{LL}/@samp{SC} errata.
> +This issue exists in all Loongson3 CPUs.

Cheers
James

--2VXyA7JGja7B50zs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqNW1cACgkQbAtpk944
dnqy7w/8CA9hYwmEbhKYNunEJa/BHdJnasJVQdTae4aBzfCsSbZklWYTlgyu4oc/
s6VFrNhnX1NatJeCPclwZy0+iDBEDABJIasfow7+LuUlNLNx4mQAF5bqQ7tfc9/E
5ZziMFDtOU07y+LiI4eIAkMaoOy8UqhPsHXyJNeg/K364G6iuUD5vbJ5+KlX8Oqw
2lIEtGJvuPMaiNgjWvcOvWZEjEsEC0ws0AX4CslawyxNB9LYnw+VpaQlBexG6AHy
MhaePR8e2g8tOAQ5eEaZ1eDaI0PFOxe5lbzNCty8irUINE2NT8osGTlxVmm/+Hmb
hSS0KbBrEyVU1JsTJDRpj72ZZm/Z9kIw8UCzNa16oLL7JjP0OJVCXecaKsBQPk8+
iUrgnqYUQhfzt3Pan595kZRBZ8HGNDmbZ1hBBh8Rmt40XS+/hkXXDm8QvpOzHki5
BAjA97h2ztqVNTeSkU9PW34Sk+pFCXObCg5PWkw5cxoe0+9cpEgxPDcTkxmFji2M
4eA6+/vhQkSgT+pKjvM5xkBBCT05vUwoHgZWsw/nRhclzL5PsnL7I0T9kRksRUur
5hErpxjVw6t+d8IOFQJKFJIpAyx4Gf0z27cmSVxLrB5VNUH8o5P70gzNHTPIrgXo
dfsfPm+/dWv8l1WfJTWY9oEM+BGKLfANIVpDyiMBggvmYLXmDMc=
=u2q+
-----END PGP SIGNATURE-----

--2VXyA7JGja7B50zs--
