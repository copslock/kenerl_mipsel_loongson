Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Aug 2013 03:13:53 +0200 (CEST)
Received: from haggis.pcug.org.au ([203.10.76.10]:53699 "EHLO
        members.tip.net.au" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6853519Ab3HUBNocQz0t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Aug 2013 03:13:44 +0200
Received: from canb.auug.org.au (ibmaus65.lnk.telstra.net [165.228.126.9])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by members.tip.net.au (Postfix) with ESMTPSA id 9078416413E;
        Wed, 21 Aug 2013 11:13:29 +1000 (EST)
Date:   Wed, 21 Aug 2013 11:13:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig: Remove hotplug enable hints in CONFIG_KEXEC
 help texts
Message-Id: <20130821111323.1325e3f37faf2f54f3549832@canb.auug.org.au>
In-Reply-To: <1377027483-17025-1-git-send-email-geert@linux-m68k.org>
References: <1377027483-17025-1-git-send-email-geert@linux-m68k.org>
X-Mailer: Sylpheed 3.4.0beta4 (GTK+ 2.24.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__21_Aug_2013_11_13_23_+1000_GADke1ldKgHjpl8v"
Return-Path: <sfr@canb.auug.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfr@canb.auug.org.au
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

--Signature=_Wed__21_Aug_2013_11_13_23_+1000_GADke1ldKgHjpl8v
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue, 20 Aug 2013 21:38:03 +0200 Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
>
> commit 40b313608ad4ea655addd2ec6cdd106477ae8e15 ("Finally eradicate
> CONFIG_HOTPLUG") removed remaining references to CONFIG_HOTPLUG, but miss=
ed
> a few plain English references in the CONFIG_KEXEC help texts.
>=20
> Remove them, too.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Looks good to me.  Thanks.

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Wed__21_Aug_2013_11_13_23_+1000_GADke1ldKgHjpl8v
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSFBQ4AAoJEECxmPOUX5FETsMP/3VZR2oZGvtk3dTQaWWzB2dD
EkosPsIrqso9g4eHsEBYlDjZ8v45CKoTbp6kbV05x8YWsE+76NWWs6ey8jjoi9Cn
sSUvUjJ+PuNWGEjM2lsNDIAOfEdcudUVCfTv6aImxGcgCNz4KI0sbxtbWsi9yhlY
qwQJYtIjxv9gwb3f/gmdEfiyIsTMZPeBslrvWZLhM8yqi1iIFUntRFW8faX4UWAm
VP9WC92xExfClmaA+jb9iv7bwIB0wsyLMC9v2PipkaWIl5DxAi1f9O1TqlWQUCAE
FSzsvHl2iwB0vwPRzBSeB+VbJZxVtH9VHqVu3vrZWvPmFMZH00P4l6jkxgH/yUiK
EBNVKCOUpZyOpBaZ7DYVd6IR8V32LUFysQQijbE81YM+8d/D5JAOUlMu10I8Bzsq
sWZAe0Yn+tn7uhjIjG/HImewVnxwNjKwWqB258Wo7uvb0ku9+FPstFocAkNtKp3B
R9wt/F22neliAI5JwuBsd8YE0mJG/MUJNjkJ6Whq+CDzsTZnqGAcvlMin2Tazc3J
IjCz7Yjn63Pjv9spNvtTdotrzMalNRM7SSG/u7IvR505KYB1VcxL51AYCDnyAtUl
gLOzWvSxyeq6c1XTr/vO+SKs98Sn0ONl+tlMMgaX04XkWx79qYBKOVlmpqfoiZgK
ppDQ3M3O70TzO+fk5hNp
=3DQN
-----END PGP SIGNATURE-----

--Signature=_Wed__21_Aug_2013_11_13_23_+1000_GADke1ldKgHjpl8v--
