Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 12:06:47 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:44200 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990436AbdK1LGkF3h5- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 12:06:40 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 28 Nov 2017 11:06:17 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 28 Nov
 2017 03:04:37 -0800
Date:   Tue, 28 Nov 2017 11:04:35 +0000
From:   James Hogan <james.hogan@mips.com>
To:     David Daney <ddaney@caviumnetworks.com>
CC:     "Steven J. Hill" <steven.hill@cavium.com>,
        <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
Subject: Re: [PATCH v3 04/11] MIPS: Octeon: Remove usage of cvmx_wait()
 everywhere.
Message-ID: <20171128110434.GE27409@jhogan-linux.mipstec.com>
References: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
 <1510633827-23548-5-git-send-email-steven.hill@cavium.com>
 <2f2def3f-e047-1a46-1cd7-ebf4744dc2c3@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
Content-Disposition: inline
In-Reply-To: <2f2def3f-e047-1a46-1cd7-ebf4744dc2c3@caviumnetworks.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1511867176-452059-20463-34679-5
X-BESS-VER: 2017.14.1-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187372
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, Nov 27, 2017 at 10:56:33AM -0800, David Daney wrote:
> On 11/13/2017 08:30 PM, Steven J. Hill wrote:
> > From: "Steven J. Hill" <Steven.Hill@cavium.com>
> >=20
> > Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> > Acked-by: David Daney <david.daney@cavium.com>
> > ---
> >   arch/mips/cavium-octeon/executive/cvmx-helper.c |  2 +-
> >   arch/mips/cavium-octeon/executive/cvmx-spi.c    | 10 +++++-----
> >   arch/mips/include/asm/octeon/cvmx-fpa.h         |  4 +++-
> >   arch/mips/include/asm/octeon/cvmx.h             | 15 ++-------------
> >   arch/mips/pci/pcie-octeon.c                     | 12 ++++++------
> >   5 files changed, 17 insertions(+), 26 deletions(-)
> >=20
>=20
> WTF:
>=20
> drivers/staging/octeon-usb/octeon-hcd.c: In function 'cvmx_fifo_setup':
> drivers/staging/octeon-usb/octeon-hcd.c:636:2: error: implicit=20
> declaration of function 'cvmx_wait' [-Werror=3Dimplicit-function-declarat=
ion]
> cc1: some warnings being treated as errors
>=20
> Why was this patch submitted and merged without running git-grep on=20
> cvmx_wait?

I guess I put too much store by your ack ;-)

Lesson learned, I'll grep next time.

>=20
> Steven, send a patch to fix the breakage.

See this patch & thread which you were Cc'd on:
https://lkml.kernel.org/r/20171117075010.24131-1-aaro.koskinen@iki.fi

Cheers
James

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlodQrYACgkQbAtpk944
dnpVuQ//aPI6eMHm89UPCnApI/jS2kfAuhC5cZVnN2QXrnZGYsxOyBKdSzHPY+7F
I7ZTjOI9Gz0XZtKtY/3+utY1eiNKQLCJbAeS95tHGNaF72kl+V6e6rxzDiWC/04U
eVXyxq+Y8fmqAqCV6EP7g2RQHsCsUXjGwBGsJFLFDtIuNg1oyl7Kts6qC490sIak
gFxqnq9nevrJSspbM3cienaKeRdp774DpWdm9dVu3Nbe/0wG9+dCJlgbzXS4jQLB
sUY7/DKhbJtyQ28ic+NP2xmCjcDNbrA0MehpRV8ZhfFvsXqD0F3DsUVak3zgO4Ko
mr+Px33UhqKjvoLXZfrKcawyzBKHG0faEdtYWgKPtBZZBLNkWfKQ8zO0k6Qo3H3d
LFlU46MjFUz2feyeNlA+NXDAxMgA0r5Akp8TSgHQw0ufDurqv2gdfUKwG4a4D8y6
A1O9DDwSM6ZTnjzSsQrZWaNAdzxudrbRB6q/sizn54P4jsNiGQMUieGcuPQw6eNH
UKbx6svGXJ7+kZzyew9YarZtE9RFC2BclNJWCmdAV/zjvjQUZYMAMVSgO0v2kY3W
tyFlX1zRu9N3wrNgcBs9B7zKNbCLSgGDMrexiT0YfA/7VGXSfEIIInCEKxTFytnx
d2Xbnnrt5BFWGehce+1eWv1nS5bOde4pPM4qnLYuL1JrrOq1fmY=
=YckL
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--
