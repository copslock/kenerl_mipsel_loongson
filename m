Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2003 12:07:42 +0100 (BST)
Received: from noose.gt.owl.de ([IPv6:::ffff:62.52.19.4]:58379 "EHLO
	noose.gt.owl.de") by linux-mips.org with ESMTP id <S8225072AbTGPLHk>;
	Wed, 16 Jul 2003 12:07:40 +0100
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 9031F25E14; Wed, 16 Jul 2003 13:07:38 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 2ADA0138002; Wed, 16 Jul 2003 13:07:35 +0200 (CEST)
Date: Wed, 16 Jul 2003 13:07:35 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@linux-mips.org
Subject: sudo oops on mips64 linux_2_4
Message-ID: <20030716110735.GA10511@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Return-Path: <flo@paradigm.rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
i am getting this oops running anything with "sudo" on a mips64 sgi indy.
This is -r linux_2_4 of yesterday. Module support is not compiled in

strace output up to the oops is this:

[...]
old_mmap(NULL, 321040, PROT_READ|PROT_EXEC, MAP_PRIVATE, 0, 0) =3D 0x2adc80=
00
mprotect(0x2add7000, 259600, PROT_NONE) =3D 0
old_mmap(0x2ae16000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, =
0) =3D
0x2ae16000
close(3)                                =3D 0
open("/lib/libnsl.so.1", O_RDONLY)      =3D 3
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1024) =
=3D 1024
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D100028, ...}) =3D 0
old_mmap(NULL, 363472, PROT_READ|PROT_EXEC, MAP_PRIVATE, 0, 0) =3D 0x2ae180=
00
mprotect(0x2ae2f000, 269264, PROT_NONE) =3D 0
old_mmap(0x2ae6e000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, =
0x16000) =3D 0x2ae6e000
old_mmap(0x2ae6f000, 7120, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_=
ANONYMOUS, 3, 0x16000) =3D 0x2ae6f000
close(3)                                =3D 0
munmap(0x2aac4000, 9572)                =3D 0
uname({sys=3D"Linux", node=3D"debian", ...}) =3D 0
open("/etc/passwd", O_RDONLY)           =3D 3
fcntl64(3, F_GETFD)                     =3D 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         =3D 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) =3D 4
ioctl(4, 0x8912Oops in fault.c::do_page_fault, line 231:
Cpu 0

debian:~# sudo ls
Cpu 0 Unable to handle kernel paging request at address 0000000000000000, e=
pc =3D=3D ffffffff88171104, ra =3D=3D ffffffff880159f0

These are by the System.map
	ffffffff88171104 l_exc
	ffffffff880159f0 dev_ifconf

Oops in fault.c::do_page_fault, line 231:
Cpu 0
$0      : 0000000000000000 ffffffff881e0000 0000000000000020 00000000000000=
00
$4      : 0000000000000000 ffffffff881dffff ffffffff881e0000 00000000000000=
20
$8      : 0000000000000000 0000000000000000 0000000000000000 00000000000000=
00
$12     : 0000000000000000 0000000000000001 0000000000000028 00000000000000=
03
$16     : ffffffffffffffff 000000007fff7a20 0000000000000000 000000007fff7a=
28
$20     : 0000000000000004 000000007fff7aa0 000000007fff7b60 000000007fff7b=
f0
$24     : 0000000000000000 000000002ad0d6f0
$28     : ffffffff8a188000 ffffffff8a18be30 000000007fff7c80 ffffffff880159=
f0
Hi      : 0000000000000040
Lo      : 0000000000000010
epc     : ffffffff88171104    Not tainted
badvaddr: 0000000000000000
Status  : b000cce3  [ KX SX UX KERNEL EXL IE ]
Cause   : 0000000c
Process sudo (pid: 225, stackpage=3Dffffffff8a188000)
Stack: 0000004000000000 000000050000013a 000000505d00f61c 0000000000000000
       ffffffff881cdd08 0000000000008912 ffffffff8a231a80 000000007fff7a20
       ffffffff880157dc 0000000000000002 000000007fff7e34 0000000000000004
       0000000000000004 000000007fff7a64 000000007fff7a60 ffffffff8801aeec
       0000000000000000 00000000100006c0 0000000000000fd6 0000000000000000
       0000000000000004 0000000000008912 000000007fff7a20 0000000000000000
       0000000000000000 0000000000000000 0000000010003ec0 0000000000000010
       000000002adc3f44 000000002adc3f44 0000000020666f72 0000000020256820
       000000007fff7e34 0000000000000001 0000000000000001 0000000000000002
       0000000000000000 000000007fff7aa0 000000007fff7b60 000000007fff7bf0
       0000000000000006 ...
Call Trace: [<ffffffff880157dc>] [<ffffffff8801aeec>]

Code: 0085202f  10c0fff2  64c5ffff <a0800000> 64840001  14a0fffd  64a5ffff =
 03e00008  00000000
Segmentation fault

--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/FTH3Uaz2rXW+gJcRAg3vAJ9Sh+yPwcEIumXuMgV75+sg9ADx/ACfaP5O
nPI3eArRIJC/11oAmZQkmnI=
=JIyt
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
