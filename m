Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2018 15:36:01 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:34058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994722AbeCGOfyQtDmt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Mar 2018 15:35:54 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 615652172D;
        Wed,  7 Mar 2018 14:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615652172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 7 Mar 2018 14:35:41 +0000
From:   James Hogan <jhogan@kernel.org>
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        sboyd@codeaurora.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-clk@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Dominik Peklo <dom.peklo@gmail.com>
Subject: Re: [RFC 3/4] MIPS: Ingenic: Initial X1000 SoC support
Message-ID: <20180307143541.GN4197@saruman>
References: <20170927151527.25570-1-prasannatsmkumar@gmail.com>
 <20170927151527.25570-4-prasannatsmkumar@gmail.com>
 <20180306000832.GL4197@saruman>
 <CANc+2y5_R5xYQuLbW7NAjO4mcW5RNn3Da77tAhYU5zj=0rkBDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GIP5y49pbaVPin6k"
Content-Disposition: inline
In-Reply-To: <CANc+2y5_R5xYQuLbW7NAjO4mcW5RNn3Da77tAhYU5zj=0rkBDQ@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62830
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


--GIP5y49pbaVPin6k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2018 at 07:14:49PM +0530, PrasannaKumar Muralidharan wrote:
> > Does X1000 use a different PRID, or is it basically just a JZ4780 core
> > with different SoC peripherals?
>=20
> Yes X1000 does have a different PRID (PRID =3D 0x2ed1024f). X1000 has

Right, so thats 0x2e000000 | PRID_COMP_INGENIC_D1 | PRID_IMP_JZRISC |
0x4f, which cpu-probe.c already handles (apparently the D1 company code
is used for JZ4770 & JZ4775 too).

> I used to get my code tested from Domink but I could not reach him for
> quite some time. Before buying the development board myself I would
> like to see if anyone can help me in testing. Do you have any contact
> with Ingenic who can help in testing this?

Not personally, but I'll ask around. Of course if nobody much cares
about it in practice and nobody has the hardware, there may be little
value in supporting it upstream.

Cheers
James

--GIP5y49pbaVPin6k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqf+L0ACgkQbAtpk944
dnpxJg//YwmBGpZiKtWrr50Yl9djqsbIg8DK8NbUWmpkL00AEb33Km0FXtjJZJA2
ui3yc67jcMiE6BdJ8+jJoEnYlkOq8/6Uk1U6dyOUfKitnQVVKq92TMdzQe5vmNSr
kJY/F2YsknT/3Z6YGn+RlRM6NBhRiT/VnIrj1CIzK7hc/NB1/eKgP7jBwQDs77Gx
0PmX+bXifRmYYPPaSf3Ki2vx07jKqBPdcnpluvZB57XwpGSwUScTqQcBTOcFZAAL
92b2AGRvEAjoWBc3IXo5OgMPGEtkodwHgDjZVYQH0XLM4UaLuj2bI/fEQQ9z/fbV
ONAi/Cqit7RcHBspNnpJuoYbcEqn0/Xy3k2xbTJja/4VybZgK/wFb3IPEIHEqOVQ
PJTfj2UoADNnccEXSMJRyFVXjK9Na5sN5zjnnelRfObNZ4ssSO6bMry6RX/OcT8z
LnbsM1DLcpk16ZGUDSx/d2S7mQK1oc2YBfw7KY2uuAJ6ARyaw4uftk2l9RDSqI9g
/yqwKMCtmR6iYF4Wd7CVbF+QeGOykvg4KHV50E3r19AEDvHFbOS7poVW1yfWiV56
QHyx3rMoM3YcX6OoZBkm+qFA+Yyfkzn2Ut7bHUG5JutuJ+ZuUIAkyj3pq4cEeoaw
9LkVmgGulWlXSJDFaxHXSIyj61d626Hs7lfiwVzZLaz+T6+J5+o=
=zbax
-----END PGP SIGNATURE-----

--GIP5y49pbaVPin6k--
