Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2015 13:34:02 +0200 (CEST)
Received: from mail-wg0-f43.google.com ([74.125.82.43]:35116 "EHLO
        mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012560AbbEFLeAeCIKe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2015 13:34:00 +0200
Received: by wgyo15 with SMTP id o15so8194425wgy.2;
        Wed, 06 May 2015 04:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5BMMkFmRrqdt9SoxaTWI8BBT0IpPnDhsG9pvZKtnc44=;
        b=HePgLFGJIH/ATpwMMF+aGSb6ZkcbXEjPfe4hA80cmPwPzZEzE4IOFpoKI/vrHZ5d6P
         0uqXHXXbeI3iwnCqW+BbdWEMJCvgUAV4gqJfbIV36hSgZ1hHweDqWJbfAQaNSfTD147j
         qcijBXZVAlbiora0YR1RYykTVequfoX8NM4xt0eJ0AAQ1bTsW3xjzZuKRlKzBVgPJVIn
         2XwRerGvMnAHGyN8rwM47xrbv2DIaFXEHv9KFwO6wssQ1hewprGTBHjun0pNLM2u7Bfq
         J2FXUzhuykTQOhGwapp1kfpG1kIGi+QSuyEM669jjiD5vyIzXvvJVum+S6sEggqO3cEB
         b6Vg==
X-Received: by 10.180.24.65 with SMTP id s1mr4108275wif.66.1430912037382;
        Wed, 06 May 2015 04:33:57 -0700 (PDT)
Received: from localhost (port-23489.pppoe.wtnet.de. [46.59.153.115])
        by mx.google.com with ESMTPSA id r9sm2331742wjo.26.2015.05.06.04.33.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2015 04:33:56 -0700 (PDT)
Date:   Wed, 6 May 2015 13:33:55 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Barry Song <baohua@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: Re: [PATCH v2 0/8] clk: Minor cleanups
Message-ID: <20150506113354.GA9421@ulmo>
References: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@gmail.com
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


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2015 at 01:46:15PM +0900, Krzysztof Kozlowski wrote:
[...]
>   clk: tegra: Fix inconsistent indenting
>   clk: tegra: Fix duplicate const for parent names

I've squashed these into the patches that add the EMC driver.

Thanks,
Thierry

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVSfwfAAoJEN0jrNd/PrOhVSwQAJ/rA3S2D6xMynluMc5UstEk
UZ72ZR6v0z5S9VzLenuIhtSsuk7oVJbTmDgMvf8XAbbOWtbGHJQn6ZmR3Me6GG+x
zzIGolMjNHrBRK9MOdni1ryv3/F81BE7QZrGHvnMpeXRbDerQJz3C+PUlcZ1nsu6
6hGfCl6+QCVT82nX3oj3qEdQScMMbiG37VTTluW63wQY3qaSZARouMLou1/MY+ln
4GUa09KVJdiAlASQ6llRQVAPVas1WGX2OCmhNeqhk8ERQVJj1orjxl4rOyTVux14
PvHHdfJrTA1w8WxzrLKjvUCm1aJgc5sNTQqZV9TcA0ktdjMtjkFaWAFS70J9oWrG
/bk+CbeJtEDWhTOIvclVlbwQ0kyZtFexSZgc1uICHB3PABb2LdZ3HDHrZs3KskCD
7FrUSakBBB5c9USKnaBDmBxuRW5ORDHQfPlrAB46Ye6SBB2GvgsW/S9JxVDRioqX
BB83VnMMxSxPyGCqgmvAkAV06wHMy3RwVs+OMi8FqhQwb7f+QTo/ERxwTBbtk/WC
SRJaopAR/sz6igINaL1Nx21Z/kju4xMjCZraLcII4p3CJvT6YtT9Q78xWJGGribj
U6bHROgmnJxNnb9PTq/nYL4j4GeOfr6+sbp/If0v4WkS7BBtQAxXHXLgVbmPR1Un
IO7lmnPDceWy7YJedk4F
=LSUk
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
