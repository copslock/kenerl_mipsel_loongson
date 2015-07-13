Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 11:32:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31784 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009001AbbGMJb6O6Kjr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 11:31:58 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id E783641F8DED;
        Mon, 13 Jul 2015 10:31:52 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 13 Jul 2015 10:31:52 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 13 Jul 2015 10:31:52 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 49897F50363A;
        Mon, 13 Jul 2015 10:31:50 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 13 Jul 2015 10:31:52 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 13 Jul
 2015 10:31:52 +0100
Message-ID: <55A3858D.6020405@imgtec.com>
Date:   Mon, 13 Jul 2015 10:31:57 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Andrew Bresticker <abrestic@chromium.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/9] MIPS: Remove "weak" from get_c0_fdc_int() declaration
References: <20150712230402.11177.11848.stgit@bhelgaas-glaptop2.roam.corp.google.com> <20150712231146.11177.23561.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150712231146.11177.23561.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="L3I9CbCiWgfUg1gqMCXAiIju2pDqNi8uK"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: f107b6f
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48220
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

--L3I9CbCiWgfUg1gqMCXAiIju2pDqNi8uK
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13/07/15 00:11, Bjorn Helgaas wrote:
> Weak header file declarations are error-prone because they make every
> definition weak, and the linker chooses one based on link order (see
> 10629d711ed7 ("PCI: Remove __weak annotation from pcibios_get_phb_of_no=
de
> decl")).
>=20
> get_c0_fdc_int() is defined only in arch/mips/mti-malta/malta-time.c so=


well, until 6b5e741e9a83 ("MIPS: Pistachio: Support CDMM & Fast Debug
Channel") in v4.2-rc2 ;-)

> there's no problem with multiple definitions.  But it works better to h=
ave
> a weak default implementation and allow a strong function to override i=
t.
> Then we don't have to test whether a definition is present, and if ther=
e
> are ever multiple strong definitions, we get a link error instead of
> calling a random definition.
>=20
> Add a weak get_c0_fdc_int() definition with the default code and remove=
 the
> weak annotation from the declaration.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: James Hogan <james.hogan@imgtec.com>

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Thanks
James

> ---
>  arch/mips/include/asm/irq.h  |    2 +-
>  drivers/tty/mips_ejtag_fdc.c |    9 ++++++---
>  2 files changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
> index f0db99f8..15e0fec 100644
> --- a/arch/mips/include/asm/irq.h
> +++ b/arch/mips/include/asm/irq.h
> @@ -49,7 +49,7 @@ extern int cp0_compare_irq_shift;
>  extern int cp0_perfcount_irq;
>  extern int cp0_fdc_irq;
> =20
> -extern int __weak get_c0_fdc_int(void);
> +extern int get_c0_fdc_int(void);
> =20
>  void arch_trigger_all_cpu_backtrace(bool);
>  #define arch_trigger_all_cpu_backtrace arch_trigger_all_cpu_backtrace
> diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.=
c
> index 358323c..a8c8cfd 100644
> --- a/drivers/tty/mips_ejtag_fdc.c
> +++ b/drivers/tty/mips_ejtag_fdc.c
> @@ -879,6 +879,11 @@ static const struct tty_operations mips_ejtag_fdc_=
tty_ops =3D {
>  	.chars_in_buffer	=3D mips_ejtag_fdc_tty_chars_in_buffer,
>  };
> =20
> +int __weak get_c0_fdc_int(void)
> +{
> +	return -1;
> +}
> +
>  static int mips_ejtag_fdc_tty_probe(struct mips_cdmm_device *dev)
>  {
>  	int ret, nport;
> @@ -967,9 +972,7 @@ static int mips_ejtag_fdc_tty_probe(struct mips_cdm=
m_device *dev)
>  	wake_up_process(priv->thread);
> =20
>  	/* Look for an FDC IRQ */
> -	priv->irq =3D -1;
> -	if (get_c0_fdc_int)
> -		priv->irq =3D get_c0_fdc_int();
> +	priv->irq =3D get_c0_fdc_int();
> =20
>  	/* Try requesting the IRQ */
>  	if (priv->irq >=3D 0) {
>=20


--L3I9CbCiWgfUg1gqMCXAiIju2pDqNi8uK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVo4WNAAoJEGwLaZPeOHZ6ZhsP/2rYyIMrfn61TunNA3obAYjj
EV0WgQ1SZekvcUCribU7kCNbHvyqXIRFaTq7MBtqO+d4nI/dOIEYKXq8rk94BVnD
8TkkBghe5CeGMr+oI9VdEVJo9C9ZVR4tNPvH8why/g6chJEztHA0iA0peJHkyRUT
pwZSTqsJcolb9GzmuMeFgYSYiMo1eLlMrQ6ew6DXw0wfcvwJDCSzLtT2dXfRVztt
UnybXqmzaFCBlb1rz8g4kocUYczqD4Bbza5mraCwOXLPtft4mxqMz8tdLXBewyxv
UVDJySvyqy93mSkoC03ME2pArLV85HVgkPPAqZ419mlT67L6escLDFrigUA+1W2Q
Bt3Y8LIVVTSA2UAsW4HoXdbCSnXA0fAjtVxD0o0PCGjLXHtyog/leQbCIWPNc3fi
rdHr7eLI9aUOT8m+UaFQHZCoW/bdKdgHuOs7uxCr3xb4//HvQdcHghR48NmlSoGT
VUWMX7718/5KLydmnIw8EaeFn1jfC9USDcN+xgbrOmZeD/fcvkDCJ7B1EwBm+EVy
SQLyOr8dUYlFunbC9voG3ioykXurJtBIAmtnzr2RbbyaJaE218gvX6B+DK5NgLql
Th773NiJDJyNP5PsVyxjKd+wvoUKHki10sqbJM/A1YIuVtjt9SEx1qq/UYAHRYEo
zFU9vqokJld4ZASFZJbK
=+TwD
-----END PGP SIGNATURE-----

--L3I9CbCiWgfUg1gqMCXAiIju2pDqNi8uK--
