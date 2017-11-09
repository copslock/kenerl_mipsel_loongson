Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 09:07:10 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:55057 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990485AbdKIIHDDXJA5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Nov 2017 09:07:03 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx3.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 09 Nov 2017 08:06:04 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 9 Nov 2017
 00:06:03 -0800
Date:   Thu, 9 Nov 2017 08:06:02 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 1/2] MIPS: dts: remove bogus bcm96358nb4ser.dtb from
 dtb-y entry
Message-ID: <20171109080601.GS15260@jhogan-linux>
References: <1509859853-27473-1-git-send-email-yamada.masahiro@socionext.com>
 <1509859853-27473-2-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAQfK_BWQcVW-ScrpAwNAHav3MrrzV-tjn_YUjsuvd7U5A@mail.gmail.com>
 <20171106095139.GG15260@jhogan-linux>
 <CAK7LNAQ_bugEP8hHKmCif5QCz2=Pw_GpXzYz4zJeXO0HXaT_ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cYG5ZC/RuVsIq1ir"
Content-Disposition: inline
In-Reply-To: <CAK7LNAQ_bugEP8hHKmCif5QCz2=Pw_GpXzYz4zJeXO0HXaT_ag@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510214764-298554-12061-28287-1
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186747
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--cYG5ZC/RuVsIq1ir
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2017 at 08:00:49PM +0900, Masahiro Yamada wrote:
> 2017-11-06 19:41 GMT+09:00 James Hogan <jhogan@kernel.org>:
> > Hi,
> >
> > On Sun, Nov 05, 2017 at 11:11:38PM +0900, Masahiro Yamada wrote:
> >> +CC Ralf Baechle <ralf@linux-mips.org>
> >> +CC linux-mips@linux-mips.org
> >> +CC Kevin Cernekee <cernekee@gmail.com>
> >> +CC Florian Fainelli <f.fainelli@gmail.com>
> >>
> >>
> >> I missed to CC MIPS maintainers.
> >
> > Yes, please resend the patch so it lands in patchwork.linux-mips.org.
>=20
>=20
> This is a part of clean-up series of DT building.
>=20
> I want Acked-by from MIPS maintainers
> so that the whole series can go to a different tree.
> (DT or Kbuild).

Well FWIW, as acting MIPS maintainer right now:

Acked-by: James Hogan <jhogan@kernel.org>

Cheers
James

--cYG5ZC/RuVsIq1ir
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloEDGkACgkQbAtpk944
dnqtMQ/9EkU6LBbjrqwXDF9JqmxGykox4YXqoZwkvmKBG2aDeaqvh9MhpDEZSQmC
EIBwQH5Yej7SRh4XxSgTOwfKdKHKOqPj4ExPK+X5pO5hlg5A2cZAzAjsSrsTRAgM
B4J4yX3jPCS1LHbkXaEvzXZOJWMbCcpTmbkavHTGDfxDAnLh1ZecC8Otn75be3cF
rz8Nji/xXzlKws2GvQm/4UGAsqKTrcMFTRWqaQW3eDw3w09T10HyxFejx9X9dA/Z
YRXSTPNCSJ5Vt/UzJ8Chqp6/898VyUKj1mjmttudNiHSSnyrBQM4fu72NqVEbYnS
2GzG5VIr+uXkmpgfsZpjsxYTupNI9vmoEjF+wOnzuVkip9NIHirYQkr5snImjrx1
0zWn3dskm3Jh33tYDEVY2RYyt4jVvOxgHc+p/MY4TIB1wVVvZ9JCE8XskhF42g7X
1eXn92wVj+Yzcx/mp2haFiQ54LNP6ADbXbtgHvkYMiMpkfoAk7Um1Pg1TAdHC7pZ
ii1rg67UqB18YIiojXYn27HUuFpaoBhyfraGYuW++yt2rFWRzVsm7//dZclO+Vrr
emwzWSAogXkFrVuD1tlfAHRrpice0QSh+VJoqAp+N/gTTgQONU5LZ/B+cTEsSP8i
janm5/1JBMVbHlbd0WNwvrfwfGuzVJvMzrW1r3lECGSDPlkPrzU=
=wanZ
-----END PGP SIGNATURE-----

--cYG5ZC/RuVsIq1ir--
