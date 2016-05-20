Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 May 2016 10:13:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19091 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27031475AbcETINTLRUGR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 May 2016 10:13:19 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id CF1E641F8D9C;
        Fri, 20 May 2016 09:13:13 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 20 May 2016 09:13:13 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 20 May 2016 09:13:13 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 556F5BA8FF400;
        Fri, 20 May 2016 09:13:11 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 20 May 2016 09:13:13 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 20 May
 2016 09:13:13 +0100
Date:   Fri, 20 May 2016 09:13:13 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Fix write_gc0_* macros when writing zero
Message-ID: <20160520081313.GX1124@jhogan-linux.le.imgtec.org>
References: <1463587478-5815-1-git-send-email-james.hogan@imgtec.com>
 <alpine.DEB.2.00.1605200848410.6794@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NJ5+aVN4Egd/eJfU"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1605200848410.6794@tp.orcam.me.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 6e37d52
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53553
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

--NJ5+aVN4Egd/eJfU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 20, 2016 at 09:01:33AM +0100, Maciej W. Rozycki wrote:
> On Wed, 18 May 2016, James Hogan wrote:
>=20
> > The versions of the __write_{32,64}bit_gc0_register() macros for when
> > there is no virt support in the assembler use the "J" inline asm
> > constraint to allow integer zero, but this needs to be accompanied by
> > the "z" formatting string so that it turns into $0. Fix both macros to
> > do this.
>=20
>  NB `z' here is an "operand code" in GCC-speak.  There's a list of the=20
> MIPS-specific ones in gcc/config/mips/mips.c above `mips_print_operand'. =
=20
> There are a few generic operand codes as well, most notably `a' to print=
=20
> an address, matching the `p' constraint.  I think it would be good to hav=
e=20
> this all documented in the GCC manual sometime.

Thanks Maciej! To be honest I pretty much guessed at what they were
called. Good to see 'z' does do what I thought. I couldn't find any
documentation online for the MIPS specific operand codes, so having them
documented with GCC would be an excellent idea!

>=20
> > Fixes: bad50d79255a ("MIPS: Fix VZ probe gas errors with binutils <2.24=
")
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> > ---
>=20
> Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>

Thanks!

James

--NJ5+aVN4Egd/eJfU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXPscZAAoJEGwLaZPeOHZ6AhgP/iuXwpU2CgmXONxej6MIm2lG
6Nf6sOkp0KEzDS2DcNUcTGL+csvz8zPnv/GXy03vocLMnFGSojRaLtOK4uXAsCcQ
4tz/Ndo+cn/Zmnc6F5jtPvgGhYIpbOo/1nyI5RYzJRyp4zAGyO7vrkiz6SWCMH9r
mN0uF6Zviiea74uj0+LAQBGG2S3ES5TJQJgnB+A+CNL6JF9UjTZtrJtbSG24ZLuu
RLp5JbchGSLRW/ZHExRLDb/rZuEEnrRQfYufNooydblE97IemgSHsJqLkQfLs9tr
tI1N7ynWdkGt5+BYBjYnm4vLA7Ix5929wst8b8I16Dot0EHxQAKJeMCdAe2SDDT5
JBoL2FjvYIEGdiM6HJdv2Umk4lOQcwwM+rsb2PZ92WAwU9WPrVwT1IHDakNOGhyD
JBNgGoU+DGh7ku/E5GZ98xyiPU9aq68jk91CPBxIl5cRTHoeZoGMD6IGGEDvVjZP
1ggfFd4+rvzw1NgvZJJa1EpP1jgRFRtwL3WimAuKKmpRWYKm0Qo7GxWu5loam21c
5xXmBMjSqb0HoHXx5SHqFGgKl8ikKbPy2RaOOPddTofBPckY4p9x8uobevH9HMim
C3xy4q1YU3fblJIpMITNDNunMWTGPzvhaiVeKg3i6KH69rDmvw92rX26Ud7pJdow
2gwtAF/UGMHRrNv9lvtD
=47d4
-----END PGP SIGNATURE-----

--NJ5+aVN4Egd/eJfU--
