Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4A9VhwJ004946
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 10 May 2002 02:31:43 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4A9VhWP004945
	for linux-mips-outgoing; Fri, 10 May 2002 02:31:43 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4A9VbwJ004942
	for <linux-mips@oss.sgi.com>; Fri, 10 May 2002 02:31:38 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id D0972859; Fri, 10 May 2002 11:33:10 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 1B66D3711E; Fri, 10 May 2002 11:32:32 +0200 (CEST)
Date: Fri, 10 May 2002 11:32:32 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Robert Rusek <rrusek@teknuts.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Indy SCSI Errors
Message-ID: <20020510093232.GD26862@paradigm.rfc822.org>
References: <20020509154327.GB6197@paradigm.rfc822.org> <C0F41630CD8B9C4680F2412914C1CF070164C2@WH-EXCHANGE1.AD.WEIDERPUB.COM>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Content-Disposition: inline
In-Reply-To: <C0F41630CD8B9C4680F2412914C1CF070164C2@WH-EXCHANGE1.AD.WEIDERPUB.COM>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2002 at 09:31:01AM -0700, Robert Rusek wrote:
> I am familiar with the error that you are referring to.  I just fixed it
> by upgrading to kernel 2.4.17.  The error that I am describing, should I
> just ignore it and just do a fsck on my main drive every month?  I have
> three drives sda1, sdb1, and sdc1 and it only seems to happened on the
> sda1.  My sda2 is the swap drive, would that be affecting my sda1 ?

If its not the error i fixed a couple of months ago i would
suspect bad hardware - Either ram or disk. I wouldnt ignore it.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE825OvUaz2rXW+gJcRAiUIAKCWJg5nyKpgCrjPUPx4oMhQiZSzJQCg0LWh
+rzaob3+WxoLITCs9ckoBPU=
=kNpc
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
