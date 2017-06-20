Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 18:46:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27118 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992036AbdFTQqFAtSfC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2017 18:46:05 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id E726141F8EB1;
        Tue, 20 Jun 2017 18:55:40 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 20 Jun 2017 18:55:40 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 20 Jun 2017 18:55:40 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 80B3599BC8251;
        Tue, 20 Jun 2017 17:45:55 +0100 (IST)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 20 Jun 2017 17:45:59 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL-X.hh.imgtec.org
 (10.100.10.113) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 20 Jun
 2017 17:45:58 +0100
Received: from np-p-burton.localnet (10.20.1.33) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 20 Jun
 2017 09:45:57 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Stephen Boyd <sboyd@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v5 2/4] clk: boston: Add a driver for MIPS Boston board clocks
Date:   Tue, 20 Jun 2017 09:45:56 -0700
Message-ID: <1566867.5D4LADdskZ@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <20170620002651.GY20170@codeaurora.org>
References: <20170617205249.1391-1-paul.burton@imgtec.com> <20170617205249.1391-3-paul.burton@imgtec.com> <20170620002651.GY20170@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1660472.2L4SBVNbov";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.1.33]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--nextPart1660472.2L4SBVNbov
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 19 June 2017 17:26:51 PDT Stephen Boyd wrote:
> On 06/17, Paul Burton wrote:
> > Add a driver for the clocks provided by the MIPS Boston board from
> > Imagination Technologies. 2 clocks are provided - the system clock & the
> > CPU clock - and each is a simple fixed rate clock whose frequency can be
> > determined by reading a register provided by the board.
> > 
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Cc: linux-clk@vger.kernel.org
> > Cc: linux-mips@linux-mips.org
> > 
> > ---
> 
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> Unless you wanted this to go through the clk tree?

Thanks Stephen.

Ralf: are you happy to take this through the MIPS tree along with the rest of 
the series?

Thanks,
    Paul
--nextPart1660472.2L4SBVNbov
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAllJUUQACgkQgiDZ+mk8
HGV6yhAAp9GK3pqBFAQOrdJck7KKRLN4uU7N97og/PnJhoSyCpKBtKU9v7oT5Am2
z5H8KVjWgsrl6TrqB+0pJIq0GmENHUCK7CrazNKDpUWYCC+3UwpjFdFQcoR0ez0n
gkFZEKZmuFN4I6g5aMh/MPkYuTGOc6fGQOm/bkvLtBpjTb1a+CsGBdA0FeOEAz3v
2Sr5nWN3/I8EYdZERWSWjcjrsF4P+rliTjbSNNQfgMep4b8xp7ONV0ago51A1kbF
9NGBeO2jOw8LDgzfpAKm4FRBDjN3z5wXDtSgBogZyjstvj2uDp2t84TgPXnhN60P
Mj/jL65umPoYQWPtiU9SdZE53XqT5Iw8L2utxqmAVR+V3wgolWH/7GqEJOuuGy/A
vRFHjY7gFoF7TdoyIIpkFR6ME+0e4xdmyRc20xvFyaLSM9R1TvXAqJDGbzYed5o7
aM0KLBkEa/2k0CYSvpzxpsEJX3sjKIVHQpunz+SD/4DT9LL0HzY0u3mycwygGo/C
CGe/dN49phAzG+SlaimGtxHM2UqGSd++JV4FkM/gFhd1+ZpUOdqech9xIT+gjs0s
WinSKvFXAwS6DgEfJfkZ92WEmIy3xx3pcaXbS4pIx4/gCi2AInfrfT/yIliPlSog
IZ3P7RaTUzqFdGS2sIjZept2pxEP5raX4T5CJfq26Omj4GBagG4=
=6NJt
-----END PGP SIGNATURE-----

--nextPart1660472.2L4SBVNbov--
