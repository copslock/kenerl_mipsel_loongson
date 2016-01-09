Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Jan 2016 03:07:11 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17693 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010667AbcAICHJCor-N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Jan 2016 03:07:09 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 18A1EB1628178;
        Sat,  9 Jan 2016 02:07:02 +0000 (GMT)
Received: from [10.100.200.34] (10.100.200.34) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.235.1; Sat, 9 Jan 2016
 02:07:02 +0000
Date:   Sat, 9 Jan 2016 02:05:31 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Brian Norris <computersforpeace@gmail.com>,
        =?ISO-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: io.h: Define `ioremap_cache'
Message-ID: <alpine.DEB.2.00.1601090127240.5958@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.34]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
Ralf,

 Please try and push it ASAP, with 4.5 if possible.  This should be an 
obviously correct internal API consistency fix, along the lines of the 
recent `ioremap_uc' addition.  NB, there's a fallback `ioremap_cache' 
implementation in kernel/memremap.c redirecting to plain `ioremap', but I 
think we should simply do the right thing rather than relying on that 
code.

 Thanks,

  Maciej

linux-mips-ioremap-cache.diff
Index: linux-sfr-test/arch/mips/include/asm/io.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/io.h	2015-10-07 19:33:20.000000000 +0100
+++ linux-sfr-test/arch/mips/include/asm/io.h	2016-01-09 01:32:14.432587000 +0000
@@ -275,6 +275,7 @@ static inline void __iomem * __ioremap_m
  */
 #define ioremap_cachable(offset, size)					\
 	__ioremap_mode((offset), (size), _page_cachable_default)
+#define ioremap_cache ioremap_cachable
 
 /*
  * These two are MIPS specific ioremap variant.	 ioremap_cacheable_cow
