Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2017 08:10:34 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.230]:35474 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990482AbdJaHKZNuim0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Oct 2017 08:10:25 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 31 Oct 2017 07:09:52 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 31 Oct
 2017 00:07:23 -0700
Date:   Tue, 31 Oct 2017 07:08:05 +0000
From:   James Hogan <james.hogan@mips.com>
To:     "Gustavo A. R. Silva" <garsilva@embeddedor.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, Julia Lawal <julia.lawall@lip6.fr>
Subject: Re: [PATCH] MIPS: microMIPS: Fix incorrect mask in insn_table_MM
Message-ID: <20171031070804.GB15260@jhogan-linux>
References: <20171031053503.GA5164@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <20171031053503.GA5164@embeddedor.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1509433792-452060-31106-390659-1
X-BESS-VER: 2017.12.1-r1710261623
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186444
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2017 at 12:35:03AM -0500, Gustavo A. R. Silva wrote:
> It seems that this is a typo error and the proper bit masking is
> "RT | RS" instead of "RS | RS".
>=20
> This issue was detected with the help of Coccinelle.
>=20
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>

May I suggest adding:
Fixes: d6b3314b49e1 ("MIPS: uasm: Add lh uam instruction")

> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Reviewed-by: James Hogan <jhogan@@kernel.org>

Probably worthy of a stable tag too (though there will be conflicts with
ce807d5f67ed309a6f357b88cc93185d89e921d3 before 4.13):
Cc: <stable@vger.kernel.org> # 3.16+

Thanks
James

> ---
>  arch/mips/mm/uasm-micromips.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
> index c28ff53..cdb5a19 100644
> --- a/arch/mips/mm/uasm-micromips.c
> +++ b/arch/mips/mm/uasm-micromips.c
> @@ -80,7 +80,7 @@ static const struct insn const insn_table_MM[insn_inval=
id] =3D {
>  	[insn_jr]	=3D {M(mm_pool32a_op, 0, 0, 0, mm_jalr_op, mm_pool32axf_op), =
RS},
>  	[insn_lb]	=3D {M(mm_lb32_op, 0, 0, 0, 0, 0), RT | RS | SIMM},
>  	[insn_ld]	=3D {0, 0},
> -	[insn_lh]	=3D {M(mm_lh32_op, 0, 0, 0, 0, 0), RS | RS | SIMM},
> +	[insn_lh]	=3D {M(mm_lh32_op, 0, 0, 0, 0, 0), RT | RS | SIMM},
>  	[insn_ll]	=3D {M(mm_pool32c_op, 0, 0, (mm_ll_func << 1), 0, 0), RS | RT=
 | SIMM},
>  	[insn_lld]	=3D {0, 0},
>  	[insn_lui]	=3D {M(mm_pool32i_op, mm_lui_op, 0, 0, 0, 0), RS | SIMM},
> --=20
> 2.7.4
>=20
>=20

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAln4IU0ACgkQbAtpk944
dnqTzBAAhAKEuVDCWRh9L+8IvqRPSj/4u1dq3YbKefUuimTUIBdo4POJdzUOe2n6
s32/Uoa/B1tg5adtKw78ULB5ZPSJOGGEBfm5O5ffvGOeuh7lYuO/2j3HsJzI9VUi
EaoFpkfo4SaRmKxjvpy7IE5MqWOIydnb7YQ3w+bSQavC+7GVF9Jb0DQAmaAJgbtQ
g623epwwmTBu+SlcyGKLEnmsT0tEi/LbsWX2TXJ5B/Nq+/9NzH2QFnzFZPNrK/Vj
3b2D0d1dym5eqDElPuWAK+kQykhqwNUXy2Dh5PeJXKFnjgj6DiE9CTGi/JFpGAhC
Ma+YESoBUM2JyWnSh0O8qENAqdwnphOzojnoivkAwH18FlSSOhis+DCBMRHnfj11
tGFqYsKWDstqYj6CU+w7jwyGPieZ6tjTTFLQQNqZGv18QYX/n63eJHv3mroVebzx
B61pK0MtR/+d4k6VAx0BfNFGWkumowxA9Ueyd/q3mdpE0x9SoInoA8VMSrJGequI
J/t/zFkaehsfn5Adk01u9HAT4H4pXn4gdAWSqLBg+hQqi1i/Ko0JF1rTDrBTlTJb
ExTadU974g3/kFEgQR+UedZHoKT/gosolrVSSWWMML0mYvQqptLV1lzte808OHzV
8QCmqJHsT7KgUlSOetMSlSR0u9X1Pib+UJorVAP4RLRDfgVsO8I=
=EYvz
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
