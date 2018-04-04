Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Apr 2018 00:03:26 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:53266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994611AbeDDWDPnPhyJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Apr 2018 00:03:15 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B393A2133F;
        Wed,  4 Apr 2018 22:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B393A2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 4 Apr 2018 23:02:58 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     matt.redfearn@mips.com, antonynpavlov@gmail.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org, mcgrof@kernel.org,
        robin.murphy@arm.com, geert@linux-m68k.org,
        linux-riscv@lists.infradead.org, clm@fb.com,
        ynorov@caviumnetworks.com, jk@ozlabs.org, f.fainelli@gmail.com,
        Greg KH <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, bart.vanassche@wdc.com, robh@kernel.org,
        terrelln@fb.com, dan.j.williams@intel.com, albert@sifive.com,
        viro@zeniv.linux.org.uk, tom@quantonium.net,
        linux-kernel@vger.kernel.org, richard@nod.at,
        paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH v5 2/3] lib: Rename compiler intrinsic selects to
 GENERIC_LIB_*
Message-ID: <20180404220258.GA9347@saruman>
References: <1522747466-22081-2-git-send-email-matt.redfearn@mips.com>
 <mhng-58affcc9-9eff-4403-861e-e40aea063afc@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <mhng-58affcc9-9eff-4403-861e-e40aea063afc@palmer-si-x1c4>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63414
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


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 03:39:34PM -0700, Palmer Dabbelt wrote:
> Sorry, I'm not sure if this is the right patch -- someone suggested ackin=
g=20
> this, but it's already Review-By me and if I understand correctly it's go=
ing=20
> through your tree.  I'm a bit new to this, but if it helps then here's a
>=20
> Acked-By: Palmer Dabbelt <palmer@sifive.com>

Thanks Palmer.

No worries. FYI Documentation/process/submitting-patches.rst appears to
now contain lots of gory detail about what Acked-by and Reviewed-by are
supposed to mean.

In this case an acked-by is needed to show your approval of the parts of
the patch which touch the subsystem you are responsible for (and/or code
which you have authored) so that the patch can go via another tree. It
usually indicates that you've reviewed those parts of the patch too, but
not necessarily the whole thing.

Cheers
James

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrFS4sACgkQbAtpk944
dnpr9g//V8bKit7US+KbeZJcnQjS9mk4j6Jy5u79FCg4cQEUhojq+VmZufEd4tLL
OxlaWa1DhT9QOhnFsqflnqZ707KOeEtuvrTZnAvfWhyg+pyjfpH0OZ8I945p7Vrv
KWDQRJZWVWLSJsfCyx/kmFlGqtFvAkYN0tJmPm6VgNP5PxXrl3pSle+EqBaRXTEH
rVyotC9jHPiGZ7j8v8f+uUi0LgmD5kWCgTOmHHGHtrB7t2yEPOV9bMmcBW+Cxczs
ylQ4MenNoFKBbbaDSnSBLwHRCUeiuVk87Xw9TTaRVl0uwZjk0HxIZqRqX6DhTZ4q
zbE0hYWWNH5ZYNOjhJXoyU3eerqkMLpSfhrFvF14Ju5ZiwipXg3bsA24B4ZY6R0l
MFRQ5EMJPWbzBbnpdxYRq0vmwwZGugH58h81JsRhl1WPKKy5pMUT1OCtd8UoEF10
Rhv1/YgKsPeaM3WRYlBG6/PDVZzkKJC+ldq6jFvd3QaLnlKJ88r8L4Db8vLguLng
Pg7QTyLQeQxK4wkTy5/FIJ8All79Cg6ZIjqoiZlNriiiS5SJLPQKCJZrk0nXsSOX
R7YsbYZ3xcC1eoVAbXQptvLUoJxOz1pfQzX4gCsR2FyWVBiDpPH1jrEdsktvBe6S
tLOFU206tw47obnBN51tNelX68f83D7zvIrXs/zMI6WVQYQDf6o=
=+XC4
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
