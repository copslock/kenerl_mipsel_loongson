Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2017 12:53:46 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48146 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992289AbdBTLxhuGQuH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Feb 2017 12:53:37 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id BF79D41F8E7D;
        Mon, 20 Feb 2017 12:57:45 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 20 Feb 2017 12:57:45 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 20 Feb 2017 12:57:45 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 40DBCE283F7BE;
        Mon, 20 Feb 2017 11:53:29 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 20 Feb
 2017 11:53:31 +0000
Date:   Mon, 20 Feb 2017 11:53:31 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     jianchao.wang <jianchao.wan9@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS:wrong usage of l_exc_copy in octeon-memcpy.S
Message-ID: <20170220115331.GA24226@jhogan-linux.le.imgtec.org>
References: <1487562178-2901-1-git-send-email-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CxIGHgfcyU0Ip7+W"
Content-Disposition: inline
In-Reply-To: <1487562178-2901-1-git-send-email-jianchao.wan9@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--CxIGHgfcyU0Ip7+W
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 20, 2017 at 11:42:58AM +0800, jianchao.wang wrote:
> l_exc_copy() is usually to be used like this:
> 1 EXC(	LOAD	t0, UNIT(0)(src),	l_exc)
> 2 EXC(	LOAD	t1, UNIT(1)(src),	l_exc_copy)
> 3 EXC(	LOAD	t2, UNIT(2)(src),	l_exc_copy)
> 4 EXC(	LOAD	t3, UNIT(3)(src),	l_exc_copy)
> When the fault occurs on row 4, l_exc_copy will get the bad
> addr through THREAD_BUADDR(), complete the copy of row
> 1,2 and 3, and then return the len that has not been copied.
> l_exc_copy assumes the src is smaller thann the bad addr.It will
> increase src by 1 until reach the bad addr.
>=20
> octeon-memcpy.S use the l_exc_copy with wrong way which make src
> could be greater than bad addr. We will fix it in this patch.
> We add the max offset of LOAD to 15 here to fix the issue without
> adding new commands . Howerver, the side effect is that, when LOAD
> fails in few case, l_exc_copy has to copy more.

Is this trying to fix the same issue as the following patch?

https://patchwork.linux-mips.org/patch/14978/

Thanks
James

--CxIGHgfcyU0Ip7+W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYqti0AAoJEGwLaZPeOHZ6EdAQAJtpCNK4tdtcFrEOzJ7B59WV
9s+xxGGxJAYm6XwtybxX8AAFwnOmUaFX+rA8Tec+GO7q8Km4vgbiC4UMMFd4vV3O
bwn/iQgYLr9vJOhUlUybCMXezCT1vcB9bg22oDWHJkw27vz7f9/x3c1jZvOloPdb
XhKK7x5NYA9HpnLHNx3zeS6mcBEhp1nDHGXAeq23ZVK++K1on1Nic9N385DnzlHP
HIi9/zNF4LjR2dAcrBl2YyV2KAjRyEbDDqmexml1e1rwRlZNr1sEXALti29IHngZ
nB3ame+Yxmi8fQpu0Y5GQKTe1WhO9MIYd1G0KReIq7gSXp9/mRGP3OrOQ+y5g3YO
TSA1SN45u35uK+qXwsvsEC6pyke4p7Zueo8VDZ/je7aEAm+1wOBRkOUTweINTIR1
K75tFtcyNvSRaYK5fOsd+D2LZtCFnIvhuUszajNigBeNOHVrGP9SFYsdRcLz+SEG
PZXJRiwhMMDCjd+C8dkrdVGw5wU/TqyrJFoOzLxirUkaIRCX99m59nIRLOpQ091v
noIeBIZeApZWUmE5876OGLLc4I9uzb8ejQ/MuiBDOH9MAd/YkrXcGt9yuEqIFgX/
NxOaUOqHn03n7H2iyUMYc61Vrv/zyudaB8WWZJ91GXrOZ/AaaEUa693Gxz/XAlU0
E83mVvIeGYz45AayIQxL
=ys3w
-----END PGP SIGNATURE-----

--CxIGHgfcyU0Ip7+W--
