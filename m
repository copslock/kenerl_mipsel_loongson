Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 15:15:43 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:47693 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbdKMOPeAQZFH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Nov 2017 15:15:34 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 13 Nov 2017 14:15:10 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 13 Nov
 2017 06:15:10 -0800
Date:   Mon, 13 Nov 2017 14:15:08 +0000
From:   James Hogan <james.hogan@mips.com>
To:     John Crispin <john@phrozen.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/3] arch: mips: pci: cleanups and fixes for mt7620 driver
Message-ID: <20171113141507.GA31917@jhogan-linux.mipstec.com>
References: <1487582984-40143-1-git-send-email-john@phrozen.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <1487582984-40143-1-git-send-email-john@phrozen.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510582510-321459-27079-249108-1
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186878
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
X-archive-position: 60871
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

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 10:29:41AM +0100, John Crispin wrote:
> While updating the LEDE kernel to v4.9 i stumbled across a fw compile
> warnings. While fixing these warnings I also noticed that the BIT() macro
> was not used.
>=20
> John Crispin (3):
>   arch: mips: pci: remove duplicate define in mt7620 driver
>   arch: mips: pci: remove KERN_WARN instance inside the mt7620 driver
>   arch: mips: pci: make use of the BIT() macro inside the mt7620 driver

Thanks, all applied.

Cheers
James

>=20
>  arch/mips/pci/pci-mt7620.c |   15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>=20
> --=20
> 1.7.10.4
>=20

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloJqOQACgkQbAtpk944
dnpynQ//TjDU0q7MWwDWqT5wyBWEOkwUD+M3a39Jcizo8/k8EZT5DGYHlGrZzyID
I9ZW9nlgZSafvmTr3r3byn9ODtoU0DuoM9Ag3jC/vU9SVNiATY8LPFJUKNTFoCxN
gwcA5Ex+b2SxepIx66zim7OHlGyxV73IFHqQWAV2s4vArqCThxDOiHsEKv29Sm7c
UgDinB5zeC0LJ+B9lHTFsBy5amd/HHP3KNf2D2eL6Iav9GYApmntte4nVajjePQl
ioRyUNiNvMQyzgPOp+SMbdYVSZHy+xxNA7VhlD2A8AR63A1JmAth0NaJ3Q7pd5II
EOVEjhyK5846Xhm+NrrEAQonqoeu2U6uqisHcAhM6hsGc1C8+FvdqbiiqfHoyaom
my/Lr35S6o+8JVVEQnTzsSNBqEczWOMb9aL98v04aygWpoZ1A4Pi4TLKCEdAU+NY
dzXtbeJP9ilBxXTsQK2q8gCUZ8o2xOOvj0Yl1YYAm8E9sylTsFe5cT6c4bDpSNHQ
PeVqPpq5MiLlPFM0eNJakI0zuZEwy5Jz30abdKzy8UOTpc9SYOEyuDPeL5lZaktQ
7vn95wj0vzGv9nZrh/ci6ZUhQwJCIlcCrBeBO5rDRG7jBW+Y8cZDngq1z12906n3
o2qAoOldLusBLz8e/c5F6eY9m1M5l4xnZ7LARwgqoyD1vjF7ejs=
=0rXo
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
