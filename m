Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Feb 2013 16:45:43 +0100 (CET)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50537 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818018Ab3BZPpjMDQRx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Feb 2013 16:45:39 +0100
Received: from gallifrey.ext.pengutronix.de ([2001:6f8:1178:4:5054:ff:fe8d:eefb] helo=bjornoya.do.blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.72)
        (envelope-from <mkl@pengutronix.de>)
        id 1UAMii-000707-Qy; Tue, 26 Feb 2013 16:45:32 +0100
Received: from [IPv6:2001:6f8:105b:1122:21d:e0ff:fe39:f61b] (hardanger.wlan.blackshift.org [IPv6:2001:6f8:105b:1122:21d:e0ff:fe39:f61b])
        (using TLSv1 with cipher ECDHE-ECDSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: frogger)
        by bjornoya.do.blackshift.org (Postfix) with ESMTPSA id BCD3B5EA03;
        Tue, 26 Feb 2013 16:45:27 +0100 (CET)
Message-ID: <512CD893.50904@pengutronix.de>
Date:   Tue, 26 Feb 2013 16:45:23 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Organization: Pengutronix e.K.
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
MIME-Version: 1.0
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Svetoslav Neykov <svetoslav@neykov.name>,
        'Ralf Baechle' <ralf@linux-mips.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Gabor Juhos' <juhosg@openwrt.org>,
        'John Crispin' <blogic@openwrt.org>,
        'Alan Stern' <stern@rowland.harvard.edu>,
        "'Luis R. Rodriguez'" <mcgrof@qca.qualcomm.com>,
        linux-mips@linux-mips.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/5] Chipidea driver support for the AR933x platform
References: <1360791538-6332-1-git-send-email-svetoslav@neykov.name> <87k3pvxkn8.fsf@ashishki-desk.ger.corp.intel.com> <078801ce142f$0108dea0$031a9be0$@neykov.name> <878v6bxhbd.fsf@ashishki-desk.ger.corp.intel.com>
In-Reply-To: <878v6bxhbd.fsf@ashishki-desk.ger.corp.intel.com>
X-Enigmail-Version: 1.5
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2WVSVJIHALOVQLUUILEHP"
X-SA-Exim-Connect-IP: 2001:6f8:1178:4:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
X-archive-position: 35826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mkl@pengutronix.de
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
Return-Path: <linux-mips-bounce@linux-mips.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2WVSVJIHALOVQLUUILEHP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/26/2013 03:47 PM, Alexander Shishkin wrote:
> Svetoslav Neykov <svetoslav@neykov.name> writes:
>=20
>> Hi Alex,
>> I am working on the incorporating all received comments - thanks to al=
l for
>> taking their time to comment.
>> Apologies for not replying to the received mails, didn't want to spam =
with
>> OK replies to each separately.
>=20
> Great, thanks!
> Looks like this patchset will need some synchronization with Sacha's
> dr_mode/phy_mode patchset, but I presume you're aware of that.

The current version of Sascha's patches is here:

http://git.pengutronix.de/?p=3Dmgr/linux.git;a=3Dshortlog;h=3Drefs/heads/=
chipidea-for-v3.10

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2WVSVJIHALOVQLUUILEHP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlEs2JYACgkQjTAFq1RaXHN2SwCdE8hBKqI+SZFviAk8J0e3QYrs
5IIAnAyW/+nkXufj/0xm3nITM5btme7L
=tOL2
-----END PGP SIGNATURE-----

------enig2WVSVJIHALOVQLUUILEHP--
