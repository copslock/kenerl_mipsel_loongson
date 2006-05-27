Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 May 2006 23:13:37 +0200 (CEST)
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:37776 "EHLO
	rwcrmhc12.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8133743AbWE0VN3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 27 May 2006 23:13:29 +0200
Received: from [127.0.0.1] (unknown[69.140.185.142])
          by comcast.net (rwcrmhc12) with ESMTP
          id <20060527211322m1200iteb7e>; Sat, 27 May 2006 21:13:22 +0000
Message-ID: <4478C0F1.8000006@gentoo.org>
Date:	Sat, 27 May 2006 17:13:21 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
CC:	akpm@osdl.org
Subject: Commit 78eef01b0fae087c5fadbd85dd4fe2918c3a015f (on_each_cpu(): disable
 local interrupts) Breaks SGI IP32
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips


Finally managed to track down the git commit causing SGI IP32 (O2) systems to 
lock up really early in the boot cycle, but I'm at a loss to understand why.

Effect:
It appears the system silently hangs somewhere in the void between function 
calls when trying to invoke the memset() call in __alloc_bootmem_core() in 
mm/bootmem.c.  This puts the machine hardware in a state such that a simple soft 
reset doesn't clear it -- the machine has to be cold booted to get it to boot a 
working kernel again.

Determined Cause:
It seems this commit:
78eef01b0fae087c5fadbd85dd4fe2918c3a015f
	[PATCH] on_each_cpu(): disable local interrupts

Is the cause.  I've verified this by reversing this one change on a 2.6.17-rc4 
tree, and it'll boot to a mini-userland (initramfs-based) and appears to 
function normally.


But this is as far as I can trace this.  I'm not sure what this change is doing 
internally that's triggering this lockup on O2 systems.  It doesn't appear to 
affect Octane (IP30) systems or Origin (IP27).  I haven't test-ran it on 
IP22/IP28 hardware yet, so only IP32 is known to be affected.  Unsure about 
non-SGI MIPS hardware.

Thoughts?


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
