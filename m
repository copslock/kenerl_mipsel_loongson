Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jan 2005 17:15:08 +0000 (GMT)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:64983 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225272AbVAJRPC>; Mon, 10 Jan 2005 17:15:02 +0000
Received: from localhost (p1209-ipad02funabasi.chiba.ocn.ne.jp [61.214.21.209])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 58FE87FEE; Tue, 11 Jan 2005 02:14:59 +0900 (JST)
Date: Tue, 11 Jan 2005 02:21:38 +0900 (JST)
Message-Id: <20050111.022138.25909508.anemo@mba.ocn.ne.jp>
To: macro@mips.com
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
	macro@linux-mips.org
Subject: Re: [PATCH] I/O helpers rework
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.61.0501101503020.18023@perivale.mips.com>
References: <Pine.LNX.4.61.0412151936460.14855@perivale.mips.com>
	<20050107.004521.74752947.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.61.0501101503020.18023@perivale.mips.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 10 Jan 2005 15:28:24 +0000 (GMT), "Maciej W. Rozycki" <macro@mips.com> said:
macro>  Hmm, what's the semantics of "volatile void *"?  I can't
macro> imagine any, so I don't think it would be useful.

Well, maybe the 'volatile' have no sense, but some archs (including
i386, of course :-)) and some drivers use it.  Adding the 'volatile'
will remove some compiler warnings.

macro>  Instead of using "#ifndef" the generic versions could be moved
macro> to <asm-mips/mach-generic/mangle-port.h>.  Otherwise it sounds
macro> reasonable.

Hmm, if all *ioswab*() were moved to mangle-port.h,
mach-ip22/mangle-port.h (for example) must provide all *ioswab*()
instead of only ioswabw() and __raw_ioswabw().  OTOH providing
complete set of *ioswab* in one file might be better to understand the
code.  Both are acceptable for me.

macro>  Note that __mem is a virtual address, though, so you'd have to
macro> perform a physical address lookup before deciding on a swapping
macro> strategy -- would we really have a gain on any system from
macro> using regions with different swapping properties?

Yes, virt-to-phys conversion might be needed, but if we only use KSEG1
for I/O port/memory, it does not matter.

And I have some custom boards which really needs different swapping
properties (PCI regions need SWAP_IO_SPACE, but ISA region does not,
for example).  I agree that those boards were misdesigned but I want
to run Linux on it without modifying existing drivers.

Thank you.

---
Atsushi Nemoto
