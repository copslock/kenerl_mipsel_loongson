Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Mar 2008 10:59:50 +0100 (CET)
Received: from hydra.gt.owl.de ([195.71.99.218]:38336 "EHLO hydra.gt.owl.de")
	by lappi.linux-mips.net with ESMTP id S529923AbYC2J7p (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 29 Mar 2008 10:59:45 +0100
Received: by hydra.gt.owl.de (Postfix, from userid 1000)
	id B812C32EC6; Sat, 29 Mar 2008 10:59:14 +0100 (CET)
Date:	Sat, 29 Mar 2008 10:59:14 +0100
From:	Florian Lohoff <flo@rfc822.org>
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	linux-mips@linux-mips.org, Eugene Konev <ejka@imfi.kspu.ru>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][MIPS][3/6]: AR7: VLYNQ bus
Message-ID: <20080329095914.GA18263@paradigm.rfc822.org>
References: <200803120221.25044.technoboy85@gmail.com> <200803120226.42795.technoboy85@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <200803120226.42795.technoboy85@gmail.com>
Organization: rfc822 - pure communication
X-SpiderMe: mh-200803291051@listme.rfc822.org
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi Matteo,

On Wed, Mar 12, 2008 at 02:26:42AM +0100, Matteo Croce wrote:
> +	switch (dev->divisor) {
> +	case vlynq_div_auto:
> +		/* Only try locally supplied clock, others cause problems */

i have a platform (AR7VWi - Leonardo Board) which has an external
supplied clock from an ACX111 so the div_auto autoprobing will not work.

I put the vlynq_div_external code in front of this which should
simply listen on the vlynq if there is a clock and use it. This solved
one of the issues for me. Can you elaborate on the above comment where
caused problems? I have seen multiple implementations of this, all of
them did autoprobing first by listening on the remote clock first.

> +		vlynq_reg_write(dev->remote->control, 0);
> +		for (i =3D vlynq_ldiv2; i <=3D vlynq_ldiv8; i++) {
> +			vlynq_reg_write(dev->local->control,
> +					VLYNQ_CTRL_CLOCK_INT |
> +					VLYNQ_CTRL_CLOCK_DIV(i - vlynq_ldiv1));
> +			if (vlynq_linked(dev)) {
> +				printk(KERN_DEBUG
> +				       "%s: using local clock divisor %d\n",
> +				       dev->dev.bus_id, i - vlynq_ldiv1 + 1);
> +				dev->divisor =3D i;
> +				return 0;
> +			}
> +		}

What i found in the TI code is that FIRST the local->control needs to
get set before issueing a remote access so shouldnd the=20

	vlynq_reg_write(dev->remote ... )

move behind the dev->local ? I mean the logic is to set a local clock
divisor - try to access something on the remote end and see if the link
got up ?!?

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
	Those who would give up a little freedom to get a little=20
          security shall soon have neither - Benjamin Franklin

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH7hLyUaz2rXW+gJcRAvm3AKCkLYLyJHPf+Z6xQ6VQYPMt20QNxQCdHEsZ
70YFvI1TMCRmgJORfmW9zuo=
=spvi
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
