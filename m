Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Feb 2018 17:24:45 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:33798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991096AbeB0QYbxwrsf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Feb 2018 17:24:31 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4F5B21748;
        Tue, 27 Feb 2018 16:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F5B21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 27 Feb 2018 16:23:57 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] MIPS: defconfigs: add a defconfig for Microsemi
 SoCs
Message-ID: <20180227162357.GO6245@saruman>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
 <20180116101240.5393-8-alexandre.belloni@free-electrons.com>
 <20180214170342.GF3986@saruman>
 <20180227161550.GC15333@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hOh8F6DNH/RZBSFD"
Content-Disposition: inline
In-Reply-To: <20180227161550.GC15333@piout.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62726
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


--hOh8F6DNH/RZBSFD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2018 at 05:15:50PM +0100, Alexandre Belloni wrote:
> On 14/02/2018 at 17:03:43 +0000, James Hogan wrote:
> > On Tue, Jan 16, 2018 at 11:12:39AM +0100, Alexandre Belloni wrote:
> > > +# CONFIG_EARLY_PRINTK is not set
> >=20
> > Only Loongson1b/1c explicitly disable early printk. Do you disable it
> > for a particular reason?
> >=20
>=20
> Well, it is so late that it is not really useful and I don't find that
> particularly interesting to have it on by default.
>=20
> But I don't have a strong opinion, I certainly can let it enabled.

No problem. I leave it up to you.

Cheers
James

--hOh8F6DNH/RZBSFD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqVhhcACgkQbAtpk944
dnotlxAAnBfvV8heomFoH/M+7buskOB+k3rUeZxCzMnF5UX5iPcsLtJnI6fl/NGT
FHfs0SevT8qXG6LGu4Tsv/poUI7/9b+Hma/LYUm2DBF9GW5DfRty1HIgFs8LFqmA
XkLg+ZsbQta/FthCY5/8/+fJYAYgF5t16O/tNciQ0eYA30f3LU4W86C5q7pgixaE
9uQzb+U75B3u6l9qcPBqE+XzSDiZfh30RQC5fMlf9ANN5oAHr/2wtlUtZWJYCvVV
A9S32SnpkOEhkIOk1RHKcpvcJiJb0ZuyWeVJx0ecRs4cZNOywu0DeKveweLh6kKJ
GRwIhgRjeqXIYfiLSTpt2nhQJwqYOh7twhQuJY/SC85dgRcJ7+14+20L5DDxcAPb
kNRRjPtQCorkR4GZ7Ax06TlSE4hlEoPoQeKXV+z9yLWVvOPW0io4hv3H7OTHOi56
mYTX3pzTrMp8x6kArSGxRqWCFDGJ2wcAJeWLuC8Ki0p/5HUft0ntpKytB9ghzL05
OsmtLv4/dAXwYnobTsWBaoVBtgl195oyJVHKDfPSUP5L+YcbVY2tZJ/XwtFowchX
4tHBqcuvyJ2rICpSLJEwqfWNRe1UO3vLHPsNpHIV6flv5IAIhfOHfjoFX5KYolRs
A0LyuFdTaps+pScL7MIcWzfTxYmdNZX9t+bbWkHQPNs9mxcavBw=
=rYpJ
-----END PGP SIGNATURE-----

--hOh8F6DNH/RZBSFD--
