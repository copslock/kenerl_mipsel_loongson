Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2003 15:48:05 +0100 (BST)
Received: from noose.gt.owl.de ([IPv6:::ffff:62.52.19.4]:5137 "EHLO
	noose.gt.owl.de") by linux-mips.org with ESMTP id <S8225072AbTGPOsC>;
	Wed, 16 Jul 2003 15:48:02 +0100
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 148A225DCC; Wed, 16 Jul 2003 16:48:01 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id B2571138002; Wed, 16 Jul 2003 16:21:36 +0200 (CEST)
Date: Wed, 16 Jul 2003 16:21:36 +0200
From: Florian Lohoff <flo@rfc822.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: sudo oops on mips64 linux_2_4
Message-ID: <20030716142136.GA13810@paradigm.rfc822.org>
References: <20030716110735.GA10511@paradigm.rfc822.org> <Pine.GSO.3.96.1030716150225.25959B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030716150225.25959B-100000@delta.ds2.pg.gda.pl>
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Return-Path: <flo@paradigm.rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2003 at 03:05:05PM +0200, Maciej W. Rozycki wrote:
>  Please pass it through ksymoops for more details.  Version 2.4.9 should
> work just fine for mips64.

This looks still broken - Giving the vmlinux file to ksymoops makes it
even worse - tons or errors.

ksymoops 2.4.8 on mips 2.4.19-r5k-ip22.  Options used
     -v /dev/null (specified)
     -k /dev/null (specified)
     -l /dev/null (specified)
     -o /dev/null (specified)
     -m /home/flo/System.map (specified)

Error (regular_file): read_nm_symbols /dev/null is not a regular file, igno=
red
Warning (read_vmlinux): no kernel symbols in vmlinux, is /dev/null a valid =
vmlinux file?
Error (regular_file): read_ksyms /dev/null is not a regular file, ignored
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Cpu 0 Unable to handle kernel paging request at address 0000000000000000, e=
pc =3D=3D ffffffff88171104, ra =3D=3D ffffffff880159f0
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
epc     : ffffffff88171104    Not tainted
Using defaults from ksymoops -t elf32-tradbigmips -a mips:3000
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


>>PC;  ffffffff88171104 <END_OF_CODE+fffffffeffe868fc/????>   <=3D=3D=3D=3D=
=3D

Trace; ffffffff880157dc <END_OF_CODE+fffffffeffd2afd4/????>
Trace; ffffffff8801aeec <END_OF_CODE+fffffffeffd306e4/????>

Code;  881710f8 <fbmem_read_proc+d8/100>
00000000 <_PC>:
Code;  881710f8 <fbmem_read_proc+d8/100>
   0:   0085202f  0x85202f
Code;  881710fc <fbmem_read_proc+dc/100>
   4:   10c0fff2  beqz    a2,ffffffd0 <_PC+0xffffffd0>
Code;  88171100 <fbmem_read_proc+e0/100>
   8:   64c5ffff  0x64c5ffff
Code;  88171104 <fbmem_read_proc+e4/100>
   c:   a0800000  sb      zero,0(a0)
Code;  88171108 <fbmem_read_proc+e8/100>
  10:   64840001  0x64840001
Code;  8817110c <fbmem_read_proc+ec/100>
  14:   14a0fffd  bnez    a1,c <_PC+0xc>
Code;  88171110 <fbmem_read_proc+f0/100>
  18:   64a5ffff  0x64a5ffff
Code;  88171114 <fbmem_read_proc+f4/100>
  1c:   03e00008  jr      ra
Code;  88171118 <fbmem_read_proc+f8/100>
  20:   00000000  nop


1 warning and 2 errors issued.  Results may not be reliable.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/FV9wUaz2rXW+gJcRAq7IAKCIA2BRJuWgV3eWKO2Muhqlvswl/ACeJE+g
tj8Y1eNk+wTNqfQtePmPcL8=
=IVk1
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
