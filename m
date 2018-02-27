Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Feb 2018 17:37:32 +0100 (CET)
Received: from [64.235.154.210] ([64.235.154.210]:48100 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990845AbeB0QhMxGFkN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Feb 2018 17:37:12 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 27 Feb 2018 16:34:28 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 27 Feb
 2018 07:57:50 -0800
Date:   Tue, 27 Feb 2018 15:57:48 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 6/8] MIPS: mscc: add ocelot PCB123 device tree
Message-ID: <20180227155747.GQ29460@jhogan-linux.mipstec.com>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
 <20180116101240.5393-7-alexandre.belloni@free-electrons.com>
 <20180214170042.GE3986@saruman>
 <20180227155444.GB15333@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w2Q1kmhlT73y7Um/"
Content-Disposition: inline
In-Reply-To: <20180227155444.GB15333@piout.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1519749255-321458-5405-2315-5
X-BESS-VER: 2018.2-r1802232356
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190478
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
X-archive-position: 62727
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

--w2Q1kmhlT73y7Um/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2018 at 04:54:44PM +0100, Alexandre Belloni wrote:
> On 14/02/2018 at 17:00:42 +0000, James Hogan wrote:
> > On Tue, Jan 16, 2018 at 11:12:38AM +0100, Alexandre Belloni wrote:
> > > Add a device tree for the Microsemi Ocelot PCB123 evaluation board.
> > >=20
> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.co=
m>
> >=20
> > Please Cc DT folk.
> >=20
>=20
> I can do but again, I don't think they care.
>=20
> > > diff --git a/arch/mips/boot/dts/mscc/ocelot_pcb123.dts b/arch/mips/bo=
ot/dts/mscc/ocelot_pcb123.dts
> > > new file mode 100644
> > > index 000000000000..42bd404471f6
> > > --- /dev/null
> > > +++ b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
> > > @@ -0,0 +1,27 @@
> > > +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > > +/* Copyright (c) 2017 Microsemi Corporation */
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include "ocelot.dtsi"
> > > +
> > > +/ {
> > > +	compatible =3D "mscc,ocelot-pcb123", "mscc,ocelot";
> >=20
> > Should mscc,ocelot-pcb123 be added to the mscc DT binding documentation
> > in the other patch?
> >=20
>=20
> On ARM at least, we don't document the board compatibles because this
> will be a huge list without much benefit as they are mostly unused.
> Still, it is nice to have in case something specific needs to be done
> for a particular board (and hopefully this never happens).
>=20
> also, I don't think any other MIPS boards are documented bu if you
> insist, I can either add it in
> Documentation/devicetree/bindings/mips/mscc.txt or create a new file to
> list all the mips board compatibles.

I don't insist. It was a genuine question :-)

Thanks
James

--w2Q1kmhlT73y7Um/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqVf/sACgkQbAtpk944
dnodeQ//Qtfu98Urha66CiGpP9aq1udAStF8Uzts59ARWqOn3NX1gIclwYkd5TCa
cTlkJMZWDO59Wix488va2l+B5WgBrcPtVn65K58a+z8xu71G8OZE2a08v0ATp+Ac
KQg4lvNs4Xn43dh6Wzggv7/VAwHPxobWm7AOpL96AAyO/A384y4SD6bSzZgxO+35
wtSius6KzMCmw8WiWvaQ4bRBw2vuKpVsuTcy+6NuTKG8ekaoA35zappQfbkLFQf7
FE0YRQmKHdajo/a5R4LSbJ28wE8EW9J+drO0iuP8o5biqLxlwy/kpMxkpJJGc6PF
G8Gy29AxwjdjekIhSpINtYk2vi6S4xwhL47HMn8OzOy20Y8MiNDDN50hgsCEB4NN
ufZcFAoPJ4qWJmW1J7Y7LnerU9Ksw5SKa+8zy9CnF03ZK4ve2zqh/SslsHkhurfK
Py37vRaFJHC6MCm7hun0JqVweQIDRud5DtQEe/+FOkLSWvm8JKORChWD8h8Xy9FT
p1L1J2f93HVT79Td8teoBL+MnwExp5lK3QjZnRoUMOlmFLqVBE73lZJ5p/yFbK5F
6M+1GlHG0B2h2rL1JdiEp2MNo01+Q6aFkmNR25wpnD/DiQ1nuUuUbl2+q7APflE+
3OnD0ip7hf5LzxCdc83zg2qGSk/loz8n6DJ3WAz6dYg3USeygk8=
=kaZY
-----END PGP SIGNATURE-----

--w2Q1kmhlT73y7Um/--
