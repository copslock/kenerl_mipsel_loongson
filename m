Received:  by oss.sgi.com id <S553735AbQJTSDf>;
	Fri, 20 Oct 2000 11:03:35 -0700
Received: from air.lug-owl.de ([62.52.24.190]:53252 "HELO air.lug-owl.de")
	by oss.sgi.com with SMTP id <S553724AbQJTSD2>;
	Fri, 20 Oct 2000 11:03:28 -0700
Received: by air.lug-owl.de (Postfix, from userid 1000)
	id AA9A685C3; Fri, 20 Oct 2000 20:01:51 +0200 (CEST)
Date:   Fri, 20 Oct 2000 20:01:51 +0200
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     debian-mips|lists.debian.org@lug-owl.de
Cc:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: mipsel base.tgz
Message-ID: <20001020200150.C25684@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: debian-mips|lists.debian.org, linux-mips@fnet.fr,
	linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux air 2.4.0-test8-pre1
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm currently working on a base.tgz for Debian Woody on little
endian MIPS machines (I'm working on a DECStation 5000/120).

Currently, I've got problems with these packages:

- netbase_4.05.deb
  ppp_2.4.0f-1_mipsel.deb
  pppconfig_2.0.5.deb
  telnetd_0.16-4_mipsel.deb
  ---> They depend (more or less) on (net-tools|iproute) which I
       haven't found any packages for

- base-config_0.35_mipsel.deb
  ---> Fails because I've not found any debconf (neither little
       nor big brother;)

- modconf_0.2.27.deb
  ---> Missing whiptail. I've got a whiptail executable from the old
       "declinux" root image and will produce a faked package off this.
       However, I prefer to have a native package...

- console-tools_0.2.3-13_mipsel.deb
  ---> Complains about not having a file descriptor to a console,
       which might be correct as I installed everything within
       a chroot() cage over telnet. OTOH there's the serial console
       which I'd try...


Currently, I don't have a native compiler running. I'd like to ask
anybody to help me with all the packages above which fail at the
moment...

These packages are currently installed:

Desired=3DUnknown/Install/Remove/Purge/Hold
| Status=3DNot/Installed/Config-files/Unpacked/Failed-config/Half-installed
|/ Err?=3D(none)/Hold/Reinst-required/X=3Dboth-problems (Status,Err: upperc=
ase=3Dbad)
||/ Name           Version        Description
+++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ii  adduser        3.19           Add and remove users and groups to resp. =
fro
ii  ae             962-26         Anthony's Editor -- a tiny full-screen ed=
ito
ii  apt            0.3.19         Advanced front-end for dpkg
iU  base-config    0.35           Debian base configuration package
ii  base-files     2.2.2          Debian base system miscellaneous files
ii  base-passwd    3.1.7          Debian Base System Password/Group Files
ii  bash           2.04-4         The GNU Bourne Again SHell
ii  bsdutils       2.10o-1        Basic utilities from 4.4BSD-Lite.
ii  console-data   1999.08.29-12. Keymaps, fonts, charset maps, fallback ta=
ble
iF  console-tools  0.2.3-13       Linux console and font utilities.
ii  console-tools- 0.2.3-13       Shared libraries for Linux console and fo=
nt=20
ii  debianutils    1.13.3         Miscellaneous utilities specific to Debia=
n.
ii  dialog         0.9a-20000730- Displays user-friendly dialog boxes from =
she
ii  diff           2.7-21         File comparison utilities
ii  dpkg           1.6.14         Package maintenance system for Debian
ii  e2fsprogs      1.19-2         The EXT2 file system utilities and librar=
ies
ii  elvis-tiny     1.4-9          Tiny vi compatible editor for the base sy=
ste
ii  fbset          2.1-6          Framebuffer device maintenance program.
ii  fileutils      4.0z-2         GNU file management utilities.
ii  findutils      4.1-40         utilities for finding files--find, xargs,=
 an
