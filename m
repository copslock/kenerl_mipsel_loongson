Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Apr 2004 19:26:14 +0100 (BST)
Received: from natsmtp00.rzone.de ([IPv6:::ffff:81.169.145.165]:63932 "EHLO
	natsmtp00.webmailer.de") by linux-mips.org with ESMTP
	id <S8224941AbUDFS0O>; Tue, 6 Apr 2004 19:26:14 +0100
Received: from excalibur.cologne.de (p50851417.dip.t-dialin.net [80.133.20.23])
	by post.webmailer.de (8.12.10/8.12.10) with ESMTP id i36IQBvZ009914
	for <linux-mips@linux-mips.org>; Tue, 6 Apr 2004 20:26:12 +0200 (MEST)
Received: from karsten by excalibur.cologne.de with local (Exim 3.35 #1 (Debian))
	id 1BAusp-0003Mv-00
	for <linux-mips@linux-mips.org>; Tue, 06 Apr 2004 20:01:11 +0200
Date: Tue, 6 Apr 2004 20:01:10 +0200
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@linux-mips.org
Subject: SB1250 build currently broken in 2.4
Message-ID: <20040406180110.GA4650@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
Return-Path: <karsten@excalibur.cologne.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karsten@excalibur.cologne.de
Precedence: bulk
X-list: linux-mips

Hallo everybody,

I have tried building a kernel for a Broadcom SB1250 board from current
cvs (2.4 branch) with defconfig-sb1250-swarm. This fails with:

mips-linux-ld -m elf32btsmip  -r -o kernel.o branch.o cpu-probe.o irq.o
process.o signal.o entry.o traps.o ptrace.o reset.o semaphore.o setup.o
syscall.o sysmips.o ipc.o scall_o32.o unaligned.o mips_ksyms.o r4k_fpu.o
r4k_switch.o smp.o time.o proc.o pci-dma.o
smp.o(.kstrtab+0x48): multiple definition of __kstrtab_cpu_data'
setup.o(.kstrtab+0x0): first defined here
smp.o(__ksymtab+0x20): multiple definition of __ksymtab_cpu_data'
setup.o(__ksymtab+0x0): first defined here
make[1]: *** [kernel.o] Error 1
make[1]: Leaving directory /tmp/linux/arch/mips/kernel'
make: *** [_dir_arch/mips/kernel] Error 2

It looks like the line

EXPORT_SYMBOL(cpu_data);

in arch/mips/kernel/smp.c should not be there.

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
