Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 02:09:04 +0000 (GMT)
Received: from ns.miraclelinux.com ([219.118.163.66]:49878 "EHLO
	mail01.miraclelinux.com") by ftp.linux-mips.org with ESMTP
	id S8133644AbWAZCIq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jan 2006 02:08:46 +0000
Received: from mail01 (localhost.localdomain [127.0.0.1])
	by mail01.miraclelinux.com (Postfix) with ESMTP
	id EDE5531C180; Thu, 26 Jan 2006 11:13:11 +0900 (JST)
Received: from localhost.localdomain (sshgate.miraclelinux.com [])
	by mail01.miraclelinux.com ([10.1.0.10]);
	Thu, 26 Jan 2006 02:13:11 +0000
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 6EF5D420196; Thu, 26 Jan 2006 11:13:18 +0900 (JST)
Date:	Thu, 26 Jan 2006 11:13:18 +0900
To:	Keith Owens <kaos@sgi.com>
Cc:	linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Russell King <rmk@arm.linux.org.uk>,
	Ian Molton <spyro@f2s.com>, dev-etrax@axis.com,
	David Howells <dhowells@redhat.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
	Hirokazu Takata <takata@linux-m32r.org>,
	linux-m68k@lists.linux-m68k.org, Greg Ungerer <gerg@uclinux.org>,
	linux-mips@linux-mips.org, parisc-linux@parisc-linux.org,
	linuxppc-dev@ozlabs.org, linux390@de.ibm.com,
	linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Subject: Re: [PATCH 3/6] C-language equivalents of include/asm-*/bitops.h
Message-ID: <20060126021318.GB6648@miraclelinux.com>
References: <20060125113206.GD18584@miraclelinux.com> <24086.1138190083@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24086.1138190083@ocs3.ocs.com.au>
User-Agent: Mutt/1.5.9i
From:	mita@miraclelinux.com (Akinobu Mita)
Return-Path: <mita@miraclelinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mita@miraclelinux.com
Precedence: bulk
X-list: linux-mips

On Wed, Jan 25, 2006 at 10:54:43PM +1100, Keith Owens wrote:
> Be very, very careful about using these generic *_bit() routines if the
> architecture supports non-maskable interrupts.
> 
> NMI events can occur at any time, including when interrupts have been
> disabled by *_irqsave().  So you can get NMI events occurring while a
> *_bit fucntion is holding a spin lock.  If the NMI handler also wants
> to do bit manipulation (and they do) then you can get a deadlock
> between the original caller of *_bit() and the NMI handler.
> 
> Doing any work that requires spinlocks in an NMI handler is just asking
> for deadlock problems.  The generic *_bit() routines add a hidden
> spinlock behind what was previously a safe operation.  I would even say
> that any arch that supports any type of NMI event _must_ define its own
> bit routines that do not rely on your _atomic_spin_lock_irqsave() and
> its hash of spinlocks.

At least cris and parisc are using similar *_bit function on SMP.
I will add your advise in comment.

--- ./include/asm-generic/bitops.h.orig	2006-01-26 10:56:00.000000000 +0900
+++ ./include/asm-generic/bitops.h	2006-01-26 11:01:28.000000000 +0900
@@ -50,6 +50,16 @@ extern raw_spinlock_t __atomic_hash[ATOM
  * C language equivalents written by Theodore Ts'o, 9/26/92
  */
 
+/*
+ * NMI events can occur at any time, including when interrupts have been
+ * disabled by *_irqsave().  So you can get NMI events occurring while a
+ * *_bit fucntion is holding a spin lock.  If the NMI handler also wants
+ * to do bit manipulation (and they do) then you can get a deadlock
+ * between the original caller of *_bit() and the NMI handler.
+ *
+ * by Keith Owens
+ */
+
 static __inline__ void set_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BITOP_MASK(nr);
