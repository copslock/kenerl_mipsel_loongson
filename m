Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Sep 2006 14:54:53 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:60637 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038415AbWIINyv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 9 Sep 2006 14:54:51 +0100
Received: from localhost (p6097-ipad210funabasi.chiba.ocn.ne.jp [58.88.125.97])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 24B79A8E8; Sat,  9 Sep 2006 22:54:45 +0900 (JST)
Date:	Sat, 09 Sep 2006 22:56:41 +0900 (JST)
Message-Id: <20060909.225641.41198763.anemo@mba.ocn.ne.jp>
To:	nigel@mips.com
Cc:	ralf@linux-mips.org, dan@debian.org, macro@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] fast path for rdhwr emulation for TLS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4501AABC.1050009@mips.com>
References: <20060711025342.GA6898@nevyn.them.org>
	<20060711.122014.52129937.nemoto@toshiba-tops.co.jp>
	<4501AABC.1050009@mips.com>
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
X-archive-position: 12541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 08 Sep 2006 18:39:08 +0100, Nigel Stephens <nigel@mips.com> wrote:
> > I asked on GCC bugzilla a few days ago but can not got feedback yet.
> > http://gcc.gnu.org/bugzilla/show_bug.cgi?id=28126
> >   
> 
> In spite of the GCC issue, is this patch now at the point where it could
> be applied, or at least queued?

GCC 4.2 does not put RDHWR in delay slot now.  Also, there is a
"hackish fix" to prevent gcc move a RDHWR outside of a conditional
(from Richard Sandiford).

For kernel side, my patch can be still applied to current git tree as
is.

But I'm still looking for better solution (silver bullet?) for
cpu_has_vtag_icache case.

How about something like this (and do not touch tlbex.c)?

	LEAF(handle_ri_rdhwr_vivt)
	.set	push
	.set	noat
	.set	noreorder
	/* check if TLB contains a entry for EPC */
	MFC0	K1, CP0_ENTRYHI
	andi	k1, ASID_MASK
	MFC0	k0, CP0_EPC
	andi	k0, PAGE_MASK << 1
	or	k1, k0
	MTC0	k1, CP0_ENTRYHI
	tlbp
	mfc0	k1, CP0_INDEX
	bltz	k1, handle_ri	/* slow path */
	 nop
	/* fall thru */
	LEAF(handle_ri_rdhwr)

I'm wondering if this could work on CONFIG_MIPS_MT_SMTC case...

---
Atsushi Nemoto
