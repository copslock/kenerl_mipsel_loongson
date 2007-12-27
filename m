Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Dec 2007 16:42:30 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:60109 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20035635AbXL0QmV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Dec 2007 16:42:21 +0000
Received: from localhost (p1141-ipad301funabasi.chiba.ocn.ne.jp [122.17.251.141])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A0D8899A4; Fri, 28 Dec 2007 01:40:58 +0900 (JST)
Date:	Fri, 28 Dec 2007 01:43:21 +0900 (JST)
Message-Id: <20071228.014321.41630007.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [MIPS] 64-bit Sibyte kernels need DMA32.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S20038938AbXKZMRu/20071126121750Z+44508@ftp.linux-mips.org>
References: <S20038938AbXKZMRu/20071126121750Z+44508@ftp.linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 26 Nov 2007 12:17:46 +0000, linux-mips@linux-mips.org wrote:
> Author: Ralf Baechle <ralf@linux-mips.org> Sat Nov 3 02:05:43 2007 +0000
> Commit: 75c0de3513644f9868a14f74b0c4dfec1eb4ffd5
> Gitweb: http://www.linux-mips.org/g/linux/75c0de35
> Branch: master
> 
> Sibyte SOCs only have 32-bit PCI.  Due to the sparse use of the address
> space only the first 1GB of memory is mapped at physical addresses
> below 1GB.  If a system has more than 1GB of memory 32-bit DMA will
> not be able to reach all of it.
> 
> For now this patch is good enough to keep Sibyte users happy but it seems
> eventually something like swiotlb will be needed for Sibyte.

This commit breaks platforms which have real prom_free_prom_memory().

You can reproduce the problem with this patch.

diff --git a/arch/mips/qemu/q-mem.c b/arch/mips/qemu/q-mem.c
index dae39b5..84cbee2 100644
--- a/arch/mips/qemu/q-mem.c
+++ b/arch/mips/qemu/q-mem.c
@@ -1,5 +1,9 @@
 #include <linux/init.h>
+#include <asm/bootinfo.h>
+#include <asm/sections.h>
+#include <asm/page.h>
 
 void __init prom_free_prom_memory(void)
 {
+	free_init_pages("prom memory", PAGE_SIZE, __pa_symbol(&_text));
 }


With this patch, qemu kernel crashes on boot as this:

Bad page state in process 'swapper'
page:81000020 flags:0x00000000 mapping:00000000 mapcount:1 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Call Trace:
[<8001691c>] dump_stack+0x8/0x34
[<8005a758>] bad_page+0x6c/0xa4
[<8005af7c>] free_hot_cold_page+0x98/0x1d4
[<80019e44>] free_init_pages+0x94/0xf8
[<80164b3c>] free_initmem+0x10/0x40
[<80010428>] init_post+0x10/0xe8
[<801b988c>] kernel_init+0x2f8/0x328
[<80013220>] kernel_thread_helper+0x10/0x18

If I reverted the commit, this crash does not happen.  How I can fix this?

---
Atsushi Nemoto
