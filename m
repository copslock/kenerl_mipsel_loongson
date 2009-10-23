Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2009 09:59:19 +0200 (CEST)
Received: from out01.mta.xmission.com ([166.70.13.231]:56801 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492789AbZJWH7M (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2009 09:59:12 +0200
Received: from in01.mta.xmission.com ([166.70.13.51])
	by out01.mta.xmission.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <ebiederm@xmission.com>)
	id 1N1F7Z-0001QH-2L; Fri, 23 Oct 2009 02:03:37 -0600
Received: from c-76-21-114-89.hsd1.ca.comcast.net ([76.21.114.89] helo=fess.ebiederm.org)
	by in01.mta.xmission.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <ebiederm@xmission.com>)
	id 1N1F2o-0004To-HJ; Fri, 23 Oct 2009 01:58:42 -0600
Received: from fess.ebiederm.org (localhost [127.0.0.1])
	by fess.ebiederm.org (8.14.3/8.14.3/Debian-4) with ESMTP id n9N7x5cp017748;
	Fri, 23 Oct 2009 00:59:05 -0700
Received: (from eric@localhost)
	by fess.ebiederm.org (8.14.3/8.14.3/Submit) id n9N7x35A017747;
	Fri, 23 Oct 2009 00:59:03 -0700
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	Chris Friesen <cfriesen@nortel.com>, netdev@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Irq architecture for multi-core network driver.
References: <4AE0D14B.1070307@caviumnetworks.com>
	<4AE0D72A.4090607@nortel.com> <4AE0DB98.1000101@caviumnetworks.com>
From:	ebiederm@xmission.com (Eric W. Biederman)
Date:	Fri, 23 Oct 2009 00:59:03 -0700
In-Reply-To: <4AE0DB98.1000101@caviumnetworks.com> (David Daney's message of "Thu\, 22 Oct 2009 15\:24\:24 -0700")
Message-ID: <m13a5apmm0.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-XM-SPF: eid=;;;mid=;;;hst=in01.mta.xmission.com;;;ip=76.21.114.89;;;frm=ebiederm@xmission.com;;;spf=neutral
X-SA-Exim-Connect-IP: 76.21.114.89
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Version: 4.2.1 (built Thu, 25 Oct 2007 00:26:12 +0000)
X-SA-Exim-Scanned: No (on in01.mta.xmission.com); Unknown failure
Return-Path: <ebiederm@xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiederm@xmission.com
Precedence: bulk
X-list: linux-mips

David Daney <ddaney@caviumnetworks.com> writes:

> Chris Friesen wrote:
>> On 10/22/2009 03:40 PM, David Daney wrote:
>>
>>> The main problem I have encountered is how to fit the interrupt
>>> management into the kernel framework.  Currently the interrupt source
>>> is connected to a single irq number.  I request_irq, and then manage
>>> the masking and unmasking on a per cpu basis by directly manipulating
>>> the interrupt controller's affinity/routing registers.  This goes
>>> behind the back of all the kernel's standard interrupt management
>>> routines.  I am looking for a better approach.
>>>
>>> One thing that comes to mind is that I could assign a different
>>> interrupt number per cpu to the interrupt signal.  So instead of
>>> having one irq I would have 32 of them.  The driver would then do
>>> request_irq for all 32 irqs, and could call enable_irq and disable_irq
>>> to enable and disable them.  The problem with this is that there isn't
>>> really a single packets-ready signal, but instead 16 of them.  So If I
>>> go this route I would have 16(lines) x 32(cpus) = 512 interrupt
>>> numbers just for the networking hardware, which seems a bit excessive.
>>
>> Does your hardware do flow-based queues?  In this model you have
>> multiple rx queues and the hardware hashes incoming packets to a single
>> queue based on the addresses, ports, etc. This ensures that all the
>> packets of a single connection always get processed in the order they
>> arrived at the net device.
>>
>
> Indeed, this is exactly what we have.
>
>
>> Typically in this model you have as many interrupts as queues
>> (presumably 16 in your case).  Each queue is assigned an interrupt and
>> that interrupt is affined to a single core.
>
> Certainly this is one mode of operation that should be supported, but I would
> also like to be able to go for raw throughput and have as many cores as possible
> reading from a single queue (like I currently have).

I believe will detect false packet drops and ask for unnecessary
retransmits if you have multiple cores processing a single queue,
because you are processing the packets out of order.

Eric
