Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 21:27:39 +0100 (BST)
Received: from il.qumranet.com ([82.166.9.18]:9345 "EHLO il.qumranet.com")
	by ftp.linux-mips.org with ESMTP id S20022629AbXJBU1b (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Oct 2007 21:27:31 +0100
Received: from [10.64.7.18] (unknown [10.64.7.18])
	by il.qumranet.com (Postfix) with ESMTP id AF838250D39;
	Tue,  2 Oct 2007 22:27:41 +0200 (IST)
Message-ID: <4702A99B.7020008@qumranet.com>
Date:	Tue, 02 Oct 2007 22:27:07 +0200
From:	Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
MIME-Version: 1.0
To:	qemu-devel@nongnu.org
CC:	linux-mips@linux-mips.org
Subject: Re: [Qemu-devel] QEMU/MIPS & dyntick kernel
References: <20071002200644.GA19140@hall.aurel32.net>
In-Reply-To: <20071002200644.GA19140@hall.aurel32.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <avi@qumranet.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: avi@qumranet.com
Precedence: bulk
X-list: linux-mips

Aurelien Jarno wrote:
> Hi,
>
> As announced by Ralf Baechle, dyntick is now available on MIPS. I gave a
> try on QEMU/MIPS, and unfortunately it doesn't work correctly.
>
> In some cases the kernel schedules an event very near in the future, 
> which means the timer is scheduled a few cycles only from its current
> value. Unfortunately under QEMU, the timer runs too fast compared to the
> speed at which instructions are execution.

Sounds like a kernel bug.  Can't there conceivably exist real hardware 
(or a real timeout) that exhibits the same timing?

Especially today with variable clock frequencies, I don't see how the 
kernel can rely on exact timing.

-- 
Any sufficiently difficult bug is indistinguishable from a feature.
