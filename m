Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2006 18:23:08 +0100 (BST)
Received: from web31512.mail.mud.yahoo.com ([68.142.198.141]:33433 "HELO
	web31512.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8134021AbWFGRW7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Jun 2006 18:22:59 +0100
Received: (qmail 47983 invoked by uid 60001); 7 Jun 2006 17:22:52 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=MlgPv92hWxCOwMvaKhPd8NiHUARnfJI6sowEeoBqiU0zx458zbXnyT0xDWeLXbnOfRSk2QNKhGyNeHImJ/OYKvIC608i2aycAdGWeziXqUdwig6bgoteohtyAmPNOoUzYyGMcrmg0eQfIwtiT+eCg5pll7W2Lw/j8s/va5K70MI=  ;
Message-ID: <20060607172252.47981.qmail@web31512.mail.mud.yahoo.com>
Received: from [208.187.37.98] by web31512.mail.mud.yahoo.com via HTTP; Wed, 07 Jun 2006 10:22:52 PDT
Date:	Wed, 7 Jun 2006 10:22:52 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Performance counters and profiling on MIPS
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

hi,

Two quick and semi-related questions for the Gurus of
the MIPS. First off, it would appear that profiling on
any of the Broadcom MIPS processors is broken. I get
the following warnings when compiling the
platform-specific irq.c file:

  CC      arch/mips/sibyte/sb1250/irq.o
arch/mips/sibyte/sb1250/irq.c: In function
'plat_irq_dispatch':
arch/mips/sibyte/sb1250/irq.c:462: warning: implicit
declaration of function 'sbprof_cpu_intr'
arch/mips/sibyte/sb1250/irq.c:467: warning: implicit
declaration of function 'sb1250_timer_interrupt'
arch/mips/sibyte/sb1250/irq.c:471: warning: implicit
declaration of function 'sb1250_mailbox_interrupt'

On linking, it's revealed why the declarations are
implicit:

arch/mips/sibyte/sb1250/built-in.o: In function
`plat_irq_dispatch':
arch/mips/sibyte/sb1250/irq.c:462: undefined reference
to `sbprof_cpu_intr'
arch/mips/sibyte/sb1250/irq.c:462: relocation
truncated to fit: R_MIPS_26 against `sbprof_cpu_intr'
arch/mips/sibyte/sb1250/irq.c:462: undefined reference
to `sbprof_cpu_intr'
arch/mips/sibyte/sb1250/irq.c:462: relocation
truncated to fit: R_MIPS_26 against `sbprof_cpu_intr'

Actually, with the code as it is in the git
repository, you will also get:

arch/mips/sibyte/sb1250/irq.c:461: undefined reference
to `exception_epc'

But this can be fixed by adding the following line to
irq.c in the asm block of includes:

#include <asm/branch.h>

The primary function, sbprof_cpu_intr(), seems to be
missing. It is called in the bcm1480 and sb1250
versions of irq.c. I looked but couldn't see anything
comparable in any other Sibyte directories, any other
MIPS architectures in general, or indeed in any other
architecture in general.

The ZBus profiling is also broken, showing some signs
of being a little stale. This one's not quite so
important to me, but it would still be very useful:

arch/mips/sibyte/sb1250/bcm1250_tbprof.c: In function
'sbprof_tb_ioctl':
arch/mips/sibyte/sb1250/bcm1250_tbprof.c:362: error:
expected expression before
'wait_queue_t'
arch/mips/sibyte/sb1250/bcm1250_tbprof.c:363: error:
'wait' undeclared (first use in this function)
arch/mips/sibyte/sb1250/bcm1250_tbprof.c:363: error:
(Each undeclared identifier is reported only once
arch/mips/sibyte/sb1250/bcm1250_tbprof.c:363: error:
for each function it appears in.)
arch/mips/sibyte/sb1250/bcm1250_tbprof.c: In function
'sbprof_tb_init':
arch/mips/sibyte/sb1250/bcm1250_tbprof.c:396: warning:
format '%lld' expects type 'long long int', but
argument 2 has type 'u_int64_t'

Ok, so my first question is: who (if anyone) is
working on the profiling code and are there any
patches - regardless of how experimental - that will
get this part of the code working?

My second question is with regards to accessing the
performance counters and timestamp counters from
userspace. On some architectures, this is as simple as
using a single macro.

In the case of the ix86 architecture (yuk!), the
timestamp counters can be read with nothing more than
an rdtsc() call, as follows:

asm volatile ("rdtsc" : "=a"(*(elg_ui4
*)&clock_value),
                "=d"(*(((elg_ui4 *)&clock_value)+1)));

What is the closest equiv. for the MIPS processors?

Jonathan


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
