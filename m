Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Apr 2005 23:24:14 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:36562 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225436AbVDBWX6>;
	Sat, 2 Apr 2005 23:23:58 +0100
Received: from drow by nevyn.them.org with local (Exim 4.50 #1 (Debian))
	id 1DHr22-0004ta-0G
	for <linux-mips@linux-mips.org>; Sat, 02 Apr 2005 17:23:54 -0500
Date:	Sat, 2 Apr 2005 17:23:53 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	linux-mips@linux-mips.org
Subject: ptrace and floating point related kernel crash
Message-ID: <20050402222353.GA18450@nevyn.them.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here's a nasty little bug I encountered while debugging some related
problems in GDB.

Compile and run the attached program; I'm not sure if it will demonstrate
the problem on anything with hardware FPU, but at least it works on an SB-1
(using a 32-bit kernel).  The program itself runs fine.  Debug it with GDB,
and set a breakpoint on the ctc1 instruction.  Before it executes, print out
$fsr; it will probably be 0.  After trying to copy 0xf0102 into FSR, print
$fsr again; it will be 0x102.  The program will still complete OK.

Now try again.  After the ctc1 instruction, tell gdb "set $fsr = 0xf0102".
Then continue; the kernel locks up before the program is done.

The extra bits are two bits in the cause field, and two bits in the
reserved-write-as-zero field.  I'm not sure whether setting the reserved
bits is to blame, or whether setting the cause bits raises a floating point
exception in the kernel during context switching.  In any case, it looks
like we ought to be masking out some bits before saving the fcr31 value in
ptrace.

-- 
Daniel Jacobowitz
CodeSourcery, LLC

--XsQoSWH+UP9D9v3l
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="mips-crash.c"

/* This testcase is part of GDB, the GNU debugger.

   Copyright 2004 Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
 
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

*/

#include <stdio.h>
#include <string.h>
#include <signal.h>
#include <sys/time.h>
#include <setjmp.h>

static volatile int done;

static jmp_buf env;

static void
handler (int sig)
{
  done = 1;
  /* NOTE: Don't try this at home; always use siglongjmp to leave
     a signal handler.  */
  longjmp (env, 1);
} /* handler */

struct itimerval itime;
struct sigaction action;

/* The enum is so that GDB can easily see these macro values.  */
enum {
  itimer_real = ITIMER_REAL,
  itimer_virtual = ITIMER_VIRTUAL
} itimer = ITIMER_VIRTUAL;

main ()
{
  /* Set up the signal handler.  */
  memset (&action, 0, sizeof (action));
  action.sa_handler = handler;
  sigaction (SIGVTALRM, &action, NULL);
  sigaction (SIGALRM, &action, NULL);

  /* The values needed for the itimer.  This needs to be at least long
     enough for the setitimer() call to return.  */
  memset (&itime, 0, sizeof (itime));
  itime.it_value.tv_usec = 250 * 1000;

  
  while (setjmp (env) == 0)
    {
      /* Set up a one-off timer.  A timer, rather than SIGSEGV, is
	 used as after a timer handler finishes the interrupted code
	 can safely resume.  */
      setitimer (itimer, &itime, NULL);
      /* Wait.  */
      while (!done);
      done = 0;
    }

  done = 0;
  itimer = itimer_real;

  asm volatile ("ctc1 %0, $31" : : "r" (0x000f0102));

  while (setjmp (env) == 0)
    {
      /* Set up a one-off timer.  A timer, rather than SIGSEGV, is
	 used as after a timer handler finishes the interrupted code
	 can safely resume.  */
      setitimer (itimer, &itime, NULL);
      /* Wait.  */
      while (!done);
      done = 0;
    }
}

--XsQoSWH+UP9D9v3l--
