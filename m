Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 12:42:42 +0200 (CEST)
Received: from mail-wr1-x442.google.com ([IPv6:2a00:1450:4864:20::442]:38520
        "EHLO mail-wr1-x442.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992267AbeJLKmigocNQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2018 12:42:38 +0200
Received: by mail-wr1-x442.google.com with SMTP id a13-v6so12911227wrt.5;
        Fri, 12 Oct 2018 03:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jAZc40z4iCg8HXnJNjcYhwdy1UtTUGPD1xND8ey1V3g=;
        b=DCG5HTBwn7D1uSVwIXgDw5NRHO0fJeNlRMIE+bSOvwkglu3/YgTXVWpgIwLSEp9NZx
         I58j2b7Ntlffzet4jm5o0SP7/tG4eLl6WHGtAO0CyCAor4zLlnqOZrIlUi629TTMWrms
         Oo9D2qRu11n/8JIZV0SyYO6rLqPU1D2pax4pbXfVvvVJuFs8hpTYIYBRw0/x2tEYeWLG
         kC8KRpXZ9FvlCKoQsSVqkacnPOK3Nz6Y9HTejJ2PmWm3+/uTlzlnOqunuGzZrbSD9SPG
         PT/6I9fb4HppbCMD0A5MUUjuJ2Xlea2+AsPuTYudLMEGj2N0j1KLLwjNE3nQy+CySevm
         FmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jAZc40z4iCg8HXnJNjcYhwdy1UtTUGPD1xND8ey1V3g=;
        b=EGIIQqPSIlz8lwM5z6eXkDKnAiRkVv7E2VMk2UxPb+kb2S2sq/CPqfXyxqp7u3MOq4
         U2hUZV/VcweqeBsdvwF+DdxJiKJn1HqFUBKjc40aEYooX3RxWGGxng4PoDZ6ODD6cj6J
         WWt+fKU59xgrZK0vcivvm03+h5z9OIEUBjYMdoVL7lstd5AF2O5Fef/yGtO2f3PS7lZ/
         uNwoC2NHqLY844IXksL1D6E5edaTNTBgG2a4vDwuMNpZuVZzDHn6xejwyV9t0QG/2aIE
         JeUiKg6vzSUjktmzpp+y8rs19mXzyG/g7A2ca9aDuk964mXCoYtxBaIbK0Ssy49xi9T+
         IrXA==
X-Gm-Message-State: ABuFfog/PNrovQ04APuFjzbm1e6fGJMSMvzAep9le1pnrXOdSAukwtiV
        9ev+VQkMRvNVq1MzmA3bn/vwsN56
X-Google-Smtp-Source: ACcGV61bVNRDyXyl8kw/vgJ1DnmBhq/SRKWIseLYbKg30uu4g7z9+FBngoSrZOW/zmdj3mzqMBINSA==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10-v6mr5001263wrt.320.1539340953246;
        Fri, 12 Oct 2018 03:42:33 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id o17-v6sm1094742wro.2.2018.10.12.03.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 03:42:32 -0700 (PDT)
Date:   Fri, 12 Oct 2018 12:42:31 +0200
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
Subject: Re: [PATCH v7 15/24] pwm: jz4740: Remove unused devicetree
 compatible strings
Message-ID: <20181012104231.GI9162@ulmo>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-16-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0XMZdl/q8hSSmFeD"
Content-Disposition: inline
In-Reply-To: <20180821171635.22740-16-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66762
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


--0XMZdl/q8hSSmFeD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2018 at 07:16:26PM +0200, Paul Cercueil wrote:
> Right now none of the Ingenic-based boards probe this driver from
> devicetree. This driver defined three compatible strings for the exact
> same behaviour. Before these strings are used, we can remove two of
> them.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>=20
> Notes:
>      v5: New patch
>    =20
>      v6: No change
>    =20
>      v7: No change
>=20
>  drivers/pwm/pwm-jz4740.c | 2 --
>  1 file changed, 2 deletions(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--0XMZdl/q8hSSmFeD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAepcACgkQ3SOs138+
s6HYNA/+ONd+BCqmE0Z29A+IoPCHFyLIVoy/aZWszgeBoqk9D9PAKKbi2eHSBBL2
Iq0GqudniRWhko8hmM9NU0XhYgDm8sq98sTAQReqW1ctn7/Fx5FNwM9Rtxe9yKfx
EWELqIPbypO7nHU/6kC9ekdf7KI+a35Envx+/8oOdgF//KqzzVMQsuVCFlnzPCvp
tXHT+2zHxrxMnaDVSxJQsXC5lnrFeP+lAE6+XN0W/d9x+wAtL56Nh0DOO8OJIfpm
aJYZHN8hmZxTMxNUV5j3gip0uF4+m9iumnwAXAY1SZH84NPBviqGho5P/I9NqCwO
GvncripVWrqlJVAGYfh5c/2Vg6mEGTE3gqjDumEpvPh6nyqAS4U/rmiB9wr2pE7u
FlmbeqgUe8FBm9gm/uaP7iMxkeH2ChSsQ3OKtYUv+frGhte1iCbpe4RSIK4q4FGN
Wxc5rJcOzud1GGhbrPmARDE9RzjX68N7XlIZtpDsxDLakwkmh1rJLk5wHWSLkYeh
nGRXMhOm1R5jTaipnpJ6C+h14xp7+5N4ccXHa+2Uu1x8wn01L1SL2jg4JpfidAnO
9z5i5OjGgs8ZsJOR0u3zaZSKq/fdgkw+CGXxvz3sQXRvZ/HjOpdXAXvDeweO87Ax
7H9hEhbaGvSzmyBSP0Sn5KxlE+5xfOpajThQsJhWBASaWaTlKUk=
=81jk
-----END PGP SIGNATURE-----

--0XMZdl/q8hSSmFeD--
