Received:  by oss.sgi.com id <S553691AbRACAwH>;
	Tue, 2 Jan 2001 16:52:07 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:51705 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553687AbRACAvq>;
	Tue, 2 Jan 2001 16:51:46 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f030nSC25232;
	Tue, 2 Jan 2001 16:49:28 -0800
Message-ID: <3A5277C6.89170BAD@mvista.com>
Date:   Tue, 02 Jan 2001 16:52:22 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com, ralf@oss.sgi.com
Subject: missing data cache flush in trap_init?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Ralf,

Someone reported this bug to me.  I think it is a valid one.  Basically
trap_init() installs the vectors through kseg0 address and then flushes
icache.  It is possible that the vectors are still in the data cache and not
written back to memory yet.  If an exception happens it may get the corrupted
the vector value.

The following patch should fix it.  I am not sure if I can use
flush_cache_range() to have potentially better performance.

Jun


--- linux/arch/mips/kernel/traps.c.orig Tue Jan  2 16:24:16 2001
+++ linux/arch/mips/kernel/traps.c      Tue Jan  2 16:50:59 2001
@@ -767,7 +767,7 @@
        default:
                panic("Unknown CPU type");
        }
-       flush_icache_range(KSEG0, KSEG0 + 0x200);
+       flush_cache_all();
 
        atomic_inc(&init_mm.mm_count);  /* XXX  UP?  */
        current->active_mm = &init_mm;
