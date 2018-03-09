Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Mar 2018 00:24:50 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:56618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990401AbeCIXYmmRPFe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Mar 2018 00:24:42 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C1512133D;
        Fri,  9 Mar 2018 23:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1512133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Fri, 9 Mar 2018 23:24:31 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mmc@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 12/14] MIPS: dts: jz4780: Add MMC controller node to the
 devicetree
Message-ID: <20180309232431.GK24558@saruman>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
 <20180309151219.18723-13-ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j/HO4hzKTNbM1mOX"
Content-Disposition: inline
In-Reply-To: <20180309151219.18723-13-ezequiel@vanguardiasur.com.ar>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62898
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


--j/HO4hzKTNbM1mOX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Mar 09, 2018 at 12:12:17PM -0300, Ezequiel Garcia wrote:
> This commit adds the devicetree node to support the MMC
> host controller available in JZ480 SoCs.

Nit: Please don't refer to "this commit" in commit messages. It is
preferable to use the imperative mood, e.g.:
> Add the devicetree node to support the MMC host controller available
> in JZ480 SoCs.

Otherwise

Acked-by: James Hogan <jhogan@kernel.org>

Cheers
James

--j/HO4hzKTNbM1mOX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqjF64ACgkQbAtpk944
dnp6gBAAqTEVUw8TgD93IT+Yga3nY358gazAOMskU4EfLv0J9ijxDrK+zty8scIT
eOi05SG4LhsHV2YKourLI22pkH75NAk8AXu3HjfF6kLutdawXVXtjgCcf0qFzDhz
HR4M7X+o4CzCHDD2SbKXQ1STFN+eZBhmrNJ6UUQzMZy81wf0UFGos9169S2RDs+u
bUN/NZGLcjdz8l4ZkiwzTg8G0RFKUdaX4Z7ZabfBAh9x9RVGL7J8PB83wfu5lzCd
5sPqpZtVKb3KoP8HCvUpHy7Xe60T5OZ2ysKNO0KmmN8e2UEh8vBtUkcTEYAlfnbw
dxsgILgp3HE0GgndB+wVDiiYhaLBfmBaOogj1hp3cgRxv01OLUXW4ooKoEg4yj/U
QlZyB8gX02pjOvwe6WZZi77KnSAzUjnSuRLjCTYypPyyCLZwA1dS3PFw0l7Mopw/
5T0CDkHiQtboy5wR0Byq8PaOP4Ey6cZQn6I+lmABFWwr2zczuCW/ynzZ9N7OFqRa
YIyNk03fHmylZekMQxVSLSonJWN2GXpRKmjOyoNjk0KO51MVvpM9JiiRd/6Sizkk
mjPj6arnu67P5yhf0fHGxQWV4Z5dEmlOfbunr+dDzd75wkPdB3lVz5W/UJqJOtw3
u4+hsGF2Rcqv9XMvue7XakfB/dykOAisdBkj5kxnGcUg6Jf1rqY=
=DEF0
-----END PGP SIGNATURE-----

--j/HO4hzKTNbM1mOX--
