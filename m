Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Nov 2005 20:46:52 +0000 (GMT)
Received: from web31501.mail.mud.yahoo.com ([68.142.198.130]:47807 "HELO
	web31501.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133604AbVKOUqe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Nov 2005 20:46:34 +0000
Received: (qmail 31992 invoked by uid 60001); 15 Nov 2005 20:48:28 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=A2Zs4rDMkZHnaEMBoyosJ0Qgo+3fI5qm47IalsgD1crx4lJneyQcyHeJTOp9yo6N6k0AZLKSixatgkuO5TuIFZEP1IIfRmtlXaICl8fCwrooW10VFN2ZcjdTchw1QB0S1f2cJ0ou6Wb5jYd6V5EX0sEnR0etdVGK0x52xSmG0r4=  ;
Message-ID: <20051115204828.31990.qmail@web31501.mail.mud.yahoo.com>
Received: from [208.187.37.98] by web31501.mail.mud.yahoo.com via HTTP; Tue, 15 Nov 2005 12:48:28 PST
Date:	Tue, 15 Nov 2005 12:48:28 -0800 (PST)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Problems with Linux kernel on Broadcom SB1
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

Trying to build the Linux kernel currently in the git
archive on a Broadcom SB1 (specifically, the 1250 dual
processor system).

I've not been able to get any of the page sizes other
than the 4K pages to work at all - it stops at boot,
no error messages, just a straight lock-up. If this is
a problem with the SB1, it might be wise to disable
the changing of the page size for that processor.

When enabling GDB support, I get the following
compile-time error:

arch/mips/sibyte/sb1250/irq.c: In function
'arch_init_irq':
arch/mips/sibyte/sb1250/irq.c:385: error: 'kgdb_flag'
undeclared (first use in this function)
arch/mips/sibyte/sb1250/irq.c:385: error: (Each
undeclared identifier is reported only once
arch/mips/sibyte/sb1250/irq.c:385: error: for each
function it appears in.)
arch/mips/sibyte/sb1250/irq.c: In function
'sb1250_kgdb_interrupt':
arch/mips/sibyte/sb1250/irq.c:423: warning: implicit
declaration of function 'set_async_breakpoint'

A quick inspection suggests copy-and-pasting lines 63
to 85 (inclusive) from arch/mips/bcm1480/irq.c to
arch/mips/sb1250/irq.c, overwriting lines 63 to 71, as
the bcm1480 lines seem to be much more up-to-date and
do seem to fix the problem.

The configure options allows me to enable MT on the
SB1, but I'm pretty sure the SB1 does not support MT.
If this is indeed the case, then someone might want to
have this option disabled when the SB1 is selected. In
fact, it might be good to hunt for core-specific
options and have them in their own section. That way,
you don't have obscenely-complex checks for every
option.

ipc/msg.c is giving a bunch of warnings -
setbuf.qbytes, setbuf.uid, setbuf.gid and setbuf.mode
may be being used uninitialized in the sys_msgctl and
the sys_semctl functions. Probably nothing
significant, and GCC does love to throw out errors for
conditions that aren't actually possible, but it
probably wouldn't hurt to see if there's a problem
there.

From time to time, I compile unexpectedly non-working
kernels - does anyone know of a good set of options to
enable to identify where kernel lockups could be
occuring?

Thanks,

Jonathan
(The weirdo with weekly SB1 problems)



	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
