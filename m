Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 07:56:23 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:33508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990398AbeENFzSUHTOO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 07:55:18 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8EF421771;
        Fri, 11 May 2018 21:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526073359;
        bh=QjsyJfjPntd7ZcThcZUk42ZTd2mbLGJjsRqQMi7Pxyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZSMCOybGqPRBh3jZ5GZEplHoHfRiaqaV0FA8i/kGUqJC178VMhiz+LroKjUrI+RTc
         mm/l/4ssyPmEoD3PMJbD1MaASwteCKx5LxtlLGIIzTYb7qfNEHmTJIflqFb62ecnI4
         7Nyoy20TF+hd0yRRPINqT0MUl/v3F4iy4oGVlRrY=
Date:   Fri, 11 May 2018 22:15:55 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mathieu Malaterre <malat@debian.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH v3 5/8] MIPS: jz4740: dts: Add bindings for the
 jz4740-wdt driver
Message-ID: <20180511211554.GA20264@jamesdev>
References: <5af5c20f.1c69fb81.e968b.17c0SMTPIN_ADDED_MISSING@mx.google.com>
 <20180511205413.GA18694@jamesdev>
 <20180511211416.GA10947@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <20180511211416.GA10947@roeck-us.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2018 at 02:14:16PM -0700, Guenter Roeck wrote:
> On Fri, May 11, 2018 at 09:54:14PM +0100, James Hogan wrote:
> > On Fri, May 11, 2018 at 01:17:04PM -0300, Paul Cercueil wrote:
> > > Le 11 mai 2018 11:52, James Hogan <jhogan@kernel.org> a =C3=A9crit :
> > > > Otherwise=20
> > > > Acked-by: James Hogan <jhogan@kernel.org>=20
> > > >
> > > > I'm happy to apply for 4.18 with that change if you want it to go=
=20
> > > > through the MIPS tree.=20
> > >=20
> > > Yes please!
> >=20
> > Done
> >=20
> Does that include the watchdog changes ? No problem with it, just asking =
to make
> sure that those don't get lost.

Yes, I suppose I was taking your reviewed-by as an ack.

Cheers
James

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvYICQAKCRA1zuSGKxAj
8gsrAP41gueNW6zeBWBxz+4YpHy4BUBiM55src6Gci1h5OsBtwEAmoXXTS+0VmRb
Mu8GJ4VYm+utxnD0e6iUWKcNxc0VhQg=
=wLpC
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
