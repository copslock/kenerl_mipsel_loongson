Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2007 19:08:08 +0100 (BST)
Received: from static-72-72-73-123.bstnma.east.verizon.net ([72.72.73.123]:28681
	"EHLO mail.sicortex.com") by ftp.linux-mips.org with ESMTP
	id S20021852AbXGJSIG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Jul 2007 19:08:06 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail.sicortex.com (Postfix) with ESMTP id 3F56E208872
	for <linux-mips@linux-mips.org>; Tue, 10 Jul 2007 14:08:00 -0400 (EDT)
X-Virus-Scanned: amavisd-new at sicortex.com
Received: from mail.sicortex.com ([127.0.0.1])
	by localhost (mail.sicortex.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eb6EVzsxYNnN; Tue, 10 Jul 2007 14:07:59 -0400 (EDT)
Received: from [10.0.1.104] (gs104.sicortex.com [10.0.1.104])
	by mail.sicortex.com (Postfix) with ESMTP id 7D1DD201DBD;
	Tue, 10 Jul 2007 14:07:59 -0400 (EDT)
Message-ID: <4693CAFF.6000101@sicortex.com>
Date:	Tue, 10 Jul 2007 14:07:59 -0400
From:	Peter Watkins <pwatkins@sicortex.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050831)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Peter Watkins <pwatkins@sicortex.com>
Subject: start_secondary flushing remote icaches?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <pwatkins@sicortex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pwatkins@sicortex.com
Precedence: bulk
X-list: linux-mips

Greetings,

I'm updating our port to 2.6.22 and I notice that r4k_flush_icache_range 
no longer has a check for irqs_disabled (to force local-only flush).

This hits the BUG_ON(!cpu_online(cpu)) assertion in smp_call_function 
since cpu's aren't marked online until after start_secondary:

Call Trace:
[<ffffffff8010d394>] smp_call_function+0x84/0x1f0
[<ffffffff8011dec0>] r4k_flush_icache_range+0x28/0x48
[<ffffffff80434a4c>] r4k_cache_init+0x6dc/0x1070
[<ffffffff8042fca0>] per_cpu_trap_init+0x180/0x288
[<ffffffff804304b4>] start_secondary+0x24/0x118
[<ffffffff80101c40>] prom_smp_bootstrap+0x10/0x50

So, the question is, how should the remote icache flush be avoided in 
this case?

-p
