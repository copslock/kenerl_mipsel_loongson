Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Feb 2010 18:51:38 +0100 (CET)
Received: from alius.ayous.org ([78.46.213.165]:39211 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491954Ab0BTRvf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 20 Feb 2010 18:51:35 +0100
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1NitUJ-0005fL-Up; Sat, 20 Feb 2010 17:51:32 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1NitUE-00078k-04; Sat, 20 Feb 2010 18:51:26 +0100
Date:   Sat, 20 Feb 2010 18:51:25 +0100
From:   Andreas Barth <aba@not.so.argh.org>
To:     linux-mips@linux-mips.org
Subject: Problems and workarounds while building octeon kernels
Message-ID: <20100220175125.GQ27216@mails.so.argh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aba@not.so.argh.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@not.so.argh.org
Precedence: bulk
X-list: linux-mips

Hi,

I tried to build an recent linux 2.6.33-rc something in an unstable
Debian chroot. I had the following issues (plus workarounds / fixes) -
please don't hesitate to ask me if you have further questions.


error:
arch/mips/cavium-octeon/built-in.o: In function `prom_init':
(.init.text+0x974): undefined reference to `early_serial_setup'
arch/mips/cavium-octeon/built-in.o: In function `prom_init':
(.init.text+0x974): relocation truncated to fit: R_MIPS_26 against `early_serial_setup'
arch/mips/cavium-octeon/built-in.o: In function `flash_init':

fix: enabled configuration for serial console support


error:
flash_setup.c:(.init.text+0x12dc): undefined reference to `simple_map_init'
flash_setup.c:(.init.text+0x12dc): relocation truncated to fit: R_MIPS_26 against `simple_map_init'
flash_setup.c:(.init.text+0x12ec): undefined reference to `do_map_probe'
flash_setup.c:(.init.text+0x12ec): relocation truncated to fit: R_MIPS_26 against `do_map_probe'
flash_setup.c:(.init.text+0x1314): undefined reference to `parse_mtd_partitions'
flash_setup.c:(.init.text+0x1314): relocation truncated to fit: R_MIPS_26 against `parse_mtd_partitions'
flash_setup.c:(.init.text+0x1330): undefined reference to `add_mtd_partitions'
flash_setup.c:(.init.text+0x1330): relocation truncated to fit: R_MIPS_26 against `add_mtd_partitions'
flash_setup.c:(.init.text+0x1340): undefined reference to `add_mtd_device'
flash_setup.c:(.init.text+0x1340): relocation truncated to fit: R_MIPS_26 against `add_mtd_device'

fix: set drivers/mtd to y (instead of m)



error:
arch/mips/cavium-octeon/built-in.o: In function `sched_clock':
(.text.sched_clock+0x24): undefined reference to `__lshrti3'
arch/mips/cavium-octeon/built-in.o: In function `sched_clock':
(.text.sched_clock+0x24): relocation truncated to fit: R_MIPS_26 against `__lshrti3'

workaround: in arch/mips/cavium-octeon/csrc-octeon.c
#if (__GNUC__ < 4) || ((__GNUC__ == 4) && (__GNUC_MINOR__ <= 3))
replaced by something that always uses "the ugly way"


ERROR: "i8253_lock" [drivers/input/misc/pcspkr.ko] undefined!
fix: disable pc speaker support


Cheers,
Andi
