Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4E1TsnC003934
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 13 May 2002 18:29:54 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4E1Tss0003933
	for linux-mips-outgoing; Mon, 13 May 2002 18:29:54 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4E1TnnC003929
	for <linux-mips@oss.sgi.com>; Mon, 13 May 2002 18:29:49 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id SAA04718;
	Mon, 13 May 2002 18:29:55 -0700
Message-ID: <3CE06833.60104@mvista.com>
Date: Mon, 13 May 2002 18:28:19 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: ldavies@agile.tv
CC: linux-mips@oss.sgi.com
Subject: Re: deleted /dev/zero
References: <3CE061E0.8000909@mvista.com> <3CE06604.2050800@agile.tv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Thanks.  I am using an old version of ltp, and I still see the bug there.

Jun

Liam Davies wrote:

> Jun Sun wrote:
> 
>>
>> I don't know how to re-produce this problem yet.  It seems a little 
>> non-deterministic.  I would appreciate any insight into this problem.
> 
> 
> 
> The ltp mtest05 test had a bug in which it would remove /dev/zero when
> it cleaned up. Have you got an updated ltp suite?
> 
> This is the fix that they did in late March to the mtest05 test.
> 
> /ltp/ltp/testcases/kernel/mem/mtest05/mmstress.c:246
> -    if (strcmp(filename, "NULL") || strcmp(filename, "/dev/zero"))
> +    if (strcmp(filename, "NULL") && strcmp(filename, "/dev/zero"))
> 
> I suppose that there may be other LTP tests that could have similar
> bugs...
> 
> 
> Cheers
> Liam
> 
> 
> 
> 
