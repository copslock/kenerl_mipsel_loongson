Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2005 15:51:51 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:31856 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8226044AbVDDOvh>; Mon, 4 Apr 2005 15:51:37 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 4 Apr 2005 10:47:33 -0400
Message-ID: <42515476.4060501@timesys.com>
Date:	Mon, 04 Apr 2005 10:51:34 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Greg Weeks <greg.weeks@timesys.com>
CC:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: malta 4kc machine check
References: <42514113.9060902@timesys.com> <Pine.LNX.4.61L.0504041437441.20089@blysk.ds.pg.gda.pl> <4251470C.4050901@timesys.com>
In-Reply-To: <4251470C.4050901@timesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Apr 2005 14:47:33.0593 (UTC) FILETIME=[3C2AAC90:01C53925]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

Greg Weeks wrote:

> Maciej W. Rozycki wrote:
>
>> On Mon, 4 Apr 2005, Greg Weeks wrote:
>>
>>  
>>
>>> I'm getting a machine check on a malta 4kc when userland starts up. 
>>> This was
>>> built from a copy of the malta tree from Friday. Has anyone else ran 
>>> into
>>> this?
>>>   
>>
>>
>> This is being resolved -- please try this patch for now.
>>
>>  
>>
> Pretty much the same problem. I can post the log if it's useful.

For some reason it didn't get rebuilt. Another try seems to work with 
this patch.

Greg Weeks
