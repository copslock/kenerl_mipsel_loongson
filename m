Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2018 23:33:45 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:26402 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990945AbeIKVdlUUVSb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Sep 2018 23:33:41 +0200
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id B2A0749851;
        Tue, 11 Sep 2018 23:33:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id fkvXsl2TFCZt; Tue, 11 Sep 2018 23:33:34 +0200 (CEST)
Subject: Re: [PATCH v3 net-next 3/6] dt-bindings: net: Add lantiq,xrx200-net
 DT bindings
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org
References: <20180909201647.32727-1-hauke@hauke-m.de>
 <20180909201647.32727-4-hauke@hauke-m.de> <20180910125308.GC30395@lunn.ch>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <72fed78d-bc75-b88a-faa8-d2032be59d0f@hauke-m.de>
Date:   Tue, 11 Sep 2018 23:33:29 +0200
MIME-Version: 1.0
In-Reply-To: <20180910125308.GC30395@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oLEE0ykZURaRGF50ipN8ayXlYLC9wULer"
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66205
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
--oLEE0ykZURaRGF50ipN8ayXlYLC9wULer
Content-Type: multipart/mixed; boundary="pLkFwJQBS6Z446jNBrt5JyTNjHDv7HOdD";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com, john@phrozen.org,
 linux-mips@linux-mips.org, dev@kresin.me, hauke.mehrtens@intel.com,
 devicetree@vger.kernel.org
Message-ID: <72fed78d-bc75-b88a-faa8-d2032be59d0f@hauke-m.de>
Subject: Re: [PATCH v3 net-next 3/6] dt-bindings: net: Add lantiq,xrx200-net
 DT bindings
References: <20180909201647.32727-1-hauke@hauke-m.de>
 <20180909201647.32727-4-hauke@hauke-m.de> <20180910125308.GC30395@lunn.ch>
In-Reply-To: <20180910125308.GC30395@lunn.ch>

--pLkFwJQBS6Z446jNBrt5JyTNjHDv7HOdD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/10/2018 02:53 PM, Andrew Lunn wrote:
> On Sun, Sep 09, 2018 at 10:16:44PM +0200, Hauke Mehrtens wrote:
>> This adds the binding for the PMAC core between the CPU and the GSWIP
>> switch found on the xrx200 / VR9 Lantiq / Intel SoC.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> Cc: devicetree@vger.kernel.org
>> ---
>>  .../devicetree/bindings/net/lantiq,xrx200-net.txt   | 21 ++++++++++++=
+++++++++
>>  1 file changed, 21 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/lantiq,xrx20=
0-net.txt
>>
>> diff --git a/Documentation/devicetree/bindings/net/lantiq,xrx200-net.t=
xt b/Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt
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
>> +- compatible	: "lantiq,xrx200-net" for the PMAC of the embedded
>> +		: GSWIP in the xXR200
>> +- reg		: memory range of the PMAC core inside of the GSWIP core
>> +- interrupts	: TX and RX DMA interrupts. Use interrupt-names "tx" for=

>> +		: the TX interrupt and "rx" for the RX interrupt.
>> +
>> +Example:
>> +
>> +eth0: eth@E10B308 {
>> +	#address-cells =3D <1>;
>> +	#size-cells =3D <0>;
>> +	compatible =3D "lantiq,xrx200-net";
>> +	reg =3D <0xE10B308 0x30>;
>=20
> Hi Hauke
>=20
> This binding itself looks fine. I just find this address range a bit
> odd. What are 0xe10b300-0xe10b307 used for? Are all 0x30 bytes used in
> the range? The address range ending at 0xe10b338 seems a bit
> odd. 0xe10b33f would be more typical.
>=20
> I'm asking because it can be messy when you find out you need to
> change the address range, and not break backwards compatibility.
>=20
>      Andrew

Hi Andrew,

Thank you for the question, there were multiple problems with the
register size in this description.
It is a bit more complicated because the PMAC is part of the switch and
does not start at an even address.

It is correct that this starts at 0xE10B308, but the size is 0xCF8.

0xe10b300 is unused and 0xe10B304 is used to enable debug modes.

Hauke


--pLkFwJQBS6Z446jNBrt5JyTNjHDv7HOdD--

--oLEE0ykZURaRGF50ipN8ayXlYLC9wULer
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAluYNKkACgkQ8bdnhZyy
68fFqQf/ar1w8DpUFeNPTvJ7UATq7XPntradeex7oov4OspvWegtgNT6nBoUKW21
5RQveHc/Jg2EX+45Xfjfzb9+kH/gQjsqHIbcim1/dSVvUkotp++SdhoNZypVlIPP
/HeGsfW65HiquxqvvqDSvbYKGuYatvPcPO/h3dYOysROJlnG1/grQKRc7PrecWgL
i+TP/d07m0xlg7YKBwBW7FriJIqytAPB4srDbGLIJKYKcyFZlmAX3hXPG1hpYRGV
71+J8VSOf+2rFmx345GKi5pWCXaQuPgGMsoVTL6K8+d9gu+mcBFzzL9C63i/MXeI
30go5Qps1UGOMPtb8KwcIPw5+J2Y3w==
=hjwI
-----END PGP SIGNATURE-----

--oLEE0ykZURaRGF50ipN8ayXlYLC9wULer--
