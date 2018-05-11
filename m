Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 07:41:05 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:60694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991096AbeENFkzTOFHO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 07:40:55 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA8B921739;
        Fri, 11 May 2018 20:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526072059;
        bh=g59I1iNi3KiS8HoQ3FbYmocETVcu3/qSIm4+62vE5pw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NnUgkNgYZ8VaNFyEN1QxUMudIGJv0XgR65qdmoMU74P440daA5rwhhxGnoRck5114
         8pISbOv1ASfkVucBVNAucJcSvZOeKHIVLHvXzKdEqtMh8bfwOuRrq1lfW0+gQeLPfF
         tJ5XMhorcRBVYR5+tE8gXBE7fIySyMuqu/0AM8eo=
Date:   Fri, 11 May 2018 21:54:14 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mathieu Malaterre <malat@debian.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v3 5/8] MIPS: jz4740: dts: Add bindings for the
 jz4740-wdt driver
Message-ID: <20180511205413.GA18694@jamesdev>
References: <5af5c20f.1c69fb81.e968b.17c0SMTPIN_ADDED_MISSING@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <5af5c20f.1c69fb81.e968b.17c0SMTPIN_ADDED_MISSING@mx.google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63894
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


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2018 at 01:17:04PM -0300, Paul Cercueil wrote:
> Le 11 mai 2018 11:52, James Hogan <jhogan@kernel.org> a =C3=A9crit :
> > Otherwise=20
> > Acked-by: James Hogan <jhogan@kernel.org>=20
> >
> > I'm happy to apply for 4.18 with that change if you want it to go=20
> > through the MIPS tree.=20
>=20
> Yes please!

Done

Thanks
James

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvYC9AAKCRA1zuSGKxAj
8phyAQDZoZqOKloD7PM+wLPxstrAw1VWIjKL+v52Gvt1yS1XngD/TnyxIuRbRmnd
htOP4kysT09dfNSDNBH3WOqrPo2xrAY=
=3t2e
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
