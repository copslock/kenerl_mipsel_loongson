Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 18:18:53 +0200 (CEST)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:35523
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992974AbdDFQSmwSvvZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 18:18:42 +0200
Received: by mail-wr0-x243.google.com with SMTP id t20so12816432wra.2
        for <linux-mips@linux-mips.org>; Thu, 06 Apr 2017 09:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nLkcupWmkmL1Khx604jmvuA+Qkzdtvgt/poRMYettX4=;
        b=AIACbD01qLgR2xd7sJDR6QzuXiXtAmyoOcmTaluqLelajYJfw08Cb7AU6id5tQbC4/
         2zp8Yzrpr7FiFS2Nrn8kG6gihtkP2uelHTRbMNQSNfzHYprls8grCkevxd5Dl38bC/sl
         O/xt777V8olhwsUTJjs9vdbVXHyfIp6hbvE2lOZwunF0A3j0TKCylTzl96/ABiDErJ9J
         ADmRQ7yibjlvDoY8Mm8J5McWwLlq6C4S1kzdVpBdd/CTxytD9g+T55GCBdWKlFc37a5N
         glBnmvzvjk6zCgecbF0gCn3IBHl4oHam5h2HFIB2NNS0eMaaom2OUUwHHc+qDjWmfzkE
         OJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nLkcupWmkmL1Khx604jmvuA+Qkzdtvgt/poRMYettX4=;
        b=QocVljv+BuVq3xDloIpZ2e0bKZOTV/dYFWEu+xATXVrEoXsbUGqYwQz6GEdn9kB6Vp
         1Ivybq+/HP/xGeer1wYEBZq7/FRq+lqXt8D1YtgMA0i9aGcgH1ZwCBq2JqaoS9UKpcS/
         rMZRVrt7G935M93GKb/O+iM13tj84oZ2sJn92X6PSA+aWXgC9idv7Ih4XoWZakSj5Qd0
         JA/dYjtz/Cts0Q5laAJqTHcFY2J7zGaQuoU9beBwfJpbqlDEgpxWqeVuJAZUGkHCoujN
         +JY8Ad1KrYgOXPjsF4fSjKJ1gAafJ/EGjn4+9PLaBrqbgoKtBBKh3LrtFIb52zcfnPe2
         ngHQ==
X-Gm-Message-State: AFeK/H0L+g2htM8nAo5KLhDQhmJgRLI0RgGsvCc/iCT7BMYe6p+drnKifh7Q7rtJ18oHIw==
X-Received: by 10.223.134.86 with SMTP id 22mr32205616wrw.22.1491495517320;
        Thu, 06 Apr 2017 09:18:37 -0700 (PDT)
Received: from localhost (port-21936.pppoe.wtnet.de. [46.59.147.92])
        by smtp.gmail.com with ESMTPSA id j26sm2688223wrb.30.2017.04.06.09.18.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Apr 2017 09:18:35 -0700 (PDT)
Date:   Thu, 6 Apr 2017 18:18:35 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yang Ling <gnaygnil@gmail.com>
Cc:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2 1/2] pwm: loongson1: Add PWM driver for Loongson1 SoC
Message-ID: <20170406161835.GA19312@ulmo.ba.sec>
References: <20170215144531.GA39000@ubuntu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20170215144531.GA39000@ubuntu>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57609
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


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2017 at 10:45:31PM +0800, Yang Ling wrote:
> Add support for the PWM controller present in Loongson1 family of SoCs.
>=20
> Signed-off-by: Yang Ling <gnaygnil@gmail.com>
>=20
> ---
> V2:
>   Remove ls1x_pwm_channel.
>   Remove period_ns/duty_ns check.
>   Add return values check.
> ---
>  drivers/pwm/Kconfig         |   9 +++
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-loongson1.c | 148 ++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 158 insertions(+)
>  create mode 100644 drivers/pwm/pwm-loongson1.c

Looks like this doesn't compile because it uses register definitions
=66rom loongson1.h that aren't what the driver expects. Looks like the
driver wants parameterized ones, but those present in the kernel are
not.

Any plans on fixing that? How did you build-test this?

Thierry

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljmalgACgkQ3SOs138+
s6HB4BAAnaoA+xlMxsnPD3ufWuKEpsO6y5EQfYXFsbYG/IEW/77M64HQcEZqNYG6
JJTZhK2bstuEfAVXz1uQBGYrQ7xOXliL5jhgONTLCOYpII5UlGI0R+HW8v/vRRF4
aEdvd2C7YV2+2qxFTipDlScaxM8xFBiVYjZw8fJmrFeQrqZ1jsvkMlzzKuFmOtFc
y362HHHQrn7SkXr2VkbBnjX3JEvmCH7vyDkbc9hR3qj4VtT2AHcNbMe5/9npih1c
kLS4xCuWXMHkPzLluyJESeyoZ6g7moIr/LSWnDBVnEsei7Nox/m2sih08kvmQuW2
9lFEWTp+4yRUXUuLwEkR2nfAWgLFs6YB4hCLWbmWJqUYMR9vfTs5dGKMOiwvdPul
NeGcmM7cbYPDp3HgVnPvnkcUFsK7kC6jGqERy4IuO8nMuqSh3PoL4d9VMeAdwRXz
t/6QzUbwqPRH98lz662xstgD2Odg9+Pumq1vOMHUnNe1ifXafNC5dwwLen88jJWb
DuBE8bA4GZSsb1YSdvHf/v+BngNGW0LADZlDdSPv+7xaHnNjDkXriysC64x3ptec
7LGlgkpcqvzMgR8yD4+wiKjN1muhuHUNxC1xn9VYZRtVS92LaqrdrT3h6i8xppZ9
Uma8nbEQO9lCrvXX3jtOkaJhrsQBZSBju1db/h2619oveMRVUPA=
=/Jr6
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
