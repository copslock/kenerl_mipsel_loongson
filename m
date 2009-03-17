Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Mar 2009 06:32:04 +0000 (GMT)
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:34030 "EHLO
	tyo202.gate.nec.co.jp") by ftp.linux-mips.org with ESMTP
	id S21367164AbZCQGb5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Mar 2009 06:31:57 +0000
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n2H6Vr2N019705;
	Tue, 17 Mar 2009 15:31:53 +0900 (JST)
Received: from realmbox21.aps.necel.com ([10.29.19.28] [10.29.19.28]) by relay11.aps.necel.com with ESMTP; Tue, 17 Mar 2009 15:31:53 +0900
Received: from [10.114.181.78] ([10.114.181.78] [10.114.181.78]) by mbox02.aps.necel.com with ESMTP; Tue, 17 Mar 2009 15:31:53 +0900
Message-Id: <49BF4410.8080006@necel.com>
Date:	Tue, 17 Mar 2009 15:32:48 +0900
From:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: MIPS: Enable prefetch option for VR5500 processor
References: <49ACF2EF.3080903@necel.com>
In-Reply-To: <49ACF2EF.3080903@necel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

MIPS: Enable prefetch option for VR5500 processor

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
Hi Ralf,

I haven't finished fixing up for VR5500 processor support, sigh :-(
I hope this is the last one, and don't miss anything essential.

  Shinya

 arch/mips/mm/c-r4k.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index c43f4b2..b42b9d2 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -781,6 +781,7 @@ static void __cpuinit probe_pcache(void)
 		c->dcache.waybit = 0;
 
 		c->options |= MIPS_CPU_CACHE_CDEX_P;
+		c->options |= MIPS_CPU_PREFETCH;
 		break;
 
 	case CPU_TX49XX:
