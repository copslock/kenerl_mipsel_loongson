Received:  by oss.sgi.com id <S553744AbQJRUQP>;
	Wed, 18 Oct 2000 13:16:15 -0700
Received: from air.lug-owl.de ([62.52.24.190]:64526 "HELO air.lug-owl.de")
	by oss.sgi.com with SMTP id <S553722AbQJRUQH>;
	Wed, 18 Oct 2000 13:16:07 -0700
Received: by air.lug-owl.de (Postfix, from userid 1000)
	id 7D4CF85DE; Wed, 18 Oct 2000 22:16:04 +0200 (CEST)
Date:   Wed, 18 Oct 2000 22:16:03 +0200
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     linux-mips@oss.sgi.com
Subject: Re: base.tgz
Message-ID: <20001018221603.F3596@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20001016043346.A6656@lug-owl.de> <20001017041449.A17546@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0rSojgWGcpz+ezC3"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001017041449.A17546@lug-owl.de>; from jbglaw@lug-owl.de on Tue, Oct 17, 2000 at 04:14:50AM +0200
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--0rSojgWGcpz+ezC3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2000 at 04:14:50AM +0200, Jan-Benedict Glaw wrote:
> On Mon, Oct 16, 2000 at 04:33:47AM +0200, Jan-Benedict Glaw wrote:

> * Package: base-files

base-files_2.2.2_mipsel.deb provides /etc/nsswitch.conf as well
as glibc_2.0.6ml5.rpm does. Which one do you prefer to have in
a base.tgz?

--------- .rpm version, comments/blank lines removed
passwd:     files nisplus nis
shadow:     files nisplus nis
group:      files nisplus nis
hosts:      files nisplus nis dns
services:   nisplus [NOTFOUND=3Dreturn] files
networks:   nisplus [NOTFOUND=3Dreturn] files
protocols:  nisplus [NOTFOUND=3Dreturn] files
rpc:        nisplus [NOTFOUND=3Dreturn] files
ethers:     nisplus [NOTFOUND=3Dreturn] files
netmasks:   nisplus [NOTFOUND=3Dreturn] files    =20
bootparams: nisplus [NOTFOUND=3Dreturn] files
netgroup:   nisplus
publickey:  nisplus
automount:  files nisplus
aliases:    files nisplus

--------- .deb version, comments/blank lines removed
passwd:         compat
group:          compat
shadow:         compat
hosts:          files dns
networks:       files
protocols:      db files
services:       db files
ethers:         db files
rpc:            db files
netgroup:       nis


Personally, I prefer to have the .deb version, but I think it's
better to ask before;) Esp the nisplus entries in RH's variant
make me to dislike is...

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--0rSojgWGcpz+ezC3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjnuBQIACgkQHb1edYOZ4bsh2QCfYDnnL7zHhlv14COxbAbpey1l
j4oAn2P+1BnNYJ9rZ5NaJWzmFny+D9rY
=NwaO
-----END PGP SIGNATURE-----

--0rSojgWGcpz+ezC3--
