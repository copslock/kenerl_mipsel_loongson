Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2018 11:25:01 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:33890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990845AbeC0JYucHB1m (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Mar 2018 11:24:50 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A86D121836;
        Tue, 27 Mar 2018 09:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86D121836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 27 Mar 2018 10:24:38 +0100
From:   James Hogan <jhogan@kernel.org>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Maxim Uvarov <muvarov@gmail.com>, linux-mips@linux-mips.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: Make the default for PHYSICAL_START always 64-bit
Message-ID: <20180327092438.GA17660@saruman>
References: <alpine.DEB.2.00.1803240129140.2163@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1803240129140.2163@tp.orcam.me.uk>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63246
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


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2018 at 07:11:51PM +0100, Maciej W. Rozycki wrote:
> Make the default for PHYSICAL_START always 64-bit, ensuring that a=20
> correct sign-extended value is used if a 32-bit image is loaded by a=20
> 64-bit system, and matching how the load address is set in platform=20
> Makefile fragments (arch/mips/*/Platform) in the absence of the=20
> PHYSICAL_START configuration option.

This looks correct given the defaults in the Makefile fragments. However
I presume a 32BIT kernel will produce a 32-bit ELF, in which case the
result will be indistinguishable? For other kernel image formats which
always use 64-bit pointers perhaps it matters more (if they can be
loaded by kexec-tools). uImage is 32-bit ISTR, and our ITB stuff seems
to only use 32bit addresses for CONFIG_32BIT. I don't now about other
formats.

So unless I hear otherwise I'll probably drop the stable tag and apply
for 4.17.

Thanks
James

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlq6DcwACgkQbAtpk944
dnqrAg/+MmTLbAHANlFE1Kgm/OhkAMvFiHa8L3FeJFO+jr/e8slGq0rTOgqT2ekD
YU4zb5OjKRTM14vejvml6HF6ZaXPlSXTikfiW38ATBs9zOdV4351YedfFzuog2E8
LZ7N+qbdm3y34IiX28/BllF/ZyyNk39UnP2VGzrY6iyFuXLQEFDQAFUmW7CkcMem
QE2TZx0shkmMZ5yQGUpfb7c5/aqo74kX8HP80F+UyvmR5JcWDFvTipZQZtCLjQa0
s/SZlSUqv5wkYrDa81D6XtKNcBv+iHo3UhKRpmKPAUVRXp4N9x3GRkiiB6GkmDiR
koSQ8JwCDyTRhmUnMoq4Fhbn7gsP+equ32VCXpm5ZfmGbptJrE7dlSvHWB9yfFbN
CZDzQkHpdqwDCWN1TuFi9t8/HWZMPCwNhbr/bL0aAKnzOtXFn979fRCriHufT6Rh
LvFnFIA6zxjZN/sDcsswQAPRFFCUEOeOaA20o1jrvnwE789p+kgzeY+No/S3N2ra
Yp5q+ZLl1pOmsodjxgAJyws4XnSXThDNZGNTwQUWkkxWCDIoExcpe/rCEFBWnSBH
zFI3iFFVEKZWUxfP92ALXq8Y5IQAcwj5aPF/ujAB8Xy0ymQMQTiOlszvE0oiHn3e
o2dEzye6rruk5JMXJEu7WjMEyW1duru316CLqZPNUc8ZISCGBUg=
=PEP7
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
