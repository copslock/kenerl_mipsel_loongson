Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2006 00:39:33 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:6159 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S3468186AbWATAjJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 20 Jan 2006 00:39:09 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 766A164D54; Fri, 20 Jan 2006 00:42:24 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 96124854A; Fri, 20 Jan 2006 00:42:08 +0000 (GMT)
Date:	Fri, 20 Jan 2006 00:42:08 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Crash on Cobalt with CONFIG_SERIO=y
Message-ID: <20060120004208.GA18327@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

I get the following crash on Cobalt when CONFIG_SERIO=y is set.
I realize that this option is not really necessary on Cobalt but the
kernel should neverless not crash if it is enabled.


 Activating ISA DMA hang workarounds.
 rtc: Digital UNIX epoch (1952) detected
 Real Time Clock Driver v1.12a
 Cobalt LCD Driver v2.10
 i8042.c: i8042 controller self test timeout.
 Unhandled kernel unaligned access[#1]:
 Cpu 0
 $ 0   : 0000000000000000 ffffffff940044e0 996bffffff4093b8 0000000000000000
 $ 4   : ffffffff8026a280 ffffffffdc620028 0000000000000000 996bffffff409398
 $ 8   : 980000000032c000 980000000032fdc0 0000000000000000 ffffffff80300000
 $12   : ffffffff940044e0 000000001000001e ffffffff802a0000 ffffffff80300000
 $16   : 980000000032fdc0 ffffffff802a2408 0000000000000000 ffffffff80310000
 $20   : ffffffff802b0000 ffffffff802a0000 ffffffff802a0000 ffffffff80280000
 $24   : ffffffff80310000 ffffffff802b0000                                  
 $28   : 980000000032c000 980000000032fd90 ffffffff80270000 ffffffff8008236c
 Hi    : 000000000000007b
 Lo    : e76c8b43957fdc00
 epc   : ffffffff80089a58 do_ade+0x398/0x4a0     Not tainted
 ra    : ffffffff8008236c handle_adel_int+0x34/0x48
 Status: 940044e2    KX SX UX KERNEL EXL 
 Cause : 00808010
 BadVA : 996bffffff40939f
 PrId  : 000028a0
 Modules linked in:
 Process swapper (pid: 1, threadinfo=980000000032c000, task=9800000000331788)
 Stack : ffffffff80310000 ffffffff802a2408 ffffffff940044e1 ffffffff80310000
         ffffffff8008236c ffffffff80300000 0000000000000000 ffffffff940044e0
         0033ffffffc01510 996bffffff409370 ffffffff80310000 9800000001000000
         000000000000006f ffffffff802a23f8 000000000000006f 0000000080000000
         ffffffff80300000 ffffffff80300000 ffffffff802a0000 ffffffff80300000
         ffffffff802a0000 ffffffff80300000 ffffffff80310000 ffffffff802a2408
         ffffffff940044e1 ffffffff80310000 ffffffff802b0000 ffffffff802a0000
         ffffffff802a0000 ffffffff80280000 ffffffff80310000 ffffffff802b0000
         980000000032feb8 ffffffff801bbe70 980000000032c000 980000000032fef0
         ffffffff80270000 ffffffff802f3944 ffffffff940044e2 000000000000007b
         ...
 Call Trace:
  [<ffffffff8008236c>] handle_adel_int+0x34/0x48
  [<ffffffff801bbe70>] i8042_command+0x1e8/0x3a8
  [<ffffffff802f3944>] i8042_init+0x11c/0xac8
  [<ffffffff800dc878>] kfree+0x70/0x110
  [<ffffffff802f3944>] i8042_init+0x11c/0xac8
  [<ffffffff801c8e70>] bus_register+0x120/0x270
  [<ffffffff80080600>] init+0x158/0x448
  [<ffffffff80083900>] kernel_thread_helper+0x10/0x18
  [<ffffffff800838f0>] kernel_thread_helper+0x0/0x18
 
 
 Code: 00621824  5460ff7d  de020100 <68e30007> 6ce30000  24020000  1440ffa0  00051402  08022657 
 Kernel panic - not syncing: Attempted to kill init!


The only difference between a broken and working kernel is:

--- config-broken	2006-01-20 00:30:23.000000000 +0000
+++ config-working	2006-01-20 00:30:33.000000000 +0000
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.15
-# Fri Jan 20 00:24:47 2006
+# Fri Jan 20 00:30:33 2006
 #
 CONFIG_MIPS=y
 
@@ -531,12 +531,7 @@
 #
 # Hardware I/O ports
 #
-CONFIG_SERIO=y
-CONFIG_SERIO_I8042=y
-CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_PCIPS2 is not set
-# CONFIG_SERIO_LIBPS2 is not set
-# CONFIG_SERIO_RAW is not set
+# CONFIG_SERIO is not set
 # CONFIG_GAMEPORT is not set
 
 #

-- 
Martin Michlmayr
http://www.cyrius.com/
