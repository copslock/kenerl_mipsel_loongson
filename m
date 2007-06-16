Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jun 2007 21:48:45 +0100 (BST)
Received: from farad.aurel32.net ([82.232.2.251]:33060 "EHLO mail.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20024456AbXFPUsm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 16 Jun 2007 21:48:42 +0100
Received: from farad.aurel32.net ([2001:618:400:fc13:216:3eff:fe00:100c])
	by mail.aurel32.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <aurel32@farad.aurel32.net>)
	id 1HzfCF-0006tq-7F; Sat, 16 Jun 2007 22:48:35 +0200
Received: from aurel32 by farad.aurel32.net with local (Exim 4.63)
	(envelope-from <aurel32@farad.aurel32.net>)
	id 1HzfCE-00009z-OS; Sat, 16 Jun 2007 22:48:34 +0200
Date:	Sat, 16 Jun 2007 22:48:34 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	linux-mips@linux-mips.org
Cc:	qemu-devel@nongnu.org
Subject: 2.6.21 kernel on emulated/real Malta board
Message-ID: <20070616204834.GA610@farad.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurel32@farad.aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Hi all,

Since I switch to 2.6.21 kernel on my emulated Malta board (QEMU), I
have noticed something strange. The kernel starts to boot up to the
timer calibration, and then it restart the boot again. A small example:

  ...

  Primary data cache 0kB, 4-way, linesize 0 bytes.
  Synthesized TLB refill handler (36 instructions).
  Synthesized TLB load handler fastpath (48 instructions).
  Synthesized TLB store handler fastpath (48 instructions).
  Synthesized TLB modify handler fastpath (47 instructions).
  Enable cache parity protection for MIPS 20KC/25KF CPUs.
  PID hash table entries: 512 (order: 9, 4096 bytes)
  CPU frequency 100.00 MHz
  Using 100.003 MHz high precision timer.
  Linux version 2.6.21.1 (aurel32@i386) (gcc version 4.1.1 ()) #1 Tue May 15 12:22:07 CEST 2007

  LINUX started...
  CPU revision is: 000182a0
  FPU revision is: 000f8200

  ...

I have traced the problem down to the CONFIG_EARLY_PRINTK option. 
Disabling it in the .config file (be aware that running make *config 
will reenable this function), removes the problem.

The problem occurs for kernel 2.6.21 from both linux-mips.org and
kernel.org, on both endianness, and for both 32- and 64-bit kernels.

It would be nice if somebody could tell me if the real board (I don't
own one) suffers from the same problem or not, so that I can look for a
possible bug in QEMU.

Thanks,
Aurelien

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
