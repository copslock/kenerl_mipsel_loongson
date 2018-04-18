Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2018 23:24:10 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:37864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994663AbeDRVYCrE5FV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Apr 2018 23:24:02 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B44F521726;
        Wed, 18 Apr 2018 21:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44F521726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 18 Apr 2018 22:23:51 +0100
From:   James Hogan <jhogan@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/2] MIPS: BCM47XX: Add support for Netgear WNR1000 V3
Message-ID: <20180418212350.GA16439@saruman>
References: <20180408205733.9026-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20180408205733.9026-1-zajec5@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63599
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


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 08, 2018 at 10:57:32PM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> This adds support for detecting this model board and registers some LEDs
> and buttons.
>=20
> There are two uncommon things regarding this device:
> 1) It can use two different "board_id" ID values.
>    Unit I have uses "U12H139T00_NETGEAR" value. This magic is also used
>    in firmware file header. There are two reports (one from an OpenWrt
>    user) of a different "U12H139T50_NETGEAR" magic though.
> 2) Power LEDs share GPIOs with buttons.
>    Amber one seems to share GPIO 2 with WPS button and green one seems
>    to share GPIO 3 with reset button. It remains unknown how to support
>    them and handle buttons at the same time. For that reason they aren't
>    added to the list of supported LEDs.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Thanks, both applied for 4.18.

Cheers
James

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrXt2YACgkQbAtpk944
dnoRLA/+If8qu/oXex/g8kfCD0SCH/8ucvXy/rSn4mpg7G9cfFxPLZrrQT6knlbJ
5nWUbj2mlKQbBUj1dJ0WVDK7dNBgs5qB6TFbjXlcRP1jD2UO8/jZ61ci84u678tT
30hek2tUMjo7YcxGd2AmE/vsgqF58ZuVxBzlwKiWe2S9/zv3YK0ajJD3SK6mBsBL
phtieM5hTeqzUXcqHcnCOamXLJBDHJYekoYxuFWq3Wnb7Bs9xubhQb1Lp0t5/Syf
o+W2pnTXs0N0T/BYYYHnpGTtDK7R3ATbzT16iBbIqN/LVZ+/hdNSzpbOwrYfNq76
QeeAD+qRfM3njl2flZLhTrTcZMIzs+TuAaeGZ9VPUUEMoicxAlbPuiE28OgZ4/v0
os8xB6NY8jWROgU0AHOgNCsDHN3yMqNK7A6ai49SUB11E8NxQPHkrw/QZeo/M69P
ZHoxk4LQnf1nRu4oxcbUe7TBhy8TXgISBqTgu6M9AF2I3rn9Mzz6OFnNRzSm1jxk
eEDtIxiaxrBoHtlnjwAIAMK4e2yqGVMwpDlN/aO2CAtMQWwo/GCQTr4aqmXn3aC/
5hvHJ4jQXdU8CDARijmXh9ZNIkPWv84n9a1Ys52xYHkvAusOy27c7BW63NpTeqHB
N/SlHRXrKWp+rePfVurb6qNo/rEJsA8L2xgAxL0xjTnlP7DStf4=
=uJyg
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
