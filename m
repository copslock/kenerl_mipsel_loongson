Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Mar 2007 17:04:32 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:23989 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20037640AbXCERE1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Mar 2007 17:04:27 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 33BCD29A020;
	Mon,  5 Mar 2007 12:03:39 -0500 (EST)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Mon,  5 Mar 2007 12:03:38 -0500 (EST)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 5 Mar 2007 09:03:33 -0800
Message-ID: <45EC4D64.5050803@avtrex.com>
Date:	Mon, 05 Mar 2007 09:03:32 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20070212)
MIME-Version: 1.0
To:	Dave Johnson <djohnson+linux-mips@sw.starentnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: SMP+PREEMPT causes NULL dereference in khelper on startup
References: <17897.48239.366047.442797@zeus.sw.starentnetworks.com> <17900.19125.660006.553487@zeus.sw.starentnetworks.com>
In-Reply-To: <17900.19125.660006.553487@zeus.sw.starentnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Mar 2007 17:03:33.0412 (UTC) FILETIME=[34F53E40:01C75F48]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Dave Johnson wrote:
> Dave Johnson writes:
>> It appears a0 to detach_pid (*task) points to somewhere wrong as
>> 'link' (now in a1) is a valid pointer, but points to a bunch of
>> zeros.
> 
> I found the issue.  This appears to be a compiler bug in
> __unhash_process().

Perhaps you could tell us the compiler/binutils versions you are using.

It is not unheard of that compiler bugs get fixed.  So if the problem 
can still be reproduced with GCC 4.1 or 4.2, you could file a bug report 
here:

http://gcc.gnu.org/bugzilla/

Thanks,
David Daney
