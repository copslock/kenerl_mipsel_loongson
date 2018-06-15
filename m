Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2018 10:37:04 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:42828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992735AbeFOIgBED0-V (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Jun 2018 10:36:01 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61FDF20896;
        Fri, 15 Jun 2018 08:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529051749;
        bh=qmRKMSp8djIL14P86rmGyuYpwngCK3QWaoxEkOYjqGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kju/ry3POWj8zARuCvC8450FvKx760noiFh0mFaHvC4xCZ6I7Ux9BuJ6DBLGwcPYQ
         AyPrWpooJtAyahMo32hJyEy3LH9dyhYNOZbrYmBT9i18tYt4X8SCs4nHgcUwZYCUL7
         uJe8OMjIcDdkBa1+4U0Ana2vVumEvjismhk6S5B0=
Date:   Fri, 15 Jun 2018 09:35:45 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Wire up io_pgetevents syscall
Message-ID: <20180615083543.GA7603@jamesdev>
References: <20180615002946.29757-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20180615002946.29757-1-paul.burton@mips.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64279
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


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, Jun 14, 2018 at 05:29:45PM -0700, Paul Burton wrote:
> diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
> index cbf190ef9e8a..8ce8f226e14a 100644
> --- a/arch/mips/kernel/scall64-n32.S
> +++ b/arch/mips/kernel/scall64-n32.S
> @@ -434,4 +434,5 @@ EXPORT(sysn32_call_table)
>  	PTR	sys_pkey_alloc
>  	PTR	sys_pkey_free
>  	PTR	sys_statx			/* 6330 */
> +	PTR	sys_io_pgetevents
>  	.size	sysn32_call_table,.-sysn32_call_table
> diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
> index 9ebe3e2403b1..7b5ce048b1e0 100644
> --- a/arch/mips/kernel/scall64-o32.S
> +++ b/arch/mips/kernel/scall64-o32.S
> @@ -583,4 +583,5 @@ EXPORT(sys32_call_table)
>  	PTR	sys_pkey_alloc
>  	PTR	sys_pkey_free			/* 4365 */
>  	PTR	sys_statx
> +	PTR	sys_io_pgetevents

I wonder if n32 and o32 on 64-bit kernels should use the compat versions
of the io_pgetevents syscall? compat_sys_io_getevents is already used in
these places.

Cheers
James

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWyN6XgAKCRA1zuSGKxAj
8kMuAQDPsXtlHShXAkooRQhtOhxWgiseSgYHv4ydJFjE/mtDqAEA9wDRwgLrbYq5
NZwLoA7gRadPd5a+J+rjjK4j07Oa2gc=
=QwQj
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
