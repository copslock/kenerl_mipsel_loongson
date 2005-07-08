Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2005 13:24:03 +0100 (BST)
Received: from mra04.ex.eclipse.net.uk ([IPv6:::ffff:212.104.129.139]:35976
	"EHLO mra04.ex.eclipse.net.uk") by linux-mips.org with ESMTP
	id <S8226359AbVGHMXj>; Fri, 8 Jul 2005 13:23:39 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mra04.ex.eclipse.net.uk (Postfix) with ESMTP id 0B161133FDF
	for <linux-mips@linux-mips.org>; Fri,  8 Jul 2005 13:24:13 +0100 (BST)
Received: from mra04.ex.eclipse.net.uk ([127.0.0.1])
 by localhost (mra04.ex.eclipse.net.uk [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 26987-01-94 for <linux-mips@linux-mips.org>;
 Fri,  8 Jul 2005 13:24:11 +0100 (BST)
Received: from euskadi.packetvision (unknown [82.152.104.245])
	by mra04.ex.eclipse.net.uk (Postfix) with ESMTP id CB9A5133ADB
	for <linux-mips@linux-mips.org>; Fri,  8 Jul 2005 13:24:03 +0100 (BST)
Subject: Benchmarking RM9000
From:	Alex Gonzalez <linux-mips@packetvision.com>
To:	linux-mips@linux-mips.org
In-Reply-To: <20050708120238.GA2816@linux-mips.org>
References: <20050708091711Z8226352-3678+1954@linux-mips.org>
	 <20050708120238.GA2816@linux-mips.org>
Content-Type: text/plain
Message-Id: <1120825549.28569.949.camel@euskadi.packetvision>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date:	Fri, 08 Jul 2005 13:25:49 +0100
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by Eclipse VIRUSshield at eclipse.net.uk
Return-Path: <linux-mips@packetvision.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@packetvision.com
Precedence: bulk
X-list: linux-mips

Hi,

I am doing some basic benchmarking tests on our RM9000 based platform,
running on just one of the two cores (non-smp kernel).

I would be very interesting in seeing some comparative data as we seem
to experience some performance problems.

Even if no data is available, any comments on this results will also be
appreciated.

Thanks,
Alex

----------------------------------------------------

BYTEmark* Native Mode Benchmark ver. 2 (10/95)
Index-split by Andrew D. Balsa (11/97)
Linux/Unix* port by Uwe F. Mayer (12/96,11/97)
                                                                                                                                                       
TEST                : Iterations/sec.  : Old Index   : New Index
                    :                  : Pentium 90* : AMD K6/233*
--------------------:------------------:-------------:------------
NUMERIC SORT        :          360.48  :       9.24  :       3.04
STRING SORT         :           31.23  :      13.95  :       2.16
BITFIELD            :      8.4132e+07  :      14.43  :       3.01
FP EMULATION        :          32.921  :      15.80  :       3.65
FOURIER             :            3383  :       3.85  :       2.16
ASSIGNMENT          :          4.2422  :      16.14  :       4.19
IDEA                :          1543.3  :      23.60  :       7.01
HUFFMAN             :          382.56  :      10.61  :       3.39
NEURAL NET          :          3.7153  :       5.97  :       2.51
LU DECOMPOSITION    :          209.28  :      10.84  :       7.83
==========================ORIGINAL BYTEMARK RESULTS==========================
INTEGER INDEX       : 14.242
FLOATING-POINT INDEX: 6.291
Baseline (MSDOS*)   : Pentium* 90, 256 KB L2-cache, Watcom* compiler 10.0
==============================LINUX DATA BELOW===============================
CPU                 :
L2 Cache            :
OS                  : Linux 2.6.12-rc3
C compiler          : gcc version 3.3.5
libc                : libc-2.3.5.so
MEMORY INDEX        : 3.010
INTEGER INDEX       : 4.026
FLOATING-POINT INDEX: 3.489
Baseline (LINUX)    : AMD K6/233*, 512 KB L2-cache, gcc 2.7.2.3, libc-5.4.38
* Trademarks are property of their respective holder.
