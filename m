Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2018 16:47:02 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:60584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991248AbeCNPqzIH3hD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2018 16:46:55 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A407D20779;
        Wed, 14 Mar 2018 15:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A407D20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 14 Mar 2018 15:46:42 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Matt Redfearn <matt.redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, Jason Cooper <jason@lakedaemon.net>,
        Dengcheng Zhu <dengcheng.zhu@mips.com>,
        linux-kernel@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/6] irqchip/mips-gic: Enable & use VEIC mode if available
Message-ID: <20180314154641.GA8976@saruman>
References: <1515148270-9391-1-git-send-email-matt.redfearn@mips.com>
 <c9b5d20c-7adf-5308-1a45-21471d206d10@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <c9b5d20c-7adf-5308-1a45-21471d206d10@arm.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62975
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


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 14, 2018 at 11:15:47AM +0000, Marc Zyngier wrote:
> Hi Matt,
>=20
> On 05/01/18 10:31, Matt Redfearn wrote:
> >=20
> > This series enables the MIPS GIC driver to make use of the EIC mode
> > supported in some MIPS cores. In this mode, the cores 6 interrupt lines
> > are switched to represent a vector number, 0..63. Currently all GIC
> > interrupts are routed to a single CPU interrupt pin, but this is
> > inefficient since we end up checking both local and shared interrupt
> > flag registers for both local and shared interrupts. This introduces
> > additional latency into the interrupt paths. With EIC mode this can be
> > improved by using separate vectors for local and shared interrupts.
> >=20
> > This series is based on 4.15-rc6 and has been tested on Boston, Malta &
> > SEAD3 MIPS platforms implementing a GIC with and without EIC mode
> > supported in hardware.
>=20
> What the status of this series?

FYI I've been meaning to test it with KVM, since host EIC I think will
affect KVM & guest stuff.

Cheers
James

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqpQ+EACgkQbAtpk944
dnpXVw/9Hg45TxhejxWGfq/M8fj+8mY6Idn8dYyvd8aa5kJON8ojchFU0PaCX5AG
pSnulJNecORbKX4ThakiqQsOPz9qjwSwrI1V2IQE8zlzmjLgu5FjrFM6rY4lt1/h
5466PwTZ7GefAPX0THkbG0hdqDJWGAvjIw54ga3aKE5zaNyiR+0aTYjKUdTnHUL2
XWPxBesE74w2y77q6odsJW6CsEkigIyGq5EFBSw3KJCKxW4BGo5rRY3T8Nypobgq
PB54p/wNKpaUEa4usfBbwnit+oZ/x2dImTboccG3PVxKLGPN6NTtBCa4rM/kX51Q
O3WxnYKrhWBum/q6y9r60u2+PzTZlAD80353eVD03ksUYUmTNI0hV6WL5oZNOKTS
VlHqsHKWdTOvu0tQPR+UKLnsQyoNKfsvbavkZDu1lhuRBYDh4I/ChfFmSIVj2DtM
D184cEkNJXom4LGI/w+WBokKOpMvse6yL8KOgu439XKXy8dX1/MyyQ1tA2TqkBli
ylyYV6My6EYYdxtF9IFRpX2AuzLvuAcJe2GVGOh571WYyWwm8p1HdWT5COjSAG7u
vVYXZlZGM5SPPiMsOeFK+PyIS7k4jV5TC3A0tVGOt7jQ6GkNj6Q1X1rAu7nxFaWC
v58mKXi5FdyM0cP2rDggIo0smoZtlWm/+9+FxRfEtuXCg6JuMJs=
=09L9
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