ii  ftp            0.17-3         The FTP client.
ii  gawk           3.0.4-4        GNU awk, a pattern scanning and processin=
g l
ii  gettext-base   0.10.35-15     GNU Internationalization utilities for th=
e b
ii  grep           2.4.2-1        GNU grep, egrep and fgrep.
ii  gzip           1.2.4-33       The GNU compression utility.
ii  hostname       2.07           A utility to set/show the host name or do=
mai
ii  ifupdown       0.5.5pr-1      High level tools to configure network int=
erf
ii  info           4.0-4          Standalone GNU Info documentation browser
ii  ipchains       1.3.9-1        Network firewalling for Linux 2.2.x
ii  ldso           1.9.11-9       The Linux dynamic linker, library and uti=
lit
ii  less           358-3          A file pager program, similar to more(1)
ii  libc6          2.0.6-5lm      glibc fake entry. Please don't flame me i=
f i
ii  libgdbmg1      1.7.3-26.2     GNU dbm database routines (runtime versio=
n).
ii  libncurses5    5.0-7          Shared libraries for terminal handling
ii  libpam-modules 0.72-7         Pluggable Authentication Modules for PAM
ii  libpam-runtime 0.72-7         Runtime support for the PAM library
ii  libpam0g       0.72-7         Pluggable Authentication Modules library
ii  libpopt0       1.5-0.1        lib for parsing cmdline parameters
ii  libreadline4   4.1-1          GNU readline and history libraries, run-t=
ime
ii  libwrap0       7.6-5          Wietse Venema's TCP wrappers library
ii  login          19990827-19    System login tools
ii  makedev        2.3.1-46.2     Creates special device files in /dev.
ii  mawk           1.3.3-5        a pattern scanning and text processing la=
ngu
iU  modconf        0.2.27         Device Driver Configuration
ii  modutils       2.3.11-3       Linux module utilities.
ii  mount          2.10o-1        Tools for mounting and manipulating files=
yst
ii  ncurses-base   5.0-7          Descriptions of common terminal types
ii  ncurses-bin    5.0-7          Terminal-related programs and man pages
iU  netbase        4.05           Basic TCP/IP networking system
ii  netkit-inetd   0.10-3         The Internet Superserver
ii  netkit-ping    0.10-3         The ping utility from netkit
ii  passwd         19990827-19    Change and administer password and group =
dat
ii  pciutils       2.1.8-1        Linux PCI Utilities (for 2.[123].x kernel=
s)
ii  perl-5.005     5.005.03-7.1   Larry Wall's Practical Extracting and Rep=
ort
ii  perl-5.005-bas 5.005.03-7.1   The Pathologically Eclectic Rubbish Lister
iU  ppp            2.4.0f-1       Point-to-Point Protocol (PPP) daemon.
iU  pppconfig      2.0.5          A text menu based utility for configuring=
 pp
ii  procps         2.0.6-9        The /proc file system utilities.
ii  psmisc         19-2           Utilities that use the proc filesystem
ii  sed            3.02-6         The GNU sed stream editor.
ii  setserial      2.17-16        Controls configuration of serial ports.
ii  shellutils     2.0g-2         The GNU shell programming utilities.
ii  slang1         1.4.1-1        The S-Lang programming library - runtime =
ver
ii  sysklogd       1.3-33         Kernel and system logging daemons
ii  sysvinit       2.78-4         System-V like init.
ii  tar            1.13.17-2      GNU tar
ii  tasksel        1.0-10         New task packages selector
ii  tcpd           7.6-5          Wietse Venema's TCP wrapper utilities
iU  telnetd        0.16-4         The telnet server.
ii  textutils      2.0-3          The GNU text file processing utilities.
ii  update         2.11-1         daemon to periodically flush filesystem b=
uff
ii  util-linux     2.10o-1        Miscellaneous system utilities.

That's all;)

MfG, JBG
PS: Thanks Flo for the machine! Now, after switching off all swap, it's
    quite stable:
localhost:/packets# uptime=20
  6:59pm  up 1 day, 25 min,  0 users,  load average: 0.41, 1.87, 1.18

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjnwiI4ACgkQHb1edYOZ4btkxACeNnyy6Nt62p28Rv7Aw6vLyXsU
scUAniFScqPrPkeOSkZFbtyB1kbli/iE
=2cH0
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
