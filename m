Received:  by oss.sgi.com id <S554061AbRBVDTS>;
	Wed, 21 Feb 2001 19:19:18 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:48117 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S554058AbRBVDTN>;
	Wed, 21 Feb 2001 19:19:13 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f1M3F6815347
	for <linux-mips@oss.sgi.com>; Wed, 21 Feb 2001 19:15:06 -0800
Message-ID: <3A94850D.FDFE52CD@mvista.com>
Date:   Wed, 21 Feb 2001 19:18:37 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: en, bg
MIME-Version: 1.0
To:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: RM7000 cache question
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Question on the RM7000 caches:

The function __flush_cache_all_d32i32() (and some other ones), flush the
entire primary data cache using blast_dache32().  Since writebacks from
the primary cache go to the secondary and tertiary/main memory, this
function seems fine. However, blast_dcache32() uses indexed cache
instructions. The primary data cache is only 16KB; the secondary cache
is 256KB. So my question is, since we're using indexed instructions, and
the primary data cache is only 16KB, will that flush only one of the 4
ways of the secondary cache, since each way is 64KB?  

static void __flush_cache_all_d32i32(void)
{
        blast_dcache32();
        blast_icache32();
}                              


Pete
