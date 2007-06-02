Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Jun 2007 09:35:55 +0100 (BST)
Received: from smtp-ext.int-evry.fr ([157.159.11.17]:35984 "EHLO
	smtp-ext.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20025786AbXFBIfw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 2 Jun 2007 09:35:52 +0100
Received: from ibook.alphacore.home (florian.alphacore.net [82.67.132.19])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 00AFE8D16A2;
	Sat,  2 Jun 2007 10:35:17 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	saravanan sar <sar_van81@yahoo.co.in>
Subject: Re: {Spam} porting linux to DBau1200
Date:	Sat, 2 Jun 2007 10:35:08 +0200
User-Agent: KMail/1.9.6
Cc:	linux-mips@linux-mips.org
References: <858843.6401.qm@web94308.mail.in2.yahoo.com>
In-Reply-To: <858843.6401.qm@web94308.mail.in2.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2534517.S8akteklza";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200706021035.10229.florian.fainelli@telecomint.eu>
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

--nextPart2534517.S8akteklza
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

In the bootlog you pasted, I see no flash map being enabled for your device=
=2E=20

You might want to have a look at the AMD alchemy flash driver which should=
=20
provide you a basic mapping.

This driver is located in linux/drivers/mtd/maps/alchemy-flash.c and can be=
=20
enabled within Kconfig in the Device Driver / Memory Technology Device /=20
Mapping drivers for chip access.

Le samedi 2 juin 2007, saravanan sar a =E9crit=A0:
> hi,
>
> has anyone successfully ported linux to DBau1200 board ? here i have
> problem in mounting root filesystem. i compiled the linux kernel and got
> the vmlinuz image and ported to the board also. but when i boots up it
> shows the following error: YAMON> go
> Linux version 2.6.11-r000069-smp (root@suse) (gcc version 3.4.4) #8 Wed M=
ay
> 30 19:22:16 IST 2007 CPU revision is: 04030201
> AMD Alchemy Db1200 Board
> (PRId 04030201) @ 396MHZ
> Determined physical RAM map:
>  memory: 10000000 @ 00000000 (usable)
> Built 1 zonelists
> Kernel command line:  video=3Dau1200fb:panel:bs console=3DttyS0,115200
> Primary instruction cache 16kB, physically tagged, 4-way, linesize 32
> bytes. Primary data cache 16kB, 4-way, linesize 32 bytes.
> Synthesized TLB refill handler (17 instructions).
> Synthesized TLB load handler fastpath (34 instructions).
> Synthesized TLB store handler fastpath (34 instructions).
> Synthesized TLB modify handler fastpath (33 instructions).
> PID hash table entries: 2048 (order: 11, 32768 bytes)
> calculating r4koff... 00060ae0(396000)
> Using 396.000 MHz high precision timer.
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Memory: 255872k/262144k available (1894k kernel code, 6124k reserved, 337k
> data, 116k init, 0k highmem) Mount-cache hash table entries: 512 (order: =
0,
> 4096 bytes)
> Checking for 'wait' instruction...  unavailable.
> NET: Registered protocol family 16
> Au1XXX Real Time Clock Driver v1.0
> audit: initializing netlink socket (disabled)
> audit(120525897.203:0): initialized
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> Initializing Cryptographic API
> au1200fb: LCD controller driver for AU1200 processors<6>
> au1200fb: Panel 2 SVGA_800x600
> au1200fb: Win 2 0-FS gfx, 1-video, 2-ovly gfx, 3-ovly gfx
> Panel(SVGA_800x600), 800x600
> Console: switching to colour frame buffer device 100x75
> rtc: I/O resource 70 is not free.
> Serial: Au1x00 driver
> ttyS0 at I/O 0xb1100000 (irq =3D 0) is a AU1X00_UART
> ttyS1 at I/O 0xb1200000 (irq =3D 8) is a AU1X00_UART
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered
> RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
> netconsole: not configured, aborting
> NET: Registered protocol family 2
> IP: routing cache hash table of 2048 buckets, 16Kbytes
> TCP established hash table entries: 16384 (order: 5, 131072 bytes)
> TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
> TCP: Hash tables configured (established 16384 bind 16384)
> NET: Registered protocol family 1
> Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(1,0).
>
> . i searched in the google regarding this and found that this corresponds
> to root filesystem not found.
>
> can anyone provide me any suggestions or solutions for creating root
> filesystem and linking that with the kernel ?
>
> thanks in advance,
>
> saravanan.
>
>
> ---------------------------------
>  Did you know? You can CHAT without downloading messenger.  Know how!



=2D-=20
Cordialement, Florian Fainelli
=2D--------------------------------------------

--nextPart2534517.S8akteklza
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)

iD8DBQBGYSu+mx9n1G/316sRAr2bAJ9zI0B6cZ425WySU7+irFqzvIwZewCeOIBW
dWHlR2EidJNPLDYZUHbIojo=
=Z6wM
-----END PGP SIGNATURE-----

--nextPart2534517.S8akteklza--
