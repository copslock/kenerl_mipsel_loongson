Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Dec 2005 04:52:36 +0000 (GMT)
Received: from smtp101.biz.mail.mud.yahoo.com ([68.142.200.236]:33395 "HELO
	smtp101.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8126515AbVLMEwS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Dec 2005 04:52:18 +0000
Received: (qmail 56580 invoked from network); 13 Dec 2005 04:52:32 -0000
Received: from unknown (HELO ?192.168.1.110?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp101.biz.mail.mud.yahoo.com with SMTP; 13 Dec 2005 04:52:32 -0000
Subject: Re: mprotect(PROT_NONE) doesn't prevent reading/writing on 2.6.14
	Au1550
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Clem Taylor <clem.taylor@gmail.com>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <ecb4efd10512121334g6713d30ftf5a351fc61f1b6bd@mail.gmail.com>
References: <ecb4efd10512121334g6713d30ftf5a351fc61f1b6bd@mail.gmail.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Mon, 12 Dec 2005 20:52:36 -0800
Message-Id: <1134449556.5151.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Mon, 2005-12-12 at 16:34 -0500, Clem Taylor wrote:
> Hi,
> 
> It seems that mprotect(PROT_NONE) isn't actually doing anything on my
> 2.6.14 au1550 system.
> 
> Attached is a simple test that allocates 64K (64K aligned),
> reads/writes the buffer, mprotect(PROT_NONE) the buffer and then
> attempts to read and write to the buffer a second time. I expected
> that writing to a PROT_NONE page would result in a segfault, but on
> the Au1550 the program runs without faulting. Running the same code on
> x86 (2.6.13) segfaults as expected.
> 
> Is there some reason why mprotect() wouldn't work on the Au1550, or is
> this a bug?

Do you have another MIPS system you can test this on?

Pete
