Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 23:48:12 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9299 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20025535AbZDIWsG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Apr 2009 23:48:06 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49de7b040000>; Thu, 09 Apr 2009 18:47:35 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 9 Apr 2009 15:47:05 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 9 Apr 2009 15:47:05 -0700
Message-ID: <49DE7AE9.9030900@caviumnetworks.com>
Date:	Thu, 09 Apr 2009 15:47:05 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	David Wuertele <dave+gmane@wuertele.com>
CC:	linux-mips@linux-mips.org
Subject: Re: What is the right way to setup MIPS timer irq in 2.6.29?
References: <loom.20090408T165537-312@post.gmane.org> <loom.20090409T195344-317@post.gmane.org>
In-Reply-To: <loom.20090409T195344-317@post.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Apr 2009 22:47:05.0805 (UTC) FILETIME=[1B534FD0:01C9B965]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

David Wuertele wrote:
> I wrote:
> 
>> Has the system timer paradigm changed between 2.6.18 and 2.6.29?
>> I'm trying to update my Broadcom-based embedded system to 2.6.29,
>> and I'm running into problems getting the system timer to run.
> 
> I solved my problem, though I'm still a little unclear about the reasoning.
> 
> The solution was to enable these:
> CONFIG_CEVT_R4K=y
> CONFIG_CSRC_R4K=y
> 
> I also had to define get_c0_compare_int() to return the system timer
> interrupt.  Once I had done these things, start_kernel() calls time_init(),
> which calls mips_clockevent_init() and init_mips_clocksource().
> init_mips_clocksource() calls the init_r4k_clocksource() that was
> enabled with the new config options.  Now my system clock runs like I think it
> should.
> 
> I think I might not need the CEVT components... I'm going to look into that
> next.

No, you do need them.  That is the source of the interrupts.  Using the 
standard cevt-r4k.c you get nice things like the tickless kernel all for 
free.


> But I wish there was some easy to find documentation about why this
> code had to be moved into the arch/mips/cevt-*.c and arch/mips/csrc-*.c
> libraries.
> 

It had to change because the entire Linux time keeping infrastructure 
change to use the generic clock source and clock event system.

David Daney
