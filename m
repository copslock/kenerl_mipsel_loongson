Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2018 10:33:01 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:34924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990427AbeCFJcwKqVBU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Mar 2018 10:32:52 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34557206B2;
        Tue,  6 Mar 2018 09:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34557206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 6 Mar 2018 09:32:37 +0000
From:   James Hogan <jhogan@kernel.org>
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     herbert@gondor.apana.org.au, robh+dt@kernel.org,
        ralf@linux-mips.org, davem@davemloft.net, paul@crapouillou.net,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org,
        malat@debian.org, noloader@gmail.com
Subject: Re: [PATCH v3 3/4] crypto: jz4780-rng: Add RNG node to jz4780.dtsi
Message-ID: <20180306091932.GM4197@saruman>
References: <20170918140241.24003-1-prasannatsmkumar@gmail.com>
 <20170918140241.24003-4-prasannatsmkumar@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H83aLI5Lttn3Hg7B"
Content-Disposition: inline
In-Reply-To: <20170918140241.24003-4-prasannatsmkumar@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62814
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


--H83aLI5Lttn3Hg7B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2017 at 07:32:40PM +0530, PrasannaKumar Muralidharan wrote:
> Add RNG node to jz4780 dtsi. This driver uses registers that are part of
> the register set used by Ingenic CGU driver. Use regmap in RNG driver to
> access its register. Create 'simple-bus' node, make CGU and RNG node as
> child of it so that both the nodes are visible without changing CGU
> driver code.
>=20
> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

Better late than never:
Acked-by: James Hogan <jhogan@kernel.org>

(I presume its okay for the reg ranges to overlap, ISTR that being an
issue a few years ago, but maybe thats fixed now).

Cheers
James

--H83aLI5Lttn3Hg7B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqeYDQACgkQbAtpk944
dnr9sBAAvszFQzFlZYoeB3YNQL+SLc3co/bKhDZ1SXM4px5IY9Ldd22gLk4ClEKc
N5DFig1Emi5jOHKFhSMRbAFWMJJIc9a41w0ZGLX2WVpYwY6NqVp1VlbfbWWxe+L/
wqES7YsdbYoCYJJu9wxiWsOF+q3whY3uvcKgVIvKoRl/NROX3ocf4OfO5HVL0a6o
5SpO5jMqkIqlfTzkX+skCepZOTw8ZLBCmUL5NIZUuYz3hVA/YJMpgbn+K/cD8QK+
3rpGoQKiiAFuqBEhVu/MpX+ns5RzLG+tdpiF7Gw6TYFopcn58xYM+2XAGJXaCIFc
i4qgazJ4UqDTu4QV2py5ahGFiSyd5Z5iAp+UVj9qsX7txXcrFAGUn+dneNrnpuOt
Zp0E/KqoCLKPRdgB5Gg62tngLEoSpIrpguF1/aCtqFdinTiFu5X5TmPKBf8yOy5k
HolzDNth8IQxGKRe5aBSPr2gwrZChA1Vd/NEgj4VZuF0u0rIm8rIluApSJDSY3xx
mdjVjz3uypShTMmvqkyhcnbrZ2IbtZcpmV3cPBHMcBTY0QZtQyj3rjsZ193/Kbyd
CTvKaGFiFrs+PiaJW/vW+ih8576nc8kAvRbr4tZU60JtoKKC2PaIykcUQTozkqCi
ep1fbRH+PC4JUt6zEIjPCUrHlepsnFTYWr/yFufLvE0EaswAhQo=
=FcZf
-----END PGP SIGNATURE-----

--H83aLI5Lttn3Hg7B--
