Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7GBBc024260
	for linux-mips-outgoing; Thu, 16 Aug 2001 04:11:38 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7GBBaj24257
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 04:11:36 -0700
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 16 Aug 2001 11:11:36 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms2.toshiba-tops.co.jp (Postfix) with ESMTP
	id 7B8D054C0E; Thu, 16 Aug 2001 20:11:34 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id UAA70606; Thu, 16 Aug 2001 20:11:34 +0900 (JST)
Date: Thu, 16 Aug 2001 20:15:50 +0900 (JST)
Message-Id: <20010816.201550.15258322.nemoto@toshiba-tops.co.jp>
To: kevink@mips.com
Cc: wgowcher@yahoo.com, linux-mips@oss.sgi.com
Subject: Re: Benchmark performance
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <005b01c12633$813c8820$0deca8c0@Ulysses>
References: <20010813173446.61234.qmail@web11901.mail.yahoo.com>
	<20010816125652N.nemoto@toshiba-tops.co.jp>
	<005b01c12633$813c8820$0deca8c0@Ulysses>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Thu_Aug_16_20:15:50_2001_358)--"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

----Next_Part(Thu_Aug_16_20:15:50_2001_358)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

>>>>> On Thu, 16 Aug 2001 11:11:56 +0200, "Kevin D. Kissell" <kevink@mips.com> said:
>> I do not know this is really desired behavior, but here is a patch
>> to change this.  If Unimplemented exception had been occured during
>> the benchmark, aplying this patch may result better performance.

kevink> Not desired behavior, just an artifact.  However, I agree with
kevink> Carsten that changing the API to the emulator for this and
kevink> using a counter as you have done is not appropriate, and that
kevink> the existing CPU configuration flag is a more appriate mechanism.

I see.  I created that patch while debugging time an another FPU
emulator's problem (as I reported in another message) on CPU with real
FPU.  Now the 'counter' method is not needed at all.

Although another fix by Ralf is ready, here is my new patch.

---
Atsushi Nemoto

----Next_Part(Thu_Aug_16_20:15:50_2001_358)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="fpu_emu.patch"

diff -ur linux.sgi/arch/mips/math-emu/cp1emu.c linux/arch/mips/math-emu/cp1emu.c
--- linux.sgi/arch/mips/math-emu/cp1emu.c	Sun Aug  5 23:39:27 2001
+++ linux/arch/mips/math-emu/cp1emu.c	Thu Aug 16 19:41:35 2001
@@ -48,6 +48,8 @@
 #include <asm/mipsregs.h>
 #include <asm/system.h>
 #include <asm/pgtable.h>
+#include <asm/cpu.h>
+#include <asm/bootinfo.h>
 
 #include <asm/fpu_emulator.h>
 
@@ -1682,6 +1684,8 @@
 			sig = cop1Emulate(xcp, ctx);
 		else
 			xcp->cp0_epc += 4;	/* skip nops */
+		if (mips_cpu.options & MIPS_CPU_FPU)
+			break;
 	} while (xcp->cp0_epc > prevepc && sig == 0);
 
 	/* SIGILL indicates a non-fpu instruction */

----Next_Part(Thu_Aug_16_20:15:50_2001_358)----
