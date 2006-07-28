Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jul 2006 19:32:44 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:26604 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S8134058AbWG1Sce (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Jul 2006 19:32:34 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id BC4A8B0E4C;
	Fri, 28 Jul 2006 14:45:34 -0400 (EDT)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Fri, 28 Jul 2006 14:45:34 -0400 (EDT)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 28 Jul 2006 11:32:24 -0700
Message-ID: <44CA5837.2060502@avtrex.com>
Date:	Fri, 28 Jul 2006 11:32:23 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Nigel Stephens <nigel@mips.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ths@networkno.de,
	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] dump_stack() based on prologue code analysis
References: <20060727170305.GB4505@networkno.de>	<cda58cb80607271151n2dcfe64cn4cb1ecca3ece6b1e@mail.gmail.com>	<20060727191245.GD4505@networkno.de> <20060728.233842.41629448.anemo@mba.ocn.ne.jp> <44CA43EC.9010904@avtrex.com> <44CA4AA3.8080700@mips.com>
In-Reply-To: <44CA4AA3.8080700@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jul 2006 18:32:24.0006 (UTC) FILETIME=[2B5C5660:01C6B274]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Nigel Stephens wrote:
> 
> 
> David Daney wrote:
> 
>> Atsushi Nemoto wrote:
>>
>>> On Thu, 27 Jul 2006 20:12:45 +0100, Thiemo Seufer <ths@networkno.de> 
>>> wrote:
>>>
>>>> IOW, binary analysis can't be expected to provide full accuracy, but
>>>> we can live with a reasonable approximation, I think.
>>>
>>>
>>>
>>> Yes, this is a starting point.
>>>
>>> The patch (and current mips get_wchan() implementation) tries to do is
>>> what I used to do to analyze stack dump by hand.
>>>
>>> 1. Determine PC and SP.
>>> 2. Disassemble a function containing the PC address.
>>> 3. If the function is leaf, make use RA for new PC.
>>
>>
>> This was always the tricky part for me.  How do you know if the 
>> function is a leaf?
>>
> 
> I think that if you cannot find a store instruction which saves RA to 
> the stack -- either because it's a real leaf and there is no such store, 
> or because the PC hasn't yet reached the store instruction -- then in 
> both cases it can be treated as a leaf.

Presumably you are walking the code back from the PC until you find the 
prolog.  How would you tell if you had gone past the beginning of a leaf 
function?  If you find a j $31 you might assume that it was the end of 
the previous function.

But that does not work if you are in a function that has multiple return 
points.  On encountering a j $31 you have no way of telling if you are 
in a leaf function or a non-leaf function with multiple return points.

I may be missing something here, if you know of a failure-proof manner 
to detect leaf functions I would appreciate hearing what it is.

Thanks,
David Daney.
