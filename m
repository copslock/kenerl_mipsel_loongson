Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Jun 2008 00:34:17 +0100 (BST)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:3875 "EHLO
	sj-iport-1.cisco.com") by ftp.linux-mips.org with ESMTP
	id S20037193AbYFMXeM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 14 Jun 2008 00:34:12 +0100
X-IronPort-AV: E=Sophos;i="4.27,642,1204531200"; 
   d="scan'208";a="41252106"
Received: from sj-dkim-3.cisco.com ([171.71.179.195])
  by sj-iport-1.cisco.com with ESMTP; 13 Jun 2008 16:33:53 -0700
Received: from sj-core-5.cisco.com (sj-core-5.cisco.com [171.71.177.238])
	by sj-dkim-3.cisco.com (8.12.11/8.12.11) with ESMTP id m5DNXrVC029291
	for <linux-mips@linux-mips.org>; Fri, 13 Jun 2008 16:33:53 -0700
Received: from sausatlsmtp2.sciatl.com ([192.133.217.159])
	by sj-core-5.cisco.com (8.13.8/8.13.8) with ESMTP id m5DNXrn9003742
	for <linux-mips@linux-mips.org>; Fri, 13 Jun 2008 23:33:53 GMT
Received: from default.com ([192.133.217.159]) by sausatlsmtp2.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Jun 2008 19:33:52 -0400
Received: from sausatlbhs01.corp.sa.net ([192.133.216.76]) by sausatlsmtp2.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Jun 2008 19:33:50 -0400
Received: from SAUSCUPEXCH01.corp.sa.net ([64.101.22.160]) by sausatlbhs01.corp.sa.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Jun 2008 19:33:50 -0400
Received: from [127.0.0.1] ([64.101.20.200]) by SAUSCUPEXCH01.corp.sa.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Jun 2008 16:33:49 -0700
Message-ID: <485303CE.8060504@cisco.com>
Date:	Fri, 13 Jun 2008 16:33:34 -0700
From:	David VomLehn <dvomlehn@cisco.com>
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
MIME-Version: 1.0
To:	"Pelton, Dave" <dpelton@ciena.com>
CC:	"J.Ma" <sync.jma@gmail.com>, Markus Gothe <markus.gothe@27m.se>,
	linux-mips@linux-mips.org
Subject: Re: [SPAM] linux-2.6.25.4 Porting OOPS
References: <dcf6addc0806082001m19d54184pc8ab42b0875c5238@mail.gmail.com> <20B109E2-594E-4329-95C7-F67E9A7882E2@27m.se> <dcf6addc0806120251t4785dc09tc4a6f0854c5cd425@mail.gmail.com> <A3BA2251DD85404FBBEF7478C29D8742F26EFE@onmxm01.ciena.com>
In-Reply-To: <A3BA2251DD85404FBBEF7478C29D8742F26EFE@onmxm01.ciena.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Jun 2008 23:33:49.0186 (UTC) FILETIME=[EE584E20:01C8CDAD]
X-ST-MF-Message-Resent:	6/13/2008 19:33
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=2911; t=1213400033; x=1214264033;
	c=relaxed/simple; s=sjdkim3002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[SPAM]=20linux-2.6.25.4=20Porting=20OOP
	S
	|Sender:=20;
	bh=o7sI6ijRVBVCT9HcB819eDnD7YlQ7Q0CW9kY3QzE61M=;
	b=Ar3ynGtU+7oDkKYxzc7BFI/bXW11JZD0DyP+zEBGhNEiTE0qgdjlqBzfgN
	S1BalsICsdh8Rz0X3ts5souKCOY314daIF8GBvjx53E+6lCerFckbmjM9hch
	5EaeNqw7Gz;
Authentication-Results:	sj-dkim-3; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Pelton, Dave wrote:

> The problem I had on my system was that my userspace init would crash
> (SIGSEGV).  The same userspace code would run fine on an older kernel
> (2.6.14).  Changing the init call to other things (such as /bin/sh)
> would
> lead to similar problems.  Using a JTAG debugger, I was able to track
> things into the copy_user_highpage function, and I found that this
> function was calling copy_page with a source address that had incorrect
> data.  The source address was coming from kmap_coherent (which is only
> used if cpu_has_dc_aliases is true).  As far as I can tell, the job of
> kmap_coherent is to map a user page into kernel virtual memory (kseg2).
> Normally kseg2 is in the address range 0xC0000000-0xFFFFFFFF.  However,
> on the BMIPS3300 (the embedded MIPS32 core used on my SOC), there is a
> range of addresses within kseg2 that are reserved
> (0xFF200000-0xFFFEFFFF).
> This means that the TLB entry that kmap_coherent creates will not work
> if it falls within the reserved range.  The virtual address space used
> by kmap_coherent is controlled by FIXADDR_TOP in
> include/asm-mips/fixmap.h.
> To fix my issue, I changed FIXADDR_TOP to avoid the reserved address
> space.
<snip>

Is your range of addresses reserved on the BMIPS3300 because it is being used as 
dseg, i.e. because it is being used for debugging? If I read the documentation on 
the processor I am using, the 24Kc, it has a similar issue. I don't need to be 
able to use kmap_coherent because the 24K hardware takes care of data coherence 
issues, i.e. cpu_has_dc_aliases is false, but I'm sort of thinking we might just 
generally want to change FIXADDR_TOP to avoid address in the dseg range for all 
MIPS32 processors. As we work our way through some of the cache flushing issues 
related to using high memory, I'd like to be able to develop code that works on 
processors for which cpu_has_dc_aliases is true. If my kmap_coherent is working I 
can check things out for those processors and then simply use kmap_atomic for 
processors where cpu_has_dc_aliases is false.

Any comments?

-- 
David VomLehn, dvomlehn@cisco.com
The opinions expressed herein are likely mine, but might not be my employer's...




     - - - - -                              Cisco                            - - - - -         
This e-mail and any attachments may contain information which is confidential, 
proprietary, privileged or otherwise protected by law. The information is solely 
intended for the named addressee (or a person responsible for delivering it to 
the addressee). If you are not the intended recipient of this message, you are 
not authorized to read, print, retain, copy or disseminate this message or any 
part of it. If you have received this e-mail in error, please notify the sender 
immediately by return e-mail and delete it from your computer.
