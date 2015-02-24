Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 15:25:23 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:57174 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007119AbbBXOZVmUK2o (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Feb 2015 15:25:21 +0100
Received: from p4fe25204.dip0.t-ipconnect.de ([79.226.82.4]:43718 helo=katana)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1YQGQJ-0004ua-Hs; Tue, 24 Feb 2015 15:25:19 +0100
Date:   Tue, 24 Feb 2015 15:25:24 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc:     linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 02/11] i2c: add quirk checks to core
Message-ID: <20150224142524.GB18301@katana>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
 <1420824103-24169-3-git-send-email-wsa@the-dreams.de>
 <20150112120814.GE12302@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <20150112120814.GE12302@n2100.arm.linux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45924
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


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2015 at 12:08:14PM +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 09, 2015 at 06:21:32PM +0100, Wolfram Sang wrote:
> > +static int i2c_quirk_error(struct i2c_adapter *adap, struct i2c_msg *m=
sg, char *err_msg)
> > +{
> > +	dev_err(&adap->dev, "quirk: %s (addr 0x%04x, size %u)\n", err_msg, ms=
g->addr, msg->len);
> > +	return -EOPNOTSUPP;
> > +}
>=20
> So, what happens if I open an I2C adapter, find a message which causes
> i2c_quirk_error() to be called, and then spin repeatedly calling that...
> Shouldn't there be some rate limiting to this?

Can be argued. Changed to dev_err_ratelimited(). Thanks!


--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU7InUAAoJEBQN5MwUoCm2FyMP/396wTJ79mIvC6SMKh0qHIIy
lfoEi7z+j7FXG1auWe/Jg0Zl8AdNVlmXuwo6XX/BHWyuj2ZUTSU6I0VikqzbyoRQ
CX9TDFWvPIKxw72LUNSIQjWuflc1xUL57vRHjnamEuASwPp97url6/qMFSQiRZhy
4REikDaClN3m/HlSH86r+EH/UbXdLA182nOinmuzzt4wED0EMNN8pGlj/kY2Mlgr
F1EJL71+lWetbWvwGD+OQlJyGwf/spro+5d/pJ9onbg98lKRV72HBkqx3idxfZEM
t1UDwJVCl3tUwpFY26GTenUBmnGjxjRxgiSJMPBhdaW+L5GqFh1rbmfVfT41o7Yf
dE32o1O4UO9L8IkRMw/+nKJ0xfQza1Gihskq2Q0n8rkNpg9G8lH+KGqhYK+dzTlT
W5MzoLnyzv6QvP5RB7LXdUA6g4vciaeoNOynd21r4otmNLAPR00m6OkY2FZTtsqt
M40if2xDZlY56y9Shy7oXiglC/Dw4PsjmKPuy7gV7F1K99nsXM1gNzhwjnanOyBL
FDWif4e9gEBrCONre9IRMZ3351GZEtkDGPnTWHAwF8ncgILzA/nGr4gkQDBVt00w
K5Pdo1CHdZqxzXeh8/S8u4kxOVQYyx81FJ+6mnQFhbn4TtV8Q5qQL2oh3W71eehh
5BkNrvM/ikWNOgDBUAAi
=Er7l
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
