Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2EDpem04259
	for linux-mips-outgoing; Thu, 14 Mar 2002 05:51:40 -0800
Received: from coplin19.mips.com ([80.63.7.130])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2EDpX904255
	for <linux-mips@oss.sgi.com>; Thu, 14 Mar 2002 05:51:33 -0800
Received: from localhost (kjelde@localhost)
	by coplin19.mips.com (8.11.6/8.11.6) with ESMTP id g2EDqFO22168
	for <linux-mips@oss.sgi.com>; Thu, 14 Mar 2002 14:52:15 +0100
X-Authentication-Warning: coplin19.mips.com: kjelde owned process doing -bs
Date: Thu, 14 Mar 2002 14:52:15 +0100 (CET)
From: Kjeld Borch Egevang <kjelde@mips.com>
To: linux-mips mailing list <linux-mips@oss.sgi.com>
Subject: FPU inexact flag always set for dynamic programs
Message-ID: <Pine.LNX.4.44.0203141431230.22051-100000@coplin19.mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi all.

I've discovered that the inexact bit is always set at startup for a 
program. My test program fenvtest.c:

#include <fenv.h>
#include <stdio.h>

int main()
{
        int retval;

        retval = fetestexcept(FE_ALL_EXCEPT);
        printf("%d\n", retval);
        return 0;
}

And when I run:

cc -o fenvtest fenvtest.c -lm
./fenvtest 

I get:

4

and:

cc -o fenvtest fenvtest.c -lm -static
./fenvtest

I get:

0

Is there something in /lib/ld.so.1 that invalidates the FP csr?


/Kjeld

-- 
_    _ ____  ___                       Mailto:kjelde@mips.com
|\  /|||___)(___    MIPS Denmark       Direct: +45 44 86 55 85
| \/ |||    ____)   Lautrupvang 4 B    Switch: +45 44 86 55 55
  TECHNOLOGIES      DK-2750 Ballerup   Fax...: +45 44 86 55 56
                    Denmark            http://www.mips.com/
