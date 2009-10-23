Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Oct 2009 01:22:56 +0200 (CEST)
Received: from out01.mta.xmission.com ([166.70.13.231]:41885 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493105AbZJWXWu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 24 Oct 2009 01:22:50 +0200
Received: from in02.mta.xmission.com ([166.70.13.52])
	by out01.mta.xmission.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <ebiederm@xmission.com>)
	id 1N1TXR-0001ZM-6b; Fri, 23 Oct 2009 17:27:17 -0600
Received: from c-76-21-114-89.hsd1.ca.comcast.net ([76.21.114.89] helo=fess.ebiederm.org)
	by in02.mta.xmission.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <ebiederm@xmission.com>)
	id 1N1TSx-0003aM-Be; Fri, 23 Oct 2009 17:22:39 -0600
Received: from fess.ebiederm.org (localhost [127.0.0.1])
	by fess.ebiederm.org (8.14.3/8.14.3/Debian-4) with ESMTP id n9NNMcAE012954;
	Fri, 23 Oct 2009 16:22:38 -0700
Received: (from eric@localhost)
	by fess.ebiederm.org (8.14.3/8.14.3/Submit) id n9NNMarA012953;
	Fri, 23 Oct 2009 16:22:36 -0700
To:	Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Chris Friesen <cfriesen@nortel.com>, netdev@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Irq architecture for multi-core network driver.
References: <4AE0D14B.1070307@caviumnetworks.com>
	<4AE0D72A.4090607@nortel.com> <4AE0DB98.1000101@caviumnetworks.com>
	<m13a5apmm0.fsf@fess.ebiederm.org>
	<4807377b0910231028g60b479cfycdbf3f4e25384c58@mail.gmail.com>
From:	ebiederm@xmission.com (Eric W. Biederman)
Date:	Fri, 23 Oct 2009 16:22:36 -0700
In-Reply-To: <4807377b0910231028g60b479cfycdbf3f4e25384c58@mail.gmail.com> (Jesse Brandeburg's message of "Fri\, 23 Oct 2009 10\:28\:10 -0700")
Message-ID: <m17huln1ab.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-XM-SPF: eid=;;;mid=;;;hst=in02.mta.xmission.com;;;ip=76.21.114.89;;;frm=ebiederm@xmission.com;;;spf=neutral
X-SA-Exim-Connect-IP: 76.21.114.89
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Version: 4.2.1 (built Thu, 25 Oct 2007 00:26:12 +0000)
X-SA-Exim-Scanned: No (on in02.mta.xmission.com); Unknown failure
Return-Path: <ebiederm@xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiederm@xmission.com
Precedence: bulk
X-list: linux-mips

Jesse Brandeburg <jesse.brandeburg@gmail.com> writes:

> On Fri, Oct 23, 2009 at 12:59 AM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> David Daney <ddaney@caviumnetworks.com> writes:
>>> Certainly this is one mode of operation that should be supported, but I would
>>> also like to be able to go for raw throughput and have as many cores as possible
>>> reading from a single queue (like I currently have).
>>
>> I believe will detect false packet drops and ask for unnecessary
>> retransmits if you have multiple cores processing a single queue,
>> because you are processing the packets out of order.
>
> So, the way the default linux kernel configures today's many core
> server systems is to leave the affinity mask by default at 0xffffffff,
> and most current Intel hardware based on 5000 (older core cpus), or
> 5500 chipset (used with Core i7 processors) that I have seen will
> allow for round robin interrupts by default.  This kind of sucks for
> the above unless you run irqbalance or set smp_affinity by hand.

On x86 if you have > 8 cores the hardware does not support any form of
irq balancing.  You do have an interesting point.

How often and how much does irq balancing hurt us.

> Yes, I know Arjan and others will say you should always run
> irqbalance, but some people don't and some distros don't ship it
> enabled by default (or their version doesn't work for one reason or
> another)  

irqbalance is actually more likely to move irqs than the hardware.
I have heard promises it won't move network irqs but I have seen
the opposite behavior.

> The question is should the kernel work better by default
> *without* irqbalance loaded, or does it not matter?

Good question.  I would aim for the kernel to work better by default.
Ideally we should have a coupling between which sockets applications have
open, which cpus those applications run on, and which core the irqs arrive
at.

> I don't believe we should re-enable the kernel irq balancer, but
> should we consider only setting a single bit in each new interrupt's
> irq affinity?  Doing it with a random spread for the initial affinity
> would be better than setting them all to one.

Not a bad idea.  The practical problem is that we usually have the irqs
setup before we have the additional cpus.  But that isn't entirely true,
I'm thinking of mostly pre-acpi rules.  With ACPI we do some kind of
on-demand setup of the gsi in the device initialization.

How irq threads interact also ways in here.

Eric
