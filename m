Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2017 06:31:19 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48391 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990451AbdI0EbMCAirC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Sep 2017 06:31:12 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 067C35363B222;
        Wed, 27 Sep 2017 05:31:03 +0100 (IST)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Wed, 27 Sep 2017 05:31:05 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL-X.hh.imgtec.org
 (10.100.10.113) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 27 Sep
 2017 05:31:04 +0100
Received: from np-p-burton.localnet (10.20.79.175) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 26 Sep
 2017 21:31:02 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     David Miller <davem@davemloft.net>
CC:     <matt.redfearn@imgtec.com>, <netdev@vger.kernel.org>,
        <alexandre.torgue@st.com>, <peppe.cavallaro@st.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <james.hogan@imgtec.com>
Subject: Re: [PATCH] net: stmmac: Meet alignment requirements for DMA
Date:   Tue, 26 Sep 2017 21:30:56 -0700
Message-ID: <2520219.WSsBr6LeCR@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <20170926.195244.506518182147628099.davem@davemloft.net>
References: <71740323.RRBhnhefTi@np-p-burton> <1752163.uYYNevmZpH@np-p-burton> <20170926.195244.506518182147628099.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3088073.UpTNVJzPrf";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.79.175]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60168
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

--nextPart3088073.UpTNVJzPrf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi David,

On Tuesday, 26 September 2017 19:52:44 PDT David Miller wrote:
> From: Paul Burton <paul.burton@imgtec.com>
> Date: Tue, 26 Sep 2017 14:30:33 -0700
> 
> > I'd suggest that at a minimum if you're unwilling to obey the API as
> > described in Documentation/DMA-API.txt then it would be beneficial
> > if you could propose a change to it such that it works for you, and
> > perhaps we can extend the API & its documentation to allow your
> > usage whilst also allowing us to catch broken uses.
> 
> The networking driver code works fine as is.
> 
> I also didn't write that ill-advised documentation in the DMA docs,
> nor the non-merged new MIPS assertion.
> 
> So I'm trying to figure out on what basis I am required to do
> anything.
> 
> Thank you.

Nobody said you wrote the documentation, but you do maintain code which 
disobeys the documented DMA API & now you're being an ass about it 
unnecessarily.

Nobody said that you are required to do anything, I suggested that it would be 
beneficial if you were to suggest a change to the documented DMA API such that 
it allows your usage where it currently does not. If you don't want to have 
any input into that, and you actually think that your current approach of 
ignoring the documented API is the best path forwards, then we're probably 
done here & I'll be making a note to avoid yourself & anything under net/ to 
whatever extent is possible...

Thanks,
    Paul
--nextPart3088073.UpTNVJzPrf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlnLKYAACgkQgiDZ+mk8
HGVJyxAAnRY6g4+bYlyRldy6IOLa/u30RVY+Cp+SEm8FU+SL9DWSTIlLwvo5Yeyy
1lPTtdkL0ZSNj8jB4sgaP6JscdC8+FpxXsS4vqy1K2j/XSoZjAWVAZrN7GkOZH2w
wM5AbjzcBOIkd2cWkLG4O22qkbkOolfbV1XSUros7fKZXeuHfatGs7sutRolD7iy
/KgEmF24RCYeMxp/XtolnSQcNfDWzfaNxdtm8To1j6srJ5HMTAS7goQ9sNXgQ32S
tzzHUTGXimKJdwQw3DfO4mavyN9zeW7CIvsdRtW3cQn4bxfxrW/9UUpR3ow8urav
lYrgXQa7kCCIuXX4vNK7qeYs/7V+LtjAzEp0p7NX3b5GOHu0CZxnsDQZ9u2Jf32F
3YicmJSVOB2Q/AC4RmWZ4agdHWKOU8TiuFtzItqx7GjimQG8Uaj5BjjeqRJ/CFbu
UzeLa8wVBShjAF1CmgNwsLKMle/kQpzBjxgFWl8rtDBAVTME+yH54SIAyXRDeqlX
3H/3UhzVc65lFGAJ/bA+GVzGUhfQRrRgwKhIefUY8P6hEq+MP//ZXDZuElwTSmvY
n3CnW86H8EjwL37qKgcd6hSYRTMqiMEWn/SD6ykbcYprG+IEybTv/GAymXGo1+cR
EDsJHGll7Qc0IcCNc1Y+DIH3aoqIabqILlwvX9trH1zUoAX816M=
=vqEP
-----END PGP SIGNATURE-----

--nextPart3088073.UpTNVJzPrf--
