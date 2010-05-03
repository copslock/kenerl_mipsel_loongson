Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 May 2010 04:17:37 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:36970 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490998Ab0ECCRc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 May 2010 04:17:32 +0200
Received: by gwaa12 with SMTP id a12so917544gwa.36
        for <linux-mips@linux-mips.org>; Sun, 02 May 2010 19:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:subject
         :message-id:from:date;
        bh=SFnLroP715+cuivI+P+r7rvGobcTjRZtEVbh+JHVvwg=;
        b=V04sM1BEjt2dsJ4dhKBq3PLvudrgtrQaDIxlMzzy2DfLv0f2VxLeNYxg3yvGD9ix4a
         lS49p35jeoi4NSCwdkHCyJ1E6zRpp82yb+dwF71+/lRwoqtQZjDlmhNcb2pUINk9KdtI
         eX4nOXiCZT5ZjEb+/ONLECOlhSxuL5Lz5YzoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:subject:message-id:from:date;
        b=mShrfjJxyAEZ1QgfQTqbcXW61wWHt5EBVpZCJldWSPZQtUxQzN6RWA1aHd8fcHzNLw
         ucoupeNPNeeJw3ySJESUng5tnzGyY1vhGxsAFTn1kLxhw5k5Sg0avg/nDAJAbgBgU3Qq
         Vz7h/wwxNKvba1j7KxGf7ZRcowq/SzGczeDyY=
Received: by 10.101.173.17 with SMTP id a17mr1346670anp.89.1272853045994;
        Sun, 02 May 2010 19:17:25 -0700 (PDT)
Received: from localhost ([207.47.250.203])
        by mx.google.com with ESMTPS id 22sm3915701iwn.0.2010.05.02.19.17.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 19:17:24 -0700 (PDT)
Received: from shane by localhost with local (Exim 4.69)
        (envelope-from <shane@localhost>)
        id 1O8lDn-0000Sk-86
        for linux-mips@linux-mips.org; Sun, 02 May 2010 20:17:23 -0600
To:     linux-mips@linux-mips.org
Subject: Unexpected behaviour when catching SIGFPE on FPU-less system
Message-Id: <E1O8lDn-0000Sk-86@localhost>
From:   Shane McDonald <mcdonald.shane@gmail.com>
Date:   Sun, 02 May 2010 20:17:23 -0600
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

I have run into some strange behaviour involving using the FPU
emulation software in the MIPS kernel when trying to handle
a divide-by-zero-caused floating point exception.

I have come up with a simple test case to demonstrate this problem.
--
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <fenv.h>
#include <setjmp.h>

void fpe_handler(int);

jmp_buf env;

main()
{
	double x;

	feenableexcept( FE_DIVBYZERO );
	signal( SIGFPE, fpe_handler );

	if ( setjmp( env ) == 0 )
	{
		printf( "About to try calculation\n" );
	
		x = 5.0 / 0.0;
		printf( "Value is %f\n", x );
	}
	else
	{
		printf( "Calculation causes divide by zero\n" );
	}
}

void fpe_handler(int x)
{
	feclearexcept( FE_DIVBYZERO );
	longjmp( env, 1 );
}
--

The program sets up to generate a SIGFPE when a divide-by-zero occurs,
rather than setting the result to infinity.  Then, I've created a
handler to catch the exception, and the end result is to print out
the "Calculation causes divide by zero" message.

I have two MIPS-based systems, both running Debian Etch.  One of the
systems is a PMC-Sierra RM7035C-based system, which includes an FPU.  My
other system is a PMC-Sierra MSP7120-based system, which does not
include an FPU.  The RM7035C system is running the 2.6.34-rc6 kernel,
but the MSP7120 system is running 2.6.28.

When I run this program on the system with the FPU, I see the results
that I expect to see.  The program outputs:

    About to try calculation
    Calculation causes divide by zero

I see the same results when I run the program on an x86 Debian Etch system.

When I run the program on the system without the FPU, I see:

    About to try calculation
    Floating point exception

So, it appears that the floating point exception is not caught.
However, when I run strace, the last few lines of output are:

    old_mmap(NULL, 65536, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ace9000
    write(1, "About to try calculation\n"..., 25About to try calculation
    ) = 25
    --- SIGFPE (Floating point exception) @ 0 (0) ---
    --- SIGFPE (Floating point exception) @ 0 (0) ---
    +++ killed by SIGFPE +++

Running it on the system with the FPU, I see:

    old_mmap(NULL, 65536, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ace5000
    write(1, "About to try calculation\n"..., 25About to try calculation
    ) = 25
    --- SIGFPE (Floating point exception) @ 0 (0) ---
    write(1, "Calculation causes divide by zero"..., 34Calculation causes divide by zero
    ) = 34
    exit_group(34)                          = ?

After poking around for a while, and trying to account for differences
between the systems (endianness, FPUness, kernel version), I believe the
problem is related to the lack of FPU.  If I run the RM7035C with a
disabled FPU (kernel parameter nofpu), I see the same results as on
the FPU-less MSP7120.  So, I suspect this difference in behaviour
is caused by the FPU emulation software.

Now, I don't know if this is a problem, but it does seem strange.
My level of understanding of the FPU emulation software is very low,
so I'm not quite sure where to look.

This isn't actually something that I typically do.  I noticed this
problem when trying to understand why the Debian package "yorick"
failed to build (see
http://lists.debian.org/debian-mips/2010/04/msg00019.html).

I'd appreciate any insight that anyone can provide.  Thanks!

Shane McDonald
