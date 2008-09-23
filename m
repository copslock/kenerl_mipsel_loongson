Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2008 20:03:07 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:21178 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S28591501AbYIWTC7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Sep 2008 20:02:59 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 2B82C3217FA;
	Tue, 23 Sep 2008 19:02:57 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [173.8.135.205])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Tue, 23 Sep 2008 19:02:57 +0000 (UTC)
Received: from dl2.hq2.avtrex.com ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 23 Sep 2008 12:02:37 -0700
Message-ID: <48D93D4B.1010707@avtrex.com>
Date:	Tue, 23 Sep 2008 12:02:35 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	David VomLehn <dvomlehn@cisco.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Patch 0/6] MIPS: Hardware watch register support for gdb (version
 5).
References: <48D89470.5090404@avtrex.com> <48D93A23.3020302@cisco.com>
In-Reply-To: <48D93A23.3020302@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Sep 2008 19:02:37.0396 (UTC) FILETIME=[F1BCB140:01C91DAE]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

David VomLehn wrote:
> David Daney wrote:
> 
>> To follow is my fifth pass at MIPS watch register support.
> 
> I'd like to add a feature request, understanding fully that the response 
> may very well be, "interesting idea, now show us a patch"--can we have 
> an interface that would allow kernel-space allocation of watchpoint 
> registers?
> 
> The rationale is that we have found it quite useful to have kernel and 
> driver code set watchpoints for debugging purposes. I would not expect 
> that kernel space code could grab watchpoint registers already in use by 
> ptrace, and that ptrace would be free to allocate all watchpoint 
> registers not in use for kernel space purposes, i.e. there would be no 
> watchpoint registers permanently allocated for kernel space usage.
> 

The current patch has an artificial limit of 4 registers that it would use.

I think adding this feature would be possible, but would rather make it 
part of a follow-on patch.

You would limit the number of registers available to ptrace and then 
handle the others specially in the do_watch handler.

David Daney
