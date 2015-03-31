Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 21:08:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29832 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009915AbbCaTIJgnN0u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 21:08:09 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id BD69241F8E8D;
        Tue, 31 Mar 2015 20:08:04 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 31 Mar 2015 20:08:04 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 31 Mar 2015 20:08:04 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3C1C54BDD042B;
        Tue, 31 Mar 2015 20:08:01 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 31 Mar 2015 20:08:04 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 31 Mar
 2015 20:08:03 +0100
Date:   Tue, 31 Mar 2015 20:08:03 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Kamal Mostafa <kamal@canonical.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <kernel-team@lists.ubuntu.com>
Subject: Re: [3.13.y-ckt stable] Patch "MIPS: Export FP functions used by
 lose_fpu(1) for KVM" has been added to staging queue
Message-ID: <20150331190803.GD9457@jhogan-linux.le.imgtec.org>
References: <1427827603-26295-1-git-send-email-kamal@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Content-Disposition: inline
In-Reply-To: <1427827603-26295-1-git-send-email-kamal@canonical.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: da4c5968
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46666
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

--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kamal,

On Tue, Mar 31, 2015 at 11:46:43AM -0700, Kamal Mostafa wrote:
> This is a note to let you know that I have just added a patch titled
>=20
>     MIPS: Export FP functions used by lose_fpu(1) for KVM
>=20
> to the linux-3.13.y-queue branch of the 3.13.y-ckt extended stable tree=
=20
> which can be found at:
>=20
>  http://kernel.ubuntu.com/git?p=3Dubuntu/linux.git;a=3Dshortlog;h=3Drefs/=
heads/linux-3.13.y-queue
>=20
> This patch is scheduled to be released in version 3.13.11-ckt18.
>=20
> If you, or anyone else, feels it should not be added to this tree, please=
=20
> reply to this email.
>=20
> For more information about the 3.13.y-ckt tree, see
> https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable
>=20
> Thanks.
> -Kamal
>=20
> ------
>=20
> From 7adee277d64254de602234e7e53691d729f5e50c Mon Sep 17 00:00:00 2001
> From: James Hogan <james.hogan@imgtec.com>
> Date: Tue, 10 Feb 2015 10:02:59 +0000
> Subject: MIPS: Export FP functions used by lose_fpu(1) for KVM
>=20
> commit 3ce465e04bfd8de9956d515d6e9587faac3375dc upstream.
>=20
> Export the _save_fp asm function used by the lose_fpu(1) macro to GPL
> modules so that KVM can make use of it when it is built as a module.
>=20
> This fixes the following build error when CONFIG_KVM=3Dm due to commit
> f798217dfd03 ("KVM: MIPS: Don't leak FPU/DSP to guest"):
>=20
> ERROR: "_save_fp" [arch/mips/kvm/kvm.ko] undefined!
>=20
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Fixes: f798217dfd03 (KVM: MIPS: Don't leak FPU/DSP to guest)
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: Gleb Natapov <gleb@kernel.org>
> Cc: kvm@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Patchwork: https://patchwork.linux-mips.org/patch/9260/
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Kamal Mostafa <kamal@canonical.com>
> ---
>  arch/mips/kernel/mips_ksyms.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
> index 6e58e97..60adf79 100644
> --- a/arch/mips/kernel/mips_ksyms.c
> +++ b/arch/mips/kernel/mips_ksyms.c
> @@ -14,6 +14,7 @@
>  #include <linux/mm.h>
>  #include <asm/uaccess.h>
>  #include <asm/ftrace.h>
> +#include <asm/fpu.h>
>=20
>  extern void *__bzero(void *__s, size_t __count);
>  extern long __strncpy_from_user_nocheck_asm(char *__to,
> @@ -26,6 +27,11 @@ extern long __strnlen_user_nocheck_asm(const char *s);
>  extern long __strnlen_user_asm(const char *s);
>=20
>  /*
> + * Core architecture code
> + */
> +EXPORT_SYMBOL_GPL(_save_fp);

Before v3.16 this will cause a build error with cavium_octeon_defconfig.
I submitted an updated stable patch for v3.10, v3.12, and v3.14, which
should be suitable for v3.13 too. See:
https://marc.info/?l=3Dlinux-mips&m=3D142557178417268&w=3D2

Cheers
James

> +
> +/*
>   * String functions
>   */
>  EXPORT_SYMBOL(memset);
> --
> 1.9.1
>=20

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVGvCTAAoJEGwLaZPeOHZ6R/0P/3kmnTDGZR7jJ/7o8Cg0sMqF
laNiaEfGybZyJ7oxU1KmKJ1zbLT3xz9DxAP1pewlKk5KyjnFe0Yqedy3G9EgEXRH
9saqJG62Mj0rBrd/gr7sF+GRmuDgMpwE97R569AfAPmHzjed6qYg4joPN4R7CeU+
mFn7ptqA7G+QSlrctAnYF/6eE282AgBHpO4OFf3bfcTOUVrrgRcmD/UyL1d+vL0L
uUCiDNVwjxZuET9RcWT5o10P+3KYfsQ6FCV/pxbvhRAhwOldofUb2w/Y8BeD+x7H
7uR+5aummNPrETLyuxNgaMZhyqJGqNCdyMZCnTUNYrZRLa8K8Vnewh6a/svodNSL
zoGVJXRYkSI5ESf1MglxC6YKL8sHSlZRSw/+yQ0k8I0wU7wVFnIUIA0XOuIbtGEW
zldwntcV3gI3EykxijmAeWuCz854oNU3zNBK5GBA5Bu0CwL82mRGti+JnYhx5zMy
Pxa7tmKDKgC3u5KMlJkCwgrROgN6DnLqKLc6yHT9lKl+xhZhkeco+wtvdb5YLrXD
lh27ZrPE/sukIq013OQepXADNrbXaNbaBlPtqwuRR645PO0Qnp8xDhXs4ZL1TrQv
T0/iHtRLUs8grVp4kvHD9qzJcGO5UXrEFE79qCdQnCm8WSr7pmUYkR0P1b+LnUBF
LMAaUZHcBeWUO/3vwhA9
=chxB
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--
