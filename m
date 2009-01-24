Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jan 2009 13:15:50 +0000 (GMT)
Received: from mow300.po.2iij.NET ([210.128.50.200]:30892 "EHLO
	mow.po.2iij.net") by ftp.linux-mips.org with ESMTP
	id S21365744AbZAXNPs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Jan 2009 13:15:48 +0000
Received: by mow.po.2iij.net (mow300) id n0ODFiYZ003613; Sat, 24 Jan 2009 22:15:44 +0900
Received: from delta (133.6.30.125.dy.iij4u.or.jp [125.30.6.133])
	by mbox.po.2iij.net (po-mbox304) id n0ODFgML029203
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 24 Jan 2009 22:15:43 +0900
Date:	Sat, 24 Jan 2009 22:15:42 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix oops in r4k_dma_cache_inv
Message-Id: <20090124221542.bcc6c19f.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

This patch adds alignment for cache operation address in r4k_dma_cache_inv().
The following oops is fixed by it. 

Unhandled kernel unaligned access or invalid instruction[#1]:
Cpu 0
$ 0   : 00000000 9000c400 8f9a9fff 803e0000
$ 4   : 8f9a9000 00001000 00000001 00000002
$ 8   : 00000000 00000000 8f998084 8f986600
$12   : 00000000 00000000 00000008 00000008
$16   : 8f9a9000 8f9a3500 00000000 00000001
$20   : 00000002 803e0000 803d0000 00000000
$24   : 00000000 80240000                  
$28   : 8f81a000 8f81b708 803d0000 8009560c
Hi    : 10623d20
Lo    : 4fdf2cc8
epc   : 80098470 r4k_dma_cache_inv+0x28/0x64
    Not tainted
ra    : 8009560c dma_map_sg+0xf8/0x14c
Status: 9000c402    KERNEL EXL 
Cause : 00800010
BadVA : 8f9a9fff
PrId  : 000028a0 (Nevada)
Modules linked in:
Process swapper (pid: 1, threadinfo=8f81a000, task=8f820000, tls=00000000)
Stack : 8f967424 8f967510 8f9a03ee 8f99e140 8f999300 8f998074 8f998000 00000003
        803e0000 80253a38 8f967424 8f967510 80370000 8024e344 00000000 8f9a3580
        00000008 8f81b770 8f998074 8f99e140 802389fc 8f999458 8f998000 80253a38
        80253db4 80253cbc 800df150 00000000 80257af8 8f9a0360 8f99e140 9000c401
        8f9a0360 8f99e140 8f986600 8f9674a8 802391ac 8f81b844 8f967400 80224788
        ...
Call Trace:
[<80098470>] r4k_dma_cache_inv+0x28/0x64
[<8009560c>] dma_map_sg+0xf8/0x14c
[<8024e344>] ata_qc_issue+0x1ec/0x308
[<80253db4>] ata_scsi_translate+0x134/0x1e8
[<802391ac>] scsi_dispatch_cmd+0x10c/0x270
[<8024028c>] scsi_request_fn+0x28c/0x53c


Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/mm/c-r4k.c linux/arch/mips/mm/c-r4k.c
--- linux-orig/arch/mips/mm/c-r4k.c	2009-01-15 10:27:30.170434561 +0900
+++ linux/arch/mips/mm/c-r4k.c	2009-01-15 17:06:07.326434524 +0900
@@ -612,6 +612,8 @@ static void r4k_dma_cache_wback_inv(unsi
 
 static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 {
+	unsigned long lsize = cpu_dcache_line_size();
+
 	/* Catch bad driver code */
 	BUG_ON(size == 0);
 
@@ -620,7 +622,8 @@ static void r4k_dma_cache_inv(unsigned l
 			r4k_blast_scache();
 		else {
 			cache_op(Hit_Writeback_Inv_SD, addr);
-			cache_op(Hit_Writeback_Inv_SD, addr + size - 1);
+			cache_op(Hit_Writeback_Inv_SD,
+				 (addr + size - 1) & ~(lsize - 1));
 			blast_inv_scache_range(addr, addr + size);
 		}
 		return;
@@ -631,7 +634,7 @@ static void r4k_dma_cache_inv(unsigned l
 	} else {
 		R4600_HIT_CACHEOP_WAR_IMPL;
 		cache_op(Hit_Writeback_Inv_D, addr);
-		cache_op(Hit_Writeback_Inv_D, addr + size - 1);
+		cache_op(Hit_Writeback_Inv_D, (addr + size - 1) & ~(lsize - 1));
 		blast_inv_dcache_range(addr, addr + size);
 	}
 
