Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Sep 2004 15:10:25 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:16115 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8224945AbUIROKU>; Sat, 18 Sep 2004 15:10:20 +0100
Received: from localhost (p3019-ipad28funabasi.chiba.ocn.ne.jp [220.107.202.19])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3C0267C3C; Sat, 18 Sep 2004 23:10:16 +0900 (JST)
Date: Sat, 18 Sep 2004 23:19:47 +0900 (JST)
Message-Id: <20040918.231947.74754644.anemo@mba.ocn.ne.jp>
To: mlachwani@mvista.com
Cc: linux-mips@linux-mips.org
Subject: Re: IDE woos in BE mode 2.6 kernel
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <414B388D.8060705@mvista.com>
References: <414B388D.8060705@mvista.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 17 Sep 2004 12:18:37 -0700, Manish Lachwani <mlachwani@mvista.com> said:

mlachwani> In response to Jun Suns mail sent on 06/24/2004

jsun> Anybody has tried IDE disks in big endian mode with 2.6
jsun> kernel?  I seem to have troubles with Malta board.
...
mlachwani> The following patch gets the Malta to work well. However,
mlachwani> this patch introduces board specific changes in the IDE
mlachwani> subsystem.  This is not a final patch but maybe there can
mlachwani> be a better approach to this issue

FYI, here is my approach.  Not so beautiful but less intrusive...

1. copy include/asm-mips/mach-generic/ide.h to my mach-xxx directory.
2. add following lines to include/asm-mips/mach-xxx/ide.h
--- begin ---
/* get rid of defs from io.h - ide has its private and conflicting versions */
#ifdef insb
#undef insb
#endif
#ifdef outsb
#undef outsb
#endif
#ifdef insw
#undef insw
#endif
#ifdef outsw
#undef outsw
#endif
#ifdef insl
#undef insl
#endif
#ifdef outsl
#undef outsl
#endif

#define insb(port, addr, count) ___ide_insb(port, addr, count)
#define insw(port, addr, count) ___ide_insw(port, addr, count)
#define insl(port, addr, count) ___ide_insl(port, addr, count)
#define outsb(port, addr, count) ___ide_outsb(port, addr, count)
#define outsw(port, addr, count) ___ide_outsw(port, addr, count)
#define outsl(port, addr, count) ___ide_outsl(port, addr, count)

static inline void ___ide_insb(unsigned long port, void *addr, unsigned int count)
{
	unsigned long start = (unsigned long)addr;
	unsigned long size = (unsigned long)count;
	while (count--) {
		*(u16 *)addr = *(volatile u8 *)(mips_io_port_base + port);
		addr++;
	}
	if (cpu_has_dc_aliases)
		dma_cache_wback((unsigned long)start, size);
}

static inline void ___ide_outsb(unsigned long port, void *addr, unsigned int count)
{
	while (count--) {
		*(volatile u8 *)(mips_io_port_base + port) = *(u8 *)addr;
		addr++;
	}
}

static inline void ___ide_insw(unsigned long port, void *addr, unsigned int count)
{
	unsigned long start = (unsigned long)addr;
	unsigned long size = (unsigned long)count * 2;
	while (count--) {
		*(u16 *)addr = *(volatile u16 *)(mips_io_port_base + port);
		addr += 2;
	}
	if (cpu_has_dc_aliases)
		dma_cache_wback((unsigned long)start, size);
}

static inline void ___ide_outsw(unsigned long port, void *addr, unsigned int count)
{
	while (count--) {
		*(volatile u16 *)(mips_io_port_base + port) = *(u16 *)addr;
		addr += 2;
	}
}

static inline void ___ide_insl(unsigned long port, void *addr, unsigned int count)
{
	unsigned long start = (unsigned long)addr;
	unsigned long size = (unsigned long)count * 4;
	while (count--) {
		*(u32 *)addr = *(volatile u32 *)(mips_io_port_base + port);
		addr += 4;
	}
	if (cpu_has_dc_aliases)
		dma_cache_wback((unsigned long)start, size);
}

static inline void ___ide_outsl(unsigned long port, void *addr, unsigned int count)
{
	while (count--) {
		*(volatile u32 *)(mips_io_port_base + port) = *(u32 *)addr;
		addr += 4;
	}
}
--- end ---

Note that above codes include workarounds for PIO IDE cache problem
(dma_cache_wback) though I'm not sure this workaround still needed.
Please refer this ML thread for the workaround.
<http://www.linux-mips.org/archives/linux-mips/2004-03/msg00185.html>


And as I wrote before, I think this IDE endian problem still exists in
current 2.4 tree too.  Please refer my 02/26 mail for this topic.
<http://www.linux-mips.org/archives/linux-mips/2004-02/msg00219.html>

Thank you.

---
Atsushi Nemoto
