Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2016 19:32:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64858 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27025160AbcDVRcvZNtO0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Apr 2016 19:32:51 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 2A51341F8E94;
        Fri, 22 Apr 2016 18:32:46 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 22 Apr 2016 18:32:46 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 22 Apr 2016 18:32:46 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 451E8C3A16BF;
        Fri, 22 Apr 2016 18:32:42 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 22 Apr 2016 18:32:45 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 22 Apr
 2016 18:32:45 +0100
Date:   Fri, 22 Apr 2016 18:32:45 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Paul Burton <paul.burton@imgtec.com>, <linux-mips@linux-mips.org>,
        "Ralf Baechle" <ralf@linux-mips.org>, <fengguang.wu@intel.com>,
        "stable # v4 . 4+" <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Allow R6 compact branch policy to be left
 unspecified
Message-ID: <20160422173245.GC2467@jhogan-linux.le.imgtec.org>
References: <1461314611-15317-1-git-send-email-paul.burton@imgtec.com>
 <alpine.DEB.2.00.1604221648580.21846@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1604221648580.21846@tp.orcam.me.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 6e37d52
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53217
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

--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2016 at 04:56:02PM +0100, Maciej W. Rozycki wrote:
> On Fri, 22 Apr 2016, Paul Burton wrote:
>=20
> > It turns out that some toolchains which support MIPS R6 don't support
> > the -mcompact-branches flag to specify compact branch behaviour. Default
> > to not providing the -mcompact-branch option to the compiler such that
> > we can build with such toolchains.
>=20
>  Good idea overall, one further suggestion below.
>=20
> > diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
> > index f0e314c..e91b3d1 100644
> > --- a/arch/mips/Kconfig.debug
> > +++ b/arch/mips/Kconfig.debug
> > @@ -117,7 +117,15 @@ if CPU_MIPSR6
> > =20
> >  choice
> >  	prompt "Compact branch policy"
> > -	default MIPS_COMPACT_BRANCHES_OPTIMAL
> > +	default MIPS_COMPACT_BRANCHES_DEFAULT
> > +
> > +config MIPS_COMPACT_BRANCHES_DEFAULT
> > +	bool "Toolchain Default (don't specify)"
> > +	help
> > +	  Don't pass the -mcompact-branches flag to the compiler, allowing it
> > +	  to use its default (generally "optimal"). This is particularly
> > +	  useful for early R6-supporting toolchains which don't support the
> > +	  -mcompact-branches flag.
> > =20
> >  config MIPS_COMPACT_BRANCHES_NEVER
> >  	bool "Never (force delay slot branches)"
>=20
>  How about making the option depend on DEBUG_KERNEL and maybe making it a=
n=20
> umbrella setting to hide details from users who do not want to be=20
> bothered, i.e. something like:
>=20
> config MIPS_COMPACT_BRANCHES_OVERRIDE
>      bool "Override the toolchain default for compact branch policy"
>      depends on DEBUG_KERNEL
>      default n

Although note that "default n" is redundant.

Cheers
James

> [...]
> if MIPS_COMPACT_BRANCHES_OVERRIDE
> choice
>     prompt "Compact branch policy"
>     default MIPS_COMPACT_BRANCHES_OPTIMAL
> [...]
> endif # MIPS_COMPACT_BRANCHES_OVERRIDE
>=20
> ?
>=20
>   Maciej
>=20

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXGmA9AAoJEGwLaZPeOHZ6/QYP/A0BLwpn4Ruxm7GGWdyP3qqT
6E7MA8AFnLkKVdm/b408fOovMlD1Iu7rvS+dkeeENg2z8Sqp2/wr2wDJJOlxjznj
bJ7fr5Jhl7vFfwCRqAe9RfkeMCSWb0pnlmMahcUnthI0c+suAAczdkWS+KMOnJQ0
3NU/iZgCZeGqmu2yr5nrJ2cYE6pobx/7E8na63GHCtN54JYROjfjnU2NHQ/d6lOy
r+PrFrPFVLuoQX96+EDYyj3dWDD4OMaQqGXTdoKJNtuvxNBmJN/P0pYpll4EorZg
7hRthYe9e9U5v2DsKYNkN546+C4Y2/vRaYkv+lGxBy909vB0lZ6AQW1eak5jTPsT
krvpG9eN0jUWMB4zIe+BUjb1Iq9CWNORKMWJ36gpsXNT6WRGiKXQLSIVg2vZ4gjo
6AIho0rHp0w0FaH8Tqv6Cy5TSlSPtxNXqBnZ5Q5c5VhSmhbNNaqtqnsPcXELDy1Q
Rib7zb+emNDJHR6tANDCtSLPCeUJO4HFM8/sLsnW/RAlWKVvfXB+02/oYjF0yzDB
A/B3BY9tt8Y4n9xgW3CdN/Cz2QGzCLCB1K3tzfEzQNd5zfnXqsE68kSDjPGQUFlb
/Owjc5W65isVpX5XPdxKZA7Ogio6HiD2LyBD5EUovtiIPkeK2tmZ0AeSKbQo1TSF
sd6O5AmklGLus+ID52UZ
=Mn5p
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
