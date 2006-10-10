Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 20:34:00 +0100 (BST)
Received: from smtp101.biz.mail.re2.yahoo.com ([68.142.229.215]:29629 "HELO
	smtp101.biz.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20039906AbWJJTd5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Oct 2006 20:33:57 +0100
Received: (qmail 27562 invoked from network); 10 Oct 2006 19:33:47 -0000
Received: from unknown (HELO ?192.168.253.28?) (dan@embeddedalley.com@209.113.146.155 with plain)
  by smtp101.biz.mail.re2.yahoo.com with SMTP; 10 Oct 2006 19:33:46 -0000
In-Reply-To: <20061010182747.GA14539@enneenne.com>
References: <20061010182747.GA14539@enneenne.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <29381BAC-4A96-4BFE-8E86-836A3564F2F5@embeddedalley.com>
Cc:	linux-mips@linux-mips.org
Content-Transfer-Encoding: 7bit
From:	Dan Malek <dan@embeddedalley.com>
Subject: Re: Problem on au1100 USB device support
Date:	Tue, 10 Oct 2006 15:33:45 -0400
To:	Rodolfo Giometti <giometti@linux.it>
X-Mailer: Apple Mail (2.752.2)
Return-Path: <dan@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On Oct 10, 2006, at 2:27 PM, Rodolfo Giometti wrote:

> Someone may halp me in understing where the problem could be? My
> driver doesn't use DMA, as suggested by the CPU's data sheet... it
> could be wrong?

Many people, including myself, have spent way too many
hours trying to make this device interface work.  There
are some errata associated with it, along with some challenging
design problems.  I have only been able to make it work
in one instance, with a highly custom RTLinux driver,
properly matched FIFOs and DMA, and running TCP/IP
over the link.  It wasn't 100% reliable, but the TCP retries
made it appear that way to the application (with tolerable
delays).

The device interface just requires too much babysitting
by the CPU to function, and the Linux interrupts
have too much latency to guarantee the CPU can do
what is necessary in a timely fashion.  The same is
true of not using DMA.  If you choose not to use the
DMA for data transfer, the CPU just can't respond
quickly enough to the interface state changes
unless you just spend all of your time polling the
interface.

IMHO, I wouldn't waste much time on this, but
Good Luck if you choose to do so :-)


	-- Dan
