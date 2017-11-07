Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2017 19:18:12 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:41248 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992143AbdKGSSEX32Ox (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Nov 2017 19:18:04 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 07 Nov 2017 18:17:14 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 7 Nov 2017
 10:16:01 -0800
Date:   Tue, 7 Nov 2017 18:17:22 +0000
From:   James Hogan <james.hogan@mips.com>
To:     David Daney <ddaney@caviumnetworks.com>
CC:     Arnd Bergmann <arnd@arndb.de>, kernelci.org bot <bot@kernelci.org>, "Ralf
 Baechle" <ralf@linux-mips.org>, "Steven J. Hill" <steven.hill@cavium.com>,
        Kernel Build Reports Mailman List <kernel-build-reports@lists.linaro.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, David Daney
        <david.daney@cavium.com>, Linus Walleij <linus.walleij@linaro.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, Linux Kernel Mailing List
        <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>
Subject: Re: next/master build: 214 builds: 26 failed, 188 passed, 28 errors,
 6333 warnings (next-20171107)
Message-ID: <20171107181721.GO15235@jhogan-linux>
References: <5a0159b6.08bc500a.ebe4b.25c6@mx.google.com>
 <CAK8P3a3QKkGv6eSjX7wH6LpOY0-1XUPFoX0ntog5-ZSHPab6iA@mail.gmail.com>
 <2a051ef8-d383-ffd9-e79b-34a2701e44c9@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WjzcGWYIDcuHBXpJ"
Content-Disposition: inline
In-Reply-To: <2a051ef8-d383-ffd9-e79b-34a2701e44c9@caviumnetworks.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510078630-637138-27154-844057-14
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186678
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
X-archive-position: 60750
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

--WjzcGWYIDcuHBXpJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2017 at 09:52:36AM -0800, David Daney wrote:
> On 11/07/2017 04:15 AM, Arnd Bergmann wrote:
> > On Tue, Nov 7, 2017 at 7:59 AM, kernelci.org bot <bot@kernelci.org> wro=
te:
> >=20
> >> Errors summary:
> >> 20 arch/mips/include/asm/smp.h:32:29: error: 'CONFIG_MIPS_NR_CPU_NR_MA=
P' undeclared here (not in a function)
> >=20
> > I have reported this before, as did 0day, but I don't know if anyone
> > is fixing this:
> >=20
> >
>=20
> Yes, Steven sent a patch to fix this back on Oct. 2:
>=20
> https://patchwork.linux-mips.org/patch/17400/
>=20
> Ralf seems AWOL with respect to this issue.
>=20
> Perhaps the alternate MIPS maintainer James Hogan can try to get the fix=
=20
> merged.

I've asked Stephen Rothwell to switch to my tree for the timebeing, i.e.
git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git#mips-next

If so then tomorrows linux-next should hopefully be fixed.

Cheers
James

--WjzcGWYIDcuHBXpJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloB+KoACgkQbAtpk944
dnqAuw/+ODHqYtuo1e/iyDAJPyRzHxtydU0Ym8f91q4ITA2LrKRBZUmR+zAamd11
ALDb8Qr33bdOk1BCCbBznXMmZ1TlCj9QzFwjmtCax2knwzGYJzfR8+vOPCer+YzY
FfeELyaJi11syGRFhH9pXT70MRtPodR76AMjVI1ZNI1vIp58fCHPihvZmPlkRvaU
orD+3wTqtjvkyxQSSvZGbbwIWu6wuLqftwfXdH0bFPJiqmGVnDrInH9D+Q7GtAbJ
232Rzalp6ubiTY3ciGbMiEQN4desSdAeYEfwkQTe6ilUQ/Z+NpFO77Gjbn4W1N/h
BVtOJq7Yyzq3kR0f1WqWt8c9L/YY9mlp+WCpYSlqviYsJFyA+MqWQkD3/UVV8ZDj
N4UarlPpkt6f0+qYpavqfEBwfAvukaiviwcnkqh2LkZNKz/ygXHszmeqY2pJ00KW
/nHAr66yzIM48h9R0x4CdPh8ntAKbefsKYUYuoa6gX3UAfAjxXsLkQREZOXetiUa
HXkiwDNbB4Ab6mnExEYoSMa1u5W+6CQRdyIJrvo462G6aZ5es0mn/fU5ywZ5JCdc
aKnu2thZeKKMyUahVl0jC0p91voliwRsRcesegRlWmSmB8PFrQLKvrAPGwqyNk9F
ma88u9lkhGDDQypSXvWcceYXrei9sp/+FZ2D/wmo8nE2wpZN3rU=
=udLA
-----END PGP SIGNATURE-----

--WjzcGWYIDcuHBXpJ--
