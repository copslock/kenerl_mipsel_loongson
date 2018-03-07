Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2018 15:41:46 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:35128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994721AbeCGOli4ZxLt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Mar 2018 15:41:38 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 203632172D;
        Wed,  7 Mar 2018 14:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203632172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 7 Mar 2018 14:41:24 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jaedon Shin <jaedon.shin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] MIPS: BMIPS: Add Broadcom STB device nodes
Message-ID: <20180307144122.GO4197@saruman>
References: <20171117021944.894-1-jaedon.shin@gmail.com>
 <56e80e5d-8cdd-3b32-c0f5-ac33c45346b8@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hSZb4FHl1C2xfsUy"
Content-Disposition: inline
In-Reply-To: <56e80e5d-8cdd-3b32-c0f5-ac33c45346b8@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62831
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


--hSZb4FHl1C2xfsUy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2018 at 04:06:30PM -0800, Florian Fainelli wrote:
> On 11/16/2017 06:19 PM, Jaedon Shin wrote:
> > This series adds power and memory management related devie tree nodes f=
or
> > Broadcom STB platforms.
> >=20
> > Jaedon Shin (3):
> >   MIPS: BMIPS: Add Broadcom STB power management nodes
> >   MIPS: BMIPS: Add Broadcom STB wake-up timer nodes
> >   MIPS: BMIPS: Add Broadcom STB watchdog nodes
>=20
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks, applied for 4.17.

Cheers
James

--hSZb4FHl1C2xfsUy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqf+hIACgkQbAtpk944
dnr/dhAAngkxiPO9UX5WhAnkYbdc3TQTUy6Qsz/xe/E7ma6K4OFBy86XHNK/f7k+
I9vJtO22q3Kj3WWVjV7muEMcVbZK8YFSDBWM2MnxFDOx4dwcncnt0Kl9i7GFoJ+Y
3vGAMXhJ4ek20Je0XrnMELyHrJ8g63PLeV5OvePS9wKwuzES0QLuUPnjt2riro7o
TwFvokw1UD3IScJ4+IC8PwBNlW5mGOVW24/UaehmAWuAO6rEwtTyEYUfd4r/Y4KL
kC7YlNSWLWCqXJQ1OEbXGj2A4tG2dW3092YPuYMfNNgNkoU3Nr8Su6fA4io6RWYI
FU6D7x0W8fTjZNf7U8qRi8ZXLvi9inv/R2mfcJAmw/GjKdDDaaiAms9zD+cykx1A
9B/niiWBo/0e6rXRTtjESJvtnj6bSGakLL3R8WpFS7OPjuKn2FVBKLq9Wvv2MEVp
wnqhI/8ECxMfm/AAqMM0+n7Cg3sBSV/Gt8VIgLZyCjdL0pQXJqBRJnPT2hhTugLj
oq0cF/yOOw8EvzRgaSDkqFL3Oeep52chxp/VvoLOYXFb/9hvA2f1oc+CanHqebRM
gFjUOoUwUTqffplvpbXeWOBYas1D/kJht7JwSOQjvqRwmomh58QRb5pAApBCXNwO
HMNqZfl6NqaX+TyfbN8ZFCfSKBnUxB+c4Pq5sghAXkgDsh0xG2c=
=3KrG
-----END PGP SIGNATURE-----

--hSZb4FHl1C2xfsUy--
