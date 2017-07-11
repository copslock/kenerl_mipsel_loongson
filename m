Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jul 2017 22:40:27 +0200 (CEST)
Received: from mout.gmx.net ([212.227.15.18]:52946 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993978AbdGKUkR4U7YY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Jul 2017 22:40:17 +0200
Received: from [192.168.1.100] ([31.18.251.132]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LvEZe-1deY6v3DNq-010PzE; Tue, 11
 Jul 2017 22:40:08 +0200
To:     Alban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Felix Fietkau <nbd@openwrt.org>
From:   Oleksij Rempel <linux@rempel-privat.de>
Subject: mainlining ar9344
Message-ID: <94279215-a561-58ec-db4b-94dfdd19f342@rempel-privat.de>
Date:   Tue, 11 Jul 2017 22:40:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gHsj2gmUcoR5F6qI6DkeMgOWos7eM82xC"
X-Provags-ID: V03:K0:ySeaEvS1ICKy//O9P1HzWcqcYTvcMgKmpkP41AL6O0Ymm8kbtag
 sehKc1G6C5HqA5/VbSuAhUPbHltpc/tBChQDl0UKGyenGCizU+SfBkG+GHae13km2XjytM2
 7j8QorgNCjKKTPLFb/+f80jNrYzBSSnl2u5xLsudSRCsDUbhUsoeUDRvuNrJP4GS8YGw+KT
 sLibI0NURn67YvufgPA1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VzElNV0YvhY=:z2EghYmU64jgGz9hp0EPyF
 xB75FFrvtwhJ8W463FbZiumcOira477Rvd1cANvv0FDMMmak18prirz9pFB8V3bhaoXx5HgQG
 9sW6dg6ExkU/VddlzNhhXkKafvaFSYBFlp8ty0A/v9xkyt9yyk5KuWfSJysbmX/LAT0NXA0y1
 oxT7Icp0CV1GSL1IEovxw+0acijdg/1i4uadJmoitJ6rp+/4QSexSZegvKuX5ZIlSKBx5++ql
 uNwcZktX+pFKT/S/8mH8iNAiTfilUTuucRd4o9r0Eq38+XAFVeOFWNmJwlPYYFQFZFZel77+K
 RCz0dJ0Vwu01ekKALHGmLqLYucKdX/QOTGTR+K73QjQJTgdjTD+ex6Yf9y/V/EtVviwNYMBYq
 PncaUvIuilHWe8WvbbyFqGHp9Z0x9fs87wJWWegimSmCmb2Ol7g8pl/+MdiJqpX93ai9yismT
 bkQKof1bgLniUFW3IXJ/LG/yPUKFpJZB5ZR9d8Kya1NIz9JD0O7zdlO3aE/yCVJHtSYS7Ef0u
 Cct644NIF3+Q6bOkGruQssCOo4BgUE9/EKtEO/oxLDhkXe5U+AQt8nwmZBRSFeCMQWObSfltM
 AoKXJAzQ9RvNqA/065F1uMSBib70R5N4keh+ecTOcuxJR+kjlqUWJ5rrUnCXJWEen1gsHbxkY
 RZbdowm93zcdYL+h1SdIy4JmOii5t1Qj0dULyUZRC3+sfCNwYdbJgvxr2SSdKE9Z51dBssT4y
 zNtT+hsR6YVxcKNgO0pDHfRRtzMXpV31SXlb6ehxeG8lraWwdYNpljoQq2s=
Return-Path: <linux@rempel-privat.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@rempel-privat.de
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
--gHsj2gmUcoR5F6qI6DkeMgOWos7eM82xC
Content-Type: multipart/mixed; boundary="jQI5RGxkBjxqqwwCkL6Nc9OSmFtQtQjgA";
 protected-headers="v1"
From: Oleksij Rempel <linux@rempel-privat.de>
To: Alban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
 Antony Pavlov <antonynpavlov@gmail.com>, Felix Fietkau <nbd@openwrt.org>
Message-ID: <94279215-a561-58ec-db4b-94dfdd19f342@rempel-privat.de>
Subject: mainlining ar9344

--jQI5RGxkBjxqqwwCkL6Nc9OSmFtQtQjgA
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hallo all,

I have a bunch of ar9344 based APs and would like to spend some free
time to make it work with mainline kernel (devicetree). Is it a good
thing to do? Any one working on it?

--=20
Regards,
Oleksij


--jQI5RGxkBjxqqwwCkL6Nc9OSmFtQtQjgA--

--gHsj2gmUcoR5F6qI6DkeMgOWos7eM82xC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAlllN6QACgkQHwImuRkmbWke+QD/Zb1856yhVA7D2lVhnfP1eloB
Y26Vc3rLwlU9yotxY9AA/1SV80mgBb+y/c7WHQ2wdeATUqo4qI2z9it6tHFszmnw
=jPq/
-----END PGP SIGNATURE-----

--gHsj2gmUcoR5F6qI6DkeMgOWos7eM82xC--
