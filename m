Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 20:20:27 +0100 (CET)
Received: from kuber.nabble.com ([216.139.236.158]:41090 "EHLO
        kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492379Ab0CCTUX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 20:20:23 +0100
Received: from isper.nabble.com ([192.168.236.156])
        by kuber.nabble.com with esmtp (Exim 4.63)
        (envelope-from <lists@nabble.com>)
        id 1Nmu7K-00086N-75
        for linux-mips@linux-mips.org; Wed, 03 Mar 2010 11:20:22 -0800
Message-ID: <27772495.post@talk.nabble.com>
Date:   Wed, 3 Mar 2010 11:20:22 -0800 (PST)
From:   Dea_RU <dryukovz@mail.ru>
To:     linux-mips@linux-mips.org
Subject: Re: TI AR7 7200 - no boot
In-Reply-To: <27768844.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Nabble-From: dryukovz@mail.ru
References: <27766331.post@talk.nabble.com> <201003031124.46336.florian@openwrt.org> <27766728.post@talk.nabble.com> <27767861.post@talk.nabble.com> <201003031404.53039.florian@openwrt.org> <27768844.post@talk.nabble.com>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dryukovz@mail.ru
Precedence: bulk
X-list: linux-mips


I show this rtunk left 10 day....

and patch src 2.6.33 from dir root/trunk/target/linux/ar7/patches-2.6.32

to day i see :

florian: [ar7] add missing patch to arch/mips/kernel/traps.c to allow ar7 to
setup … :confused:
 
------------------
for 2.6.33 need this modify ?? or not ?

arch/mips/include/asm/page.h
---------
#define UNCAC_ADDR(addr)        ((addr) - PAGE_OFFSET + UNCAC_BASE +
PHYS_OFFSET) 
#define CAC_ADDR(addr)          ((addr) - UNCAC_BASE + PAGE_OFFSET -
PHYS_OFFSET) 
---------


----------------
my console not work correctly - baudrate no standart ?!  :( i change port
type 

---- i change port type in ar7platform.c to:

uart_port[0].type = PORT_16550A
to 
uart_port[0].type = PORT_AR7

boot process ttyS0 detected as AR7.

Console baudrate not work correct again ....&-(

======= log ================
............
alg: No test for stdrng (krng)
Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0x8610e00 (irq = 15) is a AR7
IdÁIdÁIdÁIdÁIdÁIdÁYdÁYdÁYdÁYdÁYdÁYdÁYdÁYdÁYdÁYdÁYdÁYd
......

==========================

if remart set_termios() in serial_core.c i see all messages ... 
-- 
View this message in context: http://old.nabble.com/TI-AR7-7200---no-boot-tp27766331p27772495.html
Sent from the linux-mips main mailing list archive at Nabble.com.
