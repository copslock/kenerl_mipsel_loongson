Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 May 2004 18:03:52 +0100 (BST)
Received: from c2ce9fba.adsl.oleane.fr ([IPv6:::ffff:194.206.159.186]:43138
	"EHLO avalon.france.sdesigns.com") by linux-mips.org with ESMTP
	id <S8226050AbUEZRDk>; Wed, 26 May 2004 18:03:40 +0100
Received: from avalon.france.sdesigns.com (localhost.localdomain [127.0.0.1])
	by avalon.france.sdesigns.com (8.12.8/8.12.8) with ESMTP id i4QH3dsL025480;
	Wed, 26 May 2004 19:03:39 +0200
Received: (from michon@localhost)
	by avalon.france.sdesigns.com (8.12.8/8.12.8/Submit) id i4QH3deK025478;
	Wed, 26 May 2004 19:03:39 +0200
X-Authentication-Warning: avalon.france.sdesigns.com: michon set sender to em@realmagic.fr using -f
Subject: Re: down_trylock() implementation for MIPS 4KEc CPU implies
	64bitarithmetics?
From: Emmanuel Michon <em@realmagic.fr>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <012b01c44342$c3ec91e0$10eca8c0@grendel>
References: <1085589315.2306.49.camel@avalon.france.sdesigns.com>
	 <012b01c44342$c3ec91e0$10eca8c0@grendel>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: REALmagic France SAS
Message-Id: <1085591018.2306.82.camel@avalon.france.sdesigns.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 26 May 2004 19:03:38 +0200
Return-Path: <em@realmagic.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: em@realmagic.fr
Precedence: bulk
X-list: linux-mips

On Wed, 2004-05-26 at 18:59, Kevin D. Kissell wrote:
> Are you sure you've specified your CPU type as "MIPS32"?

No, because this choice of CPU CONFIG_MIPS32
is exclusive with CONFIG_CPU_R3000 and CONFIG_CPU_R4X00

I do use CONFIG_CPU_R4X00 so that appropriate cache routines are used

I now realize that the 4KEc has ll/sc but not the 64bit versions
lld/scd...!

so I force disabled the CONFIG_CPU_HAS_LLDSCD.

I'd prefer to find the appropriate combination of flags to get things
right though...

Sincerely yours,

E.M.

> 
> ----- Original Message ----- 
> From: "Emmanuel Michon" <em@realmagic.fr>
> To: <linux-mips@linux-mips.org>
> Sent: Wednesday, May 26, 2004 18:35
> Subject: down_trylock() implementation for MIPS 4KEc CPU implies 64bitarithmetics?
> 
> 
> > Hi,
> > 
> > I'm porting linux for a MIPS 4KEc based design;
> > 
> > my knowledge of MIPS CPUs generations is still rudimentary but I know
> > for sure this one has both features from R3000 arch but some of
> > R4000 as well (cache, lld/scd --- according to the software user's
> > manual)
> > 
> > but it is definitely a 32bit processor.
> > 
> > The implementation of down_trylock on linuxmips-2.4.25 is:
> > 
> > ---------------------------------------------
> > static inline int down_trylock(struct semaphore * sem)
> > {
> > long ret, tmp, tmp2, sub;
> > 
> > #if WAITQUEUE_DEBUG
> > CHECK_MAGIC(sem->__magic);
> > #endif
> > 
> > __asm__ __volatile__(
> > " .set mips3 # down_trylock \n"
> > "0: lld %1, %4 \n"
> > " dli %3, 0x0000000100000000 # count -= 1 \n"
> > " dsubu %1, %3 \n"
> > " li %0, 0 # ret = 0 \n"
> > " bgez %1, 2f # if count >= 0 \n"
> > " sll %2, %1, 0 # extract waking \n"
> > " blez %2, 1f # if waking < 0 -> 1f \n"
> > " daddiu %1, %1, -1 # waking -= 1 \n"
> > " b 2f \n"
> > "1: daddu %1, %1, %3 # count += 1 \n"
> > " li %0, 1 # ret = 1 \n"
> > "2: scd %1, %4 \n"
> > " beqz %1, 0b \n"
> > " sync \n"
> > " .set mips0 \n"
> > : "=&r"(ret), "=&r"(tmp), "=&r"(tmp2), "=&r"(sub)
> > : "m"(*sem)
> > : "memory");
> > 
> > return ret;
> > }
> > ---------------------------------------------
> > 
> > and after synthesized assembly dli becomes:
> > 
> >      a90:       34048000        li      a0,0x8000
> >      a94:       00042478        dsll    a0,a0,0x11
> > 
> > which is a0=0 (wrong).
> > 
> > Why is this computation done on 64bit? Should I workaround a 32bit
> > implementation of this?
> > 
> > Subsidiary question: since the 4KEc core is not mentioned explicitely
> > in mips gas possible CPUs, I build the kernel code with:
> > 
> > mipsel-linux-gcc -march=r4600 -mips2 -Wa,-32 -Wa,-march=r4600 -Wa,-mips3
> > 
> > with gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-113.2) neon
> > 
> > Is this the correct option?
> > 
> > Thanks a lot for any clue,
> > 
> > Sincerely yours,
> > 
> > E.M.
> > 
> > 
> > 
> 
