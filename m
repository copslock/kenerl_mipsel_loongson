Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 23:52:08 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:61994 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22614753AbYJ1Xv5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Oct 2008 23:51:57 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4907a5890000>; Tue, 28 Oct 2008 19:51:37 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Oct 2008 16:51:35 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Oct 2008 16:51:35 -0700
Message-ID: <4907A586.40409@caviumnetworks.com>
Date:	Tue, 28 Oct 2008 16:51:34 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 02/36] Add Cavium OCTEON files to	arch/mips/include/asm/mach-cavium-octeon
References: <490655B6.4030406@caviumnetworks.com> <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <20081028075733.GB20858@linux-mips.org>
In-Reply-To: <20081028075733.GB20858@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Oct 2008 23:51:35.0204 (UTC) FILETIME=[1C557E40:01C93958]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Oct 27, 2008 at 05:02:34PM -0700, David Daney wrote:
> 
>> +#ifdef CONFIG_SMP
>> +#define cpu_has_llsc		1
>> +#else
>> +/* Disable LL/SC on non SMP systems. It is faster to disable interrupts for
>> +   atomic access than a LL/SC */
>> +#define cpu_has_llsc		0
>> +#endif
> 
> It also means the resulting kernel won't have support for futex which
> essentially means you're cut off from modern libcs.
> 
> It is possible to get this to work - but nobody bothered so far; ll/sc-less
> R2000 class processors are very rare these days.  My recommendation is
> to keep cpu_has_llsc as 1 until you've fixed up the futex implementation,
> if you deciede so.

Someone should tell ip32 w/ R5000 this.  It seems that it is broken too.

This could explain why my R5000 O2 does weird things with glibc 2.8...

David Daney
