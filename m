Received:  by oss.sgi.com id <S553774AbRBHLUn>;
	Thu, 8 Feb 2001 03:20:43 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:25104 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553768AbRBHLU1>;
	Thu, 8 Feb 2001 03:20:27 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id E64CE7DD; Thu,  8 Feb 2001 12:20:15 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 824DCEEAC; Thu,  8 Feb 2001 12:20:30 +0100 (CET)
Date:   Thu, 8 Feb 2001 12:20:30 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: [RESUME] fpu emulator
Message-ID: <20010208122030.A5408@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Hi,
just to get it right - As i thought the FPU emulator is not really
optional - It is even required for fpu-enabled devices which means
we should clean the code in that way that if the user decides to 
compile in the fpu emulator into the kernel we do an autodetection 
upfront and change some of the entry/exit/lazy_fpu stuff.
If the user decides not to compile in the FPU Emulator he is on his
own and we ignore the whole FPU stuff and simply send SIGILL/SIGFPE
to the processes causing all fpu binarys to fail on non-fpu enabled
kernels.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
