Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8D1Xtx25261
	for linux-mips-outgoing; Wed, 12 Sep 2001 18:33:55 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8D1Xne25257
	for <linux-mips@oss.sgi.com>; Wed, 12 Sep 2001 18:33:49 -0700
Received: from dea.linux-mips.net (u-112-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.112]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA02580
	for <linux-mips@oss.sgi.com>; Wed, 12 Sep 2001 18:33:41 -0700 (PDT)
	mail_from (ralf@linux-mips.net)
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f8D1BJN27520;
	Thu, 13 Sep 2001 03:11:19 +0200
Date: Thu, 13 Sep 2001 03:11:19 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@oss.sgi.com
Subject: Re: setup_frame() failure
Message-ID: <20010913031119.B27168@dea.linux-mips.net>
References: <20010907.202652.71083122.nemoto@toshiba-tops.co.jp> <20010908013638.A19154@dea.linux-mips.net> <20010910.114402.41626914.nemoto@toshiba-tops.co.jp> <20010912.130914.112630116.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010912.130914.112630116.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Wed, Sep 12, 2001 at 01:09:14PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Sep 12, 2001 at 01:09:14PM +0900, Atsushi Nemoto wrote:

> nemoto> But, does not a debugger confused by skipping the instruction
> nemoto> which cause Trap or Breakpoint exception?  (I do not know much
> nemoto> about communication between kernel and debugger...)
> 
> I tried same fix for Trap exception (I inserted compute_return_epc()
> before force_sig(SIGTRAP, current) line in do_tr()).  With this fix,
> gdb did not work correctly.
> 
> So we should take another fix (at least for Trap exception) ?

Below a fix.  It's not the real thing but at least solved the problem
pretty reliable as normal compiler generated code will never place trap
and break instructions in delay slots.  The actual fix should be skipping
over the faulting instruction when returning from the signal handler.

  Ralf

Index: arch/mips64/kernel/traps.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips64/kernel/traps.c,v
retrieving revision 1.21
diff -u -r1.21 traps.c
--- arch/mips64/kernel/traps.c 2001/09/07 23:35:57 1.21  
+++ arch/mips64/kernel/traps.c 2001/09/13 01:01:25   
@@ -291,7 +291,7 @@
 			info.si_code = FPE_INTOVF;
 		info.si_signo = SIGFPE;
 		info.si_errno = 0;
-		info.si_addr = (void *)compute_return_epc(regs);
+		info.si_addr = (void *)regs->cp0_epc;
 		force_sig_info(SIGFPE, &info, current);
 		break;
 	default:
@@ -333,7 +333,7 @@
 			info.si_code = FPE_INTOVF;
 		info.si_signo = SIGFPE;
 		info.si_errno = 0;
-		info.si_addr = (void *)compute_return_epc(regs);
+		info.si_addr = (void *)regs->cp0_epc;
 		force_sig_info(SIGFPE, &info, current);
 		break;
 	default:
Index: arch/mips/kernel/traps.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/kernel/traps.c,v
retrieving revision 1.79
diff -u -r1.79 traps.c
--- arch/mips/kernel/traps.c 2001/09/07 23:35:57 1.79  
+++ arch/mips/kernel/traps.c 2001/09/13 01:01:25   
@@ -424,7 +424,7 @@
 			info.si_code = FPE_INTOVF;
 		info.si_signo = SIGFPE;
 		info.si_errno = 0;
-		info.si_addr = (void *)compute_return_epc(regs);
+		info.si_addr = (void *)regs->cp0_epc;
 		force_sig_info(SIGFPE, &info, current);
 		break;
 	default:
@@ -464,7 +464,7 @@
 			info.si_code = FPE_INTOVF;
 		info.si_signo = SIGFPE;
 		info.si_errno = 0;
-		info.si_addr = (void *)compute_return_epc(regs);
+		info.si_addr = (void *)regs->cp0_epc;
 		force_sig_info(SIGFPE, &info, current);
 		break;
 	default:
