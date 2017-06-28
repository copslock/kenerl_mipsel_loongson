Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2017 16:30:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16284 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993898AbdF1OaLzUPZr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Jun 2017 16:30:11 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id A4F6341F8DF0;
        Wed, 28 Jun 2017 16:40:09 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 28 Jun 2017 16:40:09 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 28 Jun 2017 16:40:09 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 42DDE8B2F4FF2;
        Wed, 28 Jun 2017 15:30:03 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 28 Jun
 2017 15:30:06 +0100
Date:   Wed, 28 Jun 2017 15:30:05 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH V7 2/9] MIPS: c-r4k: Add r4k_blast_scache_node for
 Loongson-3
Message-ID: <20170628143005.GJ31455@jhogan-linux.le.imgtec.org>
References: <1498144016-9111-1-git-send-email-chenhc@lemote.com>
 <1498144016-9111-3-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="va4/JQ6j8/8uipEp"
Content-Disposition: inline
In-Reply-To: <1498144016-9111-3-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58846
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

--va4/JQ6j8/8uipEp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Huacai,

On Thu, Jun 22, 2017 at 11:06:49PM +0800, Huacai Chen wrote:
> @@ -839,9 +860,12 @@ static void r4k_dma_cache_wback_inv(unsigned long ad=
dr, unsigned long size)
> =20
>  	preempt_disable();
>  	if (cpu_has_inclusive_pcaches) {
> -		if (size >=3D scache_size)
> -			r4k_blast_scache();
> -		else
> +		if (size >=3D scache_size) {
> +			if (current_cpu_type() !=3D CPU_LOONGSON3)
> +				r4k_blast_scache();
> +			else
> +				r4k_blast_scache_node(pa_to_nid(addr));
> +		} else
>  			blast_scache_range(addr, addr + size);
>  		preempt_enable();
>  		__sync();
> @@ -872,9 +896,12 @@ static void r4k_dma_cache_inv(unsigned long addr, un=
signed long size)
> =20
>  	preempt_disable();
>  	if (cpu_has_inclusive_pcaches) {
> -		if (size >=3D scache_size)
> -			r4k_blast_scache();
> -		else {
> +		if (size >=3D scache_size) {
> +			if (current_cpu_type() !=3D CPU_LOONGSON3)
> +				r4k_blast_scache();
> +			else
> +				r4k_blast_scache_node(pa_to_nid(addr));

malta_defconfig now fails to build:

arch/mips/mm/c-r4k.c: In function =E2=80=98r4k_dma_cache_wback_inv=E2=80=99:
arch/mips/mm/c-r4k.c:867:5: error: implicit declaration of function =E2=80=
=98pa_to_nid=E2=80=99 [-Werror=3Dimplicit-function-declaration]
     r4k_blast_scache_node(pa_to_nid(addr));
     ^

Cheers
James

--va4/JQ6j8/8uipEp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllTvWIACgkQbAtpk944
dnqtUQ//Y2RZHO/wqrQxVrepKG4SyAYXRtT4a0TzuvVI/EWzhRLy2c5ZHN5i33ef
Ifn28O+ZhxlUsGwHUdaWC5/34J5FM+GPui43MmSE5WqU3372AvMGMp2NZIrfW9/M
NsYO4ioJuaFlxzVfD0sN6WfgQaN83/O2RLSdg6vbrdj1MYnGzaXhjhjxNY1Rbs2I
mQ7pvbZVmqO9tLjq8ZSy8rsTLqBoX1QJIBTzIFBop2/BKNZqZKlpaWITUGnnbdAo
5+RIUCOjlO12Tsbswc7L+dMu83p158wCN26Pjjz5/LBXodYt0fThZ558s4n/Q5hF
1CQycp1uEnOKT0j1QuJfI3zpuTXRngu0NCjDgv2joVjPNbL9bhDLZ3fRRVwD2xCd
MiY2KRd6W1Q0GVEGGAKBqnaAAGhqD7WebBZLpITU/IdVdEWwQ56u7KFwMUFeROqu
KYYNAx0qB3BqBn7KS3fQJ98cHYXZZRqKe7OHBr+u99Lpi9x7lJ+2PxxYtCiuwa+v
IAnsDMAARWEmKVP8WKaVAsbZfWZnrt1waUhYqQMBeg7LXBbpmPjS5v5S2IAPYBKf
2shFh18eWYTsNMxqzcT7pRLzdiuDoLCdgWzd0XruGaCGgTlxjTN6h8HFM6CU3R7S
YSEKvpypsXMDlU+URkLxxxelhsMKG6nP26AOsGqEV/XyF3OsPyg=
=gZur
-----END PGP SIGNATURE-----

--va4/JQ6j8/8uipEp--
