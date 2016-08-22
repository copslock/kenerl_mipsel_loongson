Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Aug 2016 14:14:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22851 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992002AbcHVMOVtiYlm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Aug 2016 14:14:21 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 6914941F8E8A;
        Mon, 22 Aug 2016 13:14:16 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 22 Aug 2016 13:14:16 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 22 Aug 2016 13:14:16 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id BD60F2AB14AAF;
        Mon, 22 Aug 2016 13:14:12 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 22 Aug
 2016 13:14:15 +0100
Date:   Mon, 22 Aug 2016 13:14:15 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
CC:     <linux-mips@linux-mips.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 5/5] mips/kvm: Audit and remove any unnecessary uses of
 module.h
Message-ID: <20160822121415.GB13232@jhogan-linux.le.imgtec.org>
References: <20160821195817.5802-1-paul.gortmaker@windriver.com>
 <20160821195817.5802-6-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
In-Reply-To: <20160821195817.5802-6-paul.gortmaker@windriver.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: cee91754
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54724
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

--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 21, 2016 at 03:58:17PM -0400, Paul Gortmaker wrote:
> Historically a lot of these existed because we did not have
> a distinction between what was modular code and what was providing
> support to modules via EXPORT_SYMBOL and friends.  That changed
> when we forked out support for the latter into the export.h file.
>=20
> This means we should be able to reduce the usage of module.h
> in code that is obj-y Makefile or bool Kconfig.  In the case of
> kvm where it is modular, we can extend that to also include files
> that are building basic support functionality but not related
> to loading or registering the final module; such files also have
> no need whatsoever for module.h
>=20
> The advantage in removing such instances is that module.h itself
> sources about 15 other headers; adding significantly to what we feed
> cpp, and it can obscure what headers we are effectively using.
>=20
> Since module.h was the source for init.h (for __init) and for
> export.h (for EXPORT_SYMBOL) we consider each instance for the
> presence of either and replace as needed.  In this case, we did
> not need to add either to any files.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Kr=C4=8Dm=C3=A1=C5=99" <rkrcmar@redhat.com>
> Cc: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: kvm@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Thanks, looks good and builds fine with KVM enabled for me.

Acked-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>  arch/mips/kvm/commpage.c  | 1 -
>  arch/mips/kvm/dyntrans.c  | 1 -
>  arch/mips/kvm/emulate.c   | 1 -
>  arch/mips/kvm/interrupt.c | 1 -
>  arch/mips/kvm/trap_emul.c | 1 -
>  5 files changed, 5 deletions(-)
>=20
> diff --git a/arch/mips/kvm/commpage.c b/arch/mips/kvm/commpage.c
> index a36b77e1705c..f43629979a0e 100644
> --- a/arch/mips/kvm/commpage.c
> +++ b/arch/mips/kvm/commpage.c
> @@ -12,7 +12,6 @@
> =20
>  #include <linux/errno.h>
>  #include <linux/err.h>
> -#include <linux/module.h>
>  #include <linux/vmalloc.h>
>  #include <linux/fs.h>
>  #include <linux/bootmem.h>
> diff --git a/arch/mips/kvm/dyntrans.c b/arch/mips/kvm/dyntrans.c
> index d280894915ed..b36c8ddc03ea 100644
> --- a/arch/mips/kvm/dyntrans.c
> +++ b/arch/mips/kvm/dyntrans.c
> @@ -13,7 +13,6 @@
>  #include <linux/err.h>
>  #include <linux/highmem.h>
>  #include <linux/kvm_host.h>
> -#include <linux/module.h>
>  #include <linux/vmalloc.h>
>  #include <linux/fs.h>
>  #include <linux/bootmem.h>
> diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
> index e788515f766b..68fd666f8cb9 100644
> --- a/arch/mips/kvm/emulate.c
> +++ b/arch/mips/kvm/emulate.c
> @@ -13,7 +13,6 @@
>  #include <linux/err.h>
>  #include <linux/ktime.h>
>  #include <linux/kvm_host.h>
> -#include <linux/module.h>
>  #include <linux/vmalloc.h>
>  #include <linux/fs.h>
>  #include <linux/bootmem.h>
> diff --git a/arch/mips/kvm/interrupt.c b/arch/mips/kvm/interrupt.c
> index ad28dac6b7e9..e88403b3dcdd 100644
> --- a/arch/mips/kvm/interrupt.c
> +++ b/arch/mips/kvm/interrupt.c
> @@ -11,7 +11,6 @@
> =20
>  #include <linux/errno.h>
>  #include <linux/err.h>
> -#include <linux/module.h>
>  #include <linux/vmalloc.h>
>  #include <linux/fs.h>
>  #include <linux/bootmem.h>
> diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
> index 091553942bcb..21d80274ccff 100644
> --- a/arch/mips/kvm/trap_emul.c
> +++ b/arch/mips/kvm/trap_emul.c
> @@ -11,7 +11,6 @@
> =20
>  #include <linux/errno.h>
>  #include <linux/err.h>
> -#include <linux/module.h>
>  #include <linux/vmalloc.h>
> =20
>  #include <linux/kvm_host.h>
> --=20
> 2.8.4
>=20

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXuuyXAAoJEGwLaZPeOHZ6tfQP/Rqia3yd8oSq/qGrCTC1Pwuc
V5lSY8BSFETpCn2qFtEZpJyU1TYEgy9nMH5B/v53TwJ2Le0H9RBTJA5fIOIPA/ec
ilZdWhmpHlfYnb+TqPB7V10jMLogz/yBlVd10KHV6j0DzbVbXcEcCIFAHFaZIfnB
GgrHDeTOCAYZy3M71oCi8ohrLvoGi0fvvPTogLm5P0JT+2uoUaYIcDBatkXys02J
v7V8wy4erqGR7/k3IgFep2IBXJHKF9RRC5LO2t1zl2N52UY5TpB6ex1njPpaESob
+zxMDz/ttQcHb6tUT9rKLwShvF4IRD6njGIdWo3D1f30J6ZTK8k+3bFRcMXqx0vQ
56bx/iHCQwC+c9iK4finaVqm4QoyPUZfpWWDnWksFwADy2aNA8l5XGdNQgnJ5E/I
Meb3L7f+kww0wAr4/PfYfJV1IdakdYO+Xqs8GIFoV5XWh1LS1a4ftmKhde7v0v9e
GRo1Z7yjIsYdU1wt/jkHIRZXH8sJ6QU3wjtJfH+4k2Je8Vl/SF2byxtloekyvaAg
7WxZepkey7zNK4IaxPk4i+eJn29xl02oeSjiEMaUdHAB6xrTSs+mygs8EjXFa4Hz
y12jvdGkHN3zCrs+3W91z0ry4Eo5odWvcyZ7XfSeaNCyZEvMl7AH3i1f5kZINiDn
J/tuzNsoym4kVGU/TxTC
=TwNw
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
