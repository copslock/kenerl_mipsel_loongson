Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 17:04:50 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:57485 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007034AbbBXQEtcLNoY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Feb 2015 17:04:49 +0100
Received: from p4fe25204.dip0.t-ipconnect.de ([79.226.82.4]:43880 helo=katana)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1YQHyV-0007BR-U5; Tue, 24 Feb 2015 17:04:44 +0100
Date:   Tue, 24 Feb 2015 17:04:46 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Eddie Huang <eddie.huang@mediatek.com>
Cc:     linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 01/11] i2c: add quirk structure to describe adapter flaws
Message-ID: <20150224160446.GB19444@katana>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
 <1420824103-24169-2-git-send-email-wsa@the-dreams.de>
 <1421387408.9323.10.camel@mtksdaap41>
 <20150119150514.GB3820@katana>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <20150119150514.GB3820@katana>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsa@the-dreams.de
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


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2015 at 04:05:15PM +0100, Wolfram Sang wrote:
>=20
> > > +	struct i2c_adapter_quirks *quirks;
> > >  };
> > >  #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
> > > =20
> >=20
> > I suggest to add const.
> > 	const struct i2c_adapter_quirks *quirks;
> >=20
> > also, in i2c-core.c, should modify:
> > 	const struct i2c_adapter_quirks *q =3D adap->quirks;
>=20
> Thanks, I'll think about it.

And added it...


--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU7KEeAAoJEBQN5MwUoCm2jRYQAITq2tQyrAoIW8anKxRI8hOl
dpQG58/aM6kUwQVPbU3OJVTN+///VI2KPqKDg6rbTVDCePMKgyCr/kYCCfOxJbkr
xSUR9csPjPmsJn2ZeQW2VE1OoOBQeC27rOj4qpZ3qJu9Fc9vNi+8Ze64OStsLEw4
P+ZEAunCNvAhU777LBsU/MuAeKZTNvV6bKwOMR3nxfedMQt9zBMFPGYi2C78N5T/
gb/j4W+QVnoDQrvebUeWlbZeKIDgQgP/ychMHFAQ2QKLlRIuCIFFjg2jWYkRUK1I
qm4zuCji8pKs0StD3xrZpOb5MndO6EEjm8xyTbgtCmMwE81FdUwORmuauyeULjzH
ArNxETpZI2YYhtmtkiynfWPXMv/s62gAP+wLt28o7f1IIpJPMryQedYmIxHmIskq
CeBsqwlYUSIyiFoGVkWsC7AkcEoRcpDkSVdHtkVN+o2LjDxwGengcb7MdXNgt/xJ
j1eqZ7d1XQ3DzHMNvYfEwDE8gZPnzx3cIo/7aqfXSl8gx1hT+FvjSSHpZcvf1zqb
OihC3ZEQdsgreaP1qhSJriv3EAdZvhTlY2YOsKxjPONtDYpObSgoBpM1gXZCLfuf
ysRev2E8GhzoB5QFIAmJYbhRE5lJ9IXRKovz8wg+lO55tP0lJCYJPXtUIFhjgH21
nxtKytmO2wMfl25NQ2KZ
=dDPf
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
