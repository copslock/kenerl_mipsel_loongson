Return-Path: <SRS0=rYMR=PT=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320E6C43387
	for <linux-mips@archiver.kernel.org>; Fri, 11 Jan 2019 13:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A3420870
	for <linux-mips@archiver.kernel.org>; Fri, 11 Jan 2019 13:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732928AbfAKNxu (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:53:50 -0500
Received: from mout.gmx.net ([212.227.17.20]:52355 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729744AbfAKNxt (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 11 Jan 2019 08:53:49 -0500
Received: from [192.168.178.38] ([31.18.251.131]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LinyL-1hGAwd0crV-00d2HI; Fri, 11
 Jan 2019 14:53:42 +0100
Subject: Re: MIPS: ath79: regressions after dma-mapping changes
To:     Paul Burton <paul.burton@mips.com>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Crispin <john@phrozen.org>,
        "antonynpavlov@gmail.com" <antonynpavlov@gmail.com>
References: <6fcd16d9-84fc-891e-a295-9146c8071900@rempel-privat.de>
 <20190110195650.ped5tqsgkedrnn3d@pburton-laptop>
From:   Oleksij Rempel <linux@rempel-privat.de>
Openpgp: preference=signencrypt
Autocrypt: addr=linux@rempel-privat.de; prefer-encrypt=mutual; keydata=
 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
 8VXa+gkZKRSnZTvVMAriaQwqKog=
Message-ID: <315dd01f-80de-ddf0-c21e-950bad5c8988@rempel-privat.de>
Date:   Fri, 11 Jan 2019 14:53:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190110195650.ped5tqsgkedrnn3d@pburton-laptop>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TZeBoCB2KFWBkahk0fvOClrK9x3fMA42M"
X-Provags-ID: V03:K1:2TQp9/5UbF5KgWhaskLNoJHNbXg2vs2IcZ2jU/zo5GUso4S1Uc3
 yhNQiEndEzYzWIbZfuLWSnd2kd9xpWUWkmA2fIxwMtsAlfGEE2GqSh+sQK0NiZXi4El9+4g
 NLCtz2TYqBScMC9VHjeMkAvA0b2mKUzRP2fERtx9NpYA9nmBeJCVtimO8n+HddSUuQ/PpmF
 zQsTOOzwkHlTare/jio6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DjPcrFXernI=:oDZpOXy0NIzCXAY4SDhtM+
 VX1F1ermtcPBpdPYoV5YQhaO4eugMedCmnSvgxH/jbm5km38RAwnj0L1r1+K7eOT5FtCSg2I4
 hq43rud1dmOaDTWMZWnsLTMmI8xippiCI1WUp5zYr48GVuPEHWt0IRI9zdTX2YobsaIoQUBUq
 lKibQ71bBwYvnBBF5t4gfrtMm820OxqkL+/R/qm48tCWBw5rNh4f/IETLFSeWxg3jMyqDtYQb
 pb6jgOadi3mDHhHu2YLAjRQEGYInXoBd5BHFxYFm92/u7IyyADnD7DaMTs0ynFFNsOxygxQfg
 SjR7V00l85cdz5NFnLMwIcFYA0SER6Q2isedoU9XOlFfjyoekFRpUm3INICJCEt67rrUJ1YMJ
 Uj18BhpWbOA5/62kUYFYqitAJQioWz8mMphwYUdpIfBM3zHR8kGq2F/zlH8ghZlpp6aqACgiW
 g8SZf1DnEb8jcUMvgIuoPIN2GH1acjw95/HiXz4y42qjdiIKhqwEq3dMFUfZnmZj/BRtneEgG
 yEKcnYduMSDvogxvO1P2j44+LRWQEkax9z376MjoeTAsoYkNL20Hasht+Nz71XCn3+YU7OXW3
 nScYRmEDrkV3vL7PFR8FCz7oY5g6r3j9HMjm18pKW7xKujNK1lOSDR9Z12B+gCIHSAc3rYqfm
 AC959kJo7/Fdy+L0VOTl4XrcTvrtAvuoUt7lmXpr+J2/AQ7Kn4suTmHmLBFIcswcpReFbcZdK
 ZmPoqTJkjwT/pHPeJ6fFm3UQ5uk51nL/u3AMBn16ee3rW3UM8zcWs8gWQehz7kRpm1AUBcg1Z
 +BaJ9OnumgALuvBH4IEz/kavnFgr0FRz6UXa99TnQceotNYr9xIbaUDeeIRB2s5Rbcd11TUoV
 hmXXG/IIuA4JdcxhT/5m/tCWJRqWYrbKG9ajdxH1SSbGqqDW07hMgIAaE0L9pa
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TZeBoCB2KFWBkahk0fvOClrK9x3fMA42M
Content-Type: multipart/mixed; boundary="NK2cc0DMoZPOrvSbNJk4rICTwmlXjBIoj";
 protected-headers="v1"
From: Oleksij Rempel <linux@rempel-privat.de>
To: Paul Burton <paul.burton@mips.com>
Cc: "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, John Crispin <john@phrozen.org>,
 "antonynpavlov@gmail.com" <antonynpavlov@gmail.com>
Message-ID: <315dd01f-80de-ddf0-c21e-950bad5c8988@rempel-privat.de>
Subject: Re: MIPS: ath79: regressions after dma-mapping changes
References: <6fcd16d9-84fc-891e-a295-9146c8071900@rempel-privat.de>
 <20190110195650.ped5tqsgkedrnn3d@pburton-laptop>
In-Reply-To: <20190110195650.ped5tqsgkedrnn3d@pburton-laptop>

--NK2cc0DMoZPOrvSbNJk4rICTwmlXjBIoj
Content-Type: text/plain; charset=utf-8
Content-Language: ru
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Am 10.01.19 um 20:56 schrieb Paul Burton:
> Hi Oleksij,
>=20
> On Sat, Jan 05, 2019 at 05:39:06PM +0100, Oleksij Rempel wrote:
>> Hi all,
>>
>> I'm working on Atheros ar9331 related patches for upstream. Suddenly
>> this architecture is not working with latest mips_4.21 tag. Bisecting =
is
>> pointing to dma-mapping-4.20 merge.
>>
>> The symptoms are following:
>> - networking is broken, getting tx timouts from atheros network driver=
=2E
>> - depending on configuration boot will stall even before UART is enabl=
ed
>> - after reverting some of dma-mapping patches, network seems to work b=
ut
>> init will trigger segfault. It is running from nfs-root.
>=20
> Could you please try with v5.0-rc1 & let us know how that goes?
>=20
> The mips_4.21 tag was based upon v4.20-rc1 which had a bug in
> dma_alloc_coherent. That was fixed for v4.20-rc2 by commit d01501f85249=

> ("MIPS: Fix `dma_alloc_coherent' returning a non-coherent allocation").=

>=20
> In general if you're planning to use the mips-next branch or a tag from=

> it then I'd suggest always merging it with the latest -rc or the releas=
e
> of the appropriate kernel version, and possibly also the mips-fixes
> branch. Or just use linux-next instead of mips-next.
>=20
>> First patch where regressions started is this:
>> commit dc3c05504d38849f77149cb962caeaedd1efa127
>> Author: Christoph Hellwig <hch@lst.de>
>> Date:   Fri Aug 24 10:28:18 2018 +0200
>>
>>     dma-mapping: remove dma_deconfigure
>>
>>     This goes through a lot of hooks just to call arch_teardown_dma_op=
s.
>>     Replace it with a direct call instead.
>>
>>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>>     Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>=20
> Having said that, I'm not sure the dma_alloc_coherent issue we had woul=
d
> have led to this patch being pinpointed by a bisect, so let's see.

With v5.0-rc1 dma issue is solved. To run v5.0-rc1 i need only two extra
patches:

SUNRPC: Fix TCP receive code on archs with flush_dcache_page()
and
Revert "mtd: add support for reading MTD devices via the nvmem API"

every thing seems to work fine... at least on Atheros AR9331.

--=20
Regards,
Oleksij


--NK2cc0DMoZPOrvSbNJk4rICTwmlXjBIoj--

--TZeBoCB2KFWBkahk0fvOClrK9x3fMA42M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlw4n+MACgkQdQOiSHVI
77ShWAgAv/xB+Eyhq01UMvB9VT8dRaARelXdVvA0I4SCsTQXS2XmyxcjJR/IHoG8
HiMd4772CxgwX//oHHKYQgYqZOLkvHl71wQoISGdEwQE+CzGKP2x0l2JBkw1sVk2
UB9mWBxEvrr8jjJiYYQMKZf7BLdQ0Z+8jzA/tqp6Ls1bHuNy20ARZHTaJWLaCcJS
+f5MoGSbZ0VJSAvhCYqWvHILZEma8LuRNN5qiKDmtJv06h56u2G+1G5bVF+sLFdM
XHbNzBQNDdx4UuKbOn6y5bT2rRGr0zNs5YZVjixqlu5eOh/9KJhD2RMCwMWphks2
wxOAiqnHYJUg17Apd1a+BKBMdzIK7Q==
=aThI
-----END PGP SIGNATURE-----

--TZeBoCB2KFWBkahk0fvOClrK9x3fMA42M--
