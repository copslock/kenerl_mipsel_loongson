Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 15:24:14 +0100 (CET)
Received: from kuber.nabble.com ([216.139.236.158]:48898 "EHLO
        kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491793Ab0CCOYH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 15:24:07 +0100
Received: from isper.nabble.com ([192.168.236.156])
        by kuber.nabble.com with esmtp (Exim 4.63)
        (envelope-from <lists@nabble.com>)
        id 1NmpUZ-0002DK-DL
        for linux-mips@linux-mips.org; Wed, 03 Mar 2010 06:24:03 -0800
Message-ID: <27768844.post@talk.nabble.com>
Date:   Wed, 3 Mar 2010 06:24:03 -0800 (PST)
From:   Dea_RU <dryukovz@mail.ru>
To:     linux-mips@linux-mips.org
Subject: Re: TI AR7 7200 - no boot
In-Reply-To: <201003031404.53039.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Nabble-From: dryukovz@mail.ru
References: <27766331.post@talk.nabble.com> <201003031124.46336.florian@openwrt.org> <27766728.post@talk.nabble.com> <27767861.post@talk.nabble.com> <201003031404.53039.florian@openwrt.org>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dryukovz@mail.ru
Precedence: bulk
X-list: linux-mips


it work !
great work !

why this patch not present in src 2.6.33 ??? 

============ log
(psbl) 

Booting...
Linux version 2.6.33 (root@linwork) (gcc version 4.3.3 (Buildroot
2010.02-rc1) ) #13 Wed Mar 3 20:04:20 OMST 2010
bootconsole [early0] enabled
CPU revision is: 00018448 (MIPS 4KEc)
TI AR7 (TNETD7200), ID: 0x002b, Revision: 0x11
Determined physical RAM map:
 memory: 01000000 @ 14000000 (usable)
Zone PFN ranges:
  Normal   0x00014000 -> 0x00015000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00014000 -> 0x00015000
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064
Kernel command line:  console=ttyS0,9600n8 earlyprintk=ttyS0,9600
PID hash table entries: 64 (order: -4, 256 bytes)
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Primary instruction cache 16kB, VIPT, 4-way, linesize 16 bytes.
Primary data cache 8kB, 4-way, VIPT, no aliases, linesize 16 bytes
Memory: 13172k/16384k available (1316k kernel code, 3212k reserved, 409k
data, 120k init, 0k highmem)
NR_IRQS:256
Console: colour dummy device 80x25
Calibrating delay loop... 149.50 BogoMIPS (lpj=299008)
Mount-cache hash table entries: 512
rest_init
Clocks: Sync 2:1 mode
Clocks: Setting CPU clock
Adjusted requested frequency 211000000 to 211968000
Clocks: base = 35328000, frequency = 211968000, prediv = 1, postdiv = 1,
postdiv2 = -1, mul = 6
Clocks: Setting DSP clock
Clocks: base = 25000000, frequency = 105984000, prediv = 1, postdiv = 2,
postdiv2 = 1, mul = 10
Clocks: Setting USB clock
Adjusted requested frequency 48000000 to 47863741
Clocks: base = 105984000, frequency = 48000000, prediv = 1, postdiv = 31,
postdiv2 = -1, mul = 14
LinuxPPS API ver. 1 registered
Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti
<giometti@linux.it>
Switching to clocksource MIPS
Slow work thread pool: Starting up
Slow work thread pool: Ready
FS-Cache: Loaded
msgmni has been set to 25
alg: No test for cipher_null (cipher_null-generic)
alg: No test for ecb(cipher_null) (ecb-cipher_null)
alg: No test for digest_null (digest_null-generic)
alg: No test for compress_null (compress_null-generic)
alg: No test for stdrng (krng)
Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0x8610e00 (irq = 15) is a XScale
Ã}q™ya)¶‰/½¾£Ö	².W,XvÍ!a™,Ó¯\“×
---------- can not select USART options for show it ...
-- 
View this message in context: http://old.nabble.com/TI-AR7-7200---no-boot-tp27766331p27768844.html
Sent from the linux-mips main mailing list archive at Nabble.com.
