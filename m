Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2005 17:13:50 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:46611
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S3465659AbVJSQNb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Oct 2005 17:13:31 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 19 Oct 2005 09:13:28 -0700
Message-ID: <435670A8.9000402@avtrex.com>
Date:	Wed, 19 Oct 2005 09:13:28 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: [Patch] Fix lookup_dcookie for MIPS o32
References: <17236.6951.865559.479107@dl2.hq2.avtrex.com> <20051018115155.GD2656@linux-mips.org> <43551D21.3010500@avtrex.com> <20051018202654.GB2659@linux-mips.org>
In-Reply-To: <20051018202654.GB2659@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Oct 2005 16:13:28.0768 (UTC) FILETIME=[0AAE7400:01C5D4C8]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Tue, Oct 18, 2005 at 09:04:49AM -0700, David Daney wrote:
> 
> 
>>The CPU has performance counters, but they cannot trigger interrupts, so 
>>I am just using it in 'timer' mode right now.  I am wondering what would 
>>happen if I added all counter samples at each clock tick.  That is 
>>something I might try when I have a little free time.
> 
> 
> Now that's truly a strange processor - what CPU are you using?
> 

ATI Xilleon X226-A12.  According to my data sheet, there are ten 
counters, but you can only use six at a time.  They are external to the 
4KEc core, and the only operations you can do to them are enable/disable 
counting, reset to zero and read the current values.

The counters count:
I cache hit/miss
D cache hit/miss
TLB hit/miss
JTLB hit/miss
Write merging/not merging

Perhaps I should not worry about them.  Probably hooking up one of the 
high resolution timers would yield more useful profiling information.


> 
>>I had one other problem with my cross built bash where the signal 
>>numbering of the build host was being used instead of the numbering for 
>>the target.  Once I fixed bash and the lookup_dcookie system call, it 
>>seems to work flawlessly.
> 
> 
> That bug is getting a classic.  I've fixed it in ash also - ages ago ...
> 
> I usually try to escape from the horrors of crosscompiling by using a
> decent GHz MIPS system.
> 

Yeah, In a perfect world I would have such a beast.

David Daney
