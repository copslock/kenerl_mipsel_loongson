Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7CE8JRw004818
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 12 Aug 2002 07:08:19 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7CE8J0S004817
	for linux-mips-outgoing; Mon, 12 Aug 2002 07:08:19 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mailgate.bodgit-n-scarper.com (mailgate.bodgit-n-scarper.com [62.49.233.146])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7CE8CRw004808
	for <linux-mips@oss.sgi.com>; Mon, 12 Aug 2002 07:08:13 -0700
Received: (qmail 2891 invoked from network); 12 Aug 2002 14:10:30 -0000
Received: from butterlicious.wired.bodgit-n-scarper.com (192.168.1.2)
  by mould.wired.bodgit-n-scarper.com with QMQP; 12 Aug 2002 14:10:30 -0000
Date: Mon, 12 Aug 2002 15:12:33 +0100
From: Matt Dainty <matt@bodgit-n-scarper.com>
To: linux-mips@oss.sgi.com
Subject: Serial console output twice
Message-ID: <20020812151233.D19420@butterlicious.bodgit-n-scarper.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.4.17 on i686 (butterlicious), up 3:48
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I've just successfully cross-compiled a 2.4.18 kernel from the OSS CVS,
for my R4600 SGI Indy. When I netboot it with a serial console, every
printk is printed twice. I've tried various options to disable serial
console/newport but it always does the same thing. If I try say, the
Debian TFTP image, the kernel works fine.

Does someone know what the problem is? Should I be using 2.4.18?

Cheers

Matt
--=20
"Phased plasma rifle in a forty-watt range?"
"Hey, just what you see, pal"

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9V8JRKP58eR+X2TMRAtBpAJ9tJ0RxMj42L1muD6eFjZE8xzplAACgmBbu
8ejefYk7ehvnZRhUz3ibOZM=
=WDrl
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
