Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Sep 2012 22:21:42 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.17.10]:56038 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903298Ab2IBUVg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Sep 2012 22:21:36 +0200
Received: from mailbox.adnet.avionic-design.de (mailbox.avionic-design.de [109.75.18.3])
        by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
        id 0M0XGM-1TSX2v3tja-00usJK; Sun, 02 Sep 2012 22:21:28 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id 35C682A282FF;
        Sun,  2 Sep 2012 22:21:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at avionic-design.de
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
        by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VetcsFmHd-VH; Sun,  2 Sep 2012 22:21:25 +0200 (CEST)
Received: from localhost (avionic-0098.adnet.avionic-design.de [172.20.31.233])
        (Authenticated sender: thierry.reding)
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTPA id 684022A281A5;
        Sun,  2 Sep 2012 22:21:25 +0200 (CEST)
Date:   Sun, 2 Sep 2012 22:21:24 +0200
From:   Thierry Reding <thierry.reding@avionic-design.de>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: Re: [PATCH 2/3] MIPS: JZ4740: Export timer API
Message-ID: <20120902202124.GA21635@avionic-0098.mockup.avionic-design.de>
References: <1346579550-5990-1-git-send-email-thierry.reding@avionic-design.de>
 <1346579550-5990-3-git-send-email-thierry.reding@avionic-design.de>
 <50437117.8000700@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <50437117.8000700@metafoo.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:Lsn7QrQZlRfOtc4MZYuacR9C1PNcxaPad9pAFM5RS7o
 TqYXfEYcyIjhMDaLUq/W62J/76luUhB1bvM2ESY37hcx9yU3sn
 OPQTJZa88oQqSKdogfPqKXuyxuPav8Kr7ZLiBiz+hECSxGd9Lf
 YAF5vQMcggw1H8ykDnIVDDBR9RbyEBMip2oXTkWRTreEST+tpi
 Mcyv70WoJkcRAeQgHc/cpHXxY3NKbz5Q7wrMbob3xDBD2Cs27V
 gHBJ80i0QKCFazGsJ71IynAr31lZjlc5Ub9aWJZchyRZQpE1CM
 rEmJBFQAbHzHhZgIuiECl+0qHPQO9XeUtg4SXpjIPT3nfT3KF1
 42d5cH9h5TUspfaUaB0IDymfWrJwop7dcxfPkmHFrf5e403Cwu
 VigStsoz0XHag+rFQUop/PtiM9D4WrotXI=
X-archive-position: 34406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@avionic-design.de
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
Return-Path: <linux-mips-bounce@linux-mips.org>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 02, 2012 at 04:45:43PM +0200, Lars-Peter Clausen wrote:
> On 09/02/2012 11:52 AM, Thierry Reding wrote:
> > This is a prerequisite for allowing the PWM driver to be converted to
> > the PWM framework.
> >=20
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>=20
> I'd prefer to keep the timer functions inline, some of them are called qu=
ite
> often in the system clock code.

I've opted for this variant because it better hides the register values.
If the functions are inlined it also means the complete register
definitions need to go into timer.h. If you don't think that's an issue,
I can update the patch accordingly.

Thierry

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQQ7/EAAoJEN0jrNd/PrOhOicP/3Bl1HCJf7GLPkSzeCpoQFNA
pDjyGpKgQn68wn+QNV53GlRwk9KheahF+MJ35tPYJrMuV/lv+A/zDjaE4gKM9hEZ
0BRNer/A+JRRE5JXt9cDEv5XBt8HRLOesfTHIt3gB0Wu5ohQInqmOs2sSTznq6IZ
LCQTgjuKFfCGQVV9eVvc1P4BZLDJiAbBuYwSdK1amW0lNUWjiZeT3I2/s4s950xF
Nn18ByEcnnxSIg1HdbqPu+db+OYnvTk8iC2KYnIL2TO4evtx5LFMm3qELNjj+bEs
go6CLnSgJruRPnLRaP5Iibj2cn4AsBY+4+BOq3aWP9RNZBCoCk4m8ff8m5iUbARy
1BZEMb0IPmkK1cfqPnU7kK73rTsFE/ZDPJe7ZHJQ+OXXZ46MOxWdb97O8cfn7j1o
QjCk9S6KF0yAxiuJQfLTzSu7h6qboceR4+hwdGXazHWuKt6Sxl6KqsTo2H1SYInv
rrr5Pfn9TICQpYGpMPdA3dO4cSneSzC9hoos68mTHgB18E0wTbmcrd+YvMnoJSNu
FME9UEJMU+6WrVgGHV79YQ2rBF30qqeXVIV411Qy1EyE50XlTvp79YfnJb5+Qjsn
x4habdpkr+0BbLw+o5DFpob7Xelq34TVETUTD+POAvycVpdxghWR2xajbl7MukFg
B8cZa7pRCQiXVyKOrPyR
=BD1p
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
