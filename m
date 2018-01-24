Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 22:23:00 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:51306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991359AbeAXVWwF6IXU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Jan 2018 22:22:52 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCA5421778;
        Wed, 24 Jan 2018 21:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA5421778
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 24 Jan 2018 21:22:19 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/8] MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3
Message-ID: <20180124212218.GI5446@saruman>
References: <1502330433-16670-1-git-send-email-chenhc@lemote.com>
 <1502330682-16812-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fmvA4kSBHQVZhkR6"
Content-Disposition: inline
In-Reply-To: <1502330682-16812-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--fmvA4kSBHQVZhkR6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2017 at 10:04:36AM +0800, Huacai Chen wrote:
> For multi-node Loongson-3 (NUMA configuration), r4k_blast_scache() can
> only flush Node-0's scache. So we add r4k_blast_scache_node() by using
> (CAC_BASE | (node_id << NODE_ADDRSPACE_SHIFT)) instead of CKSEG0 as the
> start address.
>=20
> Cc: stable@vger.kernel.org

I believe Loongson 3 support was added in 3.15, so the following is
probably slightly better:

Cc: <stable@vger.kernel.org> # 3.15+

> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 81d6a15..7b242e8 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -459,11 +459,28 @@ static void r4k_blast_scache_setup(void)
>  		r4k_blast_scache =3D blast_scache128;
>  }
> =20
> +static void (* r4k_blast_scache_node)(long node);

Checkpatch objects to the space after '*'.

Other than those minor things this patch looks reasonable I think

Reviewed-by: James Hogan <jhogan@kernel.org>

Cheers
James

--fmvA4kSBHQVZhkR6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpo+QoACgkQbAtpk944
dnrX7w//WDBWeF7vkLNrddADTrconmI8f4rzHbgPDs53FEz67zgGXv1uNQ9R9Ugg
R0jCorYs5DssjneQ03SQy+TT0Pb4KGD4+c/xl7XOrzEFl/BVlQdAyRRqwGv4btnv
aheE1+XWfnIqhYMAmXTnIybE1XK/goMW0KqgptQLAw6zOK47z47jgWkMRTveYJf+
mTetnOWv0IvSIZQpcBQRQ4a9pnjsjgnOLfuALEt1ygz7JJDEjRt4Odcq4kZ+jg+X
VNDKm8urbXP5k/ZTI/38ehmQvx2w46PobfkyypiCpIZXbsuOK+ANqLJI3shW/4oj
R26Z6xu7030MLw6eo7k2mob9LdC5go3Ic86/D1rDanST1QiR3YJ924bB02vdsVbH
skMidHfjI33OVn6CsU9MvUmHXH4PxkSw6MAjumbQ972chqF3ASdtitGzyK3LiMSO
RbU3otxnETimDVzGlOkpFY/OmKcu8RZIlzDts/ku9/zC/tWr541fdsgaKik1B7Q8
kEtR8OV9Ty6OCMhVlX3ySrDa9gyHW29U9Ma5DvDCvCPNvPcSFjLT8e4uOL8knVEp
y6SbdEYhifeg9AW4L8JD5hCAfVS/xjxY9zS+dgcSa3tF3j3ByvxahuMoGJsbxnca
ulAtNlDeXgCm8Sgu7IwZz3TtXxm+3ljPEH3mH8J7wrG6qyd3WLQ=
=lkZq
-----END PGP SIGNATURE-----

--fmvA4kSBHQVZhkR6--
