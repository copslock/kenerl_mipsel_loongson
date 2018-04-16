Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2018 22:22:53 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:50002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994621AbeDPUWqTZaT3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Apr 2018 22:22:46 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 732D221789;
        Mon, 16 Apr 2018 20:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732D221789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 16 Apr 2018 21:22:34 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: memset.S: EVA & fault support for small_memset
Message-ID: <20180416202234.GA23881@saruman>
References: <1522315704-31641-1-git-send-email-matt.redfearn@mips.com>
 <1522315704-31641-2-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <1522315704-31641-2-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63569
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


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 29, 2018 at 10:28:23AM +0100, Matt Redfearn wrote:
> @@ -260,6 +260,11 @@
>  	jr		ra
>  	andi		v1, a2, STORMASK

This patch looks good, well spotted!

But whats that v1 write about? Any ideas? Seems to go back to the git
epoch, and $3 isn't in the clobber lists when __bzero* is called.

Cheers
James

> =20
> +.Lsmall_fixup\@:
> +	PTR_SUBU	a2, t1, a0
> +	jr		ra
> +	 PTR_ADDIU	a2, 1
> +

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrVBgMACgkQbAtpk944
dnqvdBAAwBaYV+JZiOrwbkIvv8vAlcGA+5W0c4ZPrnV7TLRJScb8LJxo7DGdEQ1v
fci8MHYpi+atntziEbiHbhDAhI4qCApDt+AnWyTPq2KVOo8TTU7rltS+8eBeQFAs
Wqhcke0/uCntBj9vJDjfKmts4i16rG+9egNaxbIvo3iSsS8AnSkhMjMajm5Mvr/Z
eS6YAMGPLbTVgTSGCRxgs707/23a+uiqq3hGfHan1ktO+124DPGwPSQw7JeW13Nt
t9PCQI0FEQGAHKGhkCzIFWxPdq6KK1UdytmQApzZ3RZ7w21u9iaWPuxMTXzPADcb
9GObjHhJ+vedOQsbiw6+For/0pXf/L8iM5YazIKp0xWv7VY8eQ/A1C2e9319Qmi0
GERR09nWkTY31oG7eg3MyxLKUrxvvUUpNHJVzHtg9TN+b50ratBWEbxgxW3Njwsa
QYBj9EChn5g9zjBE0tkPS4wShh0yVBi9WxlAyQY4Emf/pjy6yZaayKrTSRpsaqk+
oCRbIIfr6/b+vA6Xg2YVytz+PfeJuBZCHUDpqMIgZ3W0RNvwnO6NJmoyX5iZKQat
gbPrXvOXT4cz0L4q4FIPoC0HtAlhy9Dz9NjB3StZ27EChYwulnP7fNBhPOgYlBhG
kd2mgzaBl92kJFtqG0MdbSJBwv/xWFxLXd/6Jl8u6KtX22Mt71I=
=wPSw
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
