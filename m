Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Sep 2012 09:42:03 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.17.10]:61839 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903341Ab2IVHl6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 22 Sep 2012 09:41:58 +0200
Received: from mailbox.adnet.avionic-design.de (mailbox.avionic-design.de [109.75.18.3])
        by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
        id 0Mg2HB-1SruCf3v6L-00NOet; Sat, 22 Sep 2012 09:41:49 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id 51B4D2A282EB;
        Sat, 22 Sep 2012 09:41:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at avionic-design.de
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
        by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id q5hKc3KW-Nux; Sat, 22 Sep 2012 09:41:46 +0200 (CEST)
Received: from localhost (avionic-0098.adnet.avionic-design.de [172.20.31.233])
        (Authenticated sender: thierry.reding)
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTPA id 51D272A2819B;
        Sat, 22 Sep 2012 09:41:46 +0200 (CEST)
Date:   Sat, 22 Sep 2012 09:41:45 +0200
From:   Thierry Reding <thierry.reding@avionic-design.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: Re: [PATCH v2 0/3] MIPS: JZ4740: Move PWM driver to PWM framework
Message-ID: <20120922074144.GC2538@avionic-0098.mockup.avionic-design.de>
References: <1347278719-15276-1-git-send-email-thierry.reding@avionic-design.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
In-Reply-To: <1347278719-15276-1-git-send-email-thierry.reding@avionic-design.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:HKIQIIVHcPi0JX5bfrEeMQ+21+7wk9Pn68zVzqA42LU
 +9T+tYBrj3lZi/Wdw5v8OTh1L+6XGVTySSWoHVpDB40sZYR3hz
 f2TCYCZ+UDNIbFNLSMOOblrPBxdeySH3QfGkZ8hySlll97mWiX
 /LYLz1cQoyAQHPP/V2zZfhG1dQNZ62Tos/KENkcT04I42ALzTx
 td1RCeOB7RCEGb965CO72honskelPzj2ns/bfKvz1N5W4l8hfU
 sUJSkkoZynSSqlELo8GWFCwAWlmtS9oDcSJA7D7eokIfm7rChp
 jSH4WrJyneTxeyKDdOMPfjYD0SNnTdMEK8oKRxtpUkymkGqnE+
 sWBJJRjYzM1lZ1EYZ8oaGepmZ4odrrhtFOtbYhcurqG48ZdVQb
 MjEUydxmBV3AJ0lBtb9xqTf7EmGrmBivq0=
X-archive-position: 34535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@avionic-design.de
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
X-Status: A


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 10, 2012 at 02:05:16PM +0200, Thierry Reding wrote:
> Hi,
>=20
> This small series fixes a build error due to a circular header
> dependency, exports the timer API so it can be used outside of
> the arch/mips/jz4740 tree and finally moves and converts the
> JZ4740 PWM driver to the PWM framework.
>=20
> Note that I don't have any hardware to test this on, so I had to
> rely on compile tests only. Patches 1 and 2 should probably go
> through the MIPS tree, while I can take patch 3 through the PWM
> tree. It touches a couple of files in arch/mips but the changes
> are unlikely to cause conflicts.
>=20
> Thierry
>=20
> Thierry Reding (3):
>   MIPS: JZ4740: Break circular header dependency
>   MIPS: JZ4740: Export timer API
>   pwm: Add Ingenic JZ4740 support
>=20
>  arch/mips/include/asm/mach-jz4740/irq.h      |   5 +
>  arch/mips/include/asm/mach-jz4740/platform.h |   1 +
>  arch/mips/include/asm/mach-jz4740/timer.h    | 113 ++++++++++++++
>  arch/mips/jz4740/Kconfig                     |   3 -
>  arch/mips/jz4740/Makefile                    |   2 +-
>  arch/mips/jz4740/board-qi_lb60.c             |   1 +
>  arch/mips/jz4740/irq.h                       |  23 ---
>  arch/mips/jz4740/platform.c                  |   6 +
>  arch/mips/jz4740/pwm.c                       | 177 ---------------------
>  arch/mips/jz4740/time.c                      |   2 +-
>  arch/mips/jz4740/timer.c                     |   4 +-
>  arch/mips/jz4740/timer.h                     | 136 -----------------
>  drivers/pwm/Kconfig                          |  12 +-
>  drivers/pwm/Makefile                         |   1 +
>  drivers/pwm/pwm-jz4740.c                     | 221 +++++++++++++++++++++=
++++++
>  15 files changed, 363 insertions(+), 344 deletions(-)
>  delete mode 100644 arch/mips/jz4740/irq.h
>  delete mode 100644 arch/mips/jz4740/pwm.c
>  delete mode 100644 arch/mips/jz4740/timer.h
>  create mode 100644 drivers/pwm/pwm-jz4740.c

Hi Ralf,

Have you had a chance to look at this? It is the last remaining PWM
driver that isn't moved to the PWM framework yet. All the others are
either in linux-next already and queued for 3.7 or have recently got
Acked-by the respective maintainers (Unicore32). Patches 2 and 3 were
already acked and tested by Lars-Peter who did the initial porting.
Patch 1 can probably be dropped since I seem to be the only one running
into that issue.

I really want to take this in for 3.7 so I can use the 3.7 cycle to
transition from the legacy API to the new API and possibly even get rid
of the legacy parts altogether. However I don't want to do this without
the Acked-by from the MIPS maintainer.

Thierry

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQXWu4AAoJEN0jrNd/PrOhLDIP/iv28ONKXxxVsKa4449otNeV
u28SXWhBbmqtIonkcLCiuiWV2/WbmQeZ6QvvhKKmXDIVdLtNGnBQXnoLJyjokIjf
1Bq4mkFsJ021ltuHqfd8qyt80UMu2kYaxwXxPN+/H40vqeIb9UfQaE7XtV7y9/ho
C7Jy4erKpLMpS5oWBZ151q8GpojczA0MC+OsTg0KlrphF3cSZOBeHouQwZ9anaOt
aHttqo8zFQq5brXwVLdhhPOlJY3AOb3vEG3P9TUfXY/6uDQVnPKDs0Wpg/UDwS1X
z/4U35MOQijMi22C0ajXs50jgfHqwV16Br/JQW+MckBxyeAxaOu1VHfZ+2bjzAYJ
AJTdbWDmSzwSnamwUpf8UgR9v8IXDEuk8WcRsrNRAosy2F2EKO6JRhVtRqdS2nUo
X1d4vSuxCPyyQQpDIN8tQK4rKsTsFwED6/RDFJHY2FCrpjtPvbGXYMxsL5Urwee+
/KKVIo4cBAHm/zrWra7Dhg06x45JuEquPOjbS+H+bpLdyeGtw+SL7t4UCWFNZ5fK
Z5H37MtO8Rk38kcZls+ltbEsVpVZxV7cr7YS6Uw/8aDLpHx1M9DiFowaVspWU2vb
hKk0dSL6zKqLAXFAb4ykPLOprEbUthjen2/5NrAu0hQyE+/xTEtQKW0a7ACR6vvW
4LPRc7GPkewsiujUXJtp
=PsHc
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
