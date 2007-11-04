Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Nov 2007 18:59:36 +0000 (GMT)
Received: from mx.mips.com ([63.167.95.198]:43002 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20030957AbXKDS71 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 4 Nov 2007 18:59:27 +0000
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id lA4IwmeC006509;
	Sun, 4 Nov 2007 10:58:48 -0800 (PST)
Received: from Ulysses (vpn123 [192.168.3.123])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id lA4IxFhN024897;
	Sun, 4 Nov 2007 10:59:15 -0800 (PST)
Message-ID: <002801c81f14$ddda0900$7b03a8c0@Ulysses>
From:	"Kevin D. Kissell" <KevinK@mips.com>
To:	<KokHow.Teh@infineon.com>, <linux-mips@linux-mips.org>
References: <31E09F73562D7A4D82119D7F6C17298602B11510@sinse303.ap.infineon.com>
Subject: Re: Get stuck in wake_up_process(rq->migration_thread);
Date:	Sun, 4 Nov 2007 10:59:45 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1896
Return-Path: <KevinK@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KevinK@mips.com
Precedence: bulk
X-list: linux-mips

Your description isn't much to go on, but the first thing I'd look at
in such a situation would be the state of the Cause and Status registers
on the two VPEs. Cross-VPE scheduling interrupts on the standard
emulation platform, which lacks hardware support for cross-VPE
interrupts, sends IPIs by reaching across using MTTR instructions
and setting a software interrupt bit on the other VPE.  Other uses
of the same software interrupt (SW1 by default), or manipulations
in other kernel code that might clear its IM bit in the Status register,
could cause that mechanism to break down and cease processing
interprocessor interrupts.  It's a common failure mode if one botches
a mod to SMTC, and I've seen it on an SMVP port as well.

            Kevin K.

----- Original Message ----- 
From: <KokHow.Teh@infineon.com>
To: <linux-mips@linux-mips.org>
Sent: Sunday, November 04, 2007 3:26 AM
Subject: Get stuck in wake_up_process(rq->migration_thread);


> Hi;
> I have a linux-2.6.20 kernel configured with CONFIG_MIPS_MT_SMP
> (SMVPE) running on a MIPS34KC processor emulation platform. Everything
> goes fine until the scheduler gets stuck in trying to wake up the
> migration thread. I configured the kernel with max_cache_size=2097152,
> having no idea of what the variable is all about. Putting debug messages
> in kernel/sched.c tells me that the the migration_thread() routine has
> gone to sleep calling schedul() function and set_cpus_allowed() function
> gets stuck in wake_up_process(rq->migration_thread); 
> Any insight is appreciated.
> 
> Regards.
> KH
> 
> 
