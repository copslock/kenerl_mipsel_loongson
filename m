Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2018 13:43:33 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:42658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990407AbeBOMn1F5pUL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Feb 2018 13:43:27 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D4EE205F4;
        Thu, 15 Feb 2018 12:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4EE205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 15 Feb 2018 12:43:15 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 03/12] MIPS: Loongson-3: Enable Store Fill Buffer at
 runtime
Message-ID: <20180215124315.GJ3986@saruman>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
 <1517022752-3053-4-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M9pltayyoy9lWEMH"
Content-Disposition: inline
In-Reply-To: <1517022752-3053-4-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62551
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


--M9pltayyoy9lWEMH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Sat, Jan 27, 2018 at 11:12:23AM +0800, Huacai Chen wrote:
> diff --git a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
> index 3127391..4b7f58a 100644
> --- a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
> +++ b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
> @@ -26,12 +26,15 @@
>  	mfc0	t0, CP0_PAGEGRAIN
>  	or	t0, (0x1 << 29)
>  	mtc0	t0, CP0_PAGEGRAIN
> -#ifdef CONFIG_LOONGSON3_ENHANCEMENT
>  	/* Enable STFill Buffer */
> +	mfc0	t0, CP0_PRID
> +	andi	t0, 0xffff

Maybe worth including <asm/cpu.h and doing:
	andi	t0, (PRID_IMP_MASK | PRID_REV_MASK)

> +	slti	t0, 0x6308

and:
	slti	t0, (PRID_IMP_LOONGSON_64 | PRID_REV_LOONGSON3A_R2)

With something like that here and in the other place:

Reviewed-by: James Hogan <jhogan@kernel.org>

Cheers
James

--M9pltayyoy9lWEMH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqFgF0ACgkQbAtpk944
dnpzdxAAu9ZT0kpYz0mEpNYK3aYXMnHp+z/g7e9rvYSntgMpPwZ+tCTuej8V+dT/
3cFBIOBOKiEhRB3Ycjre3ixEGt8jNaOGLoZDb25RlBPEYjqKd8Brmgncr8DeCsdq
ZWgz40au/Y8zNYFXyK+sbed9AKBfOCWReFjQ0aAEtzI/qq9yoICdq+4BFHteeaJJ
GJVcy+zCZXk4gWFv3Zddnt5EiSJ3uBGAAo9NgtmHO/5kaBIRvQEY+mADRPEbWCVf
BiGohz0Gcb1yKR6b6ActDW8S9/ngFTF/I5suzAzJ4zmRHWWao7O8WABGV1H10kA4
52+0Fn7uMOaHTv8yANVPIOqz3g1W+EvRAI2r7PVLwWu6RBMdNPW0w7f78nwkzMV9
cGvk0v0Ozd7ruFgHre5rpDcLDMMZcFDAkMPTHohW0ceM2NLncrAqSvxEokzuJR9O
CMEWRQfUgPmQ9YUWddptczmOFEb9N18f4zULg+83odMDIa9RjOuExne/yVOpuCGy
dn/MLROHGgzO4yBarQ4YpHqxYBvgNuYkjTD4S+SY2Nx328UcY7QZ2XNHWSCjHo6P
ivbuhzHcHNsk4qTsKzIh3220MczANAehn7RfFOCaHCfa6hKVTAXyEqMW0qZqwCM8
P/O4xcQZKH9sTKrg5196fA72lPIYBQjrn3hl0rcfaDnqwDxdEOg=
=unaf
-----END PGP SIGNATURE-----

--M9pltayyoy9lWEMH--
