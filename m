Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 23:17:19 +0000 (GMT)
Received: from NAT.office.mind.be ([62.166.230.82]:52899 "EHLO
	nat.office.mind.be.") by ftp.linux-mips.org with ESMTP
	id S8133564AbWAXXQ7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jan 2006 23:16:59 +0000
Received: from p2 by codecarverwith local (Exim 3.36 #1 (Debian))
	id 1F1XTR-0001nO-00; Wed, 25 Jan 2006 00:21:17 +0100
Date:	Wed, 25 Jan 2006 00:21:17 +0100
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: DECstation R3000 boot error
Message-ID: <20060124232117.GA4165@codecarver>
Mail-Followup-To: peter.de.schrijver@mind.be,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
References: <20060123225040.GA23576@deprecation.cyrius.com> <Pine.LNX.4.64N.0601241059140.11021@blysk.ds.pg.gda.pl> <20060124122700.GA8527@deprecation.cyrius.com> <Pine.LNX.4.64N.0601241227290.11021@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0601241227290.11021@blysk.ds.pg.gda.pl>
X-Answer: 42
X-Operating-system: Debian GNU/Linux
X-Message-Flag:	Get yourself a real email client. http://www.mutt.org/
X-mate:	Mate, man gewoehnt sich an alles
User-Agent: Mutt/1.5.6+20040907i
From:	Peter 'p2' De Schrijver <p2@mind.be>
Return-Path: <p2@mind.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p2@mind.be
Precedence: bulk
X-list: linux-mips


--huq684BweRXVnRxX
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

>=20
>  Well, the console device was not specified at the Linux's command line=
=20
> and the kernel currently does not query REX variables to infer which=20
> device to use.  Please retry with "console=3DttyS2"; you may specify line=
=20
> parameters as required, too.  That may be compiled in if you run out of=
=20
> the BBU RAM space (which only allows up to 37 characters for kernel=20
> arguments).
>=20
>  The output you got was produced with the early console which uses REX=20
> primitives.

Ok. This results in the following panic :

>>boot 3/tftp/vmlinux-pmax console=3DttyS2
=20
 -tftp boot(3), bootp 10.42.0.190:/tftpboot/vmlinux-pmax
 -tftp load 3080326+0+114586
 Linux version 2.6.15 (tbm@deprecation) (gcc version 4.0.3 20051201
 (prerelease) (Debian 4.0.2-5)) #2 Tue Jan 24 23:08:47 GMT 2006
 This is a DECstation 5000/2x0
 CPU revision is: 00000230
 FPU revision is: 00000340
 Determined physical RAM map:
memory: 0c000000 @ 00000000 (usable)
Built 1 zonelists
Kernel command line: console=3DttyS2
Primary instruction cache 64kB, linesize 4 bytes.
Primary data cache 64kB, linesize 4 bytes.
Synthesized TLB refill handler (17 instructions).
Synthesized TLB load handler fastpath (31 instructions).
Synthesized TLB store handler fastpath (31 instructions).
Synthesized TLB modify handler fastpath (25 instructions).
PID hash table entries: 1024 (order: 10, 16384 bytes)
Using 24.999 MHz high precision timer.}SZ=B7]=BC0 @ 00000000 (usable)
Built 1 zonelists
Kernel command line: console=3DttyS2
Primary instruction cache 64kB, linesize 4 bytes.
Primary  cache 64kB, linesize 4 bytes.
Synthesized TLB refill handler (17 instructions).
Synthesized TLB load handler fastpath (31 instructions).
Synthesized TLB store handler fastpath (31 instructions).
Synthesized TLB modify handler fastpath (25 instructions).
PID hash table entries: 1024 (order: 10, 16384 bytes)
Using 24.999 MHz high precision timer.
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Reserved instruction in kernel code[#1]:
Cpu 0
$ 0   : 00000000 1008ec00 80000000 00000010
$ 4   : 8034e000 00000001 8034f000 00000000
$ 8   : 0000bae0 802e1740 00000044 ffffc000
$12   : 00000078 81178018 802e17f4 00000005
$16   : 810069c0 00000001 810069c0 80340000
$20   : 00000000 1008ec01 00000001 00000001
$24   : 802a69d8 00000000
$28   : 802dc000 802ddea0 00029cf1 8009a88c
Hi    : 00000000
Lo    : 00000000
epc   : 80332384 0x80332384     Not tainted
ra    : 8009a88c get_page_from_freelist+0x4b0/0x548
Status: 1008ec04    IEp
Cause : 30000028
PrId  : 00000230
Modules linked in:
Process swapper (pid: 0, threadinfo=3D802dc000, task=3D802de000)
Stack : 00000048 8117a018 802e17c4 00000005 00000044 8117a800 00000000 0000=
0000
        00000000 802e1be0 802e1be0 802de000 000080d0 a000fcec 00000000 802e=
1be0
        00000000 fdbcbd7e 00000000 8009a9b8 000280d0 00000000 00000000 0000=
0044
        8031cd84 8031cd4c 00000010 00000000 000280d0 00000000 00000080 802d=
df18
        00000000 80340000 80340000 a000fcec 00000000 00000003 00000000 fdbc=
bd7e
        ...
Call Trace:
 [<8009a9b8>] __alloc_pages+0x94/0x3cc
 [<8031cd84>] __free_pages_bootmem+0x128/0x144
 [<8031cd4c>] __free_pages_bootmem+0xf0/0x144
 [<8009b440>] __get_free_pages+0x3c/0x8c
 [<8004e414>] setup_zero_pages+0x34/0x1ac
 [<80313b74>] mem_init+0x5c/0x1ac
 [<8031ed8c>] inode_init_early+0xa8/0xc0
 [<8030c440>] start_kernel+0x140/0x21c
 [<8030c000>] _sinittext+0x0/0x7c
 [<8030c448>] start_kernel+0x148/0x21c
 [<8030c530>] unknown_bootoption+0x0/0x374


Code: 00000000  00000000  24861000 <fc800000> fc800008  fc800010 fc800018  =
24840040  fc80ffe0
Kernel panic - not syncing: Attempted to kill the idle task!

L & L

p2.

--=20
goa is a state of mind

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD1rZtKLKVw/RurbsRAmk/AJwOUll20pDZ7NsxktrC6kWBfZoDLwCeIsbv
U1rnd8Rk9amStTGUTh+mOf4=
=0Cra
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
