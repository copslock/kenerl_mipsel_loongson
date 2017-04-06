Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 11:30:01 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28999 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990519AbdDFJ3xtafWJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 11:29:53 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id BAB2341F8D68;
        Thu,  6 Apr 2017 11:36:03 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 06 Apr 2017 11:36:03 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 06 Apr 2017 11:36:03 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id F1D5184D71129;
        Thu,  6 Apr 2017 10:29:44 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 6 Apr
 2017 10:29:47 +0100
Date:   Thu, 6 Apr 2017 10:29:47 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Amit Pundir <amit.pundir@linaro.org>
CC:     <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        Felix Fietkau <nbd@nbd.name>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2 for-4.9 04/32] MIPS: Lantiq: Fix cascaded IRQ setup
Message-ID: <20170406092947.GQ31606@jhogan-linux.le.imgtec.org>
References: <1491388344-13521-1-git-send-email-amit.pundir@linaro.org>
 <1491388344-13521-5-git-send-email-amit.pundir@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8HHeiRpSfOSMcPVo"
Content-Disposition: inline
In-Reply-To: <1491388344-13521-5-git-send-email-amit.pundir@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57580
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

--8HHeiRpSfOSMcPVo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Amit,

On Wed, Apr 05, 2017 at 04:01:56PM +0530, Amit Pundir wrote:
> From: Felix Fietkau <nbd@nbd.name>
>=20
> With the IRQ stack changes integrated, the XRX200 devices started
> emitting a constant stream of kernel messages like this:
>=20
> [  565.415310] Spurious IRQ: CAUSE=3D0x1100c300
>=20
> This is caused by IP0 getting handled by plat_irq_dispatch() rather than
> its vectored interrupt handler, which is fixed by commit de856416e714
> ("MIPS: IRQ Stack: Fix erroneous jal to plat_irq_dispatch").
>=20
> Fix plat_irq_dispatch() to handle non-vectored IPI interrupts correctly
> by setting up IP2-6 as proper chained IRQ handlers and calling do_IRQ
> for all MIPS CPU interrupts.
>=20
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> Acked-by: John Crispin <john@phrozen.org>
> Cc: linux-mips@linux-mips.org
> Patchwork: https://patchwork.linux-mips.org/patch/15077/
> [james.hogan@imgtec.com: tweaked commit message]
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>=20
> (cherry picked from commit 6c356eda225e3ee134ed4176b9ae3a76f793f4dd)
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>

Is there a particular reason this is desired in stable? I was under the
impression it was only helpful in the presence of a bug in the separate
IRQ stack stuff in 4.11, which was fixed in the above mentioned commit
de856416e714 ("MIPS: IRQ Stack: Fix erroneous jal to
plat_irq_dispatch"), and otherwise just a nice to have cleanup.

If you've cherry picked the IRQ stack work, have you also cherry-picked
de856416e714?

Cheers
James

--8HHeiRpSfOSMcPVo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY5gqEAAoJEGwLaZPeOHZ6PAEQAIqVEPVRWYEM2dwbTEeUmkSh
1ycYD7wXDIsi6RNXqtIr35+L0lRUE758BKAWom1SIWHKrQh32XUO7s0QnLUoSA8v
BWQBBkmOIHfSFwbbXM08ep89CcexxVWqljgOC8qgMD1HI9raXpuhABQMZy96xtHH
IfOua1NpYZuFPCVTpo/r2qHPXDy5TK1JHl2pcm9E+NgkDcA+q9yTcmN9nulzbtdV
5kZDpU+9J0V/KnyiugRnAGl5OIoCG2TwtCm9AwZk/5X1TXL9YSGgtFsBCa/HBffx
rBRqFhNRbZIyPru+Lsc/YRpZbmsl8S833raR2gDmKR5ezN6eA347Q679oHUgU5cQ
STv5Q/xW/qEx7P419W3d3QMN8KxWRM4n1w4Mze7rOaY/xsxsOKU4Iw8om5xBuujd
LgIZwRd9YZqwf6/h6/EGL8p1/7w7ne8LDYCXLuk0i6di+e8lwQZDnpNZMlB7iarF
rVbvon50OURuS5exG8llnR5k6FwZsX/OQKHfNCwSfx+hYNEJAsMvVN/1FZsArub4
3YrL5hUWOknCFrcPE60EaV/CvlhH+joHhul2UGBgWX9cvDfBm78MWRE+vLnK1kVu
dQD/1uUY4laDNl057iupAeKnAjgy9YghxT1RoUaqmR8b6HVEY0BRDukXHJIOz5S8
JtSALxKqh6eFuBQW5jmW
=ZbgZ
-----END PGP SIGNATURE-----

--8HHeiRpSfOSMcPVo--
