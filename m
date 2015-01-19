Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 16:05:18 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:33660 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011837AbbASPFRjrHi- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Jan 2015 16:05:17 +0100
Received: from p4fe24a52.dip0.t-ipconnect.de ([79.226.74.82]:60128 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1YDDtD-00083E-54; Mon, 19 Jan 2015 16:05:15 +0100
Date:   Mon, 19 Jan 2015 16:05:15 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Eddie Huang <eddie.huang@mediatek.com>
Cc:     linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 01/11] i2c: add quirk structure to describe adapter flaws
Message-ID: <20150119150514.GB3820@katana>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
 <1420824103-24169-2-git-send-email-wsa@the-dreams.de>
 <1421387408.9323.10.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <1421387408.9323.10.camel@mtksdaap41>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45314
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


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +	struct i2c_adapter_quirks *quirks;
> >  };
> >  #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
> > =20
>=20
> I suggest to add const.
> 	const struct i2c_adapter_quirks *quirks;
>=20
> also, in i2c-core.c, should modify:
> 	const struct i2c_adapter_quirks *q =3D adap->quirks;

Thanks, I'll think about it.


--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUvR0qAAoJEBQN5MwUoCm2kAQQAIn4NHdQ77C3iBtOkfdr7nta
VM8Ft7w+0genCuj5Gkse3W92uzfmv6l50ffQH5vDEG+20b0dOTJI05peBler8+hK
hFBE7V5lkx/ujwtuWUhn4wMcnWOXGLnIyTxm7MQCo146ORIp4Z3th5/jR0ACSe40
vTAlbm3sAkZvArbjIeLfSiQY3MNhYjYx/0wPp2u9Tyi+TxHs27bj/bS0Q8Z8xgxA
jMjhHZzFvplwoy8x76FglCx1ZPpgWajLgQQtcz/JXOwmXqlc+jTMbVcgbunEh6w3
F5WYGEM6eUVT5dKvTLdBvaxrcbhGU56tXiX1z54J8A6ZyXipji28CT/8QG0xJt8p
R1I20oHhwd+Fz9ZX0Y1KJthj+2ZkvoKiBTIVcNyJt0KnCQUU+DKslUQELsBn3dO+
vD3r7kL/DHLVFtXLSWMASyzkB6ytANOBCmt5elHoKD10ZOZx9oBbMEUXkH/6MNEK
IPJSdGevkCMsPnDiKcEISk+COYyzFHyPYIu4Gahl5SgpytIyCkWVRTCl4HBpW+e3
Gc0u08W59eDmuzzOqfmYga+EPU6Wr3YIrhtAnagtmrhGP4332L3htI/kHSt2uylE
3TP8XymlY/PcAWwWfbH+R0Wv5nBfUsCTtJgNa4KHhqdr3O0tLyKKf6MfjzSCtFN9
dOAm/x3bZqagrE8Cq8Lf
=PK3B
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
