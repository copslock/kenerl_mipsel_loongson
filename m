Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jul 2006 18:46:55 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:45719 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133511AbWGRRqp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Jul 2006 18:46:45 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1G2sft-0008Lr-2H
	for linux-mips@linux-mips.org; Tue, 18 Jul 2006 18:43:57 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1G2teZ-0006cb-Tq
	for linux-mips@linux-mips.org; Tue, 18 Jul 2006 19:46:39 +0200
Date:	Tue, 18 Jul 2006 19:46:39 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060718174639.GB6887@enneenne.com>
References: <20060713163200.GA7186@gundam.enneenne.com> <20060714.103521.25910483.nemoto@toshiba-tops.co.jp> <20060714075441.GE7186@gundam.enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
In-Reply-To: <20060714075441.GE7186@gundam.enneenne.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: Re: Problems after merge to 2.6.18-rc1
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2006 at 09:54:41AM +0200, Rodolfo Giometti wrote:
>=20
> The first strange thing is that this time the kernel messages stop
> after "au1xxx_pm_prepare: state =3D 3" and not after "au_sleep: Zzz..."
> as before the merge! Maybe something as changed in serial console
> magement?

Yes, something as changed... here the patch to remove the problem.

   diff --git a/kernel/power/main.c b/kernel/power/main.c
   index 6d295c7..10bf859 100644
   --- a/kernel/power/main.c
   +++ b/kernel/power/main.c
   @@ -86,7 +86,9 @@ static int suspend_prepare(suspend_state
    			goto Thaw;
    	}
   =20
   +#ifndef CONFIG_DEBUG_KERNEL
    	suspend_console();
   +#endif
    	if ((error =3D device_suspend(PMSG_SUSPEND))) {
    		printk(KERN_ERR "Some devices failed to suspend\n");
    		goto Finish;

I'd like also sending this patch to the Linux main tree, where should
I send it? I found nothing useful in MAINTAINERS file... :-o

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFEvR5/QaTCYNJaVjMRArfQAJ9mgkuN6FILxTuig9Nz4Tvt0vt3AgCfcDii
igOzwcHEos+f/q0FynVDLss=
=vcL4
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
