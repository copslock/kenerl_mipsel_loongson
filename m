Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 May 2013 16:29:58 +0200 (CEST)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48915 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817128Ab3EOO34oif0m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 May 2013 16:29:56 +0200
Received: from gallifrey.ext.pengutronix.de ([2001:6f8:1178:4:5054:ff:fe8d:eefb] helo=bjornoya.do.blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.72)
        (envelope-from <mkl@pengutronix.de>)
        id 1UcciE-0001KH-Ts; Wed, 15 May 2013 16:29:50 +0200
Received: from [IPv6:2001:6f8:105b:1122:21d:e0ff:fe39:f61b] (hardanger.wlan.blackshift.org [IPv6:2001:6f8:105b:1122:21d:e0ff:fe39:f61b])
        (using TLSv1 with cipher ECDHE-ECDSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: frogger)
        by bjornoya.do.blackshift.org (Postfix) with ESMTPSA id 35AA85E9AA;
        Wed, 15 May 2013 16:29:47 +0200 (CEST)
Message-ID: <51939BDA.2080601@pengutronix.de>
Date:   Wed, 15 May 2013 16:29:46 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Svetoslav Neykov <svetoslav@neykov.name>
CC:     'Alexander Shishkin' <alexander.shishkin@linux.intel.com>,
        'Ralf Baechle' <ralf@linux-mips.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Gabor Juhos' <juhosg@openwrt.org>,
        'John Crispin' <blogic@openwrt.org>,
        'Alan Stern' <stern@rowland.harvard.edu>,
        "'Luis R. Rodriguez'" <mcgrof@qca.qualcomm.com>,
        linux-mips@linux-mips.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/2] usb: chipidea: big-endian support
References: <1362176257-2328-1-git-send-email-svetoslav@neykov.name> <1362176257-2328-2-git-send-email-svetoslav@neykov.name> <878v57kh4v.fsf@ashishki-desk.ger.corp.intel.com> <5154508B.6050509@pengutronix.de> <013d01ce4cfb$5830ab90$089202b0$@neykov.name>
In-Reply-To: <013d01ce4cfb$5830ab90$089202b0$@neykov.name>
X-Enigmail-Version: 1.5.1
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2FGNDSKJDAHUGURRPPQKE"
X-SA-Exim-Connect-IP: 2001:6f8:1178:4:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
Return-Path: <mkl@pengutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36405
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2FGNDSKJDAHUGURRPPQKE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/09/2013 11:22 PM, Svetoslav Neykov wrote:
> Hi Marc,
>=20
> Marc Kleine-Budde [mailto:mkl@pengutronix.de] (On Thursday, March 28, 2=
013
> 4:16 PM)
>> On 03/28/2013 10:28 AM, Alexander Shishkin wrote:
>>> Svetoslav Neykov <svetoslav@neykov.name> writes:
>>>
>>>> Convert between big-endian and little-endian format when accessing
>>>> the usb controller structures which are little-endian by
>>>> specification. Fix cases where the little-endian memory layout is
>>>> taken for granted. The patch doesn't have any effect on the already
>>>> supported little-endian architectures.
>>
>> Has anyone tested how the cpu_to_le32 and vice versa effects the
>> load/store operations? Does the compiler generate full 32 bit accesses=

>> on mips (and big endian arm) or is a byte-shift-or pattern used?
>=20
> Better late than never... I have checked your question, the value is lo=
aded
> in a register and then swapped, so the read is performed only once.

Thanks for checking this.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2FGNDSKJDAHUGURRPPQKE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGTm9oACgkQjTAFq1RaXHPfugCcDWk+CIelDL3h5+Bfb4D7s6ma
vEYAn1xw7uxYIXI3x6B7P4gccfOBvHK/
=dUAW
-----END PGP SIGNATURE-----

------enig2FGNDSKJDAHUGURRPPQKE--
