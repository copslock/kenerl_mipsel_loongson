Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2018 18:15:02 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:59530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994697AbeEUQOzu4O5z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 May 2018 18:14:55 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26D8E2086A;
        Mon, 21 May 2018 16:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526919289;
        bh=k/UmY2LlIf/g4P1KQMKApBpI7n8otaGfio/L42hUK6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Ku4SGXCHLwkZrEpcowTfxKBUjSgMnzUWv/FFDPAYQPL+I3YRGgqRGJRKWhOjT7hK
         wo98cfECBtBUNwl9vhM8fRiRshLGp2HXA8wBXxpEGGGafy7+ZipJCjQK68G1zm4qOS
         Ceblr/nj9ooxjfG/hacbHy0RtuDKkXlCFeFcrTCk=
Date:   Mon, 21 May 2018 17:14:45 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] MIPS: memset.S: Add comments to fault fixup
 handlers
Message-ID: <20180521161443.GA9998@jamesdev>
References: <1523979603-492-1-git-send-email-matt.redfearn@mips.com>
 <1523979603-492-4-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <1523979603-492-4-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63993
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


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2018 at 04:40:03PM +0100, Matt Redfearn wrote:
> diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
> index 1cc306520a55..a06dabe99d4b 100644
> --- a/arch/mips/lib/memset.S
> +++ b/arch/mips/lib/memset.S
> @@ -231,16 +231,25 @@
> =20
>  #ifdef CONFIG_CPU_MIPSR6
>  .Lbyte_fixup\@:
> +	/*
> +	 * unset_bytes =3D current_addr + 1
> +	 *      a2     =3D      t0      + 1

The code looks more like a2 =3D 1 - t0 to me:

> +	 */
>  	PTR_SUBU	a2, $0, t0
>  	jr		ra
>  	 PTR_ADDIU	a2, 1

I.e. t0 counts up to 1 and then stops.

Anyway I've applied patch 3 for 4.18.

Cheers
James

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWwLwbgAKCRA1zuSGKxAj
8pVzAQCMm0CcwP/uwnlI1wpP3iYFikj0u1zLwAjzUkfKc9ulwQEAhFUoRm2/fb1m
ge9q5n/5sVHMJCTh9P/GShTwKXSvqQc=
=zRxf
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
