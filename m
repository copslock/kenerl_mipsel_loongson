Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Feb 2005 14:39:44 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:62732 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225218AbVBDOj2>;
	Fri, 4 Feb 2005 14:39:28 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1Cx4hR-0000SH-00; Fri, 04 Feb 2005 14:44:45 +0000
Received: from shoreditch-home.algor.co.uk ([172.20.192.99])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Cx4bz-0005IG-00; Fri, 04 Feb 2005 14:39:07 +0000
Message-ID: <4203890B.5030305@mips.com>
Date:	Fri, 04 Feb 2005 14:39:07 +0000
From:	Nigel Stephens <nigel@mips.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: c-r4k.c cleanup
References: <20050204.231254.74753794.anemo@mba.ocn.ne.jp>
In-Reply-To: <20050204.231254.74753794.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.813,
	required 4, AWL, BAYES_00)
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



Atsushi Nemoto wrote:

>This code is wrong (should be "c->dcache.waysize > PAGE_SIZE") and
>unnecessary (done correctly in probe_pcache).
>
>diff -u -r1.96 c-r4k.c
>--- arch/mips/mm/c-r4k.c	7 Dec 2004 02:33:02 -0000	1.96
>+++ arch/mips/mm/c-r4k.c	4 Feb 2005 14:01:35 -0000
>@@ -1213,9 +1213,6 @@
> 	probe_pcache();
> 	setup_scache();
> 
>-	if (c->dcache.sets * c->dcache.ways > PAGE_SIZE)
>-		c->dcache.flags |= MIPS_CACHE_ALIASES;
>-
> 	r4k_blast_dcache_page_setup();
> 	r4k_blast_dcache_page_indexed_setup();
> 	r4k_blast_dcache_setup();
>
>
>Also, some MIPS32/MIPS64 chip have physically indexed data cache so do
>no suffer from aliasing.  CPU_20KC is one of them.  Others?
>  
>

The MIPS 24K family's caches are not physically indexed, but they do 
have optional h/w assist to prevent aliases in certain cache 
configurations. This optional feature is indicated by the read-only AR 
(alias removed) flag being set - that's bit 16 in the CP0 Config7 register.

Nigel
