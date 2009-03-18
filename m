Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Mar 2009 00:03:19 +0000 (GMT)
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:50601 "EHLO
	tyo201.gate.nec.co.jp") by ftp.linux-mips.org with ESMTP
	id S21369220AbZCRADK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Mar 2009 00:03:10 +0000
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n2I02qO3005077;
	Wed, 18 Mar 2009 09:03:06 +0900 (JST)
Received: from realmbox21.aps.necel.com ([10.29.19.32] [10.29.19.32]) by relay11.aps.necel.com with ESMTP; Wed, 18 Mar 2009 09:03:06 +0900
Received: from [10.114.181.78] ([10.114.181.78] [10.114.181.78]) by mbox02.aps.necel.com with ESMTP; Wed, 18 Mar 2009 09:03:06 +0900
Message-Id: <49C03A71.1070905@necel.com>
Date:	Wed, 18 Mar 2009 09:04:01 +0900
From:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH revised] MIPS: Enable prefetch option for VR5500 processor
References: <49ACF2EF.3080903@necel.com> <49BF4410.8080006@necel.com> <49BFD438.3070805@ru.mvista.com>
In-Reply-To: <49BFD438.3070805@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
Hi,

Sergei Shtylyov wrote:
>     Why not:
> 
>          c->options |= MIPS_CPU_CACHE_CDEX_P | MIPS_CPU_PREFETCH;

Thank you, patch revised.

  Shinya

 arch/mips/mm/c-r4k.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index c43f4b2..871e828 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -780,7 +780,7 @@ static void __cpuinit probe_pcache(void)
 		c->dcache.ways = 2;
 		c->dcache.waybit = 0;
 
-		c->options |= MIPS_CPU_CACHE_CDEX_P;
+		c->options |= MIPS_CPU_CACHE_CDEX_P | MIPS_CPU_PREFETCH;
 		break;
 
 	case CPU_TX49XX:
