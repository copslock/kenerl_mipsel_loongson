Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Aug 2011 18:46:34 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43826 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491188Ab1H2Qq0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Aug 2011 18:46:26 +0200
Received: from lump.einval.com ([78.32.9.209] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <ben@decadent.org.uk>)
        id 1Qy4ye-0004Mq-51; Mon, 29 Aug 2011 17:46:24 +0100
Received: from ben by deadeye with local (Exim 4.76)
        (envelope-from <ben@decadent.org.uk>)
        id 1Qy4ya-0002mX-JX; Mon, 29 Aug 2011 17:46:20 +0100
Subject: Re: Bug#639706: linux-image-2.6-4kc-malta: version 3.0.0-1 doesn't
 boot on qemu
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     639706@bugs.debian.org, Klaus Treichel <ktreichel@web.de>,
        linux-mips@linux-mips.org
Date:   Mon, 29 Aug 2011 17:46:15 +0100
In-Reply-To: <20110829152936.1097.42281.reportbug@debian-mipsel.ktreichel.local>
References: <20110829152936.1097.42281.reportbug@debian-mipsel.ktreichel.local>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-ZH3tMr1H2BPwGsXFV2Fi"
X-Mailer: Evolution 3.0.2- 
Message-ID: <1314636380.3092.32.camel@deadeye>
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 78.32.9.209
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-archive-position: 31007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21600


--=-ZH3tMr1H2BPwGsXFV2Fi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2011-08-29 at 17:29 +0200, Klaus Treichel wrote:
> Package: linux-image-2.6-4kc-malta
> Version: 3.0.0+39
> Severity: important
>=20
> version 3.0.0-1 (also 2.6.39-2) don't boot in qemu.
> They panic with this output:

I think this was broken by:

commit af3a1f6f4813907e143f87030cde67a9971db533
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Tue Mar 29 11:43:19 2011 +0200

    MIPS: Malta: Fix GCC 4.6.0 build error

arch_init_irq() requires that gcmp_probe() has been called.  But the
call to gcmp_probe() is now dependent on CONFIG_MIPS_CMP, which is not
set for our 4kc-malta flavour.

Ben.

> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Linux version 3.0.0-1-4kc-malta (Debian 3.0.0-1) (ben@deca=
dent.org.uk) (gcc version 4.5.3 (Debian 4.5.3-3) ) #1 Mon Jul 25 14:35:25 U=
TC 2011
> [    0.000000] bootconsole [early0] enabled
> [    0.000000] CPU revision is: 00019300 (MIPS 24Kc)
> [    0.000000] FPU revision is: 00000000
> [    0.000000] Determined physical RAM map:
> [    0.000000]  memory: 00001000 @ 00000000 (reserved)
> [    0.000000]  memory: 000ef000 @ 00001000 (ROM data)
> [    0.000000]  memory: 00616000 @ 000f0000 (reserved)
> [    0.000000]  memory: 0f8fa000 @ 00706000 (usable)
> [    0.000000] Wasting 57536 bytes for tracking 1798 unused pages
> [    0.000000] Initrd not found or empty - disabling initrd
> [    0.000000] Zone PFN ranges:
> [    0.000000]   DMA      0x00000000 -> 0x00001000
> [    0.000000]   Normal   0x00001000 -> 0x00010000
> [    0.000000] Movable zone start PFN for each node
> [    0.000000] early_node_map[1] active PFN ranges
> [    0.000000]     0: 0x00000000 -> 0x00010000
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  To=
tal pages: 65024
> [    0.000000] Kernel command line: root=3D/dev/sda1 console=3DttyS0
> [    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 b=
ytes)
> [    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 byt=
es)
> [    0.000000] Primary instruction cache 2kB, VIPT, 2-way, linesize 16 by=
tes.
> [    0.000000] Primary data cache 2kB, 2-way, VIPT, no aliases, linesize =
16 bytes
> [    0.000000] Writing ErrCtl register=3D00000000
> [    0.000000] Readback ErrCtl register=3D00000000
> [    0.000000] Memory: 252660k/254952k available (4253k kernel code, 2292=
k reserved, 1192k data, 236k init, 0k highmem)
> [    0.000000] NR_IRQS:256
> [    0.000000] CPU 0 Unable to handle kernel paging request at virtual ad=
dress 00000080, epc =3D=3D 80655a3c, ra =3D=3D 80655a1c
> [    0.000000] Oops[#1]:
> [    0.000000] Cpu 0
> [    0.000000] $ 0   : 00000000 10000000 00000000 1bdc0001
> [    0.000000] $ 4   : 00000018 10000000 00000001 00000000
> [    0.000000] $ 8   : 00000000 007cffff 8fc09000 00000000
> [    0.000000] $12   : 00000001 8fc0679c ffffffff fffffffc
> [    0.000000] $16   : 80680425 80680000 80690000 80690000
> [    0.000000] $20   : 00000000 00000000 00000000 00000000
> [    0.000000] $24   : 00000000 00000000                 =20
> [    0.000000] $28   : 80618000 80619ec0 00000000 80655a1c
> [    0.000000] Hi    : 00000000
> [    0.000000] Lo    : 00000000
> [    0.000000] epc   : 80655a3c arch_init_irq+0x38/0x168
> [    0.000000]     Not tainted
> [    0.000000] ra    : 80655a1c arch_init_irq+0x18/0x168
> [    0.000000] Status: 10000002    KERNEL EXL=20
> [    0.000000] Cause : 0080000c
> [    0.000000] BadVA : 00000080
> [    0.000000] PrId  : 00019300 (MIPS 24Kc)
> [    0.000000] Modules linked in:
> [    0.000000] Process swapper (pid: 0, threadinfo=3D80618000, task=3D806=
1da80, tls=3D00000000)
> [    0.000000] Stack : 80680000 80690000 80690000 00000000 00000000 80680=
425 80680000 806527d8
> [    0.000000]         00000000 8067c1f8 ffffffff 80695cf4 8065221c 00000=
000 80680408 00000000
> [    0.000000]         8067c1f8 00000000 00000000 00000000 00000000 00000=
000 00000000 8051c090
> [    0.000000]         00000000 00000000 00000000 00000000 00000000 00000=
000 00000000 00000000
> [    0.000000]         00000000 00000000 00000000 00000000 00000000 00000=
000 00000000 00000000
> [    0.000000]         ...
> [    0.000000] Call Trace:
> [    0.000000] [<80655a3c>] arch_init_irq+0x38/0x168
> [    0.000000] [<806527d8>] start_kernel+0x250/0x434
> [    0.000000] [<8051c090>] kernel_entry+0x0/0xa0
> [    0.000000]=20
> [    0.000000]=20
> [    0.000000] Code: 8c42e044  3c031bdc  24630001 <ac430080> 24030001  3c=
028069  081956a0  ac43e040  8c43e01c=20
> [    0.000000] Disabling lock debugging due to kernel taint
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle tas=
k!
>=20
> Last known kernel that boots ok is 3.6.32-5
>=20
> -- System Information:
> Debian Release: wheezy/sid
>   APT prefers testing
>   APT policy: (500, 'testing')
> Architecture: mipsel (mips)
>=20
> Kernel: Linux 2.6.32-5-4kc-malta
> Locale: LANG=3DC, LC_CTYPE=3DC (charmap=3DANSI_X3.4-1968)
> Shell: /bin/sh linked to /bin/dash
>=20
> Versions of packages linux-image-2.6-4kc-malta depends on:
> ii  linux-image-4kc-malta         3.0.0+39   Linux for MIPS Malta (meta-p=
ackage
>=20
> linux-image-2.6-4kc-malta recommends no packages.
>=20
> linux-image-2.6-4kc-malta suggests no packages.
>=20
> -- no debconf information
>=20
>=20
>=20

--=20


--=-ZH3tMr1H2BPwGsXFV2Fi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUATlvCV+e/yOyVhhEJAQqSVA/9HMsyyy0lUThOixgDmQoye4w8j5EzRwBp
M6lG+b6XBIXTTXLckaK2vy7ilVemyPDPS6Z3XIy8QTOoh7fJlQYkyuhMCieuVUV4
c2K01iToDEQS8OP8Znqxs+eqRcF+QuHeD+nv3c7ZUP8HOEDFwVe82Qg6jbbD6S3v
2oFtpZe6OSyYyQcY0sgo/8weqvGF28WYVdYbGcijyhfEvnxF7ZybbS26wnBvH4PB
HrCWxz+l/Go/RfgAGlKsMkQ0qNaMcTuLiDq61Rj6NB2ZRkw7sTL5iZ5YZV61hY/y
QCFsNdw2t0RQY3ZWXM3ab7DQvBfr+AWF+jgwT4HfCPjkBER5lGPgo/tD9R+22qY5
GzICvCXjc7RWDB+haT4+qD61/XQh0786fnktehQexk9rIoLO0GfiP7mrFoMqGeys
q5KhPgwtrvKmoUFXsrJGNTZG85d7KzhFmsbm5uMqK+RV0+uc51NBqB3L4zKg23K0
pjpQfsQW5sbwL8Bz837ogwuGqZIT2ahtaV9R9CCCy14CK+UHut3vA+9xF8I3ncEj
waUrqKrPZsS+OhGHWTNJvXZyfxEUtvVfwhlRNokKlwzbskCX1xKuPt3H/0/DH3o3
ruUnX+lxyHTwQpGmN6fuqE70zotDn8M7KJvyXmeQo/RgX/LnL05B1DkDgip4ikA0
nbyJxB/YGHQ=
=52mH
-----END PGP SIGNATURE-----

--=-ZH3tMr1H2BPwGsXFV2Fi--
