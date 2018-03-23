Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 21:57:07 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:44516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990656AbeCWU47k4v-1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Mar 2018 21:56:59 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B7AD20838;
        Fri, 23 Mar 2018 20:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7AD20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Fri, 23 Mar 2018 20:56:48 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [GIT PULL] MIPS fixes for 4.16-rc7
Message-ID: <20180323205647.GC11796@saruman>
References: <20180323102601.GA11796@saruman>
 <CA+55aFwERU7m_DYffR=xcUmb1_mzzqwU2gK7xOck8X4N9CtLCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
In-Reply-To: <CA+55aFwERU7m_DYffR=xcUmb1_mzzqwU2gK7xOck8X4N9CtLCw@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63191
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


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 23, 2018 at 11:36:29AM -0700, Linus Torvalds wrote:
> On Fri, Mar 23, 2018 at 3:26 AM, James Hogan <jhogan@kernel.org> wrote:
> >
> >  arch/mips/lantiq/Kconfig        |  2 ++
> >  arch/mips/lantiq/xway/sysctrl.c |  6 ++---
> >  arch/mips/ralink/mt7621.c       | 50 +++++++++++++++++++++------------=
--------
> >  arch/mips/ralink/reset.c        |  7 ------
> >  4 files changed, 31 insertions(+), 34 deletions(-)
>=20
> Odd. This didn't match for me. It turns out that's because you have
> the patience diff enabled.
>=20
> Normally the patience diff generates moire legible diffs, but in this
> case the default diff actually seems better.
>=20
> You don't have to do anything about your config, I realize that some
> people and projects prefer patience-dff. I just found it interesting
> how *completely* different the diffs look. Normally the differences
> are subtler.

Indeed I do have patience enabled from long ago when the default diff
was probably showing some change unintuitively.

The only nice thing I suppose is that it emphasises the added __sync()
and its choice of code to show as moved is essentially unchanged, but
then again it doesn't match so closely how the author has described the
change...

Cheers
James

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlq1agoACgkQbAtpk944
dnrvyBAAo5sJbUWsIgZl4kPmrmznVtayj+2GlDJMwRSQIaYDk/fOs/nSdv0nPvWu
cvAGj+0JIHm1jKw1o3BqHvKDPtfykkMczSngjaVZwrFoVnCTbAol1lMvTqQ8b2bc
1QN+iEMmEw6Fo0nLlJ1Cojg5BzkxAl26czNMPeKYbgisab6f02yWvvjwh0u+p53t
35vYJIR0BYmB6RPV9OTveP1KkymQTBuxBRYg4VYWrgWBOQEXnFxoUxMb/ntOULvc
wxzc/RBIyvTax0KM22Px1bYYMbjNG6nr9jiWGXG0wqOCRRmZ/Umt0N7G2WtFZayj
cl5UAvDGLpOm9pj+xRmvtEGnaCDtYES1MBcWaZNWSsGQp3Wm1WFPm2HgbKCG8FTu
tvEH6hnoRWO8xLGXnGlKBj9RrKNKQzM1KAvfP5J2MPsXb6cSHI7q199E7QpK4m2F
QTB1aRFjeWQhjxK23srwtaABKAPoOICBRdQJQjzDrtco0kWhEtFS7ORbhEddR8bx
CzVsf58DCHSof9jaLv6/wDIl4YnkTVS1CYD8+IT3g8oaKLZxnxeeGU/9B78+8Joi
YkD7rO88LIRBvLGSlNawUBvYgAQ7zy39EG/lz912vxcXUstFbySkOcYkrnwaNWYV
XCkQ3+uYn3dpH42FLuy47udQE+tM2R05+8SYSLytD+o8wn1iXvc=
=DpRp
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
