Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2006 17:57:10 +0000 (GMT)
Received: from Jg555.com ([64.30.195.78]:38066 "EHLO jg555.com")
	by ftp.linux-mips.org with ESMTP id S3468145AbWARR4v (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Jan 2006 17:56:51 +0000
Received: from [172.16.0.55] ([::ffff:172.16.0.55])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Wed, 18 Jan 2006 10:00:28 -0800
  id 001D9075.43CE823C.00001980
Message-ID: <43CE821A.6060004@jg555.com>
Date:	Wed, 18 Jan 2006 09:59:54 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	ralf@linux-mips.org, tbm@cyrius.com, pdh@colonel-panic.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH Cobalt 1/1] 64-bit fix
References: <20060116154543.GA26771@deprecation.cyrius.com>	<43CBCAAE.6030403@jg555.com>	<20060117135145.GE3336@linux-mips.org> <20060117.232350.93019515.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060117.232350.93019515.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> But got no response at that time.  So I ask again.  Could you tell us
> how the iomap patch broken verbosely, please?
>
>   
How can we get this resolved, this issue has been open a long time. Can 
we all work together to get a working solution in place that everyone 
will accept?

We all need to understand the concerns with the current method. The only 
issue I see from Ralf is the following:

    Broken on multiple PCI busses.

    Now the way I understand the issue is the current iomap.c only 
handles a single bus, Ralf's point is that if there are multiple busses 
this patch may not work properly. Is that a correct statement Ralf.

    So can't we have one iomap.c for single pci bus systems and one for 
multiple pci bus systems? Just a thought.

-- 
----
Jim Gifford
maillist@jg555.com
