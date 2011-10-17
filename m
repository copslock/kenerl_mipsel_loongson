Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Oct 2011 02:34:51 +0200 (CEST)
Received: from mx1.riseup.net ([204.13.164.18]:39531 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491184Ab1JRAen (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Oct 2011 02:34:43 +0200
Received: from fruiteater.riseup.net (fruiteater-pn.riseup.net [10.0.1.74])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Gandi Standard SSL CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 14B10596C7;
        Mon, 17 Oct 2011 17:34:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: proge@fruiteater.riseup.net)
        with ESMTPSA id BA8A05B7
Date:   Mon, 17 Oct 2011 18:00:15 -0500
From:   Paul Roge <proge@riseup.net>
To:     wu zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Andreas Barth <aba@not.so.argh.org>, linux-mips@linux-mips.org,
        debian-mips@lists.debian.org
Subject: Re: YeeLoong / hotkey driver
Message-ID: <20111017180015.1e5fc4fe@dragon.agroecology>
In-Reply-To: <CAD+V5Y+shM4eqVHomaHvrXKdO8WpKfpCHw=2ExP1GFuuQzSaGw@mail.gmail.com>
References: <20111012190659.GC15003@mails.so.argh.org>
        <20111013080412.GA17240@linux-mips.org>
        <CAD+V5Y+shM4eqVHomaHvrXKdO8WpKfpCHw=2ExP1GFuuQzSaGw@mail.gmail.com>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; mipsel-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/cGZhmzMQE5qKtYo/1vqe0Yq"; protocol="application/pgp-signature"
X-Virus-Scanned: clamav-milter 0.97 at mx1
X-Virus-Status: Clean
X-archive-position: 31248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: proge@riseup.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12492

--Sig_/cGZhmzMQE5qKtYo/1vqe0Yq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

> The old patch is out-of-date, perhaps we can start a new trip to
> upstream the latest version maintained at
> http://dev.lemote.com/code/linux-loongson-community.
>=20
> The latest one threaded the irq interrupt handler and fixed some bugs.
>=20
> Hope somebody else can work on it for I'm a little busy currently ;-)

Since I am new to configuring kernels, I doubt that I can help very much on=
 this.=20

The 3.0.4-libre-lemote kernel from http://linux-libre.fsfla.org/pub/linux-l=
ibre/lemote/gnewsense has everything except hotkey support for wireless. Th=
e CONFIG_RTL8187 and CONFIG_RTL8187B options are disabled in the config fil=
e. Typing "echo 1 > /sys/class/rfkill/rfkill0/state" does nothing, even whe=
n the kernel is reconfigured with those drivers enabled.

The 2.36.8-loongson-2f kernel from http://bjlx.org.cn/loongson2f/squeeze ha=
s functional hotkey and wireless networking capability. However, the date r=
esets to 1968 when restarted, thus messing up certificates, and scrolling w=
ith the keybad is disabled.=20

I would really appreciate suggestions for adding wireless/hotkey capability=
 to the 3.0.4-libre-lemote kernel, or fixing the date problem and adding th=
e keybad scrolling capability on 2.36.8-loongson-2f! Should I add the patch=
, modify options, or both?=20

Thanks!
Paul

--Sig_/cGZhmzMQE5qKtYo/1vqe0Yq
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6cs38ACgkQuBW/tw9lDuQWVgCguqMlpZWNuQkr9kBaUf4TBT4X
CNAAoLyH/Tf1pu5zES1Mt0sR/pWTPi60
=ZGWQ
-----END PGP SIGNATURE-----

--Sig_/cGZhmzMQE5qKtYo/1vqe0Yq--
