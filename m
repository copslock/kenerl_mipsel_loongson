Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2005 17:23:25 +0000 (GMT)
Received: from Jg555.com ([64.30.195.78]:35466 "EHLO jg555.com")
	by ftp.linux-mips.org with ESMTP id S8133750AbVKRRW5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2005 17:22:57 +0000
Received: from [172.16.0.55] ([::ffff:172.16.0.55])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Fri, 18 Nov 2005 09:25:13 -0800
  id 001F5613.437E0E7A.00003014
Message-ID: <437E0E68.7010008@jg555.com>
Date:	Fri, 18 Nov 2005 09:24:56 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Kumba <kumba@gentoo.org>,
	Linux MIPS List <linux-mips@linux-mips.org>,
	Peter Horton <pdh@colonel-panic.org>
Subject: Re: MIPS - 64bit woes
References: <436D0061.5070100@jg555.com> <Pine.LNX.4.55.0511071143210.28165@blysk.ds.pg.gda.pl> <4371B87A.9040101@jg555.com> <4371FB46.1000805@gentoo.org> <4372304A.9080608@jg555.com> <4379FBF4.1040505@jg555.com> <437D0AE2.9040706@jg555.com> <437D2C97.8070804@jg555.com> <20051118171706.GD2707@linux-mips.org>
In-Reply-To: <20051118171706.GD2707@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

I'll give it a shot and send back results and a updated patch.

One more question, what is the future off the iomap.c file, I didn't 
include it in my patch. Could it be simply be added to arch/mips/cobalt? 
I can only speak for the RaQ2, but is it required for any of the other 
MIPS based machines?

-- 
----
Jim Gifford
maillist@jg555.com
