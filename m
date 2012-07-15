Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jul 2012 23:51:51 +0200 (CEST)
Received: from smtp.gentoo.org ([140.211.166.183]:43199 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903414Ab2GOVvm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 15 Jul 2012 23:51:42 +0200
Received: from vapier.localnet (localhost [127.0.0.1])
        by smtp.gentoo.org (Postfix) with ESMTP id DF5001B4026;
        Sun, 15 Jul 2012 21:51:32 +0000 (UTC)
From:   Mike Frysinger <vapier@gentoo.org>
Organization: wh0rd.org
To:     Joe Perches <joe@perches.com>
Subject: Re: [PATCH net-next 8/8] arch: Use eth_random_addr
Date:   Sun, 15 Jul 2012 17:51:29 -0400
User-Agent: KMail/1.13.7 (Linux/3.4.4; KDE/4.6.5; x86_64; ; )
Cc:     David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-c6x-dev@linux-c6x.org, linux-mips@linux-mips.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net
References: <1341968967.13724.23.camel@joe2Laptop> <14a91278564bb5a263c561a7f1bd10ea6386d90a.1342157022.git.joe@perches.com>
In-Reply-To: <14a91278564bb5a263c561a7f1bd10ea6386d90a.1342157022.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2984557.iEo3zAiUsd";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201207151751.32715.vapier@gentoo.org>
X-archive-position: 33929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vapier@gentoo.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

--nextPart2984557.iEo3zAiUsd
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 13 July 2012 01:33:12 Joe Perches wrote:
> Convert the existing uses of random_ether_addr to
> the new eth_random_addr.
>=20
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/blackfin/mach-bf537/boards/stamp.c |    2 +-

Acked-by: Mike Frysinger <vapier@gentoo.org>
=2Dmike

--nextPart2984557.iEo3zAiUsd
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQAztkAAoJEEFjO5/oN/WBdAEP/2504DMXVeLawf3QYL83Ybgk
JdSLiVaZvOSvNibDqyWKFczikUDAKeJBBSUYdHht10Jo6By/EHzslxnK+y22yoE9
bN0Y9bI+7WpOjischyUg7iZzDEOx+sKWK0TooVv15wu68flAy8AY6PnpxKA2+//e
x28CnNgrc0DbKqTg2FnDtzgZzkOpp1zX/Zdku+oJLBxo6VEBmgVZb8D5Aydoc5fD
se81hN0yVigA85WfYDt1MaQhf6dc4rauPCEby1NGaB5EAdqy2p1wRsCLCGoIOZsV
PIEQUfAiNWICF1kkO1QBhmotPTGSWPHo5Iw+DWuud0h7JK5/KQWtYwLcBmSGYlJ3
fRqzQaI9tmqcXW6sWXT1qPA2pHVGninJ9sJKehdy6dmK7nZqE5KV3B26ntRxUqFB
tnSKUVaMPFJOlaBCEOi/eKZHEBeLHatev/qYqj7rF3dURWkhmTqDPJy59rgs+sHv
/YitzpASRvl7M0mKm2RpNtO6/fYK5AO3yr7mfnZ4psXpKutEiMPkEZ13m4Fbp4mW
tbh65jfkrOHuY02IvTXwqb9Cpl4dzYYEBCBCgD6p6mmXGcT0moBgCiDHF5vKbJMc
+8eKfqsXOz+P3jf1cGGkoSgVZtWKkfm7TX4gfB3+xBXhVQe8k+ljAcNbGuC5M5Mj
VoGCFnUMFIONUUj71+wZ
=85OH
-----END PGP SIGNATURE-----

--nextPart2984557.iEo3zAiUsd--
