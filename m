Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2003 20:54:56 +0100 (BST)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:40589 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225211AbTDVTyz>;
	Tue, 22 Apr 2003 20:54:55 +0100
Received: (qmail 12801 invoked by uid 6180); 22 Apr 2003 19:54:50 -0000
Date: Tue, 22 Apr 2003 12:54:50 -0700
From: Jeff Baitis <baitisj@evolution.com>
To: Pete Popov <ppopov@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Improperly handled case in arch/mips/au1000/common/time.c
Message-ID: <20030422125450.E10148@luca.pas.lab>
Reply-To: baitisj@evolution.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Pete:

While struggling to get Linux up on Evolution's custom board based on the
Au1500, I discovered a poorly handled case in time.c; null interrupts are
handled should not affect the local IRQ count. (if the local IRQ count is not
decremented, tests for in_irq() fail.)

Thanks for taking a look at my patch!

-Jeff

Index: time.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/au1000/common/time.c,v
retrieving revision 1.5.2.10
diff -u -r1.5.2.10 time.c
--- time.c      25 Mar 2003 14:30:19 -0000      1.5.2.10
+++ time.c      22 Apr 2003 19:47:24 -0000
@@ -114,6 +114,7 @@
        return;
 
 null:
+       irq_exit(cpu, irq);
        ack_r4ktimer(0);
 }
