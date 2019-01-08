Return-Path: <SRS0=z0u9=PQ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A96C43387
	for <linux-mips@archiver.kernel.org>; Tue,  8 Jan 2019 18:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F21206A3
	for <linux-mips@archiver.kernel.org>; Tue,  8 Jan 2019 18:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfAHSCp (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:02:45 -0500
Received: from mout.gmx.net ([212.227.17.21]:57015 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728752AbfAHSCo (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 8 Jan 2019 13:02:44 -0500
Received: from [192.168.178.38] ([31.18.251.131]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M4TgW-1hUF2C0v40-00yfXd; Tue, 08
 Jan 2019 19:02:32 +0100
Subject: Re: MIPS: ath79: net boot related regressions
From:   Oleksij Rempel <linux@rempel-privat.de>
To:     linux-mips@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     John Crispin <john@phrozen.org>, antonynpavlov@gmail.com,
        kernel@pengutronix.de,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        l.stach@pengutronix.de
References: <6fcd16d9-84fc-891e-a295-9146c8071900@rempel-privat.de>
Openpgp: preference=signencrypt
Autocrypt: addr=linux@rempel-privat.de; prefer-encrypt=mutual; keydata=
 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
 8VXa+gkZKRSnZTvVMAriaQwqKog=
Message-ID: <de5f0808-11e2-0e7c-573d-327b66235e86@rempel-privat.de>
Date:   Tue, 8 Jan 2019 19:02:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6fcd16d9-84fc-891e-a295-9146c8071900@rempel-privat.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6JjzfLHBFtYh3KXyaiq1v6Bnzxyfr5urv"
X-Provags-ID: V03:K1:4PWxHrGTspM6MndLWO7RT5v6AIY+LdPGs8rGbud+CufXp4CQxZf
 QDLC5PxOuZpKMJNpIqmJbcfn+sv5K0uMT/fwmAtGBrmPE+il3cRqtV2MKPmwVB4vJNbK59t
 cDPqkZrd2NbXIHxn+S6qsX6hi3qKp8I1AFlxMLdF1+/cj0zzAolFHyWEVWZRULfFUHJXCT6
 KiUj3OTU8Q5yhiMK4tQCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:14abPCMtuM0=:F/AkfLtTp3hIaqYS3oBWHy
 FmnIXvD8n5We/NT/eTOacCfluSS7TCbDqOg/t0X5//hKT7tYdSnQgluTcNDk98V4QzrM/MM4F
 +9hIqHmIBb0dJGDkMMn0y3s9ilCEKzISgKgDefIghE2Icl5fNP8SKyACfAVlsQ4QvdhKcVYmy
 /v9ShSliancMmFDVujpyiUEi11gw2DY8ShdpgQcTqaWqGsgpQ/SxC3705cVLy/nrZk1rWYNK8
 TX7HOZUwnT8vI5HagaF4ZZcQU2wk5qwKFI+j7pVh6hWRITRVhiIVhNR5dovOoT+CnjbYqY+us
 dz/9OET7pb5l23gIm/mNT8//8atahh492C8f1V2CNG8ZpL3Z4HVlXpp42DkOvy3j20wZXPqfy
 9eQos3sxxTHwKUyWY9AXbIzD29U6K6Uokd1vnd+uHUOSQmMcFq/Ar5hVQTrocsZyDXytkO9Xv
 XdzDxOGmIBL0JFcOjx+AXbaSNxTPYeRyq7A7f+Z2dqOPvIUtANoj82DgQfkz1kdZFw9wiEBMP
 wWobRIYABkMc8Xr1LZl2iGsTu/sQkPM56VdOnCxKOscvxkJCHn1mMF+1dp/gxgxOA8fdT38pP
 lP6UG2kOUkXo9MKCM4zoAZOwLhe/DkNMoAHSCUvOuJyRdC7lN5o6Vh1t/hL09r/S4nCqKGd8l
 TCT3x0x8mRxOGNBORKWjsbZDRijxtWq3VQnoAVRsHWXip6gQNG/F9NfVfCGn3uebFMqTAl3sM
 Na2OINM17ZMst3czjHlnQo8YeOGvZ69d70DiUxX7A0/06L2xRjSeMpkklcYHskc6TTVzcgtFo
 cfXiwXCFz7KD3QKVmGcWv9KUyWWsJD0sI3Fim/uTDJTjLE65m6FDqWBygtpQjc2P9pa/39Bi+
 5DqimZ5H7Z6ZFSi6GZpf50nbSDo91564+QjjVsytUbwxCoG7HPsU5TpZrzvdQCXEZ7OOWdh3Q
 umFw0lb2btmiGZ+i/kLr0sRYPo9voKEBkpMN4WeRWv5jz56Z0rGaKdoto5pgqsJjWopoFISCf
 sNqc/XV6L4QD+nq8Aywiksg=
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6JjzfLHBFtYh3KXyaiq1v6Bnzxyfr5urv
Content-Type: multipart/mixed; boundary="nM79OAx18q2FQIK5qdwwmj5rJVX2orZbz";
 protected-headers="v1"
From: Oleksij Rempel <linux@rempel-privat.de>
To: linux-mips@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc: John Crispin <john@phrozen.org>, antonynpavlov@gmail.com,
 kernel@pengutronix.de, Trond Myklebust <trond.myklebust@hammerspace.com>,
 l.stach@pengutronix.de
Message-ID: <de5f0808-11e2-0e7c-573d-327b66235e86@rempel-privat.de>
Subject: Re: MIPS: ath79: net boot related regressions
References: <6fcd16d9-84fc-891e-a295-9146c8071900@rempel-privat.de>
In-Reply-To: <6fcd16d9-84fc-891e-a295-9146c8071900@rempel-privat.de>

--nM79OAx18q2FQIK5qdwwmj5rJVX2orZbz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

Am 05.01.19 um 17:39 schrieb Oleksij Rempel:
> Hi all,
>=20
> I'm working on Atheros ar9331 related patches for upstream. Suddenly
> this architecture is not working with latest mips_4.21 tag. Bisecting i=
s
> pointing to dma-mapping-4.20 merge.
>=20
> The symptoms are following:
> - networking is broken, getting tx timouts from atheros network driver.=

> - depending on configuration boot will stall even before UART is enable=
d
> - after reverting some of dma-mapping patches, network seems to work bu=
t
> init will trigger segfault. It is running from nfs-root.
>=20
>=20
> First patch where regressions started is this:
> commit dc3c05504d38849f77149cb962caeaedd1efa127
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Fri Aug 24 10:28:18 2018 +0200
>=20
>     dma-mapping: remove dma_deconfigure
>=20
>     This goes through a lot of hooks just to call arch_teardown_dma_ops=
=2E
>     Replace it with a direct call instead.
>=20
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>     Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>=20
> It is not enough to revert this patch. This rework seems to be huge.
>=20
> I also tested dma-mapping-4.21 tag, with same result.
> In case, some one won't to play with it, the patches can be found here:=

> https://github.com/olerem/linux-2.6/commits/v4.20/topic/ath79-upstream-=
2019.01.04.1
>=20
>=20
> It will be great if some one can help me to troubleshoot this issue.

So far i found 3 issues, 2 of them are fixed:
- reconfigured boot loader, so kernel do not overlap on decompression.
Fixes no console stall boot.
- cherry picked commit d01501f85249848a2497968d46dd46d5c6fe32e6
MIPS: Fix `dma_alloc_coherent' returning a non-coherent allocation

fixes kernel network auto configuration.

The last issue prevent to execute any thing over NFS
[    4.790625] Run /sbin/init as init process

[    4.840768] do_page_fault(): sending SIGSEGV to init for invalid read
access from 77fed718
[    4.847670] epc =3D 77fcf138 in ld-2.28.so[77fb2000+27000]
[    4.853116] ra  =3D 77fcf414 in ld-2.28.so[77fb2000+27000]
[    4.911530] Kernel panic - not syncing: Attempted to kill init!
exitcode=3D0x0000000b
[    4.917745] Rebooting in 1 seconds..


First patch seems to be:
commit 277e4ab7d530bf287e02b65cfcd3ea8f489784f6 (HEAD, refs/bisect/bad)
Author: Trond Myklebust <trond.myklebust@hammerspace.com>
Date:   Fri Sep 14 09:49:06 2018 -0400

    SUNRPC: Simplify TCP receive code by switching to using iterators

    Most of this code should also be reusable with other socket types.

    Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>


nfs-for-4.20-6 tag do not have fixes covering this issue. @Trond, can
you please help me here?

--=20
Regards,
Oleksij


--nM79OAx18q2FQIK5qdwwmj5rJVX2orZbz--

--6JjzfLHBFtYh3KXyaiq1v6Bnzxyfr5urv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlw05bYACgkQdQOiSHVI
77RN8Qf/cgUw1g7XyVs5wYh0GdEpQStoA698uIl2uLY2/l8NNhSNzvkpXBHoa6Vd
Xn43w+yw8N2x2FFH22MKo99WkvufEPNTATKeNlaTsexSOx0KkcfDaaI+49xlZyjx
8tZ0Ww8/mqQvl0bsan37c8+u//YNA8HfX5C36DsKhtwiCaokCHAYT8zmZopXIUhy
u0ct0oVWhizRm/KSlvaX4ooqUEZJ+sEUxElDqTHwyh2pb0t//xSM/cS5zeNSpCCk
aBO9+Q3QinEHSyJzKq5H6/qmIXlWaaL+D3F0oCVCSk6BQ3/dL5H9LG8qTHo/F9r1
dAlSTbM49S3UpH2LdvBwv/AKMy2h6w==
=B+kb
-----END PGP SIGNATURE-----

--6JjzfLHBFtYh3KXyaiq1v6Bnzxyfr5urv--
