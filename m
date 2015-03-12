Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Mar 2015 15:55:58 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:44371 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006906AbbCLOz5QtJld (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Mar 2015 15:55:57 +0100
Received: from p4fe24c69.dip0.t-ipconnect.de ([79.226.76.105]:57858 helo=katana)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1YW4Wa-0001mO-Mm; Thu, 12 Mar 2015 15:55:49 +0100
Date:   Thu, 12 Mar 2015 15:56:07 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Ray Jui <rjui@broadcom.com>
Cc:     linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 12/12] i2c: bcm-iproc: make use of the new
 infrastructure for quirks
Message-ID: <20150312145607.GC9572@katana>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
 <1424880126-15047-13-git-send-email-wsa@the-dreams.de>
 <54EFAD2A.9060501@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline
In-Reply-To: <54EFAD2A.9060501@broadcom.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46350
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


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Change on the iproc i2c driver looks good to me. Sanity tested the
> change from Wolfram's i2c/quirks branch on Cygnus 958300K combo board.
> Sanity tested with an attempt to transfer large amount of I2C data to
> ensure the transfer is denied by the i2c-core:
>=20
> / # cat /dev/i2c-0
> [  657.310261] i2c i2c-0: quirk: msg too long (addr 0x0000, size 4096, re=
ad)
>=20
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Tested-by: Ray Jui <rjui@broadcom.com>

Thanks for testing, and especially describing your test! Much
appreciated.


--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVAakHAAoJEBQN5MwUoCm2fhkP/RegkbE8DFbXjl3zsQrI3uCi
znNLVQG8LUjRJlC8YsLgcQsC7ph6BQjCTYtkLQGpz6zxn0SGR3T4lJmzakfbFCuy
NMt4yuUdpktXE3ARA7k0u2DG8J0LTzeYo0MIBaWlwtitswmEhGuTkfkXif2iGOBq
ddquZ3SRzWPFo4m7/9FgCYMwR4EPi8NKUor4QZ4R866oug2uWX/IOr/gPtsrIwM5
BbFoysprOtmwFNfaCEBCNvKKWGG8HJFHOzITj+s6BpG9Z0xxyilKoTBtCkef/jA2
qj0fhLVP3DvjjLLPcb2oZuF0NNvpP6KEeGwWEtXYiqwkUVXaSXfIn6OkuikGj8eB
sW/DEyjvyo6U2VZvXX5SdW/HDk7m52mmhvOMNMJ+ZDxfMxIVr/lmIS8YMcQDMXPa
I85vlFW4/1hbwIttfG71b9AEdgCVOzWH3GrgsFjP3dGhi1y3H+r8pCwsI8Q6lOTi
mgWWm6vZ6Oup9xEp0D8YJZIlCqRUAeF4vJ0EbqKZ4/58wUH+kYy/svAViHdYJ5hr
frDuQVqRFN0eIxQ/QIP8qTWUqrjVx6wObvFw4I/jrg6aWwfZ6wrPWAhO5xbY4QRl
CDQs7/236BZ4GpSRbvwosdwP2le6xxuRs7CtWnxshV3cHTVakYBiDRwTswybHfZl
YSE/CSiPwPrn28XdxMfY
=qVbz
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--
