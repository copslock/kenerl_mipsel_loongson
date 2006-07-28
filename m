Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jul 2006 18:34:57 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:38906 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133763AbWG1Rer
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Jul 2006 18:34:47 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k6SHYVVv000389;
	Fri, 28 Jul 2006 10:34:32 -0700 (PDT)
Received: from ukservices1.mips.com (ukservices1 [192.168.192.240])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id k6SHYWfA024992;
	Fri, 28 Jul 2006 10:34:33 -0700 (PDT)
Received: from wapping.mips-uk.com ([172.20.192.98])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1G6WEF-00037m-00; Fri, 28 Jul 2006 18:34:27 +0100
Message-ID: <44CA4AA3.8080700@mips.com>
Date:	Fri, 28 Jul 2006 18:34:27 +0100
From:	Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies
User-Agent: Thunderbird 1.5.0.4 (X11/20060619)
MIME-Version: 1.0
To:	David Daney <ddaney@avtrex.com>
CC:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ths@networkno.de,
	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] dump_stack() based on prologue code analysis
References: <20060727170305.GB4505@networkno.de>	<cda58cb80607271151n2dcfe64cn4cb1ecca3ece6b1e@mail.gmail.com>	<20060727191245.GD4505@networkno.de> <20060728.233842.41629448.anemo@mba.ocn.ne.jp> <44CA43EC.9010904@avtrex.com>
In-Reply-To: <44CA43EC.9010904@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: nigel@mips.com
X-Scanned-By: MIMEDefang 2.39
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



David Daney wrote:
> Atsushi Nemoto wrote:
>> On Thu, 27 Jul 2006 20:12:45 +0100, Thiemo Seufer <ths@networkno.de> 
>> wrote:
>>
>>> IOW, binary analysis can't be expected to provide full accuracy, but
>>> we can live with a reasonable approximation, I think.
>>
>>
>> Yes, this is a starting point.
>>
>> The patch (and current mips get_wchan() implementation) tries to do is
>> what I used to do to analyze stack dump by hand.
>>
>> 1. Determine PC and SP.
>> 2. Disassemble a function containing the PC address.
>> 3. If the function is leaf, make use RA for new PC.
>
> This was always the tricky part for me.  How do you know if the 
> function is a leaf?
>

I think that if you cannot find a store instruction which saves RA to 
the stack -- either because it's a real leaf and there is no such store, 
or because the PC hasn't yet reached the store instruction -- then in 
both cases it can be treated as a leaf.

Nigel
