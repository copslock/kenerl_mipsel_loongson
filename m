Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2017 08:28:08 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:36538
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992380AbdARH2A12mKP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jan 2017 08:28:00 +0100
Received: by mail-wm0-x243.google.com with SMTP id r126so1866932wmr.3;
        Tue, 17 Jan 2017 23:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r8/BeODMaR4mcxxc3RNS/PjS0CtEesGW0RVi6h68D5s=;
        b=I3nTbX5ni6DlFp8F020G7nVMfwbukdO+SybWvfJglk9SRsoPzGx8pqjBfzBR5NOm1v
         0RVEhdTm1YV2pbL/jJs5y9jPrbkHaQZ/LJ/8HcnwwPXeYMkOi/wsqeVPdhLoTARea9zY
         KS6G+2fR6MzNxvUIs3VHkQIPkJ3ESXv9MSfaS+9WVBRolYZs6SdgrMwbO8cv672XobmR
         7eeRhl9l1+JvlGIHWWp2yK5kVRt78ofxi9V7x8t0QkdMgFiypCiCZPck8tLizbG3vPRZ
         JfHGj941llnY+Soym1aTQHOWzNrfRPIpaQeDH3NaTi6GcU+dHvyfWhpUoXwKN6EzAvtA
         vXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r8/BeODMaR4mcxxc3RNS/PjS0CtEesGW0RVi6h68D5s=;
        b=P/cNK+Nss0pocVs5mHIGh9BuJCAuotK7/Iuy8ODvJ1gZiSJeAvG6zIv+vC/UDP8Fnb
         zFkkp1cOMkLTSFq/MPWjectfFBXsp6nEng6CF+CsQ/+YtvewAvedq250Ka2GJNzQRYZe
         jj37uMEBbNoW+b2/Ai+Jz4AE1rk/oNdrWaWKoL1GOH7MTBHu6yxvOJuE46YVGZMs8Jt/
         ZnvPrMzJLUM7bGPTZWak1zAA22cqkYkHx2g05hq0mDIYJu/LdEBd2vthSMaxZ050hZx/
         8p/Dgl6Ij9xRdvavjuEuXKaDJN3hfZgeMsMvygKiHcRFzs2yBfr4JX3EUC+eYduSOZOu
         NdJg==
X-Gm-Message-State: AIkVDXLkT8Bp+dt/VcRt+KghOkLqHS9MCskOiMrOMLLai4ZZMjKtutZUZ025yXHoKa4z6g==
X-Received: by 10.28.27.14 with SMTP id b14mr1471890wmb.82.1484724474290;
        Tue, 17 Jan 2017 23:27:54 -0800 (PST)
Received: from localhost (port-5733.pppoe.wtnet.de. [84.46.22.123])
        by smtp.gmail.com with ESMTPSA id r6sm2768616wmd.4.2017.01.17.23.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jan 2017 23:27:52 -0800 (PST)
Date:   Wed, 18 Jan 2017 08:27:51 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        james.hogan@imgtec.com
Subject: Re: [PATCH 13/13] MIPS: jz4740: Remove custom GPIO code
Message-ID: <20170118072751.GC18989@ulmo.ba.sec>
References: <20170117231421.16310-1-paul@crapouillou.net>
 <20170117231421.16310-14-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
Content-Disposition: inline
In-Reply-To: <20170117231421.16310-14-paul@crapouillou.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@gmail.com
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


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2017 at 12:14:21AM +0100, Paul Cercueil wrote:
> All the drivers for the various hardware elements of the jz4740 SoC have
> been modified to use the pinctrl framework for their pin configuration
> needs.
> As such, this platform code is now unused and can be deleted.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/include/asm/mach-jz4740/gpio.h | 371 ----------------------
>  arch/mips/jz4740/Makefile                |   2 -
>  arch/mips/jz4740/gpio.c                  | 519 -------------------------=
------
>  3 files changed, 892 deletions(-)
>  delete mode 100644 arch/mips/jz4740/gpio.c

Have you considered how this could best be merged? It's probably easiest
to take all of this through the MIPS tree because we have an addition of
the pinctrl that would be a replacement for the GPIO code, while at the
same time a bunch of drivers rely on the JZ4740 GPIO code for successful
compilation.

That's slightly complicated by the number of drivers, so needs a lot of
coordination, but it's not the worst I've seen.

Maybe one other solution that would make the transition easier would be
to stub out the GPIO functions if the pinctrl driver is enabled, and do
the removal of the mach-jz4740/gpio.h after all drivers have been merged
through their corresponding subsystem trees. That way all drivers should
remain compilable and functional at runtime, while still having the
possibility to merge through the subsystem trees.

That said, the whole series is fairly simple, so merging everything
through the MIPS tree sounds like the easiest way to go.

Thierry

--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlh/GPcACgkQ3SOs138+
s6HJuA/8DBbCWXiobPupHIJkfkobmKLcWcDTCHrFnZvAFle+RTPeoANQQYkJ75pW
qHYVgHTL0x3n4NBLFvYl1Twl+fGLQNxEKbg87WBSj5jeAyTK3y4KA0P79OAfnkee
nSWeP8v+TluNV7gWSnFpUgFffHif24BbwtIsuLYxxn/awM2ZPQEx3CxDr5jvJD4E
2lTp4sYoRLmgHQb7Q7YH6b8JSibxXFEafzIfuSC42ySLXThDqY2TiMcQproKxfXl
/lruvG7w89INCAQOlXHG81sX0XGcbFYW0Cv1M5c0E3hk7DkbgFL3A5Q6IpnHjHdO
tOXg+DMjByeZMy9H3PP2vVnVva+fg5oMCWJHIP2Ih3d+CIBJdo6YlI/TvGH+Gh4h
4HKGiO83F+JljR5/ver0BBue9gyxCGs9sUO3B3TVAiunrS+hgfw/Wv+hcQ1IsubU
wnxXDrj54QxeP9O1T84yPD98e75O4tD1DHltfPZOI+bkxiQmvOGFYarcATKS0Edk
uJdWdEbfV/gB+1ckUpq0QEoTDdx7YEwuQCVn7dcS2hwyD4qEEc86j9Z+hkvk2+zg
cGHxOJ54wGqgIUMQM9/ohreFUPpifTWo6afe4tlos4V9BhA+1/dj29d0EmBJ2gON
TmNKjvYGHnilhT2uGMYDx6xfaXLGq8QG8o1kVlfRhCBWnGEyqzc=
=/Oal
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--
