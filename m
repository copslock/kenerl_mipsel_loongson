Received:  by oss.sgi.com id <S42216AbQFYSzT>;
	Sun, 25 Jun 2000 11:55:19 -0700
Received: from Cantor.suse.de ([194.112.123.193]:19468 "HELO Cantor.suse.de")
	by oss.sgi.com with SMTP id <S42183AbQFYSzG>;
	Sun, 25 Jun 2000 11:55:06 -0700
Received: from Hermes.suse.de (Hermes.suse.de [194.112.123.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 892951E0F8; Sun, 25 Jun 2000 20:54:35 +0200 (MEST)
Received: from arthur.inka.de (Galois.suse.de [10.0.0.1])
	by Hermes.suse.de (Postfix) with ESMTP
	id E62D310A109; Sun, 25 Jun 2000 20:54:33 +0200 (MEST)
Received: from gromit.rhein-neckar.de ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.14 #1)
	id 136HXA-0002aq-00; Sun, 25 Jun 2000 20:53:32 +0200
Received: by gromit.rhein-neckar.de (Postfix, from userid 207)
	id 96D8D1821; Sun, 25 Jun 2000 20:53:30 +0200 (CEST)
To:     Ralf Baechle <ralf@uni-koblenz.de>
Cc:     Mike Klar <mfklar@ponymail.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: errno assignment in _syscall macros and glibc
References: <NDBBIDGAOKMNJNDAHDDMCEODCKAA.mfklar@ponymail.com>
	<u8d7l6p0vq.fsf@gromit.rhein-neckar.de>
	<20000625204334.E1572@bacchus.dhis.org>
From:   Andreas Jaeger <aj@suse.de>
Date:   25 Jun 2000 20:53:30 +0200
In-Reply-To: Ralf Baechle's message of "Sun, 25 Jun 2000 20:43:34 +0200"
Message-ID: <u8zoo9mw2d.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

>>>>> Ralf Baechle writes:

Ralf> On Sun, Jun 25, 2000 at 11:26:33AM +0200, Andreas Jaeger wrote:
>> The question remains what we should do with glibc 2.2.  Currently
>> <sys/syscalls.h> includes <asm/unistd.h> and this makes _syscall0 and
>> friends available to userspace. 
>> 
>> I couldn't find any reference to <sys/syscalls.h> in the ABI and
>> consider dropping the include of <asm/unistd.h> since it's not needed
>> at all.
>> 
>> Any objections or better suggestions?

Ralf> I will take his report as a real bug but for another reason.  The kernel
Ralf> has a global variable errno which at least on i386 get the returned
Ralf> error value.  Fixing this one will magically fix userland.

Ralf> Still everybody should be aware that using your own syscall wrappers
Ralf> can be _very_ dangerous.  I saw an attempt to use pread / pwrite which
Ralf> was ok on Intel but might have corrupted data on MIPS due to different
Ralf> calling conventions.  You have been warned.

Ralf> Andreas - I think the syscall interface should finally officially be
Ralf> declared a private interface between libc and the kernel, that is nobody
Ralf> except these two should use it.  Many of the other attempts to use it
Ralf> have been quite problematic - portabilitywise and worse.

I'm considering to commit the appended patch.  I've compiled glibc
with it and didn't notice any problems.  If nobody objects, I'll apply
it tomorrow.

Ralf, are there any other places that needs to be changed?  What do
you think of adding 
#ifdef KERNEL
around _syscallX in <asm/unistd.h> ?

Andreas

2000-06-25  Andreas Jaeger  <aj@suse.de>

	* sysdeps/unix/sysv/linux/mips/sys/syscall.h: Don't include
	<asm/unistd.h> - we don't need any of these at all in glibc or
	user programs.

============================================================
Index: sysdeps/unix/sysv/linux/mips/sys/syscall.h
--- sysdeps/unix/sysv/linux/mips/sys/syscall.h	2000/06/23 07:55:36	1.4
+++ sysdeps/unix/sysv/linux/mips/sys/syscall.h	2000/06/25 18:51:00
@@ -19,11 +19,6 @@
 #ifndef	_SYSCALL_H
 #define	_SYSCALL_H	1
 
-/* This file should list the numbers of the system the system knows.
-   But instead of duplicating this we use the information available
-   from the kernel sources.  */
-#include <asm/unistd.h>
-
 /*
  * SVR4 syscalls are in the range from 1 to 999
  */


-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
