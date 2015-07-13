Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 12:27:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58603 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009255AbbGMK146gC98 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 12:27:56 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 7FAAA41F8DED;
        Mon, 13 Jul 2015 11:27:51 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 13 Jul 2015 11:27:51 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 13 Jul 2015 11:27:51 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 50D88B684C6CB;
        Mon, 13 Jul 2015 11:27:49 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 13 Jul 2015 11:27:51 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 13 Jul
 2015 11:27:50 +0100
Message-ID: <55A392AB.9030702@imgtec.com>
Date:   Mon, 13 Jul 2015 11:27:55 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Andrew Bresticker <abrestic@chromium.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/9] MIPS: MT: Remove "weak" from vpe_run() declaration
References: <20150712230402.11177.11848.stgit@bhelgaas-glaptop2.roam.corp.google.com> <20150712231120.11177.53145.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150712231120.11177.53145.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="TJIfCbCaNoWrPJGRqIJ0wsBmq2MflrMjl"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: e4aa9c8
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48225
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

--TJIfCbCaNoWrPJGRqIJ0wsBmq2MflrMjl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13/07/15 00:11, Bjorn Helgaas wrote:
> Weak header file declarations are error-prone because they make every
> definition weak, and the linker chooses one based on link order (see
> 10629d711ed7 ("PCI: Remove __weak annotation from pcibios_get_phb_of_no=
de
> decl")).
>=20
> That's not a problem for vpe_run() because Kconfig ensures there's neve=
r
> more than one definition:
>=20
>   - vpe_run() is defined in arch/mips/kernel/vpe-mt.c if
>     CONFIG_MIPS_VPE_LOADER_MT=3Dy
>=20
>   - vpe_run() is defined in arch/mips/mti-malta/malta-amon.c if
>     CONFIG_MIPS_CMP=3Dy
>=20
>   - CONFIG_MIPS_VPE_LOADER_MT cannot be set if CONFIG_MIPS_CMP=3Dy
>=20
> But it's simpler to verify correctness if we remove "weak" from the pic=
ture
> and test the config symbols directly.
>=20
> Remove "weak" from the vpe_run() declaration and use #if to test whethe=
r a
> definition should be present.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/mips/include/asm/vpe.h |    2 +-
>  arch/mips/kernel/vpe.c      |   10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/mips/include/asm/vpe.h b/arch/mips/include/asm/vpe.h
> index 7849f39..80e70db 100644
> --- a/arch/mips/include/asm/vpe.h
> +++ b/arch/mips/include/asm/vpe.h
> @@ -122,7 +122,7 @@ void release_vpe(struct vpe *v);
>  void *alloc_progmem(unsigned long len);
>  void release_progmem(void *ptr);
> =20
> -int __weak vpe_run(struct vpe *v);
> +int vpe_run(struct vpe *v);
>  void cleanup_tc(struct tc *tc);
> =20
>  int __init vpe_module_init(void);
> diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
> index 72cae9f..04539d6 100644
> --- a/arch/mips/kernel/vpe.c
> +++ b/arch/mips/kernel/vpe.c
> @@ -817,15 +817,11 @@ static int vpe_open(struct inode *inode, struct f=
ile *filp)
> =20
>  static int vpe_release(struct inode *inode, struct file *filp)
>  {
> +#if defined(CONFIG_MIPS_VPE_LOADER_MT) || defined(CONFIG_MIPS_CMP)

That should be CONFIG_MIPS_VPE_LOADER_CMP, in which case the error case
in the #else bit is always dead code. This file is built only if
CONFIG_MIPS_VPE_LOADER, and the other ones are defined without prompts:

config MIPS_VPE_LOADER_CMP
	bool
	default "y"
	depends on MIPS_VPE_LOADER && MIPS_CMP

config MIPS_VPE_LOADER_MT
	bool
	default "y"
	depends on MIPS_VPE_LOADER && !MIPS_CMP

I.e. one xor the other must be "y" when MIPS_VPE_LOADER=3Dy.

Maybe its worth just removing the weak and the vpe_run check?

Cheers
James

>  	struct vpe *v;
>  	Elf_Ehdr *hdr;
>  	int ret =3D 0;
> =20
> -	if (!vpe_run) {
> -		pr_warn("VPE loader: ELF load failed.\n");
> -		return -ENOEXEC;
> -	}
> -
>  	v =3D get_vpe(aprp_cpu_index());
>  	if (v =3D=3D NULL)
>  		return -ENODEV;
> @@ -855,6 +851,10 @@ static int vpe_release(struct inode *inode, struct=
 file *filp)
>  	v->plen =3D 0;
> =20
>  	return ret;
> +#else
> +	pr_warn("VPE loader: ELF load failed.\n");
> +	return -ENOEXEC;
> +#endif
>  }
> =20
>  static ssize_t vpe_write(struct file *file, const char __user *buffer,=

>=20


--TJIfCbCaNoWrPJGRqIJ0wsBmq2MflrMjl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVo5KsAAoJEGwLaZPeOHZ6BcMP+wSdfXv5leqvijgMpX0wNMOw
1F1n53eiuh1O+btL/EaxuenDy88Rjzeszq79Wa2exukWzdujrpi5OFuKw+cbalW2
LNCU/p4jP+q+KVtwjAONhTxQlei1YekTcJDi1iZDx19rNFBcZsdqNGNfI42KqS+y
Pd1pSUzUttzE/MZ5xY7NL4JnbQVAT+75wxal49WhkSFdW15rU7FNGPj9SJ51XTqE
AEoL+ILCSCFidoZYMtSlbAQzOGgCfJuXWsA/z7a3fkEA/3XgxYjRRsh4LkDxRpBY
BqD6n9JpCC82culks9ifO/bNzzxu4ZYmZEk946Feq0JVNInKeXUQ/Y9ZK6bKoDDB
o742oHStJCcvxBz1sJXgOIKax0H17TCpecKhVpRfVBjUYohpV6OoBEYb+UoB767w
S9KCtc3OBSwZMCTrE1dcZICJSypEuwWJonoKCbpRKnaU3bl4Fnin5DARkvH+ZebJ
iEX2hcXb4PSMGk+PrZGFU3LgyYpiS/QaR6pDyuncrtNmEGNZ0hPr0ChA0+tZy3pV
0LJi7VTnzSZA7ZWCiAA3xNPcWf2OPfOxjK5P7pwoOw7cdiNqnYDcJ0BfHV0d3Rmj
+hOXFpTD0C88CsXRoM97OslNY3hfM010aM7Jc/9zrinuAmUG6dlSMBeIpeqhzBRH
Jh2vk0aC1V3tzJ9Y0m88
=vN3O
-----END PGP SIGNATURE-----

--TJIfCbCaNoWrPJGRqIJ0wsBmq2MflrMjl--
