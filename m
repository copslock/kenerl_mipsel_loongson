Received:  by oss.sgi.com id <S553888AbQLQBBJ>;
	Sat, 16 Dec 2000 17:01:09 -0800
Received: from air.lug-owl.de ([62.52.24.190]:44807 "HELO air.lug-owl.de")
	by oss.sgi.com with SMTP id <S553885AbQLQBAq>;
	Sat, 16 Dec 2000 17:00:46 -0800
Received: by air.lug-owl.de (Postfix, from userid 1000)
	id 1F3B88655; Sun, 17 Dec 2000 02:00:43 +0100 (CET)
Date:   Sun, 17 Dec 2000 02:00:43 +0100
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     linux-mips@oss.sgi.com
Subject: Re: FAQ/
Message-ID: <20001217020043.B29250@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-mips@oss.sgi.com
References: <3A36AFFE.51C9F2B@web.de> <20001213135723.B3060@paradigm.rfc822.org> <3A3C0ACE.8A13EA97@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A3C0ACE.8A13EA97@web.de>; from olaf.zaplinski@web.de on Sun, Dec 17, 2000 at 01:37:34AM +0100
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2000 at 01:37:34AM +0100, Olaf Zaplinski wrote:
> Where do I find it? I saw the debian-mipsel dist on ftp.rfc822.org, but as
> there is no doc at all, this dist is unusuable... perhaps I am lucky with
> that, I strongly dislike the Debian dist.

Btw, what kind of doc do you expect? The MIPS port is, well, everything
but a "customer linux" right now. It's more-or-less working for
people who know what they do. There's no installer comparable to
a regular PC installation (insert boot CDROM, press enter sometimes,
ready). Everything you can expect is a tarball, which can be
mounted via nfsroot. There you can find a kernel inside which you
can boot over bootp/tftp (or via mop, if you have not so much luck).
Then, you can locally fdisk/mkfs/mount your HDDs and copy everything
by hand. That's the installation.

Anything else still needs to be written. I've started an approach
of a clean debian root filesystem (ftp.lug-owl.de) you may want
to try. However, Debian is currently the only distribution supporting
those machines at all. The declinux image is heavily outdated and
ships a totally broken libc with it... It's no fun!

MfG, JB"Nur die Harten komm'n in'n Garten, alle Weichen geh'n in Teich!"G
PS: http://oss.sgi.com/mips/mips-howto.html

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjo8EDoACgkQHb1edYOZ4bt6eQCffQnYKPhvZcBYfRIxf4CdHwCN
td8An0HFilpQWPcHyriI2RKaJa6FYSTJ
=Uysh
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
