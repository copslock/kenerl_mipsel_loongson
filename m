Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2018 12:36:47 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:34772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990393AbeBOLglFMxN- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Feb 2018 12:36:41 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91EBB217CB;
        Thu, 15 Feb 2018 11:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91EBB217CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 15 Feb 2018 11:36:29 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 02/12] MIPS: Loongson64: Define and use some CP0
 registers
Message-ID: <20180215113628.GI3986@saruman>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
 <1517022752-3053-3-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Rmm1Stw9KgbdL9/H"
Content-Disposition: inline
In-Reply-To: <1517022752-3053-3-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62550
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


--Rmm1Stw9KgbdL9/H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Sat, Jan 27, 2018 at 11:12:22AM +0800, Huacai Chen wrote:
> This patche defines CP0_CONFIG3, CP0_CONFIG6, CP0_PAGEGRAIN and uses
> them in kernel-entry-init.h for Loongson64.

Please write commit messages in the imerative mood (i.e. like you're
telling the code how to change), and without referring to the patch
itself, E.g.
> Define CP0_CONFIG3, CP0_CONFIG6, CP0_PAGEGRAIN and use them in
> kernel-entry-init.h for Loongson64.

Thanks for splitting this patch out.

Reviewed-by: James Hogan <jhogan@kernel.org>

Cheers
James

--Rmm1Stw9KgbdL9/H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqFcLwACgkQbAtpk944
dnpEvRAAqgoVV9J/6XjMgsw1+uCoLMDOVxfz5vhjbn44miBjFjYuTbweGVNigvmX
YiV/S386P48tvsh4oromrCs8+uR8lvFhrl0Z5nbgy6HWWFc/VgtCYhlPffkyp5sq
IETdrSdTZLrfljAWpfDzCqBIIy+B9sWU7tvbTCyxty8R+/xvFMpyOe/izTkVnrJz
hg6dD7EUXUx41Qot2nFv+obE1cwsWMoxqQufK47idb8z6XU8Dob0ptL8VvddZaoC
aJckNwliYCH3vE9DVKrM1ilP86OLlwXT9pw82Ykli8SxKKcra0tH71D5I0U3ZBc+
mCIBztuqGhuRMzDaJqJ+AR10O05//zj/Je3Dn2ipfo7eq/lC2/wjQv/wWJDgUPvF
/3yZlS9PaOLTKc3E+lZtVcl9+U+HOCWli9QMMu6sULR3R/7Z0+HqUh/IwzyteGBJ
1AzLhMAcjCQFtVqYx1zqtYJ/kFXsymt8GgscceyOCS+NPOGTFD6r3ql1+Aml7zLG
h2yLPnWJpHGnkcHPl2FOld2f6n0cgKqB9UXo+89qwuydWRh9ch4gBNjXLZF4fpbh
/iswPR6oHdaxt6JJVChBp5JmFxt1s6ApVTbRTDDTjxGQ1+hPF2RVIJO3oHDxVLV9
uYDI5J3C0zWVfzh7+3jTKFm8ipXgFr9AbQWEBMha/LjxmcD8nc0=
=A5Mf
-----END PGP SIGNATURE-----

--Rmm1Stw9KgbdL9/H--
