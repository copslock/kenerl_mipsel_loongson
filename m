Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f57IktB03284
	for linux-mips-outgoing; Thu, 7 Jun 2001 11:46:55 -0700
Received: from mail.eclipse.net (mail.eclipse.net [207.207.192.13])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f57Ikrh03281
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 11:46:54 -0700
Received: from hork (njc2-04-152.dial.eclipse.net [207.207.240.152])
	by mail.eclipse.net (8.9.1a/8.9.1) with ESMTP id OAA07288;
	Thu, 7 Jun 2001 14:46:45 -0400 (EDT)
Received: from molotov by hork with local (Exim 3.22 #1 (Debian))
	id 1584nw-0001Nl-00; Thu, 07 Jun 2001 14:46:48 -0400
Date: Thu, 7 Jun 2001 14:46:48 -0400
To: Robert Rusek <robru@teknuts.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Newbie Question, Please help
Message-ID: <20010607144648.A4949@hork>
Mail-Followup-To: Robert Rusek <robru@teknuts.com>, linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <002e01c0ee0c$1572fed0$031010ac@rjrtower>
User-Agent: Mutt/1.3.18i
From: Chris Ruvolo <chris@ruvolo.org>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2001 at 03:08:42PM -0700, Robert Rusek wrote:
> It gets the address then claims it is sending the vmlinux file via tftp.
> On the SGI it just times out.
>=20
> Any advice, pointers, etc would be greatly appreciated.

=46rom the HOWTO (http://www.oss.sgi.com/mips/mips-howto.html):

7.6 My machine doesn't download the kernel when I try to netboot

Your machine is replying to the BOOTP packets (you may verify this using a
packet sniffer like tcpdump or ethereal), but doesn't download the kernel
from your BOOTP server. This happens if your boot server is running a kernel
of the 2.3 series or higher. The problem may be circumvented by doing a
"echo 1 > /proc/sys/net/ipv4/ip_no_pmtu_disc" as root on your boot server.


Good luck.
-Chris

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7H8wYKO6EG1hc77ERAhQsAKDwU2CtU74sc/SaIRL/W1b0zwD6tgCg62wr
tH5lGE15Eo4DGW/83qmCVeo=
=jnHZ
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
