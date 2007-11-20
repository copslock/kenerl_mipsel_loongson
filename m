Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2007 19:00:46 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:1231 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022090AbXKTTAo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Nov 2007 19:00:44 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lAKJ0grk028865;
	Tue, 20 Nov 2007 19:00:42 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lAKJ0fYL028864;
	Tue, 20 Nov 2007 19:00:41 GMT
Date:	Tue, 20 Nov 2007 19:00:41 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	Kaz Kylheku <kaz@zeugmasystems.com>, linux-mips@linux-mips.org
Subject: Re: futex_wake_op deadlock?
Message-ID: <20071120190041.GA18138@linux-mips.org>
References: <20071119184837.GA12287@linux-mips.org> <DDFD17CC94A9BD49A82147DDF7D545C54DCDE2@exchange.ZeugmaSystems.local> <20071120112051.GB30675@linux-mips.org> <4743279B.7070402@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4743279B.7070402@avtrex.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 20, 2007 at 10:29:47AM -0800, David Daney wrote:

>> Notice the branch at the end of the fixup code, it goes back to the
>> SC instruction.  The SC instruction took an exception so it will not have
>> changed $1 so the loop will continue endless unless by coincidence the
>> value to be stored from $1 happened to be zero.
>>
>> Obviously this one was MIPS specific and may hit all supported ABIs.  So
>> my initial suspicion this might be the issue David Miller recently
>> discovered in the binary compat code isn't true.  And it's a local DoS
>> probably for all of 2.6.16 and up.
>>
>
> I mostly similar code is in 2.6.15, so I think it is effected as well. 
> 2.6.12 on the other hand doesn't seem to have futex.h

It originally appeared in the lmo kernel for 2.6.14-rc1 and a little
after the 2.6.14 release in kernel.org.

If I say 2.6.16 then it's simply that I don't ever look at anything that
doesn't have a -stable branch.

  Ralf
