Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2017 21:42:05 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45507 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993866AbdAIUl6cd-2P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2017 21:41:58 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 5BD7041F8EC6;
        Mon,  9 Jan 2017 21:44:13 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 09 Jan 2017 21:44:13 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 09 Jan 2017 21:44:13 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id CAA4896987FE6;
        Mon,  9 Jan 2017 20:41:48 +0000 (GMT)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 9 Jan
 2017 20:41:52 +0000
Date:   Mon, 9 Jan 2017 20:41:52 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     James Cowgill <James.Cowgill@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: OCTEON: Fix copy_from_user fault handling for
 large buffers
Message-ID: <20170109204152.GA30210@jhogan-linux.le.imgtec.org>
References: <ede411ad-ee19-e4e4-e6a2-585a85c640db@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <ede411ad-ee19-e4e4-e6a2-585a85c640db@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56234
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

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2017 at 04:52:28PM +0000, James Cowgill wrote:
> If copy_from_user is called with a large buffer (>=3D 128 bytes) and the
> userspace buffer refers partially to unreadable memory, then it is
> possible for Octeon's copy_from_user to report the wrong number of bytes
> have been copied. In the case where the buffer size is an exact multiple
> of 128 and the fault occurs in the last 64 bytes, copy_from_user will
> report that all the bytes were copied successfully but leave some
> garbage in the destination buffer.
>=20
> The bug is in the main __copy_user_common loop in octeon-memcpy.S where
> in the middle of the loop, src and dst are incremented by 128 bytes. The
> l_exc_copy fault handler is used after this but that assumes that
> "src < THREAD_BUADDR($28)". This is not the case if src has already been
> incremented.
>=20
> Fix by adding an extra fault handler which rewinds the src and dst
> pointers 128 bytes before falling though to l_exc_copy.
>=20
> Thanks to the pwritev test from the strace test suite for originally
> highlighting this bug!
>=20

May I suggest adding:
Fixes: 5b3b16880f40 ("MIPS: Add Cavium OCTEON processor support ...")

> Signed-off-by: James Cowgill <James.Cowgill@imgtec.com>
> Cc: stable@vger.kernel.org
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>  arch/mips/cavium-octeon/octeon-memcpy.S | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/mips/cavium-octeon/octeon-memcpy.S b/arch/mips/cavium-o=
cteon/octeon-memcpy.S
> index 64e08df51d65..4668537b09c2 100644
> --- a/arch/mips/cavium-octeon/octeon-memcpy.S
> +++ b/arch/mips/cavium-octeon/octeon-memcpy.S
> @@ -208,18 +208,18 @@ EXC(	STORE	t2, UNIT(6)(dst),	s_exc_p10u)
>  	ADD	src, src, 16*NBYTES
>  EXC(	STORE	t3, UNIT(7)(dst),	s_exc_p9u)
>  	ADD	dst, dst, 16*NBYTES
> -EXC(	LOAD	t0, UNIT(-8)(src),	l_exc_copy)
> -EXC(	LOAD	t1, UNIT(-7)(src),	l_exc_copy)
> -EXC(	LOAD	t2, UNIT(-6)(src),	l_exc_copy)
> -EXC(	LOAD	t3, UNIT(-5)(src),	l_exc_copy)
> +EXC(	LOAD	t0, UNIT(-8)(src),	l_exc_copy_rewind16)
> +EXC(	LOAD	t1, UNIT(-7)(src),	l_exc_copy_rewind16)
> +EXC(	LOAD	t2, UNIT(-6)(src),	l_exc_copy_rewind16)
> +EXC(	LOAD	t3, UNIT(-5)(src),	l_exc_copy_rewind16)
>  EXC(	STORE	t0, UNIT(-8)(dst),	s_exc_p8u)
>  EXC(	STORE	t1, UNIT(-7)(dst),	s_exc_p7u)
>  EXC(	STORE	t2, UNIT(-6)(dst),	s_exc_p6u)
>  EXC(	STORE	t3, UNIT(-5)(dst),	s_exc_p5u)
> -EXC(	LOAD	t0, UNIT(-4)(src),	l_exc_copy)
> -EXC(	LOAD	t1, UNIT(-3)(src),	l_exc_copy)
> -EXC(	LOAD	t2, UNIT(-2)(src),	l_exc_copy)
> -EXC(	LOAD	t3, UNIT(-1)(src),	l_exc_copy)
> +EXC(	LOAD	t0, UNIT(-4)(src),	l_exc_copy_rewind16)
> +EXC(	LOAD	t1, UNIT(-3)(src),	l_exc_copy_rewind16)
> +EXC(	LOAD	t2, UNIT(-2)(src),	l_exc_copy_rewind16)
> +EXC(	LOAD	t3, UNIT(-1)(src),	l_exc_copy_rewind16)
>  EXC(	STORE	t0, UNIT(-4)(dst),	s_exc_p4u)
>  EXC(	STORE	t1, UNIT(-3)(dst),	s_exc_p3u)
>  EXC(	STORE	t2, UNIT(-2)(dst),	s_exc_p2u)
> @@ -383,6 +383,10 @@ done:
>  	 nop
>  	END(memcpy)
> =20
> +l_exc_copy_rewind16:
> +	/* Rewind src and dst by 16*NBYTES for l_exc_copy */
> +	SUB	src, src, 16*NBYTES
> +	SUB	dst, dst, 16*NBYTES
>  l_exc_copy:
>  	/*
>  	 * Copy bytes from src until faulting load address (or until a
> --=20
> 2.11.0
>=20
>=20

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYc/WQAAoJEGwLaZPeOHZ6j/QP/joX+o0orSFL1a+ACexlQcVS
xBqedzlg+r+i3XI7sMHzsTbuYwMsyN/8u1t7hxUrAQMNRZYVE2xOanWL/nHwT4yE
g33tvC8uoEWx+C3SUj9V4PdZ/dpZ5IWOZ/bAElSIe20c6cPUVhjWtMMo2v29mFbW
/DSpKBkaDSVZdIB6AwkliAfjoHJSN0xQcVoYENGug/MNSiYCbiIz9lnERIH7TQru
OOB0DCwgT6Fwp+teBkkClER0SFDR/HLhfTJk5yuhFdfWGjQlQaN7+765B9BdzjfV
Rpyn4Zrb8iXEipq3zsi3DrWmZx6vPUkbDxEUbPBNl3pDI3rx+onPAbl7tcayGpgx
0zP4crAh3Hw05drs1ofsE77XNRlnW7+9n67CaoAB07fmfLEIM3cRtc7bf/msLFQA
J+1yqEdp2jFzAojHRJoAyfDeBvk85PyDTsxoP+nwUViBZOWJcbwMRA4W46kxchb2
TzrqGRRJmPeL4swIYRwt5RludxPRLrxW+dcLh2AZ2dWylzsvek7ry8CrZfcY1jRd
pweBReDck4lwCIEvUBeVv64JDMbkYRsjE8lwZsHKFoahCZu9FX/p2NeC4xeilwSA
Ov+GBeDoxLZrUouBB4m0nHB5EbAUdxe/h7PDz0OAgsB6iwiqTbxfmv9rEfyrcOF4
dudhAVmfzds8G94KwqdG
=dTJg
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
