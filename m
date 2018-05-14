Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2018 00:13:45 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:33488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992684AbeENWNiQIibv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 15 May 2018 00:13:38 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2152921726;
        Mon, 14 May 2018 22:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526336011;
        bh=+LJAjBec2JbTijWck0mp06Mr1m5iy66Wrn5U8QwYfnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zeig7FpPgzv1lMRoGZsxiP2WfWfjW+OgQNYfxSBajBGjAQfNf74xPdI+ihpGCJSEd
         gS08H7bI0/WPOrK+k2iWoNecTE7bU9QIymswwtD1CfIB5SQ7wBWCp8W2IWOb0RwPYj
         sEIuNbkTt07RJ7bv3EokdSR+LldXi8ayRbYt4C8A=
Date:   Mon, 14 May 2018 23:13:27 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: fix spelling mistake: "cop_unsuable" ->
 "cop_unusable"
Message-ID: <20180514221326.GC29541@jamesdev>
References: <20180514172350.26601-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline
In-Reply-To: <20180514172350.26601-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63956
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


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 06:23:50PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Trivial fix to spelling mistake in debugfs_entries text
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Adding KVM folk. Its a fairly trivial change so I'll just take it as a
fix via the MIPS tree unless anybody objects.

This does change the name of one of the stats counters debugfs files
though (which I have no doubt isn't relied upon by anything), so I've
added:

Fixes: 669e846e6c4e ("KVM/MIPS32: MIPS arch specific APIs for KVM")
Cc: <stable@vger.kernel.org> # 3.10+

Thanks
James

> ---
>  arch/mips/kvm/mips.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index 2549fdd27ee1..0f725e9cee8f 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -45,7 +45,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] =3D {
>  	{ "cache",	  VCPU_STAT(cache_exits),	 KVM_STAT_VCPU },
>  	{ "signal",	  VCPU_STAT(signal_exits),	 KVM_STAT_VCPU },
>  	{ "interrupt",	  VCPU_STAT(int_exits),		 KVM_STAT_VCPU },
> -	{ "cop_unsuable", VCPU_STAT(cop_unusable_exits), KVM_STAT_VCPU },
> +	{ "cop_unusable", VCPU_STAT(cop_unusable_exits), KVM_STAT_VCPU },
>  	{ "tlbmod",	  VCPU_STAT(tlbmod_exits),	 KVM_STAT_VCPU },
>  	{ "tlbmiss_ld",	  VCPU_STAT(tlbmiss_ld_exits),	 KVM_STAT_VCPU },
>  	{ "tlbmiss_st",	  VCPU_STAT(tlbmiss_st_exits),	 KVM_STAT_VCPU },
> --=20
> 2.17.0
>=20

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvoKBQAKCRA1zuSGKxAj
8vEWAP0WiOiXuPk1YrXK8FVgnv1SV4ZByfR3S33VjwPpgWy1nQEAumPws9ZYuPRR
gLEqrdEV6UnTOyGBfqiZ7xxsdXiYsw8=
=w39k
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
