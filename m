Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 09:54:07 +0100 (CET)
Received: from smtp3-g21.free.fr ([212.27.42.3]:14800 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990518AbcKGIx7ksPop (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Nov 2016 09:53:59 +0100
Received: from avionic-0020 (unknown [87.138.236.184])
        (Authenticated sender: albeu@free.fr)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 1E32F13F814;
        Mon,  7 Nov 2016 09:53:41 +0100 (CET)
Date:   Mon, 7 Nov 2016 09:53:35 +0100
From:   Alban <albeu@free.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Alban <albeu@free.fr>, ralf@linux-mips.org,
        antonynpavlov@gmail.com, hackpascal@gmail.com,
        amitoj1606@gmail.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] MIPS: ath79: Fix error handling
Message-ID: <20161107095335.276c5c7f@avionic-0020>
In-Reply-To: <20161030082546.15019-1-christophe.jaillet@wanadoo.fr>
References: <20161030082546.15019-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/z60iR6RP2Mu=WzIQF=jQuj6"; protocol="application/pgp-signature"
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

--Sig_/z60iR6RP2Mu=WzIQF=jQuj6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 30 Oct 2016 09:25:46 +0100
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> 'clk_register_fixed_rate()' returns an error pointer in case of error, not
> NULL. So test it with IS_ERR.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Aban Bedel <albeu@free.fr>

Alban

--Sig_/z60iR6RP2Mu=WzIQF=jQuj6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYIEEPAAoJEHSUmkuduC28ZX4P+gPm9fsHq0QW+oEokIPnRd6N
LUX1qwhH1g0TI5ekXQUw0e/tKTVA/P8bUqC2miFnIa8gBTPWpJxzoOoHE+Oylion
p90ym79Yo2Y19BSMRUbg06VKTCpYGS7jpxfCLI822oIYBJxMa0OZmxWT2QaXSRwg
xeI17CYsQoDIcqgilJKSCV4j/YB/LpIln4SWuVJzDuWcWCFgKP/vincCkgQHZLud
gT1LTQSKJJWNpdsyKyLOQIUkxYxCV5NhK1RpTLfWxDzww1cPqhJOWqa8kHjUoBvd
PcvQxz4GAHc0n9bRTLh+BcY0N/eIqXrXjSfb2sNLJuKy4F5KET4M5b5JNhmZHF8U
wtCutGY6O8xei7UXTiODas6s/CoYiH0J4K50SRvEnjgs9hoEVx7rPuxoFLJY4Dxv
3v8MqCGzHgFdjChT7GwocjOJe7vDS567viU+wNW14bLG75m8qL+/FbgwnfnxS4a7
wH03v2BinLT2abQHrLRLKRuozTW8d5C+58uhC5XkJtunZ+pRurkjfC54msLcSCqL
8xZZFQY3hLhuKni+C1VqBCTSqPU/1/MkqqgES9fSoiiLzr+TUnyzptJvV4FQfGlm
gtkTJ3QGUXojY/qBI3D9/l98feMwNQ/tXxqsWY+EoGh9hWbMNP6wJZX7Y1dp7Zfd
WrSECPUmNicgDpORFRTn
=u1mB
-----END PGP SIGNATURE-----

--Sig_/z60iR6RP2Mu=WzIQF=jQuj6--
