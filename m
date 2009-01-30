Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2009 18:43:55 +0000 (GMT)
Received: from rtp-iport-1.cisco.com ([64.102.122.148]:29201 "EHLO
	rtp-iport-1.cisco.com") by ftp.linux-mips.org with ESMTP
	id S21366066AbZA3Snw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2009 18:43:52 +0000
X-IronPort-AV: E=Sophos;i="4.37,352,1231113600"; 
   d="scan'208";a="35439582"
Received: from rtp-dkim-1.cisco.com ([64.102.121.158])
  by rtp-iport-1.cisco.com with ESMTP; 30 Jan 2009 18:43:42 +0000
Received: from rtp-core-1.cisco.com (rtp-core-1.cisco.com [64.102.124.12])
	by rtp-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id n0UIhg1J024836;
	Fri, 30 Jan 2009 13:43:42 -0500
Received: from xbh-rtp-211.amer.cisco.com (xbh-rtp-211.cisco.com [64.102.31.102])
	by rtp-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id n0UIhggv012412;
	Fri, 30 Jan 2009 18:43:42 GMT
Received: from xmb-rtp-218.amer.cisco.com ([64.102.31.117]) by xbh-rtp-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 30 Jan 2009 13:43:42 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] MIPS: Allocate exception vector on 64 KiB boundary
Date:	Fri, 30 Jan 2009 13:43:42 -0500
Message-ID: <FF038EB85946AA46B18DFEE6E6F8A28982392E@xmb-rtp-218.amer.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] MIPS: Allocate exception vector on 64 KiB boundary
Thread-Index: AcmDCqxxcwzDWyJoRLCej1ccrrdgBw==
From:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
To:	<linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
	"David Daney" <ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 30 Jan 2009 18:43:42.0452 (UTC) FILETIME=[AC8BBB40:01C9830A]
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1434; t=1233341022; x=1234205022;
	c=relaxed/simple; s=rtpdkim1001;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20=22David=20VomLehn=20(dvomlehn)=22=20<dvomlehn@cis
	co.com>
	|Subject:=20[PATCH]=20MIPS=3A=20Allocate=20exception=20vect
	or=20on=2064=20KiB=20boundary
	|Sender:=20
	|To:=20<linux-mips@linux-mips.org>,=20<ralf@linux-mips.org>
	,=0A=20=20=20=20=20=20=20=20=22David=20Daney=22=20<ddaney@ca
	viumnetworks.com>;
	bh=1fPf7N58tN7YZWhB1AIoYIBqO60adTZQriJQ7euI2hA=;
	b=XLZSPPIp8iEtRs/p9YVbOluSRm7EkqWBoqBilq2iiuUfW88ImMZNA29zJP
	VtRhQbeVcgmIno6LhQv1+kgWGwv4MS9SkCUQIUEWY/GHDdAm1xpXi4M7IBOx
	/asHqD7U0d;
Authentication-Results:	rtp-dkim-1; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/rtpdkim1001 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Fix problem with code that incorrectly modifies ebase.

Commit 566f74f6b2f8b85d5b8d6caaf97e5672cecd3e3e had a change that
incorrectly
modified ebase. This backs out the lines that modified ebase and then
modified
the code to allocate the exception vector with an alignment that
guarantees
that bits 15..12 are always zero. This is a good thing in any case as it
will work regardless of the interrupt vector spacing, and may be what
the
original code was attempting to accomplish.

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
---
 arch/mips/kernel/traps.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 3530561..a0ce7fc 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1571,8 +1571,6 @@ void __cpuinit set_uncached_handler(unsigned long
offset, void *addr,
 #ifdef CONFIG_64BIT
 	unsigned long uncached_ebase = TO_UNCAC(ebase);
 #endif
-	if (cpu_has_mips_r2)
-		ebase += (read_c0_ebase() & 0x3ffff000);
 
 	if (!addr)
 		panic(panic_null_cerr);
@@ -1605,7 +1603,8 @@ void __init trap_init(void)
 #endif
 
 	if (cpu_has_veic || cpu_has_vint)
-		ebase = (unsigned long) alloc_bootmem_low_pages(0x200 +
VECTORSPACING*64);
+		ebase = (unsigned long)
+			__alloc_bootmem(0x200 + VECTORSPACING*64, 1 <<
16, 0);
 	else {
 		ebase = CAC_BASE;
 		if (cpu_has_mips_r2)
