Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Dec 2015 22:13:08 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40045 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007281AbbLFVNFPpyaE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Dec 2015 22:13:05 +0100
Received: from deadeye.i.decadent.org.uk ([192.168.2.112] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1a5gc6-00085y-E5; Sun, 06 Dec 2015 21:12:58 +0000
Received: from ben by deadeye with local (Exim 4.86)
        (envelope-from <ben@decadent.org.uk>)
        id 1a5gc1-0004kI-9x; Sun, 06 Dec 2015 21:12:53 +0000
Message-ID: <1449436368.2824.32.camel@decadent.org.uk>
Subject: Re: [PATCH] MIPS: Cleanup the unused __arch_local_irq_restore()
 function
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Huacai Chen <chenhc@lemote.com>, Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, stable@vger.kernel.org
Date:   Sun, 06 Dec 2015 21:12:48 +0000
In-Reply-To: <1448896958-14551-1-git-send-email-chenhc@lemote.com>
References: <1448896958-14551-1-git-send-email-chenhc@lemote.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-0eTDcClfmBHfFCVpMShm"
X-Mailer: Evolution 3.18.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.2.112
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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


--=-0eTDcClfmBHfFCVpMShm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2015-11-30 at 23:22 +0800, Huacai Chen wrote:
> In history, __arch_local_irq_restore() is only used by SMTC. However,
> SMTC support has been removed since 3.16, this patch remove the unused
> function.
>=20
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
[...]

If this is only a clean-up, then it is not suitable for stable.

If this fixes a real problem, you should explain it in the commit
message.

Ben.

--=20
Ben Hutchings
Larkinson's Law: All laws are basically false.
--=-0eTDcClfmBHfFCVpMShm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAVmSk0Oe/yOyVhhEJAQrqKhAApZAJYJSTD6uzauDAD7myqCS/+i26Wa5Z
6Tw7WfddOPCEr3GNr1kPBJoafPKsFGoXmE1zHDk4JtJr7F2K1fbhSYxO3i/54XBS
dzGYXPO2zAdgXvJ7V4IUeTEbAwpSZM8W3n2dHqP/GfAN7UVZ7Wovv+de6Hsysjj0
nMueK3kyQxcIwhucPl4GXzzY5fw7+FfUvUVL2bPOgAIarIqYiohqnn8DZPV1u6KN
ZDYvKW44owpVajULGV8PFyRalJGaYpev4HVbl/L4003giv48e9NPg/FTXPDS/7GZ
J4N4xVicJRYg3Z1so4C74Czfy9sSACYfx2IXbVu+iYagdK4ofxnfywgFtZEtdwDq
DeT9LnTuORdZCfG3xyMG6mLa8WMQiBmqVNQdV0nWULt3WqUzCRQ/Mo8qKCtjfpcI
NT541tNQVp83uMnalP65h+cglcAe2QyESFyuVdZ8XHSORoiETPcH71kgDFYpBOs/
/MKz8Br9YMFP+2+hpaxCURBvrYIS7wRotjzTSn4YzKxSRkREwkLfimLK8bFuhHSC
759hOHcnnqAHfXNgbWCLr5UCTk/nCj85HeCSq8VpEl8KGKZXVXXBYTR304KulYlP
tk59xpKxUxbRB2TD0Q1smZqo8iWtG5Yy1VjV+5y6AAboyxWuHcsFOIgY3QcsbnZM
88cNjfyNjfc=
=wlMf
-----END PGP SIGNATURE-----

--=-0eTDcClfmBHfFCVpMShm--
