Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2005 08:50:38 +0000 (GMT)
Received: from Jg555.com ([64.30.195.78]:57015 "EHLO jg555.com")
	by ftp.linux-mips.org with ESMTP id S3467015AbVKIIuU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2005 08:50:20 +0000
Received: from [172.16.0.55] ([::ffff:172.16.0.55])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Wed, 09 Nov 2005 00:51:40 -0800
  id 002AC014.4371B89C.0000205F
Message-ID: <4371B87A.9040101@jg555.com>
Date:	Wed, 09 Nov 2005 00:51:06 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	ralf@linux-mips.org
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: MIPS - 64bit woes
References: <436D0061.5070100@jg555.com> <Pine.LNX.4.55.0511071143210.28165@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0511071143210.28165@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Here is what I did to track down the errors.

I created a diff between the last working kernel 2.6.12 and the current 
kernel. Started with cpu-probe.c, that to me seemed the logical choice.

After patching the rest of files needed to support the patch in 
cpu-probe.c, I was finally able to produce a kernel under 2.6.12 with 
the same problem.

The files that I ported from 2.6.14 to 2.6.12 are the following
cpu-probe.c
cpu.h
mipsregs.h
cache.c
cpu-features.h

Here is a link to the patches I used http://ftp.jg555.com/errors

Looking at mipsregs.h, something doesn't look right for a 64 bit system. 
But I'm not the expert.

Here are my findings, I hope someone out there has an idea.

-- 
----
Jim Gifford
maillist@jg555.com
