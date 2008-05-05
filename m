Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 May 2008 15:57:28 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:45791 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28776895AbYEEO5Z (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 5 May 2008 15:57:25 +0100
Received: from localhost (p6218-ipad309funabasi.chiba.ocn.ne.jp [123.217.200.218])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 42B93AD48; Mon,  5 May 2008 23:57:19 +0900 (JST)
Date:	Mon, 05 May 2008 23:58:27 +0900 (JST)
Message-Id: <20080505.235827.93020396.anemo@mba.ocn.ne.jp>
To:	tsbogend@alpha.franken.de
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: Breakage in arch/mips/kernel/traps.c for 64bit
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080504220804.GA13442@alpha.franken.de>
References: <20080503224849.GA2314@alpha.franken.de>
	<20080504.223944.41198532.anemo@mba.ocn.ne.jp>
	<20080504220804.GA13442@alpha.franken.de>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 5 May 2008 00:08:04 +0200, tsbogend@alpha.franken.de (Thomas Bogendoerfer) wrote:
> > 	while (!kstack_end((void *)(unsigned long)sp)) {
> > 
> > will make this part sparse-free, though it seems a bit ugly.
> 
> hmm, would leaving sp as unsigned long * and casting it for __get_user()
> make sparse happy ?

Well, not as expected...  Here is some warning patterns.

1.	unsigned long __user *sp = (unsigned long __user *)(reg29 & ~3);
	...
	while (!kstack_end(sp)) {
		if (__get_user(addr, sp++)) {

linux/arch/mips/kernel/traps.c:91:21: warning: incorrect type in argument 1 (different address spaces)
linux/arch/mips/kernel/traps.c:91:21:    expected void *addr
linux/arch/mips/kernel/traps.c:91:21:    got unsigned long [noderef] <asn:1>*sp

2.	unsigned long *sp = (unsigned long *)(reg29 & ~3);
	...
	while (!kstack_end(sp)) {
		if (__get_user(addr, (unsigned long __user *)sp++)) {

linux/arch/mips/kernel/traps.c:92:7: warning: cast adds address space to expression (<asn:1>)
linux/arch/mips/kernel/traps.c:92:7: warning: cast adds address space to expression (<asn:1>)
linux/arch/mips/kernel/traps.c:92:7: warning: cast adds address space to expression (<asn:1>)
linux/arch/mips/kernel/traps.c:92:7: warning: cast adds address space to expression (<asn:1>)
linux/arch/mips/kernel/traps.c:92:7: warning: cast adds address space to expression (<asn:1>)
linux/arch/mips/kernel/traps.c:92:7: warning: cast adds address space to expression (<asn:1>)
linux/arch/mips/kernel/traps.c:92:7: warning: cast adds address space to expression (<asn:1>)
linux/arch/mips/kernel/traps.c:92:7: warning: cast adds address space to expression (<asn:1>)
linux/arch/mips/kernel/traps.c:92:7: warning: cast adds address space to expression (<asn:1>)

3.	unsigned long __user *sp = (unsigned long __user *)(reg29 & ~3);
	...
	while (!kstack_end((void *)(unsigned long)sp)) {
		if (__get_user(addr, sp++)) {

No warnings.

4.	unsigned long *sp = (unsigned long *)(reg29 & ~3);
	...
	while (!kstack_end(sp)) {
		unsigned long __user *p = (unsigned long __user *)sp++;
		if (__get_user(addr, p)) {

linux/arch/mips/kernel/traps.c:92:30: warning: cast adds address space to expression (<asn:1>)

4.	unsigned long *sp = (unsigned long *)(reg29 & ~3);
	...
	while (!kstack_end(sp)) {
		unsigned long __user *p =
			(unsigned long __user *)(unsigned long)sp++;
		if (__get_user(addr, p)) {

No warnings.


I think the "cast adds address space to expression" sparse warning is
not worth to handle so seriously.  So I'm OK with any of (2) to (4).

---
Atsushi Nemoto
