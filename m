Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Mar 2008 19:56:05 +0000 (GMT)
Received: from mordac.selfhost.de ([82.98.82.6]:33940 "EHLO mordac.selfhost.de")
	by ftp.linux-mips.org with ESMTP id S20026640AbYCWT4D (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 23 Mar 2008 19:56:03 +0000
Received: (qmail 32550 invoked from network); 23 Mar 2008 19:55:53 -0000
Received: from unknown (HELO belisama.gimme-th.at) (postmaster@gimme-th.at@84.146.149.186)
  by mailout.selfhost.de with SMTP; 23 Mar 2008 19:55:53 -0000
Received: by belisama.gimme-th.at (Postfix, from userid 5001)
	id 4AF4B4B991; Sun, 23 Mar 2008 20:52:10 +0100 (CET)
Received: from hey-dude.gimme-th.at (localhost [127.0.0.1])
	by belisama.gimme-th.at (Postfix) with ESMTP id BE5264B987
	for <linux-mips@linux-mips.org>; Sun, 23 Mar 2008 20:52:05 +0100 (CET)
Received: from 84.146.149.186
        (SquirrelMail authenticated user mrre@gimme-th.at)
        by hey-dude.gimme-th.at with HTTP;
        Sun, 23 Mar 2008 20:52:05 +0100 (CET)
Message-ID: <61692.84.146.149.186.1206301925.squirrel@hey-dude.gimme-th.at>
Date:	Sun, 23 Mar 2008 20:52:05 +0100 (CET)
Subject: Problem with compiling kernel on Octance R10K
From:	mrre@gimme-th.at
To:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.12
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <mrre@gimme-th.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mrre@gimme-th.at
Precedence: bulk
X-list: linux-mips

Hi,

I am not quite sure, whether I am at the right point to put this question.
But, maybe someone can help me

I recently aquired a SGI Octane with R10k-processor. I tried to install
gentoo on it, as described here:
http://www.gentoo.org/doc/en/handbook/handbook-mips.xml

I was using this gentoo-kernel: linux-2.6.22.6-20070902.ip30

It ended up with this failure-message:

  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/mips/sgi-ip30/built-in.o: In function `mask_and_ack_heart_irq':
ip30-irq.c:(.text+0x57c): undefined reference to `ip30_irq_bridge'
ip30-irq.c:(.text+0x580): undefined reference to `ip30_irq_bridge'
ip30-irq.c:(.text+0x584): undefined reference to `ip30_irq_bridge'
ip30-irq.c:(.text+0x588): undefined reference to `ip30_irq_bridge'
arch/mips/sgi-ip30/built-in.o: In function `startup_heart_irq':
ip30-irq.c:(.text+0x760): undefined reference to `ip30_irq_bridge'
arch/mips/sgi-ip30/built-in.o:ip30-irq.c:(.text+0x764): more undefined
references to `ip30_irq_bridge' follow
arch/mips/sgi-ip30/built-in.o: In function `startup_heart_irq':
ip30-irq.c:(.text+0x794): undefined reference to `ip30_irq_in_bridge'
ip30-irq.c:(.text+0x798): undefined reference to `ip30_irq_in_bridge'
ip30-irq.c:(.text+0x79c): undefined reference to `ip30_irq_in_bridge'
ip30-irq.c:(.text+0x7a0): undefined reference to `ip30_irq_in_bridge'
arch/mips/sgi-ip30/built-in.o: In function `shutdown_heart_irq':
ip30-irq.c:(.text+0x910): undefined reference to `ip30_irq_in_bridge'
arch/mips/sgi-ip30/built-in.o:ip30-irq.c:(.text+0x914): more undefined
references to `ip30_irq_in_bridge' follow
arch/mips/sgi-ip30/built-in.o: In function `shutdown_heart_irq':
ip30-irq.c:(.text+0x938): undefined reference to `ip30_irq_bridge'
ip30-irq.c:(.text+0x93c): undefined reference to `ip30_irq_bridge'
ip30-irq.c:(.text+0x940): undefined reference to `ip30_irq_bridge'
ip30-irq.c:(.text+0x944): undefined reference to `ip30_irq_bridge'
arch/mips/sgi-ip30/built-in.o: In function `ip30_xtalk_setup':
: undefined reference to `bridge_probe'
arch/mips/sgi-ip30/built-in.o: In function `ip30_xtalk_setup':
: relocation truncated to fit: R_MIPS_26 against `bridge_probe'
arch/mips/mm/built-in.o: In function `free_initmem':
: undefined reference to `prom_free_prom_memory'
arch/mips/mm/built-in.o: In function `free_initmem':
: relocation truncated to fit: R_MIPS_26 against `prom_free_prom_memory'
arch/mips/arc/lib.a(init.o): In function `prom_init':
init.c:(.init.text+0x130): undefined reference to `prom_meminit'
init.c:(.init.text+0x130): relocation truncated to fit: R_MIPS_26 against
`prom_meminit'
make: *** [.tmp_vmlinux1] Error 1

Does anybody know, what I might do, to correct this problem?

Thank you in advance,

Markus
