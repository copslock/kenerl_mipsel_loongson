Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2014 01:40:42 +0200 (CEST)
Received: from ozlabs.org ([103.22.144.67]:33850 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817913AbaE2XkhhCtxZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 May 2014 01:40:37 +0200
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 3B541140094;
        Fri, 30 May 2014 09:40:31 +1000 (EST)
Date:   Fri, 30 May 2014 09:40:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     abdoulaye berthe <berthe.ab@gmail.com>
Cc:     David Daney <ddaney.cavm@gmail.com>, devel@driverdev.osuosl.org,
        Alexandre Courbot <gnurou@gmail.com>,
        patches@opensource.wolfsonmicro.com, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-sh@vger.kernel.org, linux-wireless@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        spear-devel@list.st.com, linux-samsungsoc@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        linux-leds@vger.kernel.org, m@bues.ch, linux-input@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] gpio: removes all usage of gpiochip_remove retval
Message-ID: <20140530094025.3b78301e@canb.auug.org.au>
In-Reply-To: <CABprBybQ-Jyk95zCqnoWjjyzhNyHVbsbEhb=vA5d=ZYp95_bFA@mail.gmail.com>
References: <1401400492-26175-1-git-send-email-berthe.ab@gmail.com>
        <5387B149.20408@gmail.com>
        <CABprBybQ-Jyk95zCqnoWjjyzhNyHVbsbEhb=vA5d=ZYp95_bFA@mail.gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; i486-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/852XE2D+8ii.R+aAPw7pJ16"; protocol="application/pgp-signature"
Return-Path: <sfr@canb.auug.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40373
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

--Sig_/852XE2D+8ii.R+aAPw7pJ16
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi abdoulaye,

On Fri, 30 May 2014 01:16:22 +0200 abdoulaye berthe <berthe.ab@gmail.com> w=
rote:
>
> The aim of this patch is to make gpiochip_remove() behavior consistent,
> especially when issuing a remove request while the chipio chip is
> still requested. A patch has been submitted to change the return value of
> gpiochip_remove() from int to void. This one updates users of the return
> value:

Then you need to keep these two patch in a series with this one first
to make sure that the other patch is not applied without this one.

And you should add the above explanation to the changelog for this
patch.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/852XE2D+8ii.R+aAPw7pJ16
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTh8VuAAoJEMDTa8Ir7ZwV8iEQAICWaN/UMPsdzewqsMiXXSMh
C5svkPpUj+qDUSm6Z89xsBlSrNn5iaa06uiZllN8KLoLbhGpZ5xdGqmMalys33zc
Bh2lJNCtozIbI1fMW63+W94wMtWNSnUAbX4szSpxbbaZQ3ig9ixXegji8nvONTqw
QWNjGORnMPvzrCsTrv8/hNYlmeT/9WZwAwVLr9++ldM0fow/SfF251WvmNjheAcq
2YCd1vEk7ZZ9aFDr463CKP3eeTKDtWaSrdoXLdIvs627tRtfhSuqQF1q6d8B1Vbk
HR9xx3bANosgA/Fa7rHcWxw8lLr5EDXeaHJieT0I05kXPM1rSIh9tTGAeXivG/LH
j+FWHe7P3v2qN+mvgqRHIndi1axUhm4ZbqG3Wcg8uAV+rGxemlmkZMWzdMPwzcRA
YJKTVoc+LbLp4Yb1HpZ4hYbKvxu7iEf8OQJsb9bY3lnm8Rnax4VhQtn15aKn2fLr
b8xSfM9iGeL1bgEyh5pK4BVgE1+N7Z/7qGfD95EAT9v5cX7di9y+eU8zXb0fmXRh
V1rV2n9RfrbH3wE8DoR4yC2SeDcQl5F/CwII/zHkymzWTgGvpN4mhk06q0CPhxxO
nZD317b7OuLQbDbZJ+o/92/XMlOt6Sanno1I27C19ahUMynJAo32O+xHIDdv5AKI
Dom8qI4Ex3DKkwqflJzw
=RG4V
-----END PGP SIGNATURE-----

--Sig_/852XE2D+8ii.R+aAPw7pJ16--
