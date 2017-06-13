Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jun 2017 14:35:53 +0200 (CEST)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:36407
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993977AbdFMMfpeCQ2w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Jun 2017 14:35:45 +0200
Received: by mail-wr0-x244.google.com with SMTP id e23so29759171wre.3
        for <linux-mips@linux-mips.org>; Tue, 13 Jun 2017 05:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IIywL1N/tukcaRGkITD1/xdg8tXcloFz1Z6qg1hejGw=;
        b=JCXsmJs0pMpJ7oTrajaO1lCH51GGxq05xjrhtVaskuBW7GiJn5ghJ4RGLcsHO8Vldv
         wnXEpQbVqJSRvUbI7QohavYAsXp4VG6xAgfHONgDThjRqlG/tBIjp6qJinLfZIxNLcPO
         NRmT4Wi6FGF1x5Zl3MiwiBjHLrPnM0SoS6mMRAGpg3bVvodpOU8CUHKpBRNs7w3+c54n
         b60RyTOb1pekXScpPLj2uJ1n3E/KQ9cZxbUtz7aHG8J0oiRU2hriDiuli0ZSHaQoj8BW
         JjGGXZdUuyb1pfep2y3DZXw7UJ1TebOpr+vrKipxk6Wtb8E0irMAbZie7GzpeFpBjOBs
         yeug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IIywL1N/tukcaRGkITD1/xdg8tXcloFz1Z6qg1hejGw=;
        b=S16RmtpB6moOH3D/EnUAZjByMERn8veYt5/drxG6YAAhGeCxQkR9xILCoFujdmAWgn
         n5W4eCOBSlmhxfP2ww9D0NwkEs5X67ctSQnp5mVuMYus2txN0r/MKRMZXoiZiV8Q2ohm
         PlW9zVZBauEn6cu1asdUyTO38fNNa42CYl/Orc4qlJy23qpW1CASVJOPZwrVrnwGVW79
         MBc1nyqWx5zpVua62qgJ7AdFR/Gc2Zuf3lpZlewUchx2t8JhRylwj6rnugm5crenlXRq
         pjoVP1w4VxOhbNCtBjBeB27WkOpzj5mExO4OqL8dmEypEuw4MKJejeG7AV3JT5TDmGKv
         1TUA==
X-Gm-Message-State: AKS2vOx2Puv+uYtPmhbd04qlgofA2cQtEx+hPoWgdC88J/JZ2Z0kRIKo
        S9A3zWdmdVd9eQ==
X-Received: by 10.223.138.188 with SMTP id y57mr2929988wry.93.1497357340226;
        Tue, 13 Jun 2017 05:35:40 -0700 (PDT)
Received: from localhost (p200300E41BCE240033EA1446C9951F9C.dip0.t-ipconnect.de. [2003:e4:1bce:2400:33ea:1446:c995:1f9c])
        by smtp.gmail.com with ESMTPSA id y2sm13208249wme.12.2017.06.13.05.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Jun 2017 05:35:39 -0700 (PDT)
Date:   Tue, 13 Jun 2017 14:35:38 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/44] firmware/ivc: use dma_mapping_error
Message-ID: <20170613123538.GB16758@ulmo.fritz.box>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <20170608132609.32662-2-hch@lst.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58421
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


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 03:25:26PM +0200, Christoph Hellwig wrote:
> DMA_ERROR_CODE is not supposed to be used by drivers.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/firmware/tegra/ivc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlk/3BoACgkQ3SOs138+
s6HPehAAsPH3WCVEat0HG8XtDXXMKUx9atqqkjijlfz3wzr3Yu8oeWJkmauxBI2J
xWvBLcQSO632cLKWDXp9sfnjUN9McgOQi4LbbEnJZ3Wzovtn86aaPUXEtbrUImTw
P57+RXkSbiFiGp8LlUECzxlshCYZHbzvOmqvdxpBqOTjQfv7fehxm+SVPJgkRflE
EUuCItQsdBhnqBOtq743sf7Ck4QJ3Kz4pLGgntIDINnwiPxWjpMpI06SeVnvK2st
d5lq46pyBdS3dliCsRcn6jukf79HzS/jStxG8r5YCEkRfCPvw0au5ds8iywvCZrZ
hJYP0tumPW9j/x0ZC35a6j4dIbotmuhqCE2mYJUjG2mKDtAtdqZKVBvwKUmxzGok
H7YKQDZN54UOBVg4Rzsbu80eyYc2jFZEWIhICrQUYVM534Psw7LGnA6hMiv5X8aS
J4T7cOnL+71/iwE9Ey5EdvTbV22/mcx711OcyPbZ7q5Dv4AZE9HdJrPTF1rf1TeA
WDqgA3BbY6JNflUayq5in0OxeyN8/qKbJr9ozhXgCNKNUUH5nihjT4LZxENEWV2p
pRCppkKHw9Wmze/9cDuINms2Ef1DlEzxJ9BqE5mtiFFsCq1mn9EUxgMt4vbbfMqC
Ynk0gIB134Hm0HIXoJcwdQ/27Ltko3nyeRm+28ka/gS8GVgYtec=
=jGwQ
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
