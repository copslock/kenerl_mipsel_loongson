Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 May 2004 17:56:28 +0100 (BST)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:44685 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8226050AbUEZQ4O>;
	Wed, 26 May 2004 17:56:14 +0100
Received: from mercury.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.11/8.12.11) with ESMTP id i4QGiI1H003481;
	Wed, 26 May 2004 09:44:18 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.12.11/8.12.11) with SMTP id i4QGu4DW017689;
	Wed, 26 May 2004 09:56:05 -0700 (PDT)
Message-ID: <012b01c44342$c3ec91e0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Emmanuel Michon" <em@realmagic.fr>, <linux-mips@linux-mips.org>
References: <1085589315.2306.49.camel@avalon.france.sdesigns.com>
Subject: Re: down_trylock() implementation for MIPS 4KEc CPU implies 64bitarithmetics?
Date: Wed, 26 May 2004 18:59:08 +0200
Organization: MIPS Technologies Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Are you sure you've specified your CPU type as "MIPS32"?

----- Original Message ----- 
From: "Emmanuel Michon" <em@realmagic.fr>
To: <linux-mips@linux-mips.org>
Sent: Wednesday, May 26, 2004 18:35
Subject: down_trylock() implementation for MIPS 4KEc CPU implies 64bitarithmetics?


> Hi,
> 
> I'm porting linux for a MIPS 4KEc based design;
> 
> my knowledge of MIPS CPUs generations is still rudimentary but I know
> for sure this one has both features from R3000 arch but some of
> R4000 as well (cache, lld/scd --- according to the software user's
> manual)
> 
> but it is definitely a 32bit processor.
> 
> The implementation of down_trylock on linuxmips-2.4.25 is:
> 
> ---------------------------------------------
> static inline int down_trylock(struct semaphore * sem)
> {
> long ret, tmp, tmp2, sub;
> 
> #if WAITQUEUE_DEBUG
> CHECK_MAGIC(sem->__magic);
> #endif
> 
> __asm__ __volatile__(
> " .set mips3 # down_trylock \n"
> "0: lld %1, %4 \n"
> " dli %3, 0x0000000100000000 # count -= 1 \n"
> " dsubu %1, %3 \n"
> " li %0, 0 # ret = 0 \n"
> " bgez %1, 2f # if count >= 0 \n"
> " sll %2, %1, 0 # extract waking \n"
> " blez %2, 1f # if waking < 0 -> 1f \n"
> " daddiu %1, %1, -1 # waking -= 1 \n"
> " b 2f \n"
> "1: daddu %1, %1, %3 # count += 1 \n"
> " li %0, 1 # ret = 1 \n"
> "2: scd %1, %4 \n"
> " beqz %1, 0b \n"
> " sync \n"
> " .set mips0 \n"
> : "=&r"(ret), "=&r"(tmp), "=&r"(tmp2), "=&r"(sub)
> : "m"(*sem)
> : "memory");
> 
> return ret;
> }
> ---------------------------------------------
> 
> and after synthesized assembly dli becomes:
> 
>      a90:       34048000        li      a0,0x8000
>      a94:       00042478        dsll    a0,a0,0x11
> 
> which is a0=0 (wrong).
> 
> Why is this computation done on 64bit? Should I workaround a 32bit
> implementation of this?
> 
> Subsidiary question: since the 4KEc core is not mentioned explicitely
> in mips gas possible CPUs, I build the kernel code with:
> 
> mipsel-linux-gcc -march=r4600 -mips2 -Wa,-32 -Wa,-march=r4600 -Wa,-mips3
> 
> with gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-113.2) neon
> 
> Is this the correct option?
> 
> Thanks a lot for any clue,
> 
> Sincerely yours,
> 
> E.M.
> 
> 
> 
