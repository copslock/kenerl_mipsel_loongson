Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAQNksR28962
	for linux-mips-outgoing; Mon, 26 Nov 2001 15:46:54 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAQNkjo28954
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 15:46:45 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 9A05A853; Mon, 26 Nov 2001 23:46:39 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 775373F45; Mon, 26 Nov 2001 23:46:17 +0100 (CET)
Date: Mon, 26 Nov 2001 23:46:17 +0100
From: Florian Lohoff <flo@rfc822.org>
To: debian-mips@lists.debian.org, debian-boot@lists.debian.org
Cc: linux-mips@oss.sgi.com
Subject: failed installation debian-mipsel (Decstation 5000/150)
Message-ID: <20011126234617.D13081@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
i am just trying to install debian-mipsel on a Decstation 5000/150=20
with the bootfloppies 3.0.15-2001-10-19.

I am working on serial console and dont have a framebuffer nor a
keyboard.

At first the installation misses a short "Howto boot a decstation over
the net" which is not that trivial.

At least this should be mentioned:

echo 4096 >/proc/sys/net/ipv4/neigh/eth0/retrans_time

and something along that you need to set a console as the kernel is not
able to autodetect the console.

The kernel hangs for me at the detection of the LK Keyboard (which
is not attached)

-------------------------------------------------
>>boot 3/tftp/boot/kn04tftpboot.img console=3DttyS2

-tftp boot(3), bootp 195.71.97.238:/boot/kn04tftpboot.img
-tftp load 1679360+1970176+198224
This DECstation is a DS5000/1xx
Loading R4000 MMU routines.
CPU revision is: 00000430
Primary instruction cache 8kb, linesize 16 bytes.
Primary data cache 8kb, linesize 16 bytes.
Secondary cache sized at 1024K linesize 32 bytes.
Linux version 2.4.5-r4k-kn04 (root@repeat.rfc822.org) (gcc version
2.95.4 200101Determined physical RAM map:
memory: 04000000 @ 00000000 (usable)
Initial ramdisk at: 0x80203000 (1800109 bytes)
On node 0 totalpages: 16384                                                =
   =20
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=3DttyS2
Console: colour dummy device 80x25
Calibrating delay loop... 49.75 BogoMIPS
Memory: 60392k/65536k available (1632k kernel code, 5144k reserved, 1847k d=
ata,)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
TURBOchannel rev. 1 at 12.5 MHz (without parity)
slot 0: DEC      PMAZ-AA  V5.3d
slot 1: DEC      PMAZ-AA  V5.3b
slot 2: DEC      PMAF-FA  V1.1
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
DECstation Z8530 serial driver version 0.05
DECstation LK keyboard driver v0.04...=20
---------------------------------------------------------------

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8AsY5Uaz2rXW+gJcRAi/ZAJ0VlwNL1Sp2fZRdXoetARrPgXfOiQCgrmJ4
uMy7fAltCrZ1rAUcvDkHGWA=
=zK3j
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--
