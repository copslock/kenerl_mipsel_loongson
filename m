Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jan 2006 12:48:40 +0000 (GMT)
Received: from mail.renesas.com ([202.234.163.13]:62895 "EHLO
	mail04.idc.renesas.com") by ftp.linux-mips.org with ESMTP
	id S3465601AbWA0Mr2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Jan 2006 12:47:28 +0000
Received: from mail04.idc.renesas.com ([127.0.0.1])
 by mail04.idc.renesas.com. (SMSSMTP 4.1.9.35) with SMTP id M2006012721515601047
 for <linux-mips@linux-mips.org>; Fri, 27 Jan 2006 21:51:56 +0900
Received: (from root@localhost)
	by guardian01.idc.renesas.com with  id k0RCpnXj001105;
	Fri, 27 Jan 2006 21:51:49 +0900 (JST)
Received: from unknown [172.20.8.73] by guardian01.idc.renesas.com with SMTP id XAA01102 ; Fri, 27 Jan 2006 21:51:49 +0900
Received: from mrkaisv.hoku.renesas.com ([10.145.105.245])
	by ml01.idc.renesas.com (8.12.10/8.12.10) with ESMTP id k0RCpndI018876;
	Fri, 27 Jan 2006 21:51:49 +0900 (JST)
Received: from localhost (pcepx10 [10.145.105.241])
	by mrkaisv.hoku.renesas.com (Postfix) with ESMTP
	id EBC24798071; Fri, 27 Jan 2006 21:51:47 +0900 (JST)
Date:	Fri, 27 Jan 2006 21:51:47 +0900 (JST)
Message-Id: <20060127.215147.670306403.takata.hirokazu@renesas.com>
To:	mita@miraclelinux.com
Cc:	linux-kernel@vger.kernel.org, rth@twiddle.net,
	ink@jurassic.park.msu.ru, rmk@arm.linux.org.uk, spyro@f2s.com,
	dev-etrax@axis.com, dhowells@redhat.com,
	ysato@users.sourceforge.jp, torvalds@osdl.org,
	linux-ia64@vger.kernel.org, takata@linux-m32r.org,
	linux-m68k@lists.linux-m68k.org, gerg@uclinux.org,
	linux-mips@linux-mips.org, parisc-linux@parisc-linux.org,
	linuxppc-dev@ozlabs.org, linux390@de.ibm.com,
	linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
	uclinux-v850@lsi.nec.co.jp, ak@suse.de, chris@zankel.net,
	akpm@osdl.org
Subject: Re: [PATCH 3/6] C-language equivalents of include/asm-*/bitops.h
From:	Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20060125113206.GD18584@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com>
	<20060125113206.GD18584@miraclelinux.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.18 (Social Property)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <takata@linux-m32r.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: takata@linux-m32r.org
Precedence: bulk
X-list: linux-mips

Hello Mita-san, and folks,

From: mita@miraclelinux.com (Akinobu Mita)
Subject: [PATCH 3/6] C-language equivalents of include/asm-*/bitops.h
Date: Wed, 25 Jan 2006 20:32:06 +0900
> o generic {,test_and_}{set,clear,change}_bit() (atomic bitops)
> 
> This patch introduces the C-language equivalents of the functions below:
> void set_bit(int nr, volatile unsigned long *addr);
> void clear_bit(int nr, volatile unsigned long *addr);
...
> int test_and_change_bit(int nr, volatile unsigned long *addr);
> 
> HAVE_ARCH_ATOMIC_BITOPS is defined when the architecture has its own
> version of these functions.
> 
> This code largely copied from:
> include/asm-powerpc/bitops.h
> include/asm-parisc/bitops.h
> include/asm-parisc/atomic.h

Could you tell me more about the new generic {set,clear,test}_bit()
routines?

Why do you copied these routines from parisc and employed them
 as generic ones?
I'm not sure whether these generic {set,clear,test}_bit() routines
are really generic or not.

> +/* Can't use raw_spin_lock_irq because of #include problems, so
> + * this is the substitute */
> +#define _atomic_spin_lock_irqsave(l,f) do {	\
> +	raw_spinlock_t *s = ATOMIC_HASH(l);	\
> +	local_irq_save(f);			\
> +	__raw_spin_lock(s);			\
> +} while(0)
> +
> +#define _atomic_spin_unlock_irqrestore(l,f) do {	\
> +	raw_spinlock_t *s = ATOMIC_HASH(l);		\
> +	__raw_spin_unlock(s);				\
> +	local_irq_restore(f);				\
> +} while(0)

Is there a possibility that these routines affect for archs
with no HAVE_ARCH_ATOMIC_BITOPS for SMP ?
I think __raw_spin_lock() is sufficient and local_irqsave() is 
not necessary in general atomic routines.

If the parisc's LDCW instruction required disabling interrupts,
it would be parisc specific and not generic case, I think, 
although I'm not familier with the parisc architecture...

-- Takata
