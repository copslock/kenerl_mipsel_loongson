Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2018 23:54:29 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:48552 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994604AbeIDVyYgzhBI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Sep 2018 23:54:24 +0200
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 9FACE492E2;
        Tue,  4 Sep 2018 23:54:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id CkqnDsZssC5m; Tue,  4 Sep 2018 23:54:17 +0200 (CEST)
Subject: Re: [PATCH v2 net-next 4/7] dt-bindings: net: Add lantiq,xrx200-net
 DT bindings
To:     Florian Fainelli <f.fainelli@gmail.com>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, john@phrozen.org,
        linux-mips@linux-mips.org, dev@kresin.me, hauke.mehrtens@intel.com,
        devicetree@vger.kernel.org
References: <20180901114535.9070-1-hauke@hauke-m.de>
 <20180901120407.9912-1-hauke@hauke-m.de>
 <5866e89f-ac9a-8c6c-bf53-3b1206171e31@gmail.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <eb19b532-8a22-4bfb-ae03-7b563ab951e1@hauke-m.de>
Date:   Tue, 4 Sep 2018 23:54:10 +0200
MIME-Version: 1.0
In-Reply-To: <5866e89f-ac9a-8c6c-bf53-3b1206171e31@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="e9TLdY9O2j3pVJJBcjK8u3SqrPvLPQd8c"
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65933
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
--e9TLdY9O2j3pVJJBcjK8u3SqrPvLPQd8c
Content-Type: multipart/mixed; boundary="3YXgcjdJQutfN8Y4EgutzzpNnpILg0SdY";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Florian Fainelli <f.fainelli@gmail.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, andrew@lunn.ch,
 vivien.didelot@savoirfairelinux.com, john@phrozen.org,
 linux-mips@linux-mips.org, dev@kresin.me, hauke.mehrtens@intel.com,
 devicetree@vger.kernel.org
Message-ID: <eb19b532-8a22-4bfb-ae03-7b563ab951e1@hauke-m.de>
Subject: Re: [PATCH v2 net-next 4/7] dt-bindings: net: Add lantiq,xrx200-net
 DT bindings
References: <20180901114535.9070-1-hauke@hauke-m.de>
 <20180901120407.9912-1-hauke@hauke-m.de>
 <5866e89f-ac9a-8c6c-bf53-3b1206171e31@gmail.com>
In-Reply-To: <5866e89f-ac9a-8c6c-bf53-3b1206171e31@gmail.com>

--3YXgcjdJQutfN8Y4EgutzzpNnpILg0SdY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/03/2018 09:46 PM, Florian Fainelli wrote:
>=20
>=20
> On 9/1/2018 5:04 AM, Hauke Mehrtens wrote:
>> This adds the binding for the PMAC core between the CPU and the GSWIP
>> switch found on the xrx200 / VR9 Lantiq / Intel SoC.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> Cc: devicetree@vger.kernel.org
>> ---
>> =C2=A0 .../devicetree/bindings/net/lantiq,xrx200-net.txt=C2=A0=C2=A0 |=
 21
>> +++++++++++++++++++++
>> =C2=A0 1 file changed, 21 insertions(+)
>> =C2=A0 create mode 100644
>> Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt
>>
>> diff --git
>> a/Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt
>> b/Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt
>> new file mode 100644
>> index 000000000000..8a2fe5200cdc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt
>> @@ -0,0 +1,21 @@
>> +Lantiq xRX200 GSWIP PMAC Ethernet driver
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Required properties:
>> +
>> +- compatible=C2=A0=C2=A0=C2=A0 : "lantiq,xrx200-net" for the PMAC of =
the embedded
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : GSWIP in the xXR200
>> +- reg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : memory range of the=
 PMAC core inside of the GSWIP core
>> +- interrupts=C2=A0=C2=A0=C2=A0 : TX and RX DMA interrupts. Use interr=
upt-names "tx" for
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : the TX interrupt and "rx=
" for the RX interrupt.
>=20
> You would likely want to document that the order should be strict, that=

> is TX interrupt first and RX interrupt second, but other than that:
>=20
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Currently this is fetched based on the name like this:
platform_get_irq_byname(pdev, "rx");

I do not care about the order, just interrupt-names must match.

Hauke


--3YXgcjdJQutfN8Y4EgutzzpNnpILg0SdY--

--e9TLdY9O2j3pVJJBcjK8u3SqrPvLPQd8c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAluO/wIACgkQ8bdnhZyy
68dmhwf+JA1mtQmFE8JwGaL12ZOrgdDekT4TuVKvO10fkvAdRw2c9//XQ+HlYW77
DuznsLhCpHsgZJXnZmdyvRcaLSs/ZhBUpEtqDrOxgWgxCGOPIzTgykFBfxBREuwQ
4VVPstVs10+pPDh/B7UCaIJizuz3XX5qBFdyau9xcDr1MMPx5V+nucT79Dr0nRqF
aMUHA4raeJxTEpDC3gaQkmiY+d0rymGZhVZIH8tNkZU1ASY3suLC9sNGkU8ur7bh
q2XBMEoaGQkH6T55GbJ1xvTCFnhnqTWDBwf/R2SeqfUCJWI2vkg3PM8Hqpi73zOA
xMdlufWLRGoNYUt+DZXA8ICuzHmFQg==
=6GfD
-----END PGP SIGNATURE-----

--e9TLdY9O2j3pVJJBcjK8u3SqrPvLPQd8c--
