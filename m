Received:  by oss.sgi.com id <S553752AbQJQCPI>;
	Mon, 16 Oct 2000 19:15:08 -0700
Received: from air.lug-owl.de ([62.52.24.190]:44296 "HELO air.lug-owl.de")
	by oss.sgi.com with SMTP id <S553738AbQJQCOx>;
	Mon, 16 Oct 2000 19:14:53 -0700
Received: by air.lug-owl.de (Postfix, from userid 1000)
	id 8BA8285C2; Tue, 17 Oct 2000 04:14:50 +0200 (CEST)
Date:   Tue, 17 Oct 2000 04:14:50 +0200
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     linux-mips@oss.sgi.com
Subject: Re: base.tgz
Message-ID: <20001017041449.A17546@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20001016043346.A6656@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001016043346.A6656@lug-owl.de>; from jbglaw@lug-owl.de on Mon, Oct 16, 2000 at 04:33:47AM +0200
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2000 at 04:33:47AM +0200, Jan-Benedict Glaw wrote:

Hi!

> My next goal is to cleanly build something like base.tgz. Maybe
> we can get a smooth debian installation in some days;)

Okay, I took the package list off potato's base.tgz. Please comment
on the missing packets or which files to take instead. Please also
have a look at the perl packages...

Packages which seem to be not used/useable. They'll not be included:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Package: console-tools-libs
Package: fbset
Package: fdflush
Package: fdutils
Package: isapnptools
Package: lilo
Package: mbr
Package: pciutils
Package: pump
Package: syslinux
Package: xviddetect
Package: pcmcia-cs


Packages which are broken in some way right now:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Package: debconf-tiny (not found)
Package: bsdutils (not found)
Package: libc6 (will use converted 206-5 rpm)
Package: libnewt0 (not found, will use newt-0.40-9.rpm)
Package: libstdc++2.10 (not found)
Package: locales (not found)
Package: mount (not found, will take mount-2.9o-1.rpm)
Package: util-linux (not found, will take util-linux-2.7-19.rpm)
Package: whiptail (not found, will use declinux' version)


Packages which are okay:
~~~~~~~~~~~~~~~~~~~~~~~~
* Package: adduser=20
* Package: ae
* Package: apt
* Package: base-config
* Package: base-files
* Package: base-passwd
* Package: bash
* Package: debianutils
* Package: diff
* Package: dpkg
* Package: e2fsprogs
* Package: elvis-tiny
* Package: fileutils
* Package: findutils
* Package: ftp
* Package: gettext-base
* Package: grep
* Package: gzip
* Package: hostname
* Package: ldso
* Package: libdb2
* Package: libgdbmg1
* Package: libncurses5
* Package: libpam-modules
* Package: libpam-runtime
* Package: libpam0g
* Package: libpopt0
* Package: libreadline4
* Package: libwrap0
* Package: login
* Package: makedev
* Package: mawk
* Package: modconf
* Package: modutils
* Package: ncurses-base
* Package: ncurses-bin
* Package: netbase (using netstd_3.07-17.deb)
* Package: passwd
* Package: perl-5.005-base (using perl-5.005_5.005.03-7.1_mipsel.deb)
* Package: perl-base (using perl-5.005-base_5.005.03-7.1_mipsel.deb)
* Package: ppp
* Package: pppconfig
* Package: procps
* Package: psmisc
* Package: sed
* Package: setserial
* Package: shellutils
* Package: slang1
* Package: sysklogd
* Package: sysvinit
* Package: tar
* Package: tasksel
* Package: tcpd
* Package: telnet
* Package: textutils
* Package: update

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjnrthkACgkQHb1edYOZ4bumeQCfTM6/VtlYrRvPCVpcSc2QIcAZ
j6kAn3pHXi/S1nJduXixwbk9mWtgBWlP
=Qh9L
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
