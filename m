Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2018 23:36:15 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:28198 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992554AbeIKVgLux3Sb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Sep 2018 23:36:11 +0200
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id DFC98493C6;
        Tue, 11 Sep 2018 23:36:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id hchZKBxYnsoJ; Tue, 11 Sep 2018 23:36:03 +0200 (CEST)
Subject: Re: [PATCH v2 net] MIPS: lantiq: dma: add dev pointer
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org,
        hauke.mehrtens@intel.com, paul.burton@mips.com
References: <20180909192623.14998-1-hauke@hauke-m.de>
 <20180910124542.GB30395@lunn.ch>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <e7185ec8-8426-9359-ab17-26b9a64c41cb@hauke-m.de>
Date:   Tue, 11 Sep 2018 23:36:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180910124542.GB30395@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TMVKD074rZT5hLW1NTmmWLUWM3o5KJwky"
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TMVKD074rZT5hLW1NTmmWLUWM3o5KJwky
Content-Type: multipart/mixed; boundary="E8aVpwwVI6TFhZuozTovmum5dv2t1jheL";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org, f.fainelli@gmail.com,
 john@phrozen.org, linux-mips@linux-mips.org, hauke.mehrtens@intel.com,
 paul.burton@mips.com
Message-ID: <e7185ec8-8426-9359-ab17-26b9a64c41cb@hauke-m.de>
Subject: Re: [PATCH v2 net] MIPS: lantiq: dma: add dev pointer
References: <20180909192623.14998-1-hauke@hauke-m.de>
 <20180910124542.GB30395@lunn.ch>
In-Reply-To: <20180910124542.GB30395@lunn.ch>

--E8aVpwwVI6TFhZuozTovmum5dv2t1jheL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/10/2018 02:45 PM, Andrew Lunn wrote:
> On Sun, Sep 09, 2018 at 09:26:23PM +0200, Hauke Mehrtens wrote:
>> dma_zalloc_coherent() now crashes if no dev pointer is given.
>> Add a dev pointer to the ltq_dma_channel structure and fill it in the
>> driver using it.
>>
>> This fixes a bug introduced in kernel 4.19.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>
>> no changes since v1.
>>
>> This should go into kernel 4.19 and I have some other patches adding n=
ew=20
>> features for kernel 4.20 which are depending on this, so I would prefe=
r=20
>> if this goes through the net tree.=20
>=20
> Hi Hauke
>=20
> Is this a build time dependency, or a runtime dependency?
>=20
> What we don't want to do is add the switch driver to net-next and find
> it does not compile because this change is not in net-next yet.
>=20
>    Andrew
>=20

Yes, this has a compile dependency because I had to extend the API.

Hauke


--E8aVpwwVI6TFhZuozTovmum5dv2t1jheL--

--TMVKD074rZT5hLW1NTmmWLUWM3o5KJwky
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAluYNUEACgkQ8bdnhZyy
68dsTAgAzmWaKTYsCVYewVL1vYoBCc3CsdjTsxmhXAn9eZNg5l+fdXxjxUIcY+s+
hkf/1dEvDCAT+Odpiwaq9xSFKRMx9pFQJhnO0YRZQoo3+jQ8zaB2RcSV7hp4qo4Y
sXWxQ6CiPiufwcLSZh3GxGuSFYJx3gcKtkltMUbmHlmrPM9a5Nm/4m+8s2Vp7opn
uu479Zl6xCsv5DOOG9qNHIRyVji6nejA/XXSv/Ncdg0WPt+MPusjuT/n64yBy0Z1
vEeqBj30pSo3YGtv8UVNmX21NqhpZ4PRvzUYIPCFxquFpJP5rVase7Z6NSxdLfyF
SGHHngB7fEO300LO+Q2DaF+SZ9NXGQ==
=sAXk
-----END PGP SIGNATURE-----

--TMVKD074rZT5hLW1NTmmWLUWM3o5KJwky--
