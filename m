Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2016 20:40:24 +0100 (CET)
Received: from mail.lysator.liu.se ([130.236.254.3]:43716 "EHLO
        mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993208AbcKATkSBNePd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2016 20:40:18 +0100
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
        by mail.lysator.liu.se (Postfix) with ESMTP id 614244000A;
        Tue,  1 Nov 2016 20:40:17 +0100 (CET)
Received: from zarathustra.unixrus.se (c83-250-85-64.bredband.comhem.se [83.250.85.64])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.lysator.liu.se (Postfix) with ESMTPSA id B2CFE40002;
        Tue,  1 Nov 2016 20:40:16 +0100 (CET)
Subject: Re: System clock going slow/fast with ntpdate
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: multipart/signed; boundary="Apple-Mail=_D01D10A5-C32B-4931-A2FC-E8F703C23A5B"; protocol="application/pgp-signature"; micalg=pgp-sha1
X-Pgp-Agent: GPGMail 2.5.2
From:   Markus Gothe <nietzsche@lysator.liu.se>
In-Reply-To: <alpine.DEB.2.00.1611011900260.24498@tp.orcam.me.uk>
Date:   Tue, 1 Nov 2016 20:40:11 +0100
Cc:     Deepak Gaur <dgaur@cdot.in>, linux-mips@linux-mips.org
Sendlaterdate: Tue, 1 Nov 2016 20:40:11 +0100
Message-Id: <2847D646-2B3F-4D6A-9312-8EFE2D3B9AF7@lysator.liu.se>
References: <20161026081208.M10605@cdot.in> <20161026085306.M18729@cdot.in> <012925E3-E06F-413D-BBD4-9BF40F0F08A7@lysator.liu.se> <alpine.DEB.2.00.1611011900260.24498@tp.orcam.me.uk>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
X-Mailer: Apple Mail (2.1878.6)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <nietzsche@lysator.liu.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nietzsche@lysator.liu.se
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


--Apple-Mail=_D01D10A5-C32B-4931-A2FC-E8F703C23A5B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

I doubt that it changes spontaneously.

AFAIU this is related to NTP (the issue only shows up when setting time =
with ntpdate), and
time drift is a know circumstance which must be mitigated as described =
by Larry Doolittle and his rate.awk-scrip.

On 01 Nov 2016, at 20:04 , Maciej W. Rozycki <macro@imgtec.com> wrote:

> On Tue, 1 Nov 2016, Markus Gothe wrote:
>=20
>> You should calculate your boards time drift and compensate for it.
>=20
> Well it can't help if the clock rate changes spontaneously, can it?
>=20
>  Maciej
>=20

//Markus - The panama-hat hacker


--Apple-Mail=_D01D10A5-C32B-4931-A2FC-E8F703C23A5B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.28

iD8DBQFYGO+f6I0XmJx2NrwRAqYpAKCBUxG8sNdGYXU3IBwK8jzqdlfGPACff0RI
3M++4WvUGT6kDc92NmljYl8=
=Rg7m
-----END PGP SIGNATURE-----

--Apple-Mail=_D01D10A5-C32B-4931-A2FC-E8F703C23A5B--
