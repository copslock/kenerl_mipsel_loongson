Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2004 02:06:04 +0000 (GMT)
Received: from [IPv6:::ffff:202.230.225.5] ([IPv6:::ffff:202.230.225.5]:7968
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225482AbUBZCGD>; Thu, 26 Feb 2004 02:06:03 +0000
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 26 Feb 2004 02:06:05 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i1Q25k1x068762;
	Thu, 26 Feb 2004 11:05:47 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Thu, 26 Feb 2004 11:08:08 +0900 (JST)
Message-Id: <20040226.110808.74756119.nemoto@toshiba-tops.co.jp>
To: ralf@linux-mips.org
Cc: geert@linux-m68k.org, alanliu@trident.com.cn,
	alan@lxorguk.ukuu.org.uk, linux-mips@linux-mips.org
Subject: Re: IDE driver problem
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20040225181645.GA10742@linux-mips.org>
References: <20040225171315.GB17217@linux-mips.org>
	<Pine.GSO.4.58.0402251836510.2843@waterleaf.sonytel.be>
	<20040225181645.GA10742@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 3.3 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 25 Feb 2004 19:16:45 +0100, Ralf Baechle <ralf@linux-mips.org> said:
>>> I'm not sure what you call endian issue here.  The PC style
>>> partition table code we've used for years on big endian systems
>>> without problems.
>> 
>> I guess his hardware has a byteswapped IDE bus, like on Atari,
>> Q40/Q60 and Tivo.

ralf> Oh, those.  I fear every possible way to hookup the IDE bus in a
ralf> more or particularly less intelligent way to a system has
ralf> already been found out there ...

Since 2.4.21, I need following changes in asm-mips/ide.h to work
generic PCI IDE on my big-endian platform (which uses
CONFIG_SWAP_IO_SPACE) again.  This is a same hack used until 2.4.20.
CONFIG_IDE_USE_RAW_IO is a flag in my local configuration.

The 2.4.21 IDE subsystem introduced hwif->OUTW, hwif->OUTSW, etc. but
I could not found a way to override them for generic PCI IDE
controllers.  So I still need the hack.


#if defined(CONFIG_IDE_USE_RAW_IO) && defined(__MIPSEB__)

/* get rid of defs from io.h - ide has its private and conflicting versions */
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

#define insw(port, addr, count) raw_insw(port, addr, count)
#define insl(port, addr, count) raw_insl(port, addr, count)
#define outsw(port, addr, count) raw_outsw(port, addr, count)
#define outsl(port, addr, count) raw_outsl(port, addr, count)

static inline void raw_insw(unsigned long port, void *addr, unsigned int count)
{
	while (count--) {
		*(u16 *)addr = *(volatile u16 *)(mips_io_port_base + port);
		addr += 2;
	}
}

static inline void raw_outsw(unsigned long port, void *addr, unsigned int count)
{
	while (count--) {
		*(volatile u16 *)(mips_io_port_base + (port)) = *(u16 *)addr;
		addr += 2;
	}
}

static inline void raw_insl(unsigned long port, void *addr, unsigned int count)
{
	while (count--) {
		*(u32 *)addr = *(volatile u32 *)(mips_io_port_base + port);
		addr += 4;
	}
}

static inline void raw_outsl(unsigned long port, void *addr, unsigned int count)
{
	while (count--) {
		*(volatile u32 *)(mips_io_port_base + (port)) = *(u32 *)addr;
		addr += 4;
	}
}

#endif
