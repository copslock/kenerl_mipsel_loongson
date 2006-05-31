Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2006 13:02:46 +0200 (CEST)
Received: from sigrand.ru ([80.66.88.167]:61884 "HELO mail.sigrand.com")
	by ftp.linux-mips.org with SMTP id S8133506AbWEaLCi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2006 13:02:38 +0200
Received: from develop (unknown [192.168.2.238])
	by mail.sigrand.com (Postfix) with ESMTP id 0CA0712A0020;
	Wed, 31 May 2006 18:02:34 +0700 (NOVST)
Date:	Wed, 31 May 2006 18:02:34 +0700
From:	art <art@sigrand.ru>
X-Mailer: The Bat! (v1.38e) S/N A1D26E39 / Educational
Reply-To: art <art@sigrand.ru>
Organization: Sigrand LLC
X-Priority: 3 (Normal)
Message-ID: <8751.060531@sigrand.ru>
To:	linux-mips@linux-mips.org
Cc:	macro@linux-mips.org, ralf@linux-mips.org,
	rongkai.zhan@windriver.com
Subject: Re: Problem with TLB mcheck!
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <art@sigrand.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: art@sigrand.ru
Precedence: bulk
X-list: linux-mips

Hello , All

I think I'm on wright way:
I change /arch/mips/mm/tlbex.c:

--- /home/artpol/router/buildroot/kernels/linux-2.6.16-old/arch/mips/mm/tlbex.c 2006-03-20 11:35:39.000000000 +0000
+++ tlbex.c     2006-05-31 16:57:58.000000000 +0000
@@ -742,7 +742,7 @@
        }
 #endif

-       memcpy((void *)CAC_BASE, tlb_handler, 0x80);
+       memcpy((void *)ebase, tlb_handler, 0x80);
 }

 /*
@@ -838,6 +838,7 @@
                break;

        case CPU_R4300:
+       case CPU_4KC:
        case CPU_5KC:
        case CPU_TX49XX:
        case CPU_AU1000:
@@ -852,13 +853,12 @@

        case CPU_R10000:
        case CPU_R12000:
-       case CPU_4KC:
        case CPU_SB1:
        case CPU_SB1A:
        case CPU_4KSC:
        case CPU_20KC:
        case CPU_25KF:
-               tlbw(p);
+               tlbw(p);
                break;

        case CPU_NEVADA:
@@ -1260,7 +1260,7 @@
        }
 #endif

-       memcpy((void *)CAC_BASE, final_handler, 0x100);
+       memcpy((void *)ebase, final_handler, 0x100);
}

And it seem than no problem now (`cat /bin/busybox > box` work as much
as need!).
I think this is wright way, but not all - I'am not guru in memory
subsystem and can miss something! So wait for your advices!



-- 
Best regards,
 art                          mailto:art@sigrand.ru
