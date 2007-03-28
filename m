Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2007 18:11:40 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:23707 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20023091AbXC1RLi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Mar 2007 18:11:38 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 019FD29D8C5;
	Wed, 28 Mar 2007 17:10:58 +0000 (GMT)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Wed, 28 Mar 2007 17:10:57 +0000 (GMT)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 28 Mar 2007 10:10:57 -0700
Message-ID: <460AA1A0.1050508@avtrex.com>
Date:	Wed, 28 Mar 2007 10:10:56 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
MIME-Version: 1.0
To:	Ravi Pratap <Ravi.Pratap@hillcrestlabs.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: flush_anon_page for MIPS
References: <36E4692623C5974BA6661C0B18EE8EDF6CD5B2@MAILSERV.hcrest.com>
In-Reply-To: <36E4692623C5974BA6661C0B18EE8EDF6CD5B2@MAILSERV.hcrest.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Mar 2007 17:10:57.0292 (UTC) FILETIME=[0D0834C0:01C7715C]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Ravi Pratap wrote:
>> From: Atsushi Nemoto [mailto:anemo@mba.ocn.ne.jp] 
>> Sent: Monday, March 26, 2007 11:18 PM
>> To: Ravi Pratap
>> Cc: ralf@linux-mips.org; ddaney@avtrex.com; 
>> miklos@szeredi.hu; linux-mips@linux-mips.org
>> Subject: Re: flush_anon_page for MIPS
>>
>> On Mon, 26 Mar 2007 19:24:45 -0400, "Ravi Pratap" 
>> <Ravi.Pratap@hillcrestlabs.com> wrote:
>>> So I'm trying to backport these changesets and it seems that I need 
>>> the changeset that originally introduced kmap_coherent, 
>> etc. I tried 
>>> some Google searching and found this but I need your help 
>> in figuring 
>>> out which exact changesets I need.
>>>
>>> Is it this one:
>>>
>>> b895b66990f22a8a030c41390c538660a02bb97f
>>>
>>> ?
>> It was splitted into some parts when merged to mainline.
>>
>> At 2.6.19 cycle:
>> f8829caee311207afbc882794bdc5aa0db5caf33
>> At 2.6.20 cycle:
>> bcd022801ee514e28c32837f0b3ce18c775f1a7b
>> 9de455b20705f36384a711d4a20bcf7ba1ab180b
>> 77fff4ae2b7bba6d66a8287d9ab948e2b6c16145
>>
>> If you only needed kmap_coherent, the first one might be enough.
> 
> I just finished backporting your patches to a 2.6.15 kernel and FUSE now
> works just fine. 
> 

Would you mind posting your patch to this list?

There are some of us that are using the same processor you are that 
could find this helpful.

David Daney
