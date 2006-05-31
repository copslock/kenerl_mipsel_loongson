Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2006 17:21:49 +0200 (CEST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:23985 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133510AbWEaPVk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 May 2006 17:21:40 +0200
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FlSRk-0000tB-BJ; Wed, 31 May 2006 17:17:20 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FlSVx-0000K8-Of; Wed, 31 May 2006 17:21:41 +0200
Date:	Wed, 31 May 2006 17:21:41 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	jgarzik@pobox.com, netdev@vger.kernel.org,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Jordan Crouse <jordan.crouse@amd.com>
Message-ID: <20060531152141.GH4390@enneenne.com>
References: <20060405154711.GL7029@enneenne.com> <20060405222332.GO7029@enneenne.com> <20060405222620.GP7029@enneenne.com> <4435290C.50607@ru.mvista.com> <20060406155011.GC23424@enneenne.com> <4446857D.90507@ru.mvista.com> <20060502150914.GE20543@gundam.enneenne.com> <447DAFAE.10503@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzX0AQGjRQPusK/O"
Content-Disposition: inline
In-Reply-To: <447DAFAE.10503@ru.mvista.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: Re: [PATCH] au1000_eth.c Power Management, driver registration and module support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--NzX0AQGjRQPusK/O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2006 at 07:01:02PM +0400, Sergei Shtylyov wrote:
>=20
>    Now that this is merged, Rodolfo's patch should probably preempt mine.=
=2E.
> but it looks like something was lost during the transition: I failed to s=
ee
> where SYS_PINFUNC register is actually read (the comment mentioning this=
=20
> was retained :-) to check whether Ethernet port 1 is enabled (its pins ar=
e=20
> shared w/GPIO)...

You are right! Maybe something like this may fix the problem:

   diff --git a/drivers/net/au1000_eth.c b/drivers/net/au1000_eth.c
   index 341fdc4..8a6427e 100644
   --- a/drivers/net/au1000_eth.c
   +++ b/drivers/net/au1000_eth.c
   @@ -2149,6 +2149,9 @@ static int au1000_drv_probe(struct devic
           void *base_addr, *macen_addr;
           int irq, ret;

   +       if (pdev->id =3D=3D 1 && (au_readl(SYS_PINFUNC) & SYS_PF_NI2) !=
=3D 0)
   +               return -ENODEV;
   +
           /* Get the resource info */
           res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "eth-=
base");
           if (!res) {

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--NzX0AQGjRQPusK/O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFEfbSFQaTCYNJaVjMRAvHdAJ935tpG2NTxAPl+dfRJwS5FkO707gCfaOwK
Xv9Vi+r/oN86EZ8UEw3VcQk=
=7+hD
-----END PGP SIGNATURE-----

--NzX0AQGjRQPusK/O--
