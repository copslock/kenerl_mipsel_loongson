Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jul 2017 01:42:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44838 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993420AbdGXXmHEiQyt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jul 2017 01:42:07 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 82D7C41F8DE4;
        Tue, 25 Jul 2017 01:53:16 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 25 Jul 2017 01:53:16 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 25 Jul 2017 01:53:16 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8015094C98ABA;
        Tue, 25 Jul 2017 00:41:57 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 25 Jul
 2017 00:42:01 +0100
Date:   Tue, 25 Jul 2017 00:42:00 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH] MIPS: PCI: Fix smp_processor_id() in preemptible
Message-ID: <20170724234200.GW31455@jhogan-linux.le.imgtec.org>
References: <1500563083-13420-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f4arffV+Mc+T1KhS"
Content-Disposition: inline
In-Reply-To: <1500563083-13420-1-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 3d264444
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59229
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

--f4arffV+Mc+T1KhS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2017 at 04:04:43PM +0100, Matt Redfearn wrote:
> Commit 1c3c5eab1715 ("sched/core: Enable might_sleep() and
> smp_processor_id() checks early") enables checks for might_sleep() and
> smp_processor_id() being used in preemptible code earlier in the boot
> than before. This results in a new BUG from
> pcibios_set_cache_line_size().
>=20
> BUG: using smp_processor_id() in preemptible [00000000] code:
> swapper/0/1
> caller is pcibios_set_cache_line_size+0x10/0x70
> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.13.0-rc1-00007-g3ce3e4ba4275 =
#615
> Stack : 0000000000000000 ffffffff81189694 0000000000000000 ffffffff818223=
18
>         000000000000004e 0000000000000001 800000000e20bd08 20c49ba5e35400=
00
>         0000000000000000 0000000000000000 ffffffff818d0000 00000000000000=
00
>         0000000000000000 ffffffff81189328 ffffffff818ce692 00000000000000=
00
>         0000000000000000 ffffffff81189bc8 ffffffff818d0000 00000000000000=
00
>         ffffffff81828907 ffffffff81769970 800000020ec78d80 ffffffff818c7b=
48
>         0000000000000001 0000000000000001 ffffffff818652b0 ffffffff818962=
68
>         ffffffff818c0000 800000020ec7fb40 800000020ec7fc58 ffffffff81684c=
ac
>         0000000000000000 ffffffff8118ab50 0000000000000030 ffffffff817699=
70
>         0000000000000001 ffffffff81122a58 0000000000000000 00000000000000=
00
>         ...
> Call Trace:
> [<ffffffff81122a58>] show_stack+0x90/0xb0
> [<ffffffff81684cac>] dump_stack+0xac/0xf0
> [<ffffffff813f7050>] check_preemption_disabled+0x120/0x128
> [<ffffffff818855e8>] pcibios_set_cache_line_size+0x10/0x70
> [<ffffffff81100578>] do_one_initcall+0x48/0x140
> [<ffffffff81865dc4>] kernel_init_freeable+0x194/0x24c
> [<ffffffff8169c534>] kernel_init+0x14/0x118
> [<ffffffff8111ca84>] ret_from_kernel_thread+0x14/0x1c
>=20
> Fix this by using raw_current_cpu_data instead.
>=20
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> ---
>=20
> In heteregenerous systems the more correct fix for this would be to
> iterate over CPUs checking each ones cache hierarchy. However, as no
> such systems currently exist that seems wasteful.

I fear this may return to bite us at some point.

How about switching to using cpu_*cache_line_size(), which uses
cpu_data[0]? That way we'll at least be able to grep for users when the
macros are later fixed or removed.

Admitedly there is no cpu_tcache_line_size(), but it could be trivially
added.

Cheers
James

>=20
> ---
>  arch/mips/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
> index bd67ac74fe2d..7ef8d97fa324 100644
> --- a/arch/mips/pci/pci.c
> +++ b/arch/mips/pci/pci.c
> @@ -28,7 +28,7 @@ EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
> =20
>  static int __init pcibios_set_cache_line_size(void)
>  {
> -	struct cpuinfo_mips *c =3D &current_cpu_data;
> +	struct cpuinfo_mips *c =3D &raw_current_cpu_data;
>  	unsigned int lsize;
> =20
>  	/*
> --=20
> 2.7.4
>=20
>=20

--f4arffV+Mc+T1KhS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAll2hccACgkQbAtpk944
dnr0pA//bK0m5SsYVUYQkGTD+g5piX+RLF/+urYCiCqVHVc9owfBwHV+HJN8PD/x
nOpLAtZZ+sVY8+uLnX0q4wRq23LqCGH/YXSE5IzOlj4q8QbWhOYThpxXSAlAz/k1
x7DGsDlqh9w3n8V6w3679L0LWvqZXcfKZML9TDVYjRZ6vcEZEAX3+k1/wydibRvE
GVx30TjeVdLt7xba3DtWPeSVXg/fYnHXgLP2OLMvhwfXx9Y6XOd5+NpxEVbvYhVD
/nvPr61e4Sm/LhszmNvk2VvHwL9q+qCPnPbftSTQUZANANTJgNslZGaXE2XjpU7b
RSCD7aWnn8vxKc9j2B0+J+OMikO7SryyJl9dDl1A7kfdGb/0Asizwg+vCjfILo4J
7zCx9YTCBErUsqmBmQBdeRZ7QRXw9kWGH516CKVa82pSVaN6LpL9sUjG9gjbH+Kc
WrJmGQ10njhUnukrOYnENNnjliU4RSiwfIy9TEJOJGdhb/CtSeR1wARENCu/lPDF
SH6FOiMlMoaohKe1ym+9lbLjgXqj8ygdHkDZfR5fr0VjRekfhPJQ/IvuL/11TXEz
vFHBVxThoiDtPOlslSOcOC/+rXEWbglP34dyEZ3vd4FA+Fovaswmx/rh/6vddkdN
p+IAg4qcp8eCkR7fbTcMk+vFP6tbL+PFz95qgeKTJeLPyhSAVw4=
=JVyw
-----END PGP SIGNATURE-----

--f4arffV+Mc+T1KhS--
