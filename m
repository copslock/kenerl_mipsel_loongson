Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 00:50:15 +0000 (GMT)
Received: from sccrmhc15.comcast.net ([204.127.200.85]:49102 "EHLO
	sccrmhc15.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20021996AbXCTAuM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Mar 2007 00:50:12 +0000
Received: from plexity.net (c-71-193-156-244.hsd1.or.comcast.net[71.193.156.244])
          by comcast.net (sccrmhc15) with ESMTP
          id <20070320004928015001nfgae>; Tue, 20 Mar 2007 00:49:28 +0000
Received: by plexity.net (Postfix, from userid 1025)
	id 3E51E54494A; Mon, 19 Mar 2007 16:49:45 -0700 (PDT)
Date:	Mon, 19 Mar 2007 16:49:45 -0700
From:	Deepak Saxena <dsaxena@plexity.net>
To:	mingo@elte.hu
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Manish Lachwani <mlachwani@mvista.com>
Subject: [PATCH] Make MIPS udelay() preempt safe
Message-ID: <20070319234945.GA11944@plexity.net>
Reply-To: dsaxena@plexity.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.11
Return-Path: <dsaxena@plexity.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14575
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dsaxena@plexity.net
Precedence: bulk
X-list: linux-mips

Fix MIPS udelay to make is preempt safe under DEBUG_PREEMPT

Signed-off-by: Manish Lachwani <mlachwani@mvista.com>
Signed-off-by: Deepak Saxena <dsaxena@mvista.com>

---

This needs to go into -rt patch set or directly into the MIPS tree.
Applies cleanly to 2.6.21-rc4 and 2.6.21-rc3-rt0.

 include/asm-mips/delay.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18/include/asm-mips/delay.h
===================================================================
--- linux-2.6.18.orig/include/asm-mips/delay.h
+++ linux-2.6.18/include/asm-mips/delay.h
@@ -79,7 +79,7 @@ static inline void __udelay(unsigned lon
 	__delay(usecs);
 }
 
-#define __udelay_val cpu_data[smp_processor_id()].udelay_val
+#define __udelay_val cpu_data[raw_smp_processor_id()].udelay_val
 
 #define udelay(usecs) __udelay((usecs),__udelay_val)
 

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

In the end, they will not say, "those were dark times,"  they will ask
"why were their poets silent?" - Bertolt Brecht
