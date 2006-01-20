Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2006 09:18:34 +0000 (GMT)
Received: from bay102-f38.bay102.hotmail.com ([64.4.61.48]:31157 "EHLO
	hotmail.com") by ftp.linux-mips.org with ESMTP id S3457227AbWATJSJ
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jan 2006 09:18:09 +0000
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Fri, 20 Jan 2006 01:22:02 -0800
Message-ID: <BAY102-F38B10761EA28790B4473F19A1F0@phx.gbl>
Received: from 64.4.61.200 by by102fd.bay102.hotmail.msn.com with HTTP;
	Fri, 20 Jan 2006 09:22:02 GMT
X-Originating-IP: [157.120.127.3]
X-Originating-Email: [tefs_engine@hotmail.com]
X-Sender: tefs_engine@hotmail.com
In-Reply-To: <BAY102-F3125666818AD9A3E2D3EE89A1F0@phx.gbl>
From:	"tefs engine" <tefs_engine@hotmail.com>
To:	linux-mips@linux-mips.org
Cc:	tefs_engine@hotmail.com
Subject: RE: Dbau1100. About ioremap of the physical address on the ApplicationXIP.
Date:	Fri, 20 Jan 2006 18:22:02 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp; format=flowed
X-OriginalArrivalTime: 20 Jan 2006 09:22:02.0559 (UTC) FILETIME=[F8F8A4F0:01C61DA2]
Return-Path: <tefs_engine@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tefs_engine@hotmail.com
Precedence: bulk
X-list: linux-mips

Hello.

Sorry.I had made a mistake. 

When writing it in flash, the mtd partition was disregarded. 
I confirm it again. 

Tefs

>From: "tefs engine" <tefs_engine@hotmail.com>
>To: tefs_engine@hotmail.com
>Subject: Dbau1100. About ioremap of the physical address on the 
ApplicationXIP.
>Date: Fri, 20 Jan 2006 18:06:17 +0900
>
>Hello.
>
>
>I am operating linux-2.4.21 on Dbau1100.
>ApplicationXIP patched linux-2.4.21.
>(It is a reference as for http://tree.celinuxforum.org/)
>And, I want to make mount cramfs on flash.
>
>The data of cramfs is stored in physical address 0xbf000000 of flash 
>with 0x1000. It stored it by using tftp with u-boot.
>
>
>=============
># md bf000000
>bf000000: 28cd3d45 00010000 00000000 00000000 E=.(............
>bf000010: 706d6f43 73736572 52206465 53464d4f Compressed ROMFS
>bf000020: f6fedb08 e452945a 94403278 43bdbefa ....Z.R.x2@....C
>bf000030: 706d6f43 73736572 00006465 00000000 Compressed......
>bf000040: 000041ed 00000014 000004c0 000081a4 .A..............
>bf000050: 00000457 00000602 61746164 7478742e W.......data.txt
>bf000060: 00000081 34339c78 35313632 34b0b733 ....x.3426153..4
>bf000070: 651c32e0 9947328e 302a4ca3 d37cd101 .2.e.2G..L*0..|.
>bf000080:
>=============
>
>Storage in Flash is sure to have succeeded.
>
>And, the patch of applicationXIP is appropriated with Linux-2.4.21, 
>and when the mount is done from physaddr, magic number cannot 
>acquire cramfs.
>
>BF000000 has been passed to ioremap though 
>linux-2.4.21/fs/cramfs/inode.c was confirmed. The data is 0 though 
>the virtual address has come back to the return value from ioremap.
>
>The MTD flash driver is not operating it.
>
>
>Is it wrong something?
>
>
>=================
># mount -t cramfs -o physaddr=0xbf000000 none /mnt/cramfs
>===dmesg==========
>cramfs: checking physical address 0xbf000000 for linear cramfs image
>__ioremap call phys_addr1=bf000000
>__ioremap size=1000
>cramfs: virtual address = c1038000
>cramfs: readb virt_addr = 0
>cramfs: first magic = 0
>cramfs: size = 0
>cramfs: flags = 0
>cramfs: future = 0
>cramfs: signature =
>at offset 0, no cramfs magic: trying 512...
>cramfs: second magic = 0
>cramfs: wrong magic
>=============
>
>
>Tefs
>
>_________________________________________________________________
>パソコンでも携帯電話でも使える 「MSN Hotmail」 
>http://promotion.msn.co.jp/hotmail/
>

_________________________________________________________________
迷惑メールやウイルスへの対策も万全「MSN Hotmail」 
http://promotion.msn.co.jp/hotmail/ 
