Received:  by oss.sgi.com id <S553908AbQLQG6K>;
	Sat, 16 Dec 2000 22:58:10 -0800
Received: from air.lug-owl.de ([62.52.24.190]:7952 "HELO air.lug-owl.de")
	by oss.sgi.com with SMTP id <S553905AbQLQG54>;
	Sat, 16 Dec 2000 22:57:56 -0800
Received: by air.lug-owl.de (Postfix, from userid 1000)
	id 5791C8655; Sun, 17 Dec 2000 07:57:53 +0100 (CET)
Date:   Sun, 17 Dec 2000 07:57:53 +0100
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     linux-mips@oss.sgi.com
Subject: Re: FAQ/
Message-ID: <20001217075752.B5352@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-mips@oss.sgi.com
References: <3A36AFFE.51C9F2B@web.de> <20001213135723.B3060@paradigm.rfc822.org> <3A3C0ACE.8A13EA97@web.de> <20001217020043.B29250@lug-owl.de> <3A3C194B.5E85C4CE@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A3C194B.5E85C4CE@web.de>; from olaf.zaplinski@web.de on Sun, Dec 17, 2000 at 02:39:23AM +0100
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2000 at 02:39:23AM +0100, Olaf Zaplinski wrote:
> - how to prepare your bootp server

Install bootp (or dhcpd, which can do bootp as well) and read its
documentation.

> - how to boot the kernel via bootp

This is specific to your machine's firmware.

> - how to start some install script *or* boot your mini-dist/root-fs via N=
FS,
> fdisk, cp and enjoy

less  ./linux/Documentation/nfsroot.txt

~~VeryShortVersion~~:
- Activate "IP Auto Configuration" in "Networking Options"
- Build NFS directly into your kernel; there, also activate NFS-Root
  support
- "root=3D/dev/nfs" as one command option when booting the kernel (this
  is the easyest method). Then, the client mounts /tftpboot/<IP-Addr>
  from the server which did the bootp reply. Otoh, you could
  configure your bootp server to provide a different boot server
  or boot path.

fdisk and cp (btw, you should better use tar in a pipe for that...)
should be no problem...

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjo8Y/AACgkQHb1edYOZ4bty3QCfQEN3mA8JA8614NlDo+1wIjJT
L+cAoIiJggUzIVyEkvhi2DTFx5AFcE8t
=cgeY
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
