Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 17:09:34 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:39292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992404AbeC1PJ1BJoZx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Mar 2018 17:09:27 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8CC12172B;
        Wed, 28 Mar 2018 15:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8CC12172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 28 Mar 2018 16:09:15 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Dan Haab <riproute@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Dan Haab <dan.haab@luxul.com>
Subject: Re: [PATCH V2] MIPS: BCM47XX: Add Luxul XAP1500/XWR1750 WiFi LEDs
Message-ID: <20180328150914.GA1991@saruman>
References: <1519767173-8918-1-git-send-email-riproute@gmail.com>
 <1522171474-3651-1-git-send-email-riproute@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <1522171474-3651-1-git-send-email-riproute@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 27, 2018 at 11:24:34AM -0600, Dan Haab wrote:
> From: Dan Haab <dan.haab@luxul.com>
>=20
> Some Luxul devices use PCIe connected GPIO LEDs that are not available
> until the PCI subsytem and its drivers load. Using the same array for
> these LEDs would block registering any LEDs until all GPIOs become
> available. This may be undesired behavior as some LEDs should be
> available as early as possible (e.g. system status LED). This patch will
> allow registering available LEDs while deffering these PCIe GPIO
> connected 'extra' LEDs until they become available.
>=20
> Signed-off-by: Dan Haab <dan.haab@luxul.com>

Applied for 4.17.

Thanks
James

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlq7sBoACgkQbAtpk944
dnprhw//QfSDKJjP8Gx2QQLcP37NqwHUXgE8KkQzfsONawTiRJCkFPUSdM5AGI6x
4oVwOsIUI1U41pwyXIpDA1rN9++dgkwKLpSFm9+frk+wSVUkwvraXKcXigIcS4I5
lGXSZcEfwRkKahqAgbE+wVL7RA8lJ/GVLyajWyuKO+J+yAaQ38oHHRJfjj9XuLQ5
GM+JWJvFHCqOOEDXHqcxd6BYhVJcIGBHCJlYQWSuVS++pCw5fR5Xz/MPY5jb29Pk
4wmJ4S5bfBfI8bTogsz6XAcPLLZdG5df917xzjLcXzMSshMzF8W6IwzecH6dTOyg
xFZ68Vehyu/uBptE66DDglVvO2vPsIoyAshSPK4MgqdCUnKFuiM3kzu5o6x/7iGm
L0HHdzfMNWM+Gb8pHzTk5QBo8Wn3UwHX9/zQr9qB6/1qBzJXcQQVlIoW7IAs9cQP
hTHc8xgLmkQxRbrFH6C7J4rxae1ZbIlDEXMY/PinWTcIFl46Sfdy7ObUSf+qAmbh
K0jaQPGzTgCyxnyhra0UTLIxwjQLdrjjbCgj1Z0bZDxy8MIDNhlmdYg06bsXl11S
LOgabbpsLrsQTvdBqMzPdY8Q0apoUeWDLmKxj0124UsYE5/PLQGFL1TxpizaTE6g
lysqW7PcMNwj79nE/Lqd7jb+isAK1GmihBXFfwCaWX7KJpv7plE=
=J7z7
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
