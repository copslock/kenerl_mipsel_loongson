Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jan 2005 04:42:21 +0000 (GMT)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:13556 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224788AbVASEmP>;
	Wed, 19 Jan 2005 04:42:15 +0000
Received: MO(mo00)id j0J4gCfU020116; Wed, 19 Jan 2005 13:42:12 +0900 (JST)
Received: MDO(mdo01) id j0J4gBan021252; Wed, 19 Jan 2005 13:42:12 +0900 (JST)
Received: 4UMRO00 id j0J4gBnn004808; Wed, 19 Jan 2005 13:42:11 +0900 (JST)
	from rally (localhost [127.0.0.1]) (authenticated)
Date: Wed, 19 Jan 2005 13:42:11 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: ralf@linux-mips.org
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-Id: <20050119134211.2c0e24f5.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20050115013112Z8225557-1340+1316@linux-mips.org>
References: <20050115013112Z8225557-1340+1316@linux-mips.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

On Sat, 15 Jan 2005 01:31:06 +0000
ralf@linux-mips.org wrote:

> 
> CVSROOT:	/home/cvs
> Module name:	linux
> Changes by:	ralf@ftp.linux-mips.org	05/01/15 01:31:06
> 
> Modified files:
> 	drivers/net    : big_sur_ge.h gt64240eth.h 
> 	include/asm-mips: gt64120.h hardirq.h spinlock.h unistd.h 
> 	include/asm-mips/mach-atlas: mc146818rtc.h 
> 	include/asm-mips/mach-au1x00: au1000.h au1xxx_dbdma.h 
> 	                              au1xxx_psc.h 
> 	include/asm-mips/mach-db1x00: db1x00.h 
> 	include/asm-mips/mach-ip32: cpu-feature-overrides.h spaces.h 
> 	include/asm-mips/mach-mips: cpu-feature-overrides.h 
> 	include/asm-mips/mach-pb1x00: pb1550.h 
> 	include/asm-mips/vr41xx: cmbvr4133.h vrc4173.h 
> 	arch/mips/au1000/common: au1xxx_irqmap.c cputable.c dbdma.c 
> 	                         dma.c platform.c sleeper.S 
> 	arch/mips/au1000/mtx-1: init.c 
> 	arch/mips/au1000/pb1550: board_setup.c 
> 	arch/mips/ddb5xxx/ddb5074: irq.c setup.c 
> 	arch/mips/ddb5xxx/ddb5476: setup.c 
> 	arch/mips/dec  : setup.c 
> 	arch/mips/dec/boot: decstation.c 
> 	arch/mips/galileo-boards/ev96100: time.c 
> 	arch/mips/gt64120/momenco_ocelot: irq.c 
> 	arch/mips/ite-boards/generic: irq.c 
> 	arch/mips/kernel: binfmt_elfn32.c binfmt_elfo32.c mips_ksyms.c 
> 	                  semaphore.c smp.c time.c 
> 	arch/mips/mips-boards/atlas: atlas_int.c 
> 	arch/mips/mips-boards/generic: gdb_hook.c 
> 	arch/mips/mips-boards/malta: malta_int.c 
> 	arch/mips/mm   : cex-sb1.S dma-ip32.c pg-r4k.c pgtable.c 
> 	                 tlb-andes.c tlb-sb1.c 
> 	arch/mips/momentum/ocelot_3: reset.c setup.c 
> 	arch/mips/momentum/ocelot_c: irq.c 
> 	arch/mips/momentum/ocelot_g: gt-irq.c irq.c 
> 	arch/mips/pci  : fixup-atlas.c ops-msc.c 
> 	arch/mips/pmc-sierra/yosemite: atmel_read_eeprom.h irq.c 
> 	arch/mips/sgi-ip27: ip27-memory.c ip27-timer.c 
> 	arch/mips/vr4181/common: irq.c 
> 	arch/mips/vr4181/osprey: setup.c 
> 	arch/mips/vr41xx/common: giu.c icu.c ksyms.c vrc4173.c 
> 	drivers/scsi   : wd33c93.h 
> 
> Log message:
> 	Fix use rsp. non-use of <linux/config.h>.

arch/mips/vr41xx/common/giu.c and icu.c need <linux/config.h>
I,m going to update 2 files soon.
 
Please get back 2 files.

Yoichi
