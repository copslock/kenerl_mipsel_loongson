Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jan 2006 12:59:55 +0000 (GMT)
Received: from mail.renesas.com ([202.234.163.13]:58878 "EHLO
	mail03.idc.renesas.com") by ftp.linux-mips.org with ESMTP
	id S3465601AbWA0M7h (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Jan 2006 12:59:37 +0000
Received: from mail03.idc.renesas.com ([127.0.0.1])
 by mail03.idc.renesas.com. (SMSSMTP 4.1.9.35) with SMTP id M2006012722040626942
 for <linux-mips@linux-mips.org>; Fri, 27 Jan 2006 22:04:06 +0900
Received: (from root@localhost)
	by guardian03.idc.renesas.com with  id k0RD42Zn007409;
	Fri, 27 Jan 2006 22:04:02 +0900 (JST)
Received: from unknown [172.20.8.73] by guardian03.idc.renesas.com with SMTP id YAA07408 ; Fri, 27 Jan 2006 22:04:02 +0900
Received: from mrkaisv.hoku.renesas.com ([10.145.105.245])
	by ml01.idc.renesas.com (8.12.10/8.12.10) with ESMTP id k0RD42dI019742;
	Fri, 27 Jan 2006 22:04:02 +0900 (JST)
Received: from localhost (pcepx10 [10.145.105.241])
	by mrkaisv.hoku.renesas.com (Postfix) with ESMTP
	id 3BD26798071; Fri, 27 Jan 2006 22:04:02 +0900 (JST)
Date:	Fri, 27 Jan 2006 22:04:01 +0900 (JST)
Message-Id: <20060127.220401.356433243.takata.hirokazu@renesas.com>
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
Subject: Re: [PATCH 4/6] use include/asm-generic/bitops for each
 architecture
From:	Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20060126014934.GA6648@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com>
	<20060125113336.GE18584@miraclelinux.com>
	<20060126014934.GA6648@miraclelinux.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.18 (Social Property)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <takata@linux-m32r.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: takata@linux-m32r.org
Precedence: bulk
X-list: linux-mips

From: mita@miraclelinux.com (Akinobu Mita)
Subject: Re: [PATCH 4/6] use include/asm-generic/bitops for each architecture
Date: Thu, 26 Jan 2006 10:49:34 +0900
> On Wed, Jan 25, 2006 at 08:33:37PM +0900, mita wrote:
> > compile test on i386, x86_64, ppc, sparc, sparc64, alpha
> > boot test on i386, x86_64, ppc
...
>
> o m32r
> 
> - remove __{,test_and_}{set,clear,change}_bit() and test_bit()
> - remove ffz()
> - remove find_{next,first}{,_zero}_bit()
> - remove __ffs()
> - remove fls()
> - remove fls64()
> - remove sched_find_first_bit()
> - remove ffs()
> - remove hweight()
> - remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
> - remove ext2_{set,clear}_bit_atomic()
> - remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()
> - define HAVE_ARCH_ATOMIC_BITOPS
> 

compile and boot test on m32r: OK

Code size became a little bigger...  ;-)

$ size linux-2.6.16-rc1*/vmlinux
   text    data     bss     dec     hex filename
1768030  124412  721632 2614074  27e33a linux-2.6.16-rc1.bitops/vmlinux
1755010  124412  721632 2601054  27b05e linux-2.6.16-rc1.org/vmlinux

-- Takata
