Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jun 2017 14:32:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45578 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990686AbdFVMcGKxdq9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Jun 2017 14:32:06 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 33DB841F8E88;
        Thu, 22 Jun 2017 14:41:47 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 22 Jun 2017 14:41:47 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 22 Jun 2017 14:41:47 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A3180360BBBE9;
        Thu, 22 Jun 2017 13:31:56 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 22 Jun
 2017 13:31:59 +0100
Date:   Thu, 22 Jun 2017 13:31:59 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix a long-standing mistake in mips_atomic_set()
Message-ID: <20170622123159.GA31455@jhogan-linux.le.imgtec.org>
References: <1498128345-6827-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <1498128345-6827-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58743
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

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Huacai,

On Thu, Jun 22, 2017 at 06:45:45PM +0800, Huacai Chen wrote:
> This mistake comes from the commit f1e39a4a616cd99 ("MIPS: Rewrite
> sysmips(MIPS_ATOMIC_SET, ...) in C with inline assembler"). In the
> common case 'bnez' should be 'beqz' (as same as older kernels before
> 2.6.32), otherwise this syscall may cause an endless loop.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

Thats a coincidence. 8 years its been broken and I submitted an
identical patch only a few weeks ago, along with some other related
fixes:

https://patchwork.linux-mips.org/project/linux-mips/list/?series=3D313&stat=
e=3D*

Cheers
James

> ---
>  arch/mips/kernel/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
> index 1dfa7f5..95e1b30 100644
> --- a/arch/mips/kernel/syscall.c
> +++ b/arch/mips/kernel/syscall.c
> @@ -134,7 +134,7 @@ static inline int mips_atomic_set(unsigned long addr,=
 unsigned long new)
>  		"1:	ll	%[old], (%[addr])			\n"
>  		"	move	%[tmp], %[new]				\n"
>  		"2:	sc	%[tmp], (%[addr])			\n"
> -		"	bnez	%[tmp], 4f				\n"
> +		"	beqz	%[tmp], 4f				\n"
>  		"3:							\n"
>  		"	.insn						\n"
>  		"	.subsection 2					\n"
> --=20
> 2.7.0
>=20
>=20
>=20
>=20

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllLuLUACgkQbAtpk944
dnpATxAAq2eDkeuNDyPukE80pkgm3AewioKAK2lMzCvOSDWMao7iK0fd6jlmD643
HyvI0IQFKqdGTLcs4gpZtnMqXaGlKZHMQE4ug/P5EXh6ZsVEJKtbAzPsnRyslEH8
zy8kjJsPFxR2s0SKtEINssbtVIbmGxZKxzFEe9XhzEe5ykmi0cLXzOOTU0zc4p49
c9Kc55XJdLQxv7hsazJMl31OLsYsnJq4WLXo+RIVSZK9CIxqZZUjovcsXT17B3ri
zmhGGRepbW+U5Li2X6gBbi5FdskYYVzmE5GJyjrI1tigj6F3imncVLKLqX+PACGt
ROE4D1mrg7kflYC1xrVe4LoRTc2/Pk0kyjPkjeaDo0J80PU35hul78z0JoARgCQd
Cz31QtNfySh93S0uBhjXtTNzvDaRXNCTR2YVXgi7WgfYmLwCFUvuFCFRBc1kIZBn
oWrc5kbfq2fofm+S2v7vXqbLoXb0eWO4LomGwzPHmidXMmBiZKj0PFiW87kChQeP
H2ljEt4v6D9K3z41yBJbeELqksgvjMZHAIa4fMc3gfPfOLz3y7bmt2XWGWlDJWDA
dx41CKa9v9rpZpWWtaUcLouQEucckUHNps7KMXAYOIjd7oU1vMokZ8xRfvad4oa+
7zQ38/3O7FDd2rzJHQmI6yc4Bo8A1ySbEMDZSXc/zw6U6yMaE7U=
=rpRM
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
