Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 22:19:13 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:48170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990723AbeCWVTGCJQh1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Mar 2018 22:19:06 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC0D12172C;
        Fri, 23 Mar 2018 21:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0D12172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Fri, 23 Mar 2018 21:18:55 +0000
From:   James Hogan <jhogan@kernel.org>
To:     "Steven J. Hill" <steven.hill@cavium.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: Disable PCI support.
Message-ID: <20180323211854.GE11796@saruman>
References: <1521789166-6096-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7LkOrbQMr4cezO2T"
Content-Disposition: inline
In-Reply-To: <1521789166-6096-1-git-send-email-steven.hill@cavium.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63197
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


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Mar 23, 2018 at 02:12:46AM -0500, Steven J. Hill wrote:
> Until the new Octeon PCI code is upstreamed, disable it
> so the default config file builds again. Other updates

Could you clarify what build failures you're seeing please.

> from running 'make defconfig' also.

Do you mean 'make savedefconfig'?

Cheers
James

--7LkOrbQMr4cezO2T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlq1bz4ACgkQbAtpk944
dnrCEQ//X6v/Vf3Gltc4snAZduKmNVo2YAtffma/GSM4GGsfERsjEocEdPjhQm2E
aPf7ZAzt+6FbNoOhJ2YB77QYkEcmiggj8SV8ZA6zPp5ZZgidYTK7XCDw1nKwkkLs
uuhkITPvjF1g2S7ghc7kSVaVIW5cERudZ0Yvz1hJdBVePdrOOX0Y+22mP2YkWklr
7U7G6pHhgT6+zPS6zWG7mJ6BcG28AqUdKft+MsP7NV6Y0SB/r1RXylRHkzjs2Fk5
zYNUNCoFIYYtERfxZ74MTFMx+4ccetTHuyg0xUPaus76a6IayZ7qHstgaXJlsLop
RIjie+esXQY4tOcHGpzawGjr7bOfFjKQloPcjdGLKNrmptLhmVZzLuLz2Z740Ali
9SBh5ds1GXWGAC+MV/fZdddp7xjm2gIIVPqSf56KLnfUpciHuG5GAMqJUnNgslyf
vUv2RynC6AxgG0pP6tSSvbZd7nJIVVVtp7Ma4zptiuzrMm3PsCa/p9pNklRRGTaF
f7/E08z8CoCJvu/uc/QXjLTIGvqb+26Fb6ltGFLE/SZCpUIC43SySrPUlftaTlJT
6xI//arZKW6KomDw/X/Md0VX6qiukeYMatrf1Zn+3nZUL9N2Hrlv1lL3LjwmgUgG
DNzqFNbVtc6851uEZYcmaBlfSuRfO/hKYDhfEJXG7ddxcN7VX/8=
=T4Ag
-----END PGP SIGNATURE-----

--7LkOrbQMr4cezO2T--
