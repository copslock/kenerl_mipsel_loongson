Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 May 2014 12:03:07 +0200 (CEST)
Received: from [217.156.133.130] ([217.156.133.130]:17096 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-FAIL-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6824847AbaESKDEGcum3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 May 2014 12:03:04 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id D3E9441F8E22;
        Mon, 19 May 2014 11:02:44 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 19 May 2014 11:02:44 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 19 May 2014 11:02:44 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6F42D7F0FEB23;
        Mon, 19 May 2014 11:02:42 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Mon, 19 May 2014 11:02:44 +0100
Received: from localhost (192.168.154.79) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 19 May
 2014 11:02:44 +0100
Date:   Mon, 19 May 2014 11:02:44 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     chenj <chenj@lemote.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/2] MIPS: lib: csum_partial: use wsbh/movn on ls3
Message-ID: <20140519100244.GL63315@pburton-linux.le.imgtec.org>
References: <1400401410-32600-1-git-send-email-chenj@lemote.com>
 <CAAhV-H6zvhUvjoQiG9-e5HHGBkbLJvN_LkbEZWEzfjJEmrmLgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tv2SIFopg1r47n4a"
Content-Disposition: inline
In-Reply-To: <CAAhV-H6zvhUvjoQiG9-e5HHGBkbLJvN_LkbEZWEzfjJEmrmLgg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.79]
X-ESG-ENCRYPT-TAG: 96d62635
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--tv2SIFopg1r47n4a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 18, 2014 at 10:39:20PM +0800, Huacai Chen wrote:
> Due to Wang Rui's tests, Loongson-3's EI/DI instructions don't have
> correct behaviors, its Status.FR is also different with MIPS64R2. So,
> I don't want to select CPU_MIPS64_R2.

Out of curiosity, how do ei & di misbehave? There are still a number of
other areas in the kernel which special case >=3D R2, so if the 3A isn't
too incompatible it may still make sense to select R2 & special case
those incompatibilities.

Thanks,
    Paul

>=20
> On Sun, May 18, 2014 at 4:23 PM, chenj <chenj@lemote.com> wrote:
> > [PATCH] MIPS: Loongson 3: Select CPU_MIPS64_R2
> >
> > To chenhc: Please review this.
> >

--tv2SIFopg1r47n4a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTedbEAAoJEIIg2fppPBxl8doP/3SFWoIldtb4gU3Jv9u7+uPh
+GqMU952fR0pGJMazlhc5XWhiAsKkBnVZAIQ0R0g5NSwTOcXSI6q+ulskC2EiRT9
ifhg0O7NbqXYdDL5E4S4zWPfxGhJtRGjaFJ+0FKJojjyUy0PyVQo/HIvwj96x4lJ
ObZOI++/xHQIP5meCNdiNGaMFpNMBHsg+JLugV1X8X2LbOs1SM3svAlAKEO08NeI
AhO/CP9BKfaFkzy/p9B/8X40exBIaIEguAc1/caYmmkiDj0hNv8CV6J8nGUORF3G
RcbI5HjQvc9VaIZuiiVQbfBj0AQGEyDhYWf8+yPu+Oub59AZoviRTtywpQet88B+
g4b7fqMzgbLDC4x7jXjdpAOaHVBLgSf6YTCzGjYp8wQ13oFnYVeWFbTfZ0F8xJ6B
H8NHfXx5j8ODEUKb9qDvu94ZcUe7KtQNO5Pwwrkalp+F/mG4ixufNoTEG8xi5cHG
5FAWXyhXzUgbhkw6RRooC+EAiIQzeegC5qOhofgbWXxqoXUFRKmC2DFVX6g7khNr
QQTomgsIrKKjQ5dLdZrSiWAi2wmEXEjLOVtijEnmvwdIMtTQeKWTBy6yjWqR3onX
dD8DQG6Pww9jpRqdbjjt1pjuSaTntJ6rEzZajTyAyyOOxnO9OnGMfcYjLKSID5UZ
t8faTcENcravNLM1tzgX
=k0cL
-----END PGP SIGNATURE-----

--tv2SIFopg1r47n4a--
