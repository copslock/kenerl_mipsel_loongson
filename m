Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 17:15:57 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8669 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012294AbcBCQPzTeezQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 17:15:55 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id EEBF641F8DC8;
        Wed,  3 Feb 2016 16:15:48 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 03 Feb 2016 16:15:48 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 03 Feb 2016 16:15:48 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 470CCC19F13C3;
        Wed,  3 Feb 2016 16:15:46 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 16:15:48 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 16:15:48 +0000
Date:   Wed, 3 Feb 2016 16:15:48 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "Matt Redfearn" <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: [PATCH 06/15] MIPS: CM: Fix mips_cm_max_vp_width for UP kernels
Message-ID: <20160203161548.GJ5038@jhogan-linux.le.imgtec.org>
References: <1454469335-14778-1-git-send-email-paul.burton@imgtec.com>
 <1454469335-14778-7-git-send-email-paul.burton@imgtec.com>
 <20160203145858.GH5464@jhogan-linux.le.imgtec.org>
 <20160203154634.GC30470@NP-P-BURTON>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VSaCG/zfRnOiPJtU"
Content-Disposition: inline
In-Reply-To: <20160203154634.GC30470@NP-P-BURTON>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 56f439c
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51699
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

--VSaCG/zfRnOiPJtU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 03, 2016 at 03:46:34PM +0000, Paul Burton wrote:
> On Wed, Feb 03, 2016 at 02:58:59PM +0000, James Hogan wrote:
> > On Wed, Feb 03, 2016 at 03:15:26AM +0000, Paul Burton wrote:
> > > Fix mips_cm_max_vp_width for UP kernels where it previously referenced
> > > smp_num_siblings, which is not declared for UP kernels. This led to
> > > build errors such as the following:
> > >=20
> > >   drivers/built-in.o: In function `$L446':
> > >   irq-mips-gic.c:(.text+0x1994): undefined reference to `smp_num_sibl=
ings'
> > >   drivers/built-in.o:irq-mips-gic.c:(.text+0x199c): more undefined re=
ferences to `smp_num_siblings' follow
> > >=20
> > > On UP kernels simply return 1, leaving the reference to smp_num_sibli=
ngs
> > > in place only for SMP kernels.
> > >=20
> > > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> >=20
> > Need tagging for stable v4.3+?
>=20
> It happens that there were no uses of mips_cm_max_vp_width in UP
> kernels, but some are added later in this series (the next patch for
> instance). So I don't see a need to backport to stable branches. Sorry
> that could have been clearer.
>=20
> > I do wonder if this should be handled in the header files though...
>=20
> As in you don't think it should be handled in headers? It seems like the
> logical place to do it to me...
>=20
> Or do you mean smp_num_siblings should be defined as 1 for UP kernels? I
> did consider that approach, but thought this possibly more semantically
> correct since smp isn't in use at all so neither is smp_num_siblings.

Yeh, I meant this (didn't really register that the code in this patch
was a header too tbh).

Cheers
James

>=20
> Thanks,
>     Paul
>=20
> > Cheers
> > James
> >=20
> > > ---
> > >=20
> > >  arch/mips/include/asm/mips-cm.h | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/=
mips-cm.h
> > > index 1395bbc..3fdb6c9 100644
> > > --- a/arch/mips/include/asm/mips-cm.h
> > > +++ b/arch/mips/include/asm/mips-cm.h
> > > @@ -462,7 +462,10 @@ static inline unsigned int mips_cm_max_vp_width(=
void)
> > >  	if (mips_cm_revision() >=3D CM_REV_CM3)
> > >  		return read_gcr_sys_config2() & CM_GCR_SYS_CONFIG2_MAXVPW_MSK;
> > > =20
> > > -	return smp_num_siblings;
> > > +	if (config_enabled(CONFIG_SMP))
> > > +		return smp_num_siblings;
> > > +
> > > +	return 1;
> > >  }
> > > =20
> > >  /**
> > > --=20
> > > 2.7.0
> > >=20
> > >=20
>=20
>=20

--VSaCG/zfRnOiPJtU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWsie0AAoJEGwLaZPeOHZ6qLIP/j2ZIy4uWpB0gRpTJMqHpg1g
EIb/IvE7jcgHZvtWte9unJCoQ7K2vohNS+4cFC923QH4IgX0yJk9i2syTB0Ba2Fr
l1bJ/jabNCf108fg830YjZEfpb9MwTypBehRmqzBuoddwUA8/psLmhGQMDMhN4vW
cszm0vlYdP1m1k7cn+pMzGM06m9EnIIC5XONhdfTy+SPWEySzxErYovdvNZTlMmi
qaoQH5UYpeIlX7g2Qz4LEij2LBeSjMdx/Fhxz8lPhcPCH7jGJTd6gp8ASe6+6Q3B
diWZ0z53CzaNtx93Ubg1xuYWErkmE4VkZBFaQSTfyC1GMxVaW6UuCgtxiLKZAbZ5
VUTcc20S2lntXFC9YS8j1WcACZoWo4LglIgMQEWw6UrDebYTZ6zbTctmc3KveAYd
I5L1JFRYz/H3JGqW/hVe6myoAlRmZYvdYgXQipV2MyV1w9P9Xp3zz4YB826Nvz85
W+8ZsSyoxY7BjKKBCdSxDMTk2ObT8REbIdc4Jm8dC6a96AgoSUDYAVRdtPj6VskJ
VPFMpikGWnnFtcgHp5z6bVQzJZz4hCCCHGapoe52O6+4mxzFYtdPMWO9S6hG7Lv1
TjFUjyOa7HmXHs4bU5nDNIGhzheVFJkVJFZD0iJh0VdzHT2vGxxHEnmIs8EhDWZm
fShgBW4oFZpPy1mMObop
=fy4d
-----END PGP SIGNATURE-----

--VSaCG/zfRnOiPJtU--
