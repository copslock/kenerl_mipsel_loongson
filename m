Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Sep 2005 23:01:16 +0100 (BST)
Received: from NAT.office.mind.be ([62.166.230.82]:49044 "EHLO
	NAT.office.mind.be") by ftp.linux-mips.org with ESMTP
	id S8133448AbVIXWBA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Sep 2005 23:01:00 +0100
Received: (qmail 11431 invoked from network); 24 Sep 2005 22:00:56 -0000
Received: from localhost (HELO codecarver) ([127.0.0.1])
          (envelope-sender <p2@debian.org>)
          by localhost (qmail-ldap-1.03) with SMTP
          for <linux-mips@linux-mips.org>; 24 Sep 2005 22:00:56 -0000
Received: from p2 by codecarver with local (Exim 3.36 #1 (Debian))
	id 1EJI19-0002EG-00
	for <linux-mips@linux-mips.org>; Sat, 24 Sep 2005 23:57:11 +0200
Date:	Sat, 24 Sep 2005 23:57:10 +0200
To:	linux-mips@linux-mips.org
Subject: Bus error on sb1250
Message-ID: <20050924215710.GA6310@codecarver>
Mail-Followup-To: peter.de.schrijver@mind.be, linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
X-Answer: 42
X-Operating-system: Debian GNU/Linux
X-Message-Flag:	Get yourself a real email client. http://www.mutt.org/
X-mate:	Mate, man gewoehnt sich an alles
User-Agent: Mutt/1.5.6+20040907i
From:	Peter 'p2' De Schrijver <p2@debian.org>
Return-Path: <p2@debian.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p2@debian.org
Precedence: bulk
X-list: linux-mips


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm seeing some strange bus errors when trying to get the Fore
ForeRunner PCA-200EPC card to work on the sibyte swarm. The driver polls
a register on this card for status information. This triggers a bus
error once in a while. This happens regardless if the card is attached
to the PCI bus of the sb1250 or to the PCI bus behind the Alliance HT -
PCI bridge.=20

The bus error dump looks as follows :

DBE physical address: 0041000400
Data bus error, epc =3D=3D c12f8214, ra =3D=3D c13533d4
Oops in arch/mips/kernel/traps.c::do_be, line 361[#1]:
Cpu 0
$ 0   : 00000000 00000004 c12f820c c12fac20
$ 4   : c1400404 ffffffff 00ff0000 00000000
$ 8   : 00000000 00000000 00000000 8d903d48
$12   : 00000010 8d903c54 00000000 ffffffff
$16   : fffffed8 80350000 fffd59a9 c1350000
$20   : 8d410000 c1400404 803a7900 01000000
$24   : ffffffff 00000004
$28   : 8d902000 8d903cd8 c1300000 c13533d4
Hi    : 00040fff
Lo    : fb4d8000
epc   : c12f8214 fore200e_pca_read+0x8/0x54 [fore_200e]     Not tainted
ra    : c13533d4 fore200e_monitor_getc+0x9c/0x10c [fore_200e]
Status: 10001f03    KERNEL EXL IE
Cause : 0080801c
PrId  : 01040102
Modules linked in: fore_200e videodev nfsd exportfs lockd sunrpc md5 ipv6 i=
de_cs
eth1394 ohci1394 ieee1394 ehci_hcd usbhid ohci_hcd usbcore clip atm ide_cd=
=20
cdrom genrtc
Process insmod (pid: 2473, threadinfo=3D8d902000, task=3D8f66c500)
Stack : 000024ae 8d410020 c1300000 80201ac4 c1353338 8d903d41 8d410000 c135=
0000
        01000000 8d410020 c1300000 80201ac4 c1353690 c13535dc 803a892a 1000=
1f01
        000056c0 00000000 00000000 2ac23ae0 81298ea0 00000030 8d903db4 c12f=
e220
        ffffffff ffffffff 0d676f20 35366330 0d003dd0 8d410029 ffffffff ffff=
ffff
        ffffffff 00000002 c1300000 41000000 0000000a ffffffff ffffffff 0000=
0002
        ...=20
Call Trace:=20
 [<c1300000>] inet6_release+0x0/0x78 [ipv6]
 [<80201ac4>] sprintf+0x0/0x3c
 [<c1353338>] fore200e_monitor_getc+0x0/0x10c [fore_200e]
 [<c1300000>] inet6_release+0x0/0x78 [ipv6]
 [<80201ac4>] sprintf+0x0/0x3c
 [<c1353690>] fore200e_init+0x24c/0xd38 [fore_200e]
 [<c13535dc>] fore200e_init+0x198/0xd38 [fore_200e]
 [<c1300000>] inet6_release+0x0/0x78 [ipv6]
 [<c1300000>] inet6_release+0x0/0x78 [ipv6]
 [<80201ac4>] sprintf+0x0/0x3c
 [<c1300000>] inet6_release+0x0/0x78 [ipv6]
 [<80201ac4>] sprintf+0x0/0x3c
 [<c1300000>] inet6_release+0x0/0x78 [ipv6]
 [<c12f9f34>] fore200e_pca_detect+0x150/0x204 [fore_200e]
 [<80130000>] release_resource+0x1c/0xbc
 [<8021386c>] pci_device_probe+0x80/0xa4
 [<802137dc>] pci_bus_match+0x18/0x28
 [<8025427c>] driver_probe_device+0x58/0xf0
 [<80314dd0>] klist_next+0x4c/0x80
 [<80254490>] __driver_attach+0x9c/0xc4
 [<802543f4>] __driver_attach+0x0/0xc4
 [<802534b4>] next_device+0x10/0x2c
 [<802543f4>] __driver_attach+0x0/0xc4
 [<80253520>] bus_for_each_dev+0x50/0xb4
 [<80130000>] release_resource+0x1c/0xbc
 [<801fd860>] kobject_register+0x48/0x90
 [<80253b44>] bus_add_driver+0x9c/0x1a4
 [<80213400>] pci_register_driver+0x7c/0xcc
 [<801239d8>] default_wake_function+0x0/0x20
 [<c13542b0>] fore200e_module_init+0x134/0x1ac [fore_200e]
 [<80143634>] kthread_stop+0xc0/0x13c
 [<8014c778>] sys_init_module+0x158/0x39c
 [<8014c740>] sys_init_module+0x120/0x39c
 [<80175f44>] filp_close+0x6c/0xb0
 [<8010bacc>] stack_done+0x20/0x3c
 [<8010bacc>] stack_done+0x20/0x3c


Code: 00000000  8c850000  3c0600ff <30a4ff00> 00051600  00a61824 00052e02 =
=20
      00042200  00441025

Any idea why this might be happening ?

Thanks,

Peter (p2).

--=20
goa is a state of mind

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFDNcu2KLKVw/RurbsRAuVaAJ0UXb2xncNAeTzBtfrqyyPD06eGlACdFHwp
xqx9nXgrTwHtEikmNSjuGaI=
=hWSz
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
