Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jan 2008 20:07:54 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:3989 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28590215AbYAVUHw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Jan 2008 20:07:52 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0MK7pNB004561;
	Tue, 22 Jan 2008 20:07:51 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0MK7plE004560;
	Tue, 22 Jan 2008 20:07:51 GMT
Date:	Tue, 22 Jan 2008 20:07:51 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Chris Friesen <cfriesen@nortel.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: quick question on 64-bit values with 32-bit inline assembly
Message-ID: <20080122200751.GA2672@linux-mips.org>
References: <4794DFE1.5040805@nortel.com> <20080122175734.GA31013@linux-mips.org> <47963C31.2000403@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47963C31.2000403@nortel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 22, 2008 at 12:55:45PM -0600, Chris Friesen wrote:

>>> gethrtime(void)
>>> {
>>>   unsigned long long result;
>>>
>>>   asm volatile ("rdhwr %0,$31" : "=r" (result));
>
>> Ah, Cavium.
>
> Yes indeed.  Any peculiarities that we should be watching out for? Previous 
> mailing list threads would be great.

Cavium so far received little coverage on this list - but seems you're
about to start this.  The reason why I was able to identify Cavium is that
afaics only Cavium is the only 64-bit CPU to implement a 64-bit timer in
hardware register $31.

The definition of rdhwr is generic and I think if anybody has considered
this specific interaction of ABI and processor architecture then it was
probably found not to implement such a special read because it is messy
in more than one way.

  Ralf
