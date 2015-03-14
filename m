Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Mar 2015 12:14:55 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:52335 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007168AbbCNLOxquIrT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 14 Mar 2015 12:14:53 +0100
Received: from p4fe2544a.dip0.t-ipconnect.de ([79.226.84.74]:58484 helo=katana)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1YWk1V-00045p-9D; Sat, 14 Mar 2015 12:14:30 +0100
Date:   Sat, 14 Mar 2015 12:14:51 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 00/12] i2c: describe adapter quirks in a generic way
Message-ID: <20150314111450.GC970@katana>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Content-Disposition: inline
In-Reply-To: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsa@the-dreams.de
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


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2015 at 05:01:51PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Here is the second version of the patch series to describe i2c adapter qu=
irks
> in a generic way. For the motivation, please read description of patch 1.=
 This
> is still RFC because I would like to do some more tests on my own, but I =
need
> to write a tool for that. However, I'd really like to have the driver aut=
hors
> to have a look already. Actual testing is very much appreciated. Thanks t=
o the
> Mediatek guys for rebasing their new driver to this framework. That helps=
, too!

Thanks for all the testing. Merged this branch now into for-next!


--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBBgqAAoJEBQN5MwUoCm2fQAQAI1w0/RXIcR5OoBFBLw5DkCr
vA2Ou1OG9x9M2FP29hco4AzXRaRRHqe9hFRl31Adm0YoQF41/nf+7z4g1VveN4hD
P+ocEWMvzHnafbwGO0+QIYY4nhBVN+/a8eg+j4+AbKdQBLL2+b0I9uwpL1uwdiCY
ceRhoMrrg1oHcFUNKErXyuzA/t0dNq5ekx3z8iqpjjXjp3JRVmfpeueCzD6Gv0zg
HkXAC+U9Ur2gLvBpSRhadn9/Cy6cvOeuIF8Jq2wMOKDUM54Z1HwttT7dTiW8IGXo
xgXFaimc4StYeR1JQEyGLYUATfhXlOKPFOXrUktTwWLlGbgjKUqB3KKGDzR9XXB+
NvtWekSj9+h/c0hHYOiezMV21AIzr7n3c3cmAoK9XYMRz/NeTseC1jG4EgSVCQr1
Vl+QgAgOiOcSNJ3BPfLStNM0kAyPov0UB41EP25fWq3eOJMWUzUEvlLkJMadmPbL
ucvuLhMUvI1jp8EdTEiBltQuukM4tlHgp/tQrK245vO1s0NHnbOdgy68Lab7RfFp
KxbBwIQ1DOhMin80xOC9AUkkYbBppbqhCUc79Fpufx5FYSd+tS3dTLAdwOErmmSh
7YbWXMOdscAUD3+vuDYTWn4gPJGDtzM4MaYn2AAbGVchPa6UR/W1UZDKlpTDLcV/
wvo+3WNDb7KyV+YGySP4
=KnPk
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
