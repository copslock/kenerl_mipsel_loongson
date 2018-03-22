Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Mar 2018 14:31:43 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:44620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990406AbeCVNbdAccVm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Mar 2018 14:31:33 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 991C9217D8;
        Thu, 22 Mar 2018 13:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991C9217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 22 Mar 2018 13:31:21 +0000
From:   James Hogan <jhogan@kernel.org>
To:     "Steven J. Hill" <steven.hill@cavium.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v5 0/7] Add Octeon Hotplug CPU Support.
Message-ID: <20180322133121.GF13126@saruman>
References: <1521066258-11376-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Bqc0IY4JZZt50bUr"
Content-Disposition: inline
In-Reply-To: <1521066258-11376-1-git-send-email-steven.hill@cavium.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63146
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


--Bqc0IY4JZZt50bUr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 14, 2018 at 05:24:11PM -0500, Steven J. Hill wrote:
> This patchset adds working Octeon Hotplug CPU. It has been tested
> on our 70xx and 78xx develpoment boards. The 70xx has 4 cores and
> the 78xx has 48 cores. This was also tested on an EdgerouterPRO,
> which has 2 cores.
>=20
> Changes in v4:
> - Rebased against v4.16-rc5 kernel.
> - Smaller patchset due to some previous patches going upstream.

NAK. Please address v4 feedback:

On Thu, Feb 08, 2018 at 10:22:47PM +0000, James Hogan wrote:
> This series doesn't appear to build even cavium_octeon_defconfig since
> patch 1, and is full of checkpatch errors and warnings.

https://patchwork.linux-mips.org/cover/17873/#29723

Thanks
James

--Bqc0IY4JZZt50bUr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqzsCkACgkQbAtpk944
dnpZ8xAAuCMwGNbg4o8/oKkRvJzIl17OYkqT1EuajrUDSInB9l22aTG5M9oYilLO
EVazb59LxOK3PXCwpUAHmEY0Nb1VEC2lW0BBHfH2DWxHRJf9w37g54At4R7RWrzc
Oc40jCKMULc8iaF+rJ1qOx3SwjK/QkKWX3LuaxeDWPFhdMVvzzicytwwmHMQMf7I
/gWwqYa+nbGgXnwPAm1QxmYEfb0CO7WPnZWGnSDztXLcORtZy4fqQyYbM20nwrGF
kjNmcCaP3D/qxyLm11UVjAtzmnz3v57S+YAc5TvVkGk+kYnCRGrQlhN3SeTUAbnE
6Cq8v0VsAuV/PYu2Qj5cTtfjC4y1Pob/ycEhkCdNiOYIj05Vf0jUiRZSTkKHxd4f
5YOtTrhRHbyU9iwszXMntPPCLheSYn+mb5FgZYD3LgkndbTqBG/9qH+g6G/hG2g/
aMe4u4LJi6v0BmvSow7j7OcopRRmbA81xNOrvUdjq6iKHvGIIOpNRoOCh4FraSHw
5Wkfv6KijLnOcUdv5giJ5MVUvCVKZ5IapgyNJWn12SnGioA61nOOj4mPGEZZDtob
e27hynzhRsMcvtefGOYHwfw9ZRgggqO878dW9vUV/C9A9p7us0xuJ8DBP0bKtUlz
cZsRBCCETvmJeNJNHEts/VGZGLBTnk2L666Cm7Q3CA1qXfxriGo=
=vMtG
-----END PGP SIGNATURE-----

--Bqc0IY4JZZt50bUr--
