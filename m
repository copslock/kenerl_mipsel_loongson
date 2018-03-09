Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Mar 2018 00:31:05 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:57322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990401AbeCIXa6ggv-A (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Mar 2018 00:30:58 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 360242133D;
        Fri,  9 Mar 2018 23:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360242133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Fri, 9 Mar 2018 23:30:47 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mmc@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 14/14] MIPS: configs: ci20: Enable DMA and MMC support
Message-ID: <20180309233047.GL24558@saruman>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
 <20180309151219.18723-15-ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qgd2S+2VS1hsWwXW"
Content-Disposition: inline
In-Reply-To: <20180309151219.18723-15-ezequiel@vanguardiasur.com.ar>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62899
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


--Qgd2S+2VS1hsWwXW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Mar 09, 2018 at 12:12:19PM -0300, Ezequiel Garcia wrote:
> This commit enables the SD/MMC support, along with DMA
> engine support in the CI20 defconfig.

Please reword to use the imperative mood, e.g. something like:
> Enable SD/MMC support, along with DMA engine support in the CI20
> defconfig.

Otherwise:
Acked-by: James Hogan <jhogan@kernel.org>

Thanks
James

--Qgd2S+2VS1hsWwXW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqjGSYACgkQbAtpk944
dnoFOBAAtZP6rVgfU2+vKXR537tO6xtnymHXEYPcpvDPXrTZbYllIjgkpAofqQnb
hzBjLXCgS2WekxypM6w09i1Hp8s4bIyPczsNI0SC6Wzbpr5XxP0SmqxBDJIyZsRE
p/c/Pwj+R3CzWqOba9O13qw0fAa5kebH0CnaiJaqPDQMYTaU91i5On/nlz1HnnYX
BV167a23IfDprXWisqGGO429NZo5h8/491c+u7xhkD3iz4Chv/AinxoxISR8sQ6o
7+yihFgob2XpnteUqf8CquykW0f7zptexEOlmOonWfNP+RcQuJbR+kx3kEUdoRQr
vwPluMg2g9yCR6X3hlho3gIu3FnYW42v18XBSUa+QLgjpW1X3bpCINobT4iu28eq
Bfe3cdD7McA0Q35EKmlk4EsWrH7NkMBLO2M+96T2tElqa0L3cHIQAOD1ITUL8L7K
KPOhOoYr2yr258GEmBxmi1TII3phs2+Lis/njO3Bv/hONlGLQcFiHkxGVp/GBA7j
3tcR/9bnFu7eMUv4s825+qiAQGacseylU/ZHWdS2GYWdoIJqT+vGb9pe92dxwEZ/
rrZgW4v+Lpp0VHr0mJ2pSu+FICy1mZklJib9wbEi7voXiDREp0gPQ6rNYINPvlJg
atAJYXRtL5dHY+uxIOwpZwqSNNAA0ZqiwCNs8Bb3xp5ebl2bfak=
=Vu5T
-----END PGP SIGNATURE-----

--Qgd2S+2VS1hsWwXW--
