Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Feb 2007 10:26:27 +0000 (GMT)
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:63246 "EHLO
	smtp-vbr8.xs4all.nl") by ftp.linux-mips.org with ESMTP
	id S20037410AbXBVK0W (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Feb 2007 10:26:22 +0000
Received: from gateway.home (a82-92-155-199.adsl.xs4all.nl [82.92.155.199])
	by smtp-vbr8.xs4all.nl (8.13.8/8.13.8) with ESMTP id l1MAPen3083573;
	Thu, 22 Feb 2007 11:25:45 +0100 (CET)
	(envelope-from mouw@nl.linux.org)
Received: from erik by gateway.home with local (Exim 3.36 #1 (Debian))
	id 1HKB8u-0000As-00; Thu, 22 Feb 2007 11:25:40 +0100
Date:	Thu, 22 Feb 2007 11:25:40 +0100
From:	Erik Mouw <mouw@nl.linux.org>
To:	Rajat Jain <rajat.noida.india@gmail.com>
Cc:	kernelnewbies <kernelnewbies@nl.linux.org>,
	newbie <linux-newbie@vger.kernel.org>, linux-mips@linux-mips.org
Subject: Re: not getting command prompt at the console
Message-ID: <20070222102540.GB31252@gateway.home>
References: <b115cb5f0702220149wfbfc051qc8d0106b9e4ed98d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline
In-Reply-To: <b115cb5f0702220149wfbfc051qc8d0106b9e4ed98d@mail.gmail.com>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: by XS4ALL Virus Scanner
Return-Path: <mouw@nl.linux.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mouw@nl.linux.org
Precedence: bulk
X-list: linux-mips


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2007 at 03:19:10PM +0530, Rajat Jain wrote:
> Hi All,
>=20
> I just finished porting linux kernel 2.6.15 to a MIPS based board. The
> board now boots up beautifully ... and here is the console log:

[...]

> Next, I expected to see a command prompt which never comes. At this
> point if I debug, I find the processor executing the idle process.
>=20
> I am successfully hable to telnet to the board and fire whatever
> commands I want though. How do I bring the prompt to the serial
> console?

Run a getty on the serial device (I suppose you're using a serial
port).

> My root FS seems OK since the same root FS is working for the same
> board for an ancient kernel (2.4.20)

Could be that the serial driver changed or that you forgot to compile a
driver for the serial device.


Erik

--=20
They're all fools. Don't worry. Darwin may be slow, but he'll
eventually get them. -- Matthew Lammers in alt.sysadmin.recovery

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF3W+k/PlVHJtIto0RArSNAJ90TmeVEdoINTMf2c9Nbd6aEPXSkgCdG3hr
qSwrqnHz3ROZBAuJoc5JX80=
=iJ73
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
