Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Nov 2016 15:22:15 +0100 (CET)
Received: from www.zeus03.de ([194.117.254.33]:48798 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992514AbcK1OWJ2t1vQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Nov 2016 15:22:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=JESQx2AZTUX4ef2CWe4u9DRcmC7c
        j17qsq6rk5Q1Yjo=; b=tCvrM0wrZXNBkJ+itovtlZAH+3jl4H/RbpmDOJtTfNMz
        NNWeDZ67HcmkqTSvDgcaWqXaDnSeKDoJdqa76OTdlJU+bvItRqQJvQ4NQb5tEPQo
        JP3FajtEoQs40nnOmiuFlVty55qCwRWbUlvtVh/9XGGBnSlgHD1TG7Pm/goBgJw=
Received: (qmail 28866 invoked from network); 28 Nov 2016 15:22:08 +0100
Received: from p5b384559.dip0.t-ipconnect.de (HELO localhost) (l3s3148p1@91.56.69.89)
  by mail.zeus03.de with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 28 Nov 2016 15:22:08 +0100
Date:   Mon, 28 Nov 2016 15:22:08 +0100
From:   Wolfram Sang <wsa-dev@sang-engineering.com>
To:     Jan Glauber <jan.glauber@caviumnetworks.com>
Cc:     "Steven J. Hill" <Steven.Hill@cavium.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v2 0/3] i2c: octeon: thunder: Fix i2c not working on
 Octeon
Message-ID: <20161128142208.GA3916@katana>
References: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
 <99500824-4c63-b769-ad66-c136529b14b2@cavium.com>
 <20161122120106.GB3993@katana>
 <20161122145539.GA7716@hardcore>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20161122145539.GA7716@hardcore>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <wsa-dev@sang-engineering.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsa-dev@sang-engineering.com
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


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > This does not work on Octeon 71xx platforms. I will look at it more
> > > closely tomorrow.
> >=20
> > What's the outcome here? It seems we want a bugfix for 4.9 but this
> > report keeps me reluctant to apply the series.
> >=20
>=20
> Steven, did you have a chance to check which of the patches makes
> Octeon 71xx fail?

How do we proceed with this one? Is somebody at Cavium able to contact
Steven internally? I mentioned this on-going regression to Linus and
said an rc8 would help us, but reading LWN it seems we shouldn't count
on it...


--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYPD2QAAoJEBQN5MwUoCm2JYoP/A4Kkd5Po+2VqOJj356UZYLN
msaLO1kvDAzOWZkTsOf/v4nBcHhxRMswzVyZtQTCFH3UmsYhyT4JxGVvuFHyKcHM
8qefVnHlZ2JaeP7aTpdVuD46x4lEfzbf+aQGAjRChFvW8RYvv3YaK1s6TqzunHVT
Gfmn4T3AP8s/i9RJnzikcUNb6rxL/q+D34vlZjZ4c9TZ+PSqKjc842K8fXowCLXq
HNQ6iOpSyVeqqSLntlSyailItXodbMeiKjtFG00Z3nXnbFwSpNRWQ3fQabbUenuL
HdAX1+9+Z0kq9/L5CBX+j0VENpeOZ5O4S5C/y6KoKny2KSTJpPWpZNPq269IMd2+
YWJ8FK6WPqbhj0JHxn5rtutEfpyvGzq+O7iM2WAbVF0cai9xbDqtfYQpHHJDd4JZ
7Q7GPuPX/REB2hntxN9QN8nPugEJM3/v1XWA4X431DIp2tcsBszie2y3I1DU6zX9
RPJZ/80luWuHNG2U4QsMOJSmVrIoTMiuNCvow1HPveWA8Bg+7kB2XOEUZ1FOQRvG
1rjEJxK69Pu/SmGabGd0xujh2X972U3L1sDKAX5d2Wt+ulN+W2GpDYc5ilL9XB9p
o5NSLQxxhEPCqFd4aTa0b9TQ5Zucz5kN1BiVcjrsNJlLOa2IGmRb8UmC4QQvLeHI
wIeWAipmBc25VPELPbp/
=LeNA
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
