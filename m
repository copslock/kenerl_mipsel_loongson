Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 15:19:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6067 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993179AbdDFNTHG2fyi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 15:19:07 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 2F49241F8D68;
        Thu,  6 Apr 2017 15:25:17 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 06 Apr 2017 15:25:17 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 06 Apr 2017 15:25:17 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5BFD26E3133D9;
        Thu,  6 Apr 2017 14:18:57 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 6 Apr
 2017 14:19:00 +0100
Date:   Thu, 6 Apr 2017 14:19:00 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Amit Pundir <amit.pundir@linaro.org>
CC:     <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>,
        Felix Fietkau <nbd@nbd.name>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH for-4.4 7/7] MIPS: Lantiq: Fix cascaded IRQ setup
Message-ID: <20170406131900.GS31606@jhogan-linux.le.imgtec.org>
References: <1491482940-1163-1-git-send-email-amit.pundir@linaro.org>
 <1491482940-1163-8-git-send-email-amit.pundir@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KjJb61kpjaVQeLm7"
Content-Disposition: inline
In-Reply-To: <1491482940-1163-8-git-send-email-amit.pundir@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57599
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

--KjJb61kpjaVQeLm7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Amit,

On Thu, Apr 06, 2017 at 06:19:00PM +0530, Amit Pundir wrote:
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

Weren't you going to drop this one?

Cheers
James

--KjJb61kpjaVQeLm7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY5kA9AAoJEGwLaZPeOHZ6FFIP/j977lGKLx98azmWxYPtrAS5
6BBGqikC+rXkNBQ+UbJ8qrQChBsDckyIxrX7tBAy3yYhmLVX6DwXeG2TBUM4D5X9
aqtGDIyOX0bw53UmrLq18Gql0GsSSSmTdUUCrLdMTn3aVSD7dtTWrb1r032IhkaR
ksMU+rEe0anfg4tQyaN+w3LqL7dMAR4DwVacTbUxZGwr+ZeXfBggTOpaPSIoOGhO
cuVEodqzAbidJnYMWTYSHDLo0HO5Tr7prJNOKKzf7vEeX+OBkddLU+7vH/m1Q5Bb
5Mvh7QpXXC52zXdsFgGmScEP/MJsSPJJGXKlQDYVhll/NmFOGFFzd1zchcYy8kpt
hAx/DTA2YV+U4oWxsiMboOjd0nXsYs0KudiSyqkqNtfZrPAoy7aO9rvJRc1YGvNW
ItxQCz9pN0NDWeY4ljT4QcR0EG0pIy1zpf2fbAhAJv1Tbw4CM90RgNn0l5GH6lRt
ej0B0Zq8YjFl4Wbt9wx56jiS0jGasXdvGuHogvRhe1n+QaJ2iSkk2vghxfZDB66R
TSSYMZEH/1K026VFd2s8s2pUWxFFCFn4FVyTzjXBlFuIMli4t/HEzkr7ac3WbYQA
c4Y6HvogyJ6aj5S7m8Xdi8Gc3jE4UAhKz9CdyIl8mxgUxi96TFnWtF6e4p56tFw3
KgIeO82KBlZZAZ8C/wKG
=BR8B
-----END PGP SIGNATURE-----

--KjJb61kpjaVQeLm7--
