Received:  by oss.sgi.com id <S42207AbQGCRd1>;
	Mon, 3 Jul 2000 10:33:27 -0700
Received: from Cantor.suse.de ([194.112.123.193]:15622 "HELO Cantor.suse.de")
	by oss.sgi.com with SMTP id <S42203AbQGCRdA>;
	Mon, 3 Jul 2000 10:33:00 -0700
Received: from Hermes.suse.de (Hermes.suse.de [194.112.123.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 958921E34C; Mon,  3 Jul 2000 19:33:06 +0200 (MEST)
Received: from arthur.inka.de (Galois.suse.de [10.0.0.1])
	by Hermes.suse.de (Postfix) with ESMTP
	id 0E85910A026; Mon,  3 Jul 2000 19:33:01 +0200 (MEST)
Received: from gromit.rhein-neckar.de ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.14 #1)
	id 139A3P-00030d-00; Mon, 03 Jul 2000 19:30:43 +0200
Received: by gromit.rhein-neckar.de (Postfix, from userid 207)
	id 061DC1822; Mon,  3 Jul 2000 19:30:42 +0200 (CEST)
Mail-Copies-To: never
To:     linux-mips@fnet.fr
Cc:     linux-mips@oss.sgi.com
Subject: FPU Control Word: Initial Value looks wrong
From:   Andreas Jaeger <aj@suse.de>
Date:   03 Jul 2000 19:30:42 +0200
Message-ID: <u8sntrm88t.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Porting glibc to MIPS I noticed that the initial contents of the fpu
control word doesn't seem to be right (at least on the machines I've
tried - one with a normal MIPS 2.2.13 and one with 2.2.15 and the
MIPS/Algorithmics patches (including FPU emulator).

The appended small test program should return a 0 (that's the desired
value by glibc for full ISO C99 support) - but it seems to be set to
0x600.

Could the kernel folks fix this, please?  I grepped through the sources
and didn't find a place where the FPU gets initialised.:-(

Thanks,
Andreas

P.S. Here's the test program:
#include <stdlib.h>

#define _FPU_GETCW(cw) __asm__ ("cfc1 %0,$31" : "=r" (cw) : )
#define _FPU_SETCW(cw) __asm__ ("ctc1 %0,$31" : : "r" (cw))

int
main (void)
{
  int fpucw;

  _FPU_GETCW (fpucw);

  printf ("%x %d\n", fpucw, fpucw);

  return 0;
}


-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
