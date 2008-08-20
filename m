Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Aug 2008 21:29:46 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:48525 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S28582869AbYHTU3h (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Aug 2008 21:29:37 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B48ac7eab0000>; Wed, 20 Aug 2008 16:29:31 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 20 Aug 2008 13:29:30 -0700
Received: from [192.168.162.80] ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 20 Aug 2008 13:29:29 -0700
Message-ID: <48AC7EA2.7010002@caviumnetworks.com>
Date:	Wed, 20 Aug 2008 13:29:22 -0700
From:	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH 0/2] Initial support for OCTEON
References: <48A9E6DA.8030208@caviumnetworks.com> <20080819091247.GB28692@linux-mips.org>
In-Reply-To: <20080819091247.GB28692@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Aug 2008 20:29:29.0879 (UTC) FILETIME=[7292FA70:01C90303]
Return-Path: <Tomaso.Paoletti@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tpaoletti@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Aug 18, 2008 at 02:17:14PM -0700, Tomaso Paoletti wrote:
> 
>> This is a first (trivial) set of patches to pave the way for support of  
>> OCTEON processors in the kernel.
>>
>> The set adds:
>> - Detection of OCTEON CPU variants in cpu_probe_cavium()
>> - Processor ID (PrID) constants
>> - Workaround (WAR) include file
>>
>> Please consider for inclusion.
> 
> So with the evil email monster having kept these mails without sharing them
> with us...

We fed the 'evil email monster' with junk mail, and it let go of the 
original messages.
Quite an embarassment, sorry about that.

> I normally insist that there are users for new header files or functions
> since otherwise the kernel janitors will remove them shortly ...

Got it. I'm going to post users soon in a separate patchset, so that you 
can queue them in the reverse order (they are orthogonal), if that's ok 
with you.
Thanks

   Tomaso
