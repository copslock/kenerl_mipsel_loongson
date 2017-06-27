Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2017 00:34:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45218 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993942AbdF0Wd7CUOBb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Jun 2017 00:33:59 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id EB9F641F8DA0;
        Wed, 28 Jun 2017 00:43:54 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 28 Jun 2017 00:43:54 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 28 Jun 2017 00:43:54 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 19FF8642F1106;
        Tue, 27 Jun 2017 23:33:49 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 27 Jun
 2017 23:33:53 +0100
Date:   Tue, 27 Jun 2017 23:33:52 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 7/7] MIPS: uaccess: Use standard __user_copy* function
 calls
Message-ID: <20170627223352.GI31455@jhogan-linux.le.imgtec.org>
References: <20161107111802.12071-1-paul.burton@imgtec.com>
 <20161107111802.12071-8-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VkVuOCYP9O7H3CXI"
Content-Disposition: inline
In-Reply-To: <20161107111802.12071-8-paul.burton@imgtec.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58836
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

--VkVuOCYP9O7H3CXI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Paul,

On Mon, Nov 07, 2016 at 11:18:02AM +0000, Paul Burton wrote:
> -#define __invoke_copy_from_user(to, from, n)				\
> -({									\
> -	register long __cu_ret_r __asm__("$2");				\
> -	register void *__cu_to_r __asm__("$4");				\
> -	register const void __user *__cu_from_r __asm__("$5");		\
> -	register long __cu_len_r __asm__("$6");				\
> -									\
> -	__cu_to_r = (to);						\
> -	__cu_from_r = (from);						\
> -	__cu_len_r = (n);						\
> -	__asm__ __volatile__(						\
> -	".set\tnoreorder\n\t"						\
> -	__MODULE_JAL(__copy_user)					\
> -	".set\tnoat\n\t"						\
> -	__UA_ADDU "\t$7, %1, %2\n\t"					\

I believe __UA_ADDU is no longer used, so could now be removed from the
top of uaccess.h.

Cheers
James

--VkVuOCYP9O7H3CXI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllS3UUACgkQbAtpk944
dnq9JxAAt7oa8QlMygd8VYnzJN6kclMjFpHYme/IAMSPZLePuRWFTm09aXwc8lHy
Vjeu1oBFU8vyjZoST1bBrtvJGMg6T8Fpp2h7GNVYr7dcUBp6E1FmuliBa4Kedky8
VFCEi7t/h+RRUiVVJbTqlPXs/bT+Xxr1u9QC/9mPYwzLIKEc6C5q1m+dhA8lJ6wK
UAYrUVw6Lygc+pxHnGhPVc+ws+afA8ez2TZHj/SPzkEO7CmoSR721E6t3CS2pZRh
X3XM21uTm1dV10NgtiSFq5ih/wEXGvMbUAlQCmbW0NjvumkIVgVtHJJLmlLDpp1G
zvIrndEPKpr4EvAtk777pkNKdQUkDiFzjAnNUcPFdHPryX23KT+ewGv24oxyUaz1
zfX/TmM5h83LceaXGC1JOGuZxwOknV63UhinjnjGCE4S/+8ZW7FJuyXUUShZyqIi
nKHU8kjO/9SEyBbIMCA1NB1yYPrcFiNCWu+h30AhSYyVMfep+Rzwd5ooYVvI7alq
IFnOJj2fRZPSStb5HsXW0pjIQWpAZw3R2/74Xawt8hjVvyzWv5E1lSgR7soISw2G
XhutvNG3hRY5lCRSvcv0FrHJG3FKT+vLvA10znRCfetDdGQpFItqoJExSKaetOGT
rEz2YafUIu6s+UiIYd6EsKypSeZLBJRIKDvCjqAm5afJOTHc9JU=
=M1QJ
-----END PGP SIGNATURE-----

--VkVuOCYP9O7H3CXI--
