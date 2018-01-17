Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 10:54:40 +0100 (CET)
Received: from forward101o.mail.yandex.net ([IPv6:2a02:6b8:0:1a2d::601]:41509
        "EHLO forward101o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992391AbeAQJy0TylOI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2018 10:54:26 +0100
Received: from mxback9j.mail.yandex.net (mxback9j.mail.yandex.net [IPv6:2a02:6b8:0:1619::112])
        by forward101o.mail.yandex.net (Yandex) with ESMTP id 8B6D21344688;
        Wed, 17 Jan 2018 12:54:19 +0300 (MSK)
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [2a02:6b8:0:1a2d::28])
        by mxback9j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id XumCuWoHGu-sIE4dACk;
        Wed, 17 Jan 2018 12:54:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1516182859;
        bh=wWFyBHCIWPwzTh7bbN3K2gqwFe41nGGO+ZhOPJeXXzU=;
        h=Message-ID:Subject:From:To:Cc:Date;
        b=DN60Zd1jBAgsBzK3y+XXYiyTTguY1Kw4ysO1fR8/EE7PtXiDatQ9HuQhzPukUkzUy
         UzPNzl5I3zugsfCF1P8AnDJzoc0459MJ9c+9MhjqQMWNlJF6daKJoGVzFtHCDv4LS1
         G71URte1YsAHEy8GP1r7knyiecVbt6Msl/MAoxR0=
Received: by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id eogNcVakEx-rgUOnOO4;
        Wed, 17 Jan 2018 12:54:14 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1516182857;
        bh=wWFyBHCIWPwzTh7bbN3K2gqwFe41nGGO+ZhOPJeXXzU=;
        h=Message-ID:Subject:From:To:Cc:Date;
        b=Kfvl3HcbtNI6DTH4gpMPKUH8RuLILxBsl7+3wihqE5zXBwt4C9TaRblNWfUItnlDJ
         FHL8c9CGZAd7pza1aDSjBVxzZ06t456YJtBKmNARsa3JswKEQKygABepZzVoYfcQyL
         J0c/Ba7mRGMS88z1fJjhsj/HOJ24rpZ/ldqj7138=
Authentication-Results: smtp4o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Message-ID: <1516182767.23672.1.camel@flygoat.com>
Subject: About Loongson platforms' directories
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Huacai Chen <chenhc@lemote.com>
Date:   Wed, 17 Jan 2018 17:52:47 +0800
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-wVxaFXtWQpMyfg8KjnF4"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiaxun.yang@flygoat.com
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


--=-wVxaFXtWQpMyfg8KjnF4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, MIPS maintainers

Recently Loongson has released their now SystemOnChip chip called
Loongson2K, and I'm going to submit patches for that chip soon. But I
noticed that currently,  Loongson64 code in mainline kernel is pretty
in confusion. We mixed loongson2e/2f/3a/3b together in
/arch/mips/loongson64, but they don't have many similarities. 2E/2F are
legacy products that don't support many features such as EFI or SMBIOS,
only a little code can be reused with 3 series. After discussed with
another maintainer Huacai Chen, we thought we can separate 2E/2F with 3
series and make 4 directories.

/loongson-1 (Loongson 1B/1C Micro Control Units formal loongson32)
/loongson-2ef (Loongson 2E/2F legacy CPU machines formal
loongson64/lemote-2f fuloong-2e)
/loongson-2soc (Loongson2H/2K SoCs will be submited latter)
/loongson-3 (Loongson 3A/3B CPU machines formal loongson64/loongson3)

So we can maintain code for different family chips easier. Just ask if
anybody have a better idea about that.

BTW: My recent patches have been ignored for a long time. Probably
because Ralf didn't appear for a long time. Just ask if these patches
can get a chance to be applied. And I don't know what's the proper
upstream for me, Ralf's mips-next or James's mips-next?
--=20
Jiaxun Yang
--=-wVxaFXtWQpMyfg8KjnF4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEmAN5vv6/v0d+oE75wRGUkHP8D2cFAlpfHO8ACgkQwRGUkHP8
D2cR2BAAkgj7GSMLRhXCNAu4LQ6JHst9IN4qmfDdvxCTaUmLLN3bsYNXFWwe4fMI
u4gvlVG1/pV3Ye5Oujxbss8HYUyxsaZDq8IauLduhJRVxHtynbvnJaKMkDPcYMId
Puh2D4Xs4/cJlFCSIC3ZJgTt/znpPLJgLUjVUhgS5eUrR72I/umeEjOfmgRxTIGo
LMRjPOGdiljwWlB3vGl04Vli3TQbWx+4BZmDWFcxz83o9qj7EQHx4Vyct2UyqpF6
1eqop85hgY6YlHnutL/HUfoQYmlWDy/n+F29BLqlBhfAvVS+jtL+MtyKjyaAXnpe
1GZmSYoI2Mx0P8TDpN1tFhRTgb2hqfUgYQUsnVt9fBqRF/Tnf9tAserbcn1+mJfU
KNT1SLXtcqWGj370F3MrNdnkQXc1VHeYMJnSg1qwHnSlSA735aO4L0bveKhscg1Z
MQfyf1NZJjC+w55xLL+cZReogd6CGFzqm/l2HRwb55IIr5EEpm/J3t02K8joKbqx
wN2zWumy1qJ7sKxo6pwjb8PNGJWFHC/dyViZRaXQeLjliBfsYbsgbWTMBLBgMaIG
GD05i3wAUEisNsmB1yT0ipHkPCShf+S6M2+wSKPE+XKB1iCgcHJA6klIH91aY+qY
FlOWkXBEx/4bvkSDbzx3nJW8YnvX02udlddX0z7cK0HcH8j5CHE=
=1FWG
-----END PGP SIGNATURE-----

--=-wVxaFXtWQpMyfg8KjnF4--
