Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Sep 2006 15:11:22 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:52167 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037486AbWIKOLV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 11 Sep 2006 15:11:21 +0100
Received: from localhost (p8244-ipad25funabasi.chiba.ocn.ne.jp [220.104.86.244])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 87116A685; Mon, 11 Sep 2006 23:11:15 +0900 (JST)
Date:	Mon, 11 Sep 2006 23:13:14 +0900 (JST)
Message-Id: <20060911.231314.25910522.anemo@mba.ocn.ne.jp>
To:	ths@networkno.de
Cc:	nigel@mips.com, ralf@linux-mips.org, dan@debian.org,
	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] fast path for rdhwr emulation for TLS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060911094905.GB13414@networkno.de>
References: <20060911.140403.126141483.nemoto@toshiba-tops.co.jp>
	<20060911.175029.37531637.nemoto@toshiba-tops.co.jp>
	<20060911094905.GB13414@networkno.de>
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
X-archive-position: 12556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 11 Sep 2006 10:49:05 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> > +	tlbp
> 
> This needs a .set mips3/.set mips0 pair.

The TLBP is belong to MIPS I ISA, isn't it?

> > +#ifdef CONFIG_CPU_MIPSR2
> > +	_ehb			/* tlb_probe_hazard */
> > +#else
> > +	nop; nop; nop; nop; nop; nop	/* tlb_probe_hazard */
> > +#endif
> 
> What about a mtc0_tlbp_hazard macro here?

You mean mtc0_tlbw_hazard?  I took them from tlb_probe_hazard macro in
queue branch.

And it looks current mtc0_tlbw_hazard asm macro does not match with
its C equivalent ...

	.macro	mtc0_tlbw_hazard
	b	. + 8
	.endm

#define mtc0_tlbw_hazard()						\
	__asm__ __volatile__(						\
	"	.set	noreorder				\n"	\
	"	nop						\n"	\
	"	nop						\n"	\
	"	nop						\n"	\
	"	nop						\n"	\
	"	nop						\n"	\
	"	nop						\n"	\
	"	.set	reorder					\n")

---
Atsushi Nemoto
