Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2009 10:47:28 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:46323 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491922AbZGJIrV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 10 Jul 2009 10:47:21 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.200])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n6A8lBVS024000
	for <linux-mips@linux-mips.org>; Fri, 10 Jul 2009 01:47:11 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 00/15] Port changes from linux-mti
Date:	Fri, 10 Jul 2009 01:47:10 -0700
Message-ID: <94BD67F8AF3ED34FA362C662BA1F12C503BEE099@MTVEXCHANGE.mips.com>
In-Reply-To: <20090702023938.23268.65453.stgit@linux-raghu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 00/15] Port changes from linux-mti
Thread-Index: Acn6vmeF1EbLd7I0RpSzjAF5kgPSdwGbbyXg
References: <20090702023938.23268.65453.stgit@linux-raghu>
From:	"Gandham, Raghu" <raghu@mips.com>
To:	"Gandham, Raghu" <raghu@mips.com>, <linux-mips@linux-mips.org>
Cc:	"Dearman, Chris" <chris@mips.com>
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghu@mips.com
Precedence: bulk
X-list: linux-mips


> The following series of patches port the changes in 
> linux-mti.git repository to the head of tree. 
> ---
> 
> Chris Dearman (9):
>       Added coherentio command line option for DMA_NONCOHERENT kernel
>       Add missing memory barriers for correct operation of 
> amon_cpu_start
>       Port of GIC related changes from MTI branch.
>       Add debug prints during CPU intialization.
>       APRP Patch04: Propagate final value of max_low_pfn to max_pfn
>       [MTI] Enable PIIX4 PCI2.1 compliancy on Malta
>       [MTI] MIPS secondary cache supports 64 byte line size.
>       Fix accesses to device registers on MIPS boards
>       [MTI] Clean up SPRAM support a little
> 
> Jaidev Patwardhan (2):
>       Avoid queing multiple reschedule IPI's in SMTC
>       Avoid accessing GCMP registers when they are not present
> 
> Kurt Martin (1):
>       Do not rely on the initial state of TC/VPE bindings 
> when doing cross VPE writes
> 
> Raghu Gandham (1):
>       Fix compiler warning in vpe.c
> 
> Robin Randhawa (2):
>       Fix absd emulation
>       Due to some broken bitfiles, we can't trust IntCtl
> 
> 
>  arch/mips/Kconfig                 |    1 
>  arch/mips/include/asm/gcmpregs.h  |   18 ++--
>  arch/mips/include/asm/gic.h       |  188 
> ++++---------------------------------
>  arch/mips/include/asm/irq.h       |    1 
>  arch/mips/include/asm/smtc_ipi.h  |    5 +
>  arch/mips/include/asm/spram.h     |   10 ++
>  arch/mips/kernel/cpu-probe.c      |    8 --
>  arch/mips/kernel/irq-gic.c        |  116 +++++++++--------------
>  arch/mips/kernel/setup.c          |    3 -
>  arch/mips/kernel/smp-mt.c         |   10 ++
>  arch/mips/kernel/smtc.c           |   45 ++++++++-
>  arch/mips/kernel/spram.c          |    5 -
>  arch/mips/kernel/traps.c          |    4 +
>  arch/mips/kernel/vpe.c            |    3 -
>  arch/mips/math-emu/dp_simple.c    |   11 +-
>  arch/mips/math-emu/sp_simple.c    |    3 -
>  arch/mips/mti-malta/malta-amon.c  |    7 +
>  arch/mips/mti-malta/malta-int.c   |  115 ++++++++++++++---------
>  arch/mips/mti-malta/malta-pci.c   |   14 ++-
>  arch/mips/mti-malta/malta-setup.c |  111 
> ++++++++++++++++++++++  20 files changed, 351 insertions(+), 
> 327 deletions(-)  create mode 100644 arch/mips/include/asm/spram.h

I am resending the series as smaller patches after fixing a couple of
typos. 

Thanks,
Raghu
