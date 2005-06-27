Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2005 11:08:49 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.171]:37825
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225940AbVF0KIe>; Mon, 27 Jun 2005 11:08:34 +0100
Received: from pD95289E9.dip0.t-ipconnect.de [217.82.137.233] (helo=gaspode.madsworld.lan)
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0MKwh2-1DmqX10Bf3-0003Gk; Mon, 27 Jun 2005 12:07:59 +0200
Received: from mad by gaspode.madsworld.lan with local (Exim 4.50)
	id 1DmqX0-0007Cc-45
	for linux-mips@linux-mips.org; Mon, 27 Jun 2005 12:07:58 +0200
Date:	Mon, 27 Jun 2005 12:07:58 +0200
From:	Markus Dahms <mad@automagically.de>
To:	linux-mips@linux-mips.org
Subject: 2.6 on IP22 (Indy)
Message-ID: <20050627100757.GA27679@gaspode.automagically.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:896705dcda322f33ae3752a7fdb3dc09
Return-Path: <mad@automagically.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mad@automagically.de
Precedence: bulk
X-list: linux-mips

Hi there,

I'm trying to run a current 2.6 kernel (LinuxMIPS CVS) on my
Indy(s). It should be a 64-bit kernel (just for fun, but I tried
32-bit, too). From the mailing list archives some time ago (about
half a year) I learned that there are known problems.

My experiments: Indy with R4600PC (133MHz) boots to userspace

| ...
| EXT3-fs: mounted filesystem with ordered data mode.
| atkbd.c: keyboard reset failed on hpc3ps2/serio0
| VFS: Mounted root (ext3 filesystem) readonly.
| Freeing unused kernel memory: 204k freed
| INIT: version 2.86 booting

and dies then :(. The same machine, but with a R4000PC (100MHz)
processor module doesn't even come so far:

| arcsboot: ARCS Linux ext2fs loader 0.3.8.6
|
| Loading 2.6.12-64 from scsi(0)disk(2)rdisk(0)partition(0)
| Allocated 0x38 bytes for segments
| Loading 64-bit executable
| Loading program segment 1 at 0x88004000, offset=0x0 4000, size = \
| 0x0 3c4086
| 3c0000      (cache: 95.3%)Zeroing memory at 0x883c8086, size = \
| 0x42f9a
| Starting ELF64 kernel

no more action at this point....

Are there chances to get the machine working with a current kernel
(2.4.x works fine :), is there work going on?

Thanks anyway,

        Markus

--
Yip yip yip yip yap yap yip *BANG* --- NO TERRIER
