Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 15:31:23 +0000 (GMT)
Received: from spider.morgul.net ([128.30.28.25]:19947 "EHLO spider.morgul.net")
	by ftp.linux-mips.org with ESMTP id S20029471AbYANPbP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Jan 2008 15:31:15 +0000
Received: from frodo by spider.morgul.net with local (Exim 4.63)
	(envelope-from <frodo@morgul.net>)
	id 1JERHO-0002qT-BU
	for linux-mips@linux-mips.org; Mon, 14 Jan 2008 10:31:14 -0500
Date:	Mon, 14 Jan 2008 10:31:14 -0500
To:	linux-mips@linux-mips.org
Subject: memory related kernel bug on cobalt raq2
Message-ID: <20080114153114.GN3899@morgul.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3FyYKcuUbgqNYeqV"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Noah Meyerhans <frodo@morgul.net>
Return-Path: <frodo@morgul.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: frodo@morgul.net
Precedence: bulk
X-list: linux-mips


--3FyYKcuUbgqNYeqV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all.  I know this has come up in the past, but in case it's helpful, I
figured I'd report that the kernel bug previously reported at (at least)
http://www.linux-mips.org/archives/linux-mips/2007-10/msg00093.html is still
present in current git kernels (more recently observed in
2.6.24-rc7-raq2-gaeb7040e-dirty).  Here's the kernel output:

Kernel bug detected[#1]:
Cpu 0
$ 0   : 00000000 b000ec00 00000001 00000004
$ 4   : 81107760 7fb60f09 0000000e 83fb6000
$ 8   : 00000f09 7fb60f09 800f5fe8 00000000
$12   : 00000000 00000000 83ea6cc0 004038b4
$16   : 81107760 0000000e 83fb6000 7fb60f09
$20   : 803c0000 8fdf2cc0 00000000 86015e28
$24   : 00000006 8008d480
$28   : 86014000 86015de0 86015e2c 8008b2cc
Hi    : 00000000
Lo    : 00000000
epc   : 8008af9c kmap_coherent+0xc/0xe0     Not tainted
ra    : 8008b2cc copy_from_user_page+0xb0/0xe4
Status: b000ec03    KERNEL EXL IE
Cause : 00800034
PrId  : 000028a0 (Nevada)
Process cat (pid: 5739, threadinfo=86014000, task=804b9178)
Stack : 8fdf2cc0 7fb60f09 83fb6000 0000000e 0000000e 7fb60f09 83fb6000 00000000
        0000000e 800e0484 8fc75178 804b9178 000800d0 00000000 883bbf09 0000000e
        86015e2c 86015e28 8fe0dbfc 81107760 8fdf2cf4 00000000 8fdf2cc0 00000000
        0000000e 83fb6000 00000400 8fc75178 00001000 0052c7c8 00000000 80133f5c
        8fc75178 8fa26704 83fb6000 86015f18 00000000 0052c7c8 8fc75178 83fb6000
        ...
Call Trace:
[<8008af9c>] kmap_coherent+0xc/0xe0
[<8008b2cc>] copy_from_user_page+0xb0/0xe4
[<800e0484>] access_process_vm+0x178/0x21c
[<80133f5c>] proc_pid_cmdline+0xa4/0x14c
[<80136300>] proc_info_read+0x104/0x144
[<800f5a7c>] vfs_read+0xc0/0x160
[<800f603c>] sys_read+0x54/0xa0
[<80088cac>] stack_done+0x20/0x3c


Code: 8c820000  00021242  30420001 <00028036> 8f820014  3c03803d  24420001  af820014  8c62f2a0

Thanks.
noah


--3FyYKcuUbgqNYeqV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHi4BCYrVLjBFATsMRAvYyAJ0bwpxVmIF82B1VWfjsFg8tSwxTcwCfQRI1
eOS8jjkT6kCtjq1QoNliTkE=
=FDk5
-----END PGP SIGNATURE-----

--3FyYKcuUbgqNYeqV--
