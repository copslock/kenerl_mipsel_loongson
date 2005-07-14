Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jul 2005 06:03:07 +0100 (BST)
Received: from go4.ext.ti.com ([IPv6:::ffff:192.91.75.132]:27839 "EHLO
	go4.ext.ti.com") by linux-mips.org with ESMTP id <S8226704AbVGNFCs> convert rfc822-to-8bit;
	Thu, 14 Jul 2005 06:02:48 +0100
Received: from dlep30.itg.ti.com ([157.170.139.157])
	by go4.ext.ti.com (8.13.1/8.13.1) with ESMTP id j6E53rIx001362;
	Thu, 14 Jul 2005 00:03:53 -0500 (CDT)
Received: from dlep90.itg.ti.com (localhost [127.0.0.1])
	by dlep30.itg.ti.com (8.12.11/8.12.11) with ESMTP id j6E53q3W022523;
	Thu, 14 Jul 2005 00:03:53 -0500 (CDT)
Received: from dbde01.ent.ti.com (localhost [127.0.0.1])
	by dlep90.itg.ti.com (8.12.11/8.12.11) with ESMTP id j6E53gWF013130;
	Thu, 14 Jul 2005 00:03:52 -0500 (CDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: Au1550 ethernet throughput low
Date:	Thu, 14 Jul 2005 10:32:22 +0530
Message-ID: <A8A67F242940E246A515077CF9ECACC16B16C4@dbde01.ent.ti.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Au1550 ethernet throughput low
Thread-Index: AcWHxJN7otZhA6qjRj+as9e/GuOp8AAbHDbg
From:	"Singh, Ajay" <ajaysingh@ti.com>
To:	<jaypee@hotpop.com>, "linux-mips" <linux-mips@linux-mips.org>
Return-Path: <ajaysingh@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ajaysingh@ti.com
Precedence: bulk
X-list: linux-mips

Is your driver on Linux 2.6 NAPI enabled ? And is CONFIG_PREEMPT=y?

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of jaypee@hotpop.com
Sent: Wednesday, July 13, 2005 9:30 PM
To: linux-mips
Subject: Au1550 ethernet throughput low

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,
I've got a au1550 board based largely on the pb1550. The ethernet
throughput is ~66Mbps using the 2.6 kernel. This also consumes a lot of
cpu cycles to send.

We have older designs using au1000 and mvista 2.4 kernel that achieve
full line rate throughput without using a lot of the cpu.

Can someone with a pb/db1550 and linux 2.6 do a quick test to verify
that is is not a 2.6 kernel problem, and is a problem with our HW/SW.

If anyone can do the same with a 2.4 kernel too that would be great.

Thanks,
JP

- --
mailto:jaypee@hotpop.com
http://www.jaypee.org.uk
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC1TqCZDxnKy3oOpYRAhwaAKCoY/3lEX/DksOEq42FfxlsF2rjEgCeNI0G
/72t16fNrA4XvX+KVumsNDw=
=yoD8
-----END PGP SIGNATURE-----
