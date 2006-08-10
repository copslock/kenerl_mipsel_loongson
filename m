Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2006 14:35:56 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:59074 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S20043436AbWHJNfz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Aug 2006 14:35:55 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1GB9i7-0007Zm-Q6; Thu, 10 Aug 2006 14:32:28 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1GBAiY-0001uo-Uz; Thu, 10 Aug 2006 15:36:58 +0200
Date:	Thu, 10 Aug 2006 15:36:58 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Message-ID: <20060810133658.GZ342@enneenne.com>
References: <20060809210843.GC13145@enneenne.com> <44DB34C2.3090302@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MqIM5Iaa8ROQPHlo"
Content-Disposition: inline
In-Reply-To: <44DB34C2.3090302@ru.mvista.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: Re: [PATCH] 2/7 AU1100 MMC support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--MqIM5Iaa8ROQPHlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2006 at 05:29:38PM +0400, Sergei Shtylyov wrote:
> > static void au1xmmc_set_power(struct au1xmmc_host *host, int state)
> > {
> >=20
> >-	u32 val =3D au1xmmc_card_table[host->id].bcsrpwr;
> >+	u32 val;
> >=20
> >+	val =3D au1xmmc_card_table[host->id].power;
> >+
> >+#if defined(CONFIG_MIPS_DB1200)
> > 	bcsr->board &=3D ~val;
> > 	if (state) bcsr->board |=3D val;
> >+#endif
> >=20
> > 	au_sync_delay(1);
> > }
>=20
>    If DBAu1100 doesn't allow to control slot power, then I don't think=20
> pretending it does is a good thing. Shouldn't these #ifdef's be in=20
> au1xmmc_set_ios() instead (the function is void anyway but that would all=
ow=20
> us to save on the code size a bit more)?

Mmm. I proposed that solution but I don't know exaclty how several
DB1x00 boards work. I just protect the variable "bcsr" which is not
defined for my board.

> > static inline int au1xmmc_card_inserted(struct au1xmmc_host *host)
> > {
> >-	return (bcsr->sig_status & au1xmmc_card_table[host->id].bcsrstatus)
> >-		? 1 : 0;
> >+	u32 val, data =3D 1;
> >+
> >+	val =3D au1xmmc_card_table[host->id].status;
> >+
> >+#if defined(CONFIG_MIPS_DB1200)
> >+	data =3D bcsr->sig_status & val;
> >+#endif
> >+
> >+	return !!data;
> > }
>=20
>    Hrm, are you sure there's no way to sense that the card is *really*=20
> inserted or not?

Again as above. For my specific board I use:

   #if defined(CONFIG_MIPS_DB1200)
       data =3D bcsr->sig_status & val;
   #elif defined(CONFIG_MIPS_MYBOARD)
       specific code...
   #endif

Maybe we should modify my solution including other DB1x00 boards
ifdef. However, the important thing is to protect againt variable
"bcsr" if a specific board doesn't support it.

> > static inline int au1xmmc_card_readonly(struct au1xmmc_host *host)
> > {
> >-	return (bcsr->status & au1xmmc_card_table[host->id].wpstatus)
> >-		? 1 : 0;
> >+	u32 val, data =3D 0;
> >+
> >+	val =3D au1xmmc_card_table[host->id].wpstatus;
> >+
> >+#if defined(CONFIG_MIPS_DB1200)
> >+	data =3D bcsr->status & val;
> >+#endif
> >+
> >+	return !!data;
> > }
>=20
>    Ditto.

The same as above. :)

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--MqIM5Iaa8ROQPHlo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFE2zZ6QaTCYNJaVjMRAj9gAKCK5qBdAnqj26UJ2SeYw8VRwCaUAQCeKxM4
KwFgiaLlBV60PaBHS+AaW2w=
=9XQu
-----END PGP SIGNATURE-----

--MqIM5Iaa8ROQPHlo--
