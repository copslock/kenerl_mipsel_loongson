Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 12:41:06 +0200 (CEST)
Received: from mail-wm1-x343.google.com ([IPv6:2a00:1450:4864:20::343]:38943
        "EHLO mail-wm1-x343.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992066AbeJLKlAdHjtQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2018 12:41:00 +0200
Received: by mail-wm1-x343.google.com with SMTP id y144-v6so12386213wmd.4;
        Fri, 12 Oct 2018 03:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wk+vNsLznpsQ2NbdI/5nVh3LcdRCwmJqVyrDgud0B9Q=;
        b=JVbPw3bAJh5hbOsWFNP0Ta/pfVsJuDaDQzvo4K9L8M7AUagC6TvYJ6cKVL4clxtp+a
         coOyullKRk1qoMbPqBd7rptTgRiOO9khNO39R73nGE+uJ9K99zjWqvs+BL7Wqkla8b/T
         XEMEU/rbsSTPkXIGI/qenefG+LRuOD9mXYsfEm0UjmiXGlBLTk9E2WC/hdIv0xDzZtOX
         GQuC7ZaRp9FhsqYVKxGlZTuYTb1rHRe0WooaBpBXVP59JpwR1vsV9l8y+tSbl7hryQOW
         0PgpRi93PDqjKlRok9Docoa6flHI7usUBqDMaE6Ah+RMOVvXyO322wPkZ3qmyc1zMoLV
         EQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wk+vNsLznpsQ2NbdI/5nVh3LcdRCwmJqVyrDgud0B9Q=;
        b=rWrpowHLzcDftKq9cuDZOnFT1c2h9qB1ETr/iNq92nTRjPayTgsaR3C5XoFGiv0Gwh
         MbZRlAX5vNV7OcLaZ04Nkg5p/DoZX3iOrnX3g+tSFuLTUs0P9x9rWMANWk2OCVtY7VaB
         1IQjbaxD45eeW/khj5EC8WcDzTPMRfiEDcjmdJorZyBkuk6qcwgtUHRTRNpnE1uh5wtQ
         dub/r0Nh3VzF4pu4ma62K5DRnQk4AeENgNnEvogvW1+ied6mQaqivv9vKhxhyuAq07fh
         iGmO49jc3Bpnwuq8UzE6XMUWJGFvM0PjXNlTSxKIBfjzaZs/Trn4J1UmV5MRrPVjFywf
         7bFQ==
X-Gm-Message-State: ABuFfoj/duHRkbVhIsBJQYP3SWD73wq/hG2aiumfhnTy1oCVVIgnlhnD
        LuiPRVckFAbAnkhmnRs5hX0=
X-Google-Smtp-Source: ACcGV62bp0wi0QYrsD9rhsK2/0pyaXXXT56A5UVO1KWQRvsnMhEbgK/JnzX4P273tjeDCXE1xGkwRw==
X-Received: by 2002:a1c:cc0f:: with SMTP id h15-v6mr4786928wmb.1.1539340855134;
        Fri, 12 Oct 2018 03:40:55 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id m12sm886473wrx.75.2018.10.12.03.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 03:40:54 -0700 (PDT)
Date:   Fri, 12 Oct 2018 12:40:53 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>, od@zcrc.me,
        Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v7 13/24] pwm: jz4740: Allow selection of PWM channels 0
 and 1
Message-ID: <20181012104053.GG9162@ulmo>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-14-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HB4mHL4PVvkpZAgW"
Content-Disposition: inline
In-Reply-To: <20180821171635.22740-14-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66760
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


--HB4mHL4PVvkpZAgW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2018 at 07:16:24PM +0200, Paul Cercueil wrote:
> The TCU channels 0 and 1 were previously reserved for system tasks, and
> thus unavailable for PWM.
>=20
> This commit uses the newly introduced API functions of the ingenic-timer
> driver to request/release the TCU channels that should be used as PWM.
> This allows all the TCU channels to be used as PWM.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>=20
> Notes:
>      v6: New patch
>    =20
>      v7: No change
>=20
>  drivers/pwm/pwm-jz4740.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--HB4mHL4PVvkpZAgW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAejUACgkQ3SOs138+
s6FhYw/9FW8lZprZj6ntLye6m/IyGDHZalykPoLYefvS8bTuDn3qwMPId77gLA8m
t8XjWmPCnwAJlXJO6v4L9Ttix2VAGpApZ5fyIAK9pv9Q5XhwCVYVbgyrPOnz1at7
EsBxEwRNKMR79BkCA9JbT4eQy5tC/bpFadpItJxgRLyJAtTJX0kWa5piOvn3typ2
zPm3osA5C1Og8EIS8kk1SxlRP9+gOcollqUqkFDMsG+h82RAzWZqCMOU+c3kmyvr
v5EelQuSbw+H4Y6ZOZj6tEeIiyzUnedD07NbjRdkK33JUnE8xt33anbe5X/6P6e0
AhUlG4y8kqN0mxhkWgpgIrJh/VOEsjTj18gMCU4LFNBDzj1MLon0wukTaZ7mq4yg
lKMbQq0l+Il5Ii7JBKzz9LrbUzard4dVGDYQD2ChSQmLUTS5Yh0lAMzlYiIui+ja
/Hv5+KuxJnii1KcKenvxOgOlOyJMk6AmTfD57Wk/wM2wm3IotiV1TFhAUG8we//3
KAGPr83Uvpcx2oDhvcPplPK05TolV9W6b2QoxRaQfAcr4pEoSI3Fq7I4Mo1FvOT1
0k/zXI6YUADZY55+6B8b6oqMk+OM+lZxipHgtIQo3LmtI8JysGBzkpT+MTyQZSvI
/+neLH2EXccv9Ut5s5yYQw/uSq36oAO34Tu3zk+GsPx8XZB+Zqk=
=1+ye
-----END PGP SIGNATURE-----

--HB4mHL4PVvkpZAgW--
