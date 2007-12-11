Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Dec 2007 22:13:38 +0000 (GMT)
Received: from hydra.gt.owl.de ([195.71.99.218]:62181 "EHLO hydra.gt.owl.de")
	by ftp.linux-mips.org with ESMTP id S20022230AbXLKWN3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Dec 2007 22:13:29 +0000
Received: by hydra.gt.owl.de (Postfix, from userid 1000)
	id 6404B93703; Tue, 11 Dec 2007 23:13:27 +0100 (CET)
Date:	Tue, 11 Dec 2007 23:13:27 +0100
From:	Florian Lohoff <flo@rfc822.org>
To:	linux-mips@linux-mips.org
Subject: 2.6.24-rc2 crash in kmap_coherent
Message-ID: <20071211221327.GB2150@paradigm.rfc822.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
Organization: rfc822 - pure communication
X-SpiderMe: mh-200712112238@listme.rfc822.org
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
i just discovered that my native gcc build on one of my Indys stopped. I
found this in the dmesg ;)

Its a 2.6.24-rc2 on an R5k Indy 64M:

Kernel bug detected[#1]:
Cpu 0
$ 0   : 0000000000000000 ffffffff9000cce0 0000000000000001 ffffffff80000000
$ 4   : ffffffff8921f910 000000007fda0f05 000000007fda0f05 ffffffff8b8ea000
$ 8   : ffffffff89b4ef05 000000000000000e ffffffff8921f910 0000000000000f05
$12   : 0000000000000000 ffffffff80000008 ffffffff88090010 00000000004038b4
$16   : ffffffff8921f910 000000007fda0f05 ffffffff8b8ea000 000000000000000e
$20   : ffffffff8bdfb920 0000000000000000 ffffffff8bd88cc0 ffffffff8893fd58
$24   : 0000000000000006 ffffffff8801df00                                 =
=20
$28   : ffffffff8893c000 ffffffff8893fd20 ffffffff88430000 ffffffff8801c010
Hi    : 000000000001d1ea
Lo    : 0000000000009b4e
epc   : ffffffff8801bcf0 kmap_coherent+0x10/0x130     Not tainted
ra    : ffffffff8801c010 copy_from_user_page+0x40/0xb0
Status: 9000cce3    KX SX UX KERNEL EXL IE=20
Cause : 00000034
PrId  : 00002321 (R5000)
Modules linked in: dm_snapshot dm_mirror dm_mod ipv6
Process cat (pid: 14553, threadinfo=3Dffffffff8893c000, task=3Dffffffff88a5=
2660)
Stack : 000000000000000e 000000007fda0f05 ffffffff8b8ea000 0000000000000000
        ffffffff88079d10 ffffffff88079cc4 ffffffff8bfbd528 ffffffff8921f910
        ffffffff8bdfb980 ffffffff8b8ea000 ffffffff8bdfb920 0000000000000000
        ffffffff8b8ea000 000000000000000e ffffffff8bd88cc0 ffffffff8893fe78
        0000000000447000 000000000052c7d8 0000000000000000 ffffffff880d9014
        ffffffff8bd88cc0 ffffffff8b8ea000 fffffffffffffff4 ffffffff8b863248
        0000000000000400 ffffffff8893fe78 0000000000447000 ffffffff880db188
        ffffffff8be6f6e0 0000000000000400 0000000000447000 ffffffff8893fe78
        0000000000447000 0000000000000003 0000000000000016 ffffffff8808fbdc
        ffffffff8be6f6e0 0000000000000400 0000000000447000 fffffffffffffff7
        ...
Call Trace:
[<ffffffff8801bcf0>] kmap_coherent+0x10/0x130
[<ffffffff8801c010>] copy_from_user_page+0x40/0xb0
[<ffffffff88079d10>] access_process_vm+0x168/0x1d8
[<ffffffff880d9014>] proc_pid_cmdline+0xac/0x140
[<ffffffff880db188>] proc_info_read+0x108/0x150
[<ffffffff8808fbdc>] vfs_read+0xec/0x178
[<ffffffff88090060>] sys_read+0x50/0x98
[<ffffffff88019718>] handle_sys+0x118/0x134


Code: 0002127a  00021000  30420001 <00028036> 8f820024  3c038843  24420001 =
 af820024  dc62f390=20

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
	Those who would give up a little freedom to get a little=20
          security shall soon have neither - Benjamin Franklin

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHXwuHUaz2rXW+gJcRAr+bAJ4r9/1gtvh0RWnEE07Jyjmai60dngCdGGt/
PRqproX6zCL6OdY0ROAz/no=
=AQco
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
