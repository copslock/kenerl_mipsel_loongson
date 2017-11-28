Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 18:36:06 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:41773 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991743AbdK1RgAGH6YU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 18:36:00 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 28 Nov 2017 17:35:13 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 28 Nov
 2017 09:31:53 -0800
Date:   Tue, 28 Nov 2017 17:31:51 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 09/13] MIPS: mscc: Add initial support for Microsemi MIPS
 SoCs
Message-ID: <20171128173151.GD5027@jhogan-linux.mipstec.com>
References: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
 <20171128152643.20463-10-alexandre.belloni@free-electrons.com>
 <20171128160137.GF27409@jhogan-linux.mipstec.com>
 <20171128165359.GJ21126@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FoLtEtfbNGMjfgrs"
Content-Disposition: inline
In-Reply-To: <20171128165359.GJ21126@piout.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1511890509-321457-14187-6667-4
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187384
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
X-archive-position: 61159
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

--FoLtEtfbNGMjfgrs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2017 at 05:53:59PM +0100, Alexandre Belloni wrote:
> On 28/11/2017 at 16:01:38 +0000, James Hogan wrote:
> > On Tue, Nov 28, 2017 at 04:26:39PM +0100, Alexandre Belloni wrote:
> > > Introduce support for the MIPS based Microsemi Ocelot SoCs.
> > > As the plan is to have all SoCs supported only using device tree, the
> > > mach directory is simply called mscc.
> >=20
> > Nice. Have you considered adding this to the existing multiplatform
> > "generic" platform? See for example commit b35565bb16a5 ("MIPS: generic:
> > Add support for MIPSfpga") for the latest platform to be converted.
> >=20
>=20
> I didn't because we are currently booting using an old redboot with its
> own boot protocol and at boot, the register read by the sead3 code is
> completely random (it actually matched once).
>=20
> Do you consider that mandatory to get the platform upstream?

No, however if it is practical to do so I think it might be the best way
forward (even if generic+YAMON support is mutually exclusive of
generic+redboot, though hopefully there is some way to avoid that).

Paul on Cc, he may have thoughts on this one.

Cheers
James

--FoLtEtfbNGMjfgrs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlodnX8ACgkQbAtpk944
dnoWmxAAnEN0uM8/MqFCpBISyDS3W66qpYwgwXKTBRITY2GZYpC8naHYit3BXUR8
6SCdIKbxtouYNqXxry/IMtWX2csUBERzjinp+7o8xEpSlG0YB6rZAD+Bp5b8m5Dn
uqtJCXANEJEH9qrbryawJcsOl7K6FPapFP2Iw3sWfiKb+2p0JVxbWq15/ezv66xN
Goyd3fURLGjKFVC30601Ok+bDtmOvk8J0JyXMRfzcHiWhLGNvbvHfQ4hQJ3FYQ/k
5bfIVG9ifEqK65xt5kgjtnAuoFAqktrruELluKt9DiER2l/5DcMCK0cMH2++8VMG
f5wS9OzJW86WfAA5VdSpGLEiY/+Oz/dNDhsFur8TqCiZ5mvWhEcIuphT3vQd0Cdq
6B7bERc6bnnS51aOlF9pnoK8Lz5X8fvoLUx4vcjb3uBBjiX/NOiaqC8SS5jmgwK0
urGPQJanf8LHjrqs0dcbb2uBRCqfVKeYxH31SJxC2ZDUw+Tq+EHCgjJfYiS8x2fj
dJlTroSU+j2MpIxqKJy8yIhc0U9mQarwRcy9nYkQt/jFGnrBD5mR+FSchHpqZAQy
a4kXbKGyByb3x4JxC6Rr+JlYbw3EP9lUCKqnHWCPCu/nmDDhptPnOdXqU0f/ew+9
MykgXFNgR7EmseCnUXyVAiZYwKwvdelf3Qgx5oiQQtupZmnO6Ao=
=yb/l
-----END PGP SIGNATURE-----

--FoLtEtfbNGMjfgrs--
