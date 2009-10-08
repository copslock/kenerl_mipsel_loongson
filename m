Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Oct 2009 01:41:08 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4213 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493529AbZJHXlB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 9 Oct 2009 01:41:01 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ace70b70000>; Thu, 08 Oct 2009 16:07:40 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 Oct 2009 16:06:56 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 Oct 2009 16:06:56 -0700
Message-ID: <4ACE7090.2070006@caviumnetworks.com>
Date:	Thu, 08 Oct 2009 16:06:56 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Greg KH <gregkh@suse.de>
CC:	linux-usb@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/2] USB: Add USB HCD for Octeon SOCs.
References: <4ACD2EBF.8020901@caviumnetworks.com> <4ACE1CBD.6000106@caviumnetworks.com> <20091008205512.GA5605@suse.de>
In-Reply-To: <20091008205512.GA5605@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Oct 2009 23:06:56.0567 (UTC) FILETIME=[0841AC70:01CA486C]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Greg KH wrote:
> On Thu, Oct 08, 2009 at 10:09:17AM -0700, David Daney wrote:
>> David Daney wrote:
>>> The subject line kind of says it all.
>>>
>>> Some members of the Cavium Networks Octeon family of SOCs contain the
>>> Synopsys DWC-OTG USB controller.  This patch set adds the
>>> corresponding driver.
>>>
>>> The first patch adds between zero and two Octeon platform devices.
>>> The second is the driver.
>>>
>>> I have done a little bit of clean-up on the driver code, but
>>> undoubtedly the careful scrutiny of the USB maintainers will uncover
>>> more opportunities for improvement.  I look foreword to seeing any
>>> suggestions for how the code might be changed so that it could be
>>> merged.
>>>
>>>
>>> I will reply with the two patches.
>>>
>> I did in fact reply with the two patches.  However some spam filtering 
>> seems to have stopped '[PATCH 2/2] USB: Add HCD for Octeon SOC' from 
>> making it to the lists.
>>
>> Ralf has released it to linux-mips@linux-mips.org, but 
>> linux-usb@vger.kernel.org seems to have eaten it.
>>
>> It had a Message-Id: 
>> <1254960926-12185-2-git-send-email-ddaney@caviumnetworks.com>
>>
>> I won't send it again as it seems likely that it would get eaten again, 
>> but if the list controllers for linux-usb could release it, that would 
>> be nice.
> 
> The message is probably gone into the ether, sorry.
> 
> I got it though.
> 
> Are you looking for this to go through the usb tree?  Or the mips tree?

I don't have a preference.

However at this point, I think a more important issue would be to get 
the driver into a form that could be merged.  Any suggestions you have 
that could help me move towards that goal would be most welcome.

David Daney
