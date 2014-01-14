Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jan 2014 13:11:36 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:45555 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826363AbaANMLdCNPgy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Jan 2014 13:11:33 +0100
Received: from p4fe254f4.dip0.t-ipconnect.de ([79.226.84.244]:42211 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.69)
        (envelope-from <wsa@the-dreams.de>)
        id 1W32qA-0003J7-Rq; Tue, 14 Jan 2014 13:11:31 +0100
Date:   Tue, 14 Jan 2014 13:11:29 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     John Crispin <john@phrozen.org>
Cc:     linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 1/7] arch/mips/lantiq/xway: don't check resource with
 devm_ioremap_resource
Message-ID: <20140114121129.GA2685@katana>
References: <1389700739-3696-1-git-send-email-wsa@the-dreams.de>
 <52D52796.3030509@phrozen.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <52D52796.3030509@phrozen.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38976
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


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Jan 14, 2014 at 01:03:34PM +0100, John Crispin wrote:
> Hi Wolfgang,

Wolfram, please...

> should we take 1/7 and 6/7 via the mips tree ?

> > Should go via subsystem tree

Yes :)

Thanks,

   Wolfram


--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS1SlxAAoJEBQN5MwUoCm2oeQQAJpP+89ZvelIwolkiWBNKYF9
wX31+u1o7i7Mv2xpSOnUXGdcVtbfhxilztRS09lOamCxxHGaiV9FbNl16WTEykln
fSYBgYaFiewe64X27hVMe8i3wM28FtN9A+wGcxb+TVd8HH0unEERWUEWRYRtYoXG
VPwXMsV7M1z2tZ0upOcvy90HGpAE1nsXmgHW5w7rezmPdMS9dA4CY34NcUZfvTPt
I00Y/DlBtE2ZtTqLqX6rBt5cj1qiQYQRX2q/OHK5pKKcwpb0VxcsbXW/iR2Rf7C5
AhtHok4yUlarlq2NFFU45yOvuC5OwMyRE2VDYmpWlF/ouhtxDFrm5RdqO6Osvm94
XTPEGcMdZB3dnobZgjBrQeYQhGUfy3j7HmaOo1E8UAisoITfaEhwhVAYvMYWDk/V
CdM5I2ylpoU0KL/OB2Fi0ixbheORr31aFTw3UgMUCrXCIrwgntIXQG/w8LvGF0GV
T/CDR0vy9jwijSRWt+bgYo5qzxDCaPmaCVWsxsFX1efSzcZmlweDqqabUDC35Of/
h37QGT9Q9Hnf+1ppULaawkiBpQvYaxE/yHQYRA5koZG3g2bvJQ0k205X2k9Z4Yw/
HYwsAt/57J7Omn27zqNt+3JZHk9InBxouI8F6uxBHo6gb6yzVU2YTc678vGc8BOX
ExMtyLMJtxPDJFfcG8Ok
=LYET
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
