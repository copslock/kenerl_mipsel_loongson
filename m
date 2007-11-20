Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2007 18:07:02 +0000 (GMT)
Received: from mail.zeugmasystems.com ([192.139.122.66]:6604 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20029780AbXKTSGx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Nov 2007 18:06:53 +0000
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: futex_wake_op deadlock?
Date:	Tue, 20 Nov 2007 10:06:44 -0800
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C54DCF9F@exchange.ZeugmaSystems.local>
In-Reply-To: <20071120112051.GB30675@linux-mips.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: futex_wake_op deadlock?
Thread-Index: AcgrZ5b0yPwptPInTAa6l6KjBurCtwAN3L6w
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
>         __asm__ __volatile__(
>         "       .set    push                            \n"
>         "       .set    noat                            \n"
>         "       .set    mips3                           \n"
>         "1:     ll      %1, %4  # __futex_atomic_op     \n"
>         "       .set    mips0                           \n"
>         "       " insn  "                               \n"
>         "       .set    mips3                           \n"
>         "2:     sc      $1, %2                          \n"
>         "       beqz    $1, 1b                          \n"        
>         __WEAK_LLSC_MB "3:                                           
>         \n" "       .set    pop                             \n"
>         "       .set    mips0                           \n"
>         "       .section .fixup,\"ax\"                  \n"
>         "4:     li      %0, %6                          \n"
>         "       j       2b                              \n"	<-----
>         "       .previous                               \n"
>         "       .section __ex_table,\"a\"               \n"
>         "       "__UA_ADDR "\t1b, 4b                    \n"
>         "       "__UA_ADDR "\t2b, 4b                    \n"
>         "       .previous                               \n"
>         : "=r" (ret), "=&r" (oldval), "=R" (*uaddr)
>         : "0" (0), "R" (*uaddr), "Jr" (oparg), "i" (-EFAULT)        
> : "memory"); 
> 
> Notice the branch at the end of the fixup code, it goes back to the
> SC instruction. 

Hi Ralf,

I had gone through all that code, but didn't see it!

The problem is I didn't pay enough attention because I didn't suspect it
enough.

I was misled by the backtrace address in the soft lockup dump, which
points to one instruction /before/ the ll instruction. So I thought that
the lockup is somewhere outside of that loop, right?

Does the backward branch on MIPS set up the instruction pointer in such
a way that if an interrupt goes off, it can be pointing to the previous
instruction? I thought about that possibility.
