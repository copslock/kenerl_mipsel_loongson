Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2016 12:08:36 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46894 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990521AbcJQKI2zxKxU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2016 12:08:28 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id ADFA341F8E1B;
        Mon, 17 Oct 2016 11:07:59 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.44.0.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 17 Oct 2016 11:07:59 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 17 Oct 2016 11:07:59 +0100
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 52B5EE5DC9FE;
        Mon, 17 Oct 2016 11:08:20 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct 2016
 11:08:23 +0100
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct
 2016 11:08:22 +0100
Date:   Mon, 17 Oct 2016 11:08:22 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        "# 4 . 7+" <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: KASLR: Fix handling of NULL FDT
Message-ID: <20161017100822.GA9443@jhogan-linux.le.imgtec.org>
References: <1476698694-6685-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <1476698694-6685-1-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1cc78754
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55448
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

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Mon, Oct 17, 2016 at 11:04:54AM +0100, Matt Redfearn wrote:
> If platform code returns a NULL pointer to the FDT, initial_boot_params
> will not get set to a valid pointer and attempting to find the /chosen
> node in it will cause a NULL pointer dereference and the kernel to crash
> immediately on startup - with no output to the console.
>=20
> Fix this by checking that initial_boot_params is valid before using it.
>=20
> Fixes: 405bc8fd12f5 ("MIPS: Kernel: Implement KASLR using CONFIG_RELOCATA=
BLE")
> Cc: <stable@vger.kernel.org> # 4.7+
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> ---
>=20
>  arch/mips/kernel/relocate.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/mips/kernel/relocate.c b/arch/mips/kernel/relocate.c
> index ca1cc30c0891..8810183840ca 100644
> --- a/arch/mips/kernel/relocate.c
> +++ b/arch/mips/kernel/relocate.c
> @@ -200,6 +200,7 @@ static inline __init unsigned long get_random_boot(vo=
id)
> =20
>  #if defined(CONFIG_USE_OF)
>  	/* Get any additional entropy passed in device tree */
> +	if (initial_boot_params)
>  	{

The open brace should be on the same line as the if really.

Cheers
James

>  		int node, len;
>  		u64 *prop;
> --=20
> 2.7.4
>=20
>=20

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYBKMQAAoJEGwLaZPeOHZ6NtMP/3RXdTeujPt6l0iMzJ4LVnGp
HjHTqNS58+ToysiUunbRAA3TCyNIvrq60SnmSXhKEU4LR3nJigMi4OOfMIAnPSIl
Vl0nIHqpUrwUo4wbwlYBd9qgcr3uC55S1laQvfMWHcbPQVWfvVaMHjS6ArBp6xAw
m75DJNTfcJo1TXqa/4hZDS19hwH3HOKp5BSJEI8s/gAmqI8rFCty3eUq30o0riUk
FzAxnnl6dI4g0+75DbTOjFnjGt6aDhIB32tgILyw983p5+a9V8aoNY+lYF86bVht
VwYZGRY8Vd9jaAgj+dFlo12CB8DpBkxowbxbak/LV+E0fc6by7sOxKDnBErkUvm8
6iGZs6WHaks49dnM+CVWjG5gmircjlcF0AZT3uXK4uL+uV0UbvS9EIhIrtEVnkal
3tqjDerQaaJeVZvidPTva8NDwkgCMsXrg/fY1oYq+/I8KQdqQ6hfdI5iEfP/CRaa
zSfKdm8nhB4qULDmC/b8OGV7LT+ps7BwfPC8eljnQQfbrKnlIyPX+3Hp4+HdnG40
b2Vlnob6iYY/DbtcowUCoY9VasAKx+5ivJ9N4R4EF/Epw1prOBC5/YcSXCcN3xij
O3Lybcgd0FlXky47P0IVrwE/UrcDao6lT0FFEfDS2lnr4S1KgLi53yjlhsMKo0Cl
6L0ziTthmUUAqfAO9xvt
=3aft
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
