Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2007 16:51:16 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:21697 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038960AbXBTQvL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Feb 2007 16:51:11 +0000
Received: from localhost (p3114-ipad212funabasi.chiba.ocn.ne.jp [58.91.167.114])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6D5D7C2FD; Wed, 21 Feb 2007 01:49:47 +0900 (JST)
Date:	Wed, 21 Feb 2007 01:49:47 +0900 (JST)
Message-Id: <20070221.014947.25911981.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: section mismatches (Re: [PATCH] Drop __init from init_8259A())
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070220151128.GA649@linux-mips.org>
References: <20070220.200845.98359099.nemoto@toshiba-tops.co.jp>
	<20070220151128.GA649@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 20 Feb 2007 15:11:28 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > init_8259A() is called from i8259A_resume() so should not be marked as
> > __init.  And add some tests for whether 8259A was already initialized
> > or not.
> > 
> > Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> Thanks, applied.

Thanks.  Apparently modpost can not detect section mismatchs in kernel.

Here is an excerpt from
	find . \! -name scripts -name '*.o' | xargs -n 1 scripts/mod/modpost
in malta build directory:

WARNING: ./arch/mips/kernel/built-in.o - Section mismatch: reference to .init.text:cpu_probe from .text between 'start_secondary' (at offset 0x8c1c) and 'smp_prepare_boot_cpu'
WARNING: ./arch/mips/kernel/built-in.o - Section mismatch: reference to .init.text:cpu_report from .text between 'start_secondary' (at offset 0x8c24) and 'smp_prepare_boot_cpu'
WARNING: ./arch/mips/kernel/built-in.o - Section mismatch: reference to .init.text:per_cpu_trap_init from .text between 'start_secondary' (at offset 0x8c2c) and 'smp_prepare_boot_cpu'
WARNING: ./arch/mips/pci/built-in.o - Section mismatch: reference to .init.text: from .text between 'pcibios_fixup_bus' (at offset 0x1ac) and 'pcibios_enable_device'
WARNING: ./arch/mips/pci/built-in.o - Section mismatch: reference to .init.text: from .text between 'pcibios_fixup_bus' (at offset 0x1f8) and 'pcibios_enable_device'
WARNING: ./arch/mips/pci/pci.o - Section mismatch: reference to .init.text: from .text between 'pcibios_fixup_bus' (at offset 0x1ac) and 'pcibios_enable_device'
WARNING: ./arch/mips/pci/pci.o - Section mismatch: reference to .init.text: from .text between 'pcibios_fixup_bus' (at offset 0x1f8) and 'pcibios_enable_device'

In pci.c, __devinit pcibios_fixup_bus() calls __init
pcibios_fixup_device_resources(), so it seems to be fixed.
Maybe it is worth looking at others...

---
Atsushi Nemoto
