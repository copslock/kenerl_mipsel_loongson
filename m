Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2009 19:30:22 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:22674 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022123AbZEFSaQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2009 19:30:16 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a01d72c0000>; Wed, 06 May 2009 14:30:04 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 6 May 2009 11:29:13 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 6 May 2009 11:29:13 -0700
Message-ID: <4A01D6F9.5030209@caviumnetworks.com>
Date:	Wed, 06 May 2009 11:29:13 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	jfraser@broadcom.com
CC:	David VomLehn <dvomlehn@cisco.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/3] mips:powertv: Make kernel command line size configurable
 (resend)
References: <20090504225719.GA22417@cuplxvomd02.corp.sa.net> <20090506163518.GA19624@linux-mips.org> <20090506181931.GA14025@cuplxvomd02.corp.sa.net> <4A01D5C7.4090900@caviumnetworks.com> <1241634456.10498.11.camel@chaos.ne.broadcom.com>
In-Reply-To: <1241634456.10498.11.camel@chaos.ne.broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 May 2009 18:29:13.0323 (UTC) FILETIME=[8E292BB0:01C9CE78]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Jon Fraser wrote:
> 
> On Wed, 2009-05-06 at 11:24 -0700, David Daney wrote:
>> David VomLehn wrote:
>>> On Wed, May 06, 2009 at 05:35:18PM +0100, Ralf Baechle wrote:
>>>> On Mon, May 04, 2009 at 03:57:19PM -0700, David VomLehn wrote:
>>>>
>>>>> Most platforms can get by perfectly well with the default command line size,
>>>>> but some platforms need more. This patch allows the command line size to
>>>>> be configured for those platforms that need it. The default remains 256
>>>>> characters.
>>>>>
>>>>> Signed-off-by: David VomLehn <dvomlehn@cisco.com>
>>>> How big of a command line do you need?  For no scientific reason other
>>>> than there not being any obvious need for a larger size MIPS is using 256
>>>> and I think unless you're asking for a huge number it will be better to
>>>> just raise that constant.
>>> The answer depends on the platform, but it's at 438 characters on a typical
>>> platform. If I *had* to pick a number, I'd probably go for 512 characters; I
>>> just hate to force others to use memory they aren't going to use.
>>>
>> I wonder if the memory could be dynamically allocated.  It would of 
>> course be a much larger patch.
>>
>> David Daney
>>
> 
> 
> 
> A bit of a chicken and egg problem if your command line arguments
> set the memory configuration.
> 

I was thinking of putting it in __initdata memory, and then copying it 
to dynamically allocated memory before freeing the init memory.

David Daney
