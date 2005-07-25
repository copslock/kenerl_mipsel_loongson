Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jul 2005 08:42:02 +0100 (BST)
Received: from mail-out.m-online.net ([IPv6:::ffff:212.18.0.9]:59541 "EHLO
	mail-out.m-online.net") by linux-mips.org with ESMTP
	id <S8225439AbVGYHlj>; Mon, 25 Jul 2005 08:41:39 +0100
Received: from mail.m-online.net (svr20.m-online.net [192.168.3.148])
	by mail-out.m-online.net (Postfix) with ESMTP id 3F8FBF64D;
	Mon, 25 Jul 2005 09:43:57 +0200 (CEST)
Received: from schenk.isar.de (host-82-135-47-202.customer.m-online.net [82.135.47.202])
	by mail.m-online.net (Postfix) with ESMTP id 2F11DCA115;
	Mon, 25 Jul 2005 09:43:57 +0200 (CEST)
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j6P7huG19875;
	Mon, 25 Jul 2005 09:43:56 +0200
Received: from [172.22.10.24] (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (Postfix) with ESMTP id 691B97C0CE;
	Mon, 25 Jul 2005 09:43:56 +0200 (CEST)
Message-ID: <42E4983C.5030804@rtschenk.de>
Date:	Mon, 25 Jul 2005 09:43:56 +0200
From:	Rojhalat Ibrahim <imr@rtschenk.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Alex Gonzalez <linux-mips@packetvision.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Going over 512M of memory
References: <20050721153359Z8225218-3678+3745@linux-mips.org>	 <20050722043057.GA3803@linux-mips.org>	 <1122023087.30605.3.camel@euskadi.packetvision>	 <20050722131417.GA29581@linux-mips.org> <1122039139.30605.21.camel@euskadi.packetvision>
In-Reply-To: <1122039139.30605.21.camel@euskadi.packetvision>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <imr@rtschenk.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imr@rtschenk.de
Precedence: bulk
X-list: linux-mips

Hi,

I am not sure what patch you are actually talking about.
In the mentioned thread there were several. Did you only apply
the last one or all of them, i.e. did you also apply
the patches that keep flushing the caches?
Because those are really only a workaround and not a
solution to the root cause of the problem.

Rojhalat Ibrahim


Alex Gonzalez wrote:
> It's a RM9020.
> 
> Quoting Ibrahim's,
> 
> "With a slightly extended patch it actually works. But afterwards
> I get a lot of Illegal instructions and Segmentation faults, where
> there shouldn't be any. Below is the patch I used."
> 
> And after you post an improved patch, he says,
> 
> "I presume CKSEG is CKSEG0 in the above patch. With that it works
> about the same as before. So do you have any clue what the problem
> behind all that really is? Furthermore I still have all those
> "Illegal instruction" and "Segmentation fault" messages that
> shouldn't be there."
> 
> The illegal instructions and segmentation faults turned to be the cpu_has_64bit_gp_regs setting. So I presume it worked for him.
> 
> In our case, it seems to work completely OK. I am running a complete memory test over the whole 1G to be completely sure (with memtester), and I'll report the result back.
> 
> Thanks,
> Alex
> 
> 
> On Fri, 2005-07-22 at 14:14, Ralf Baechle wrote:
> 
>>On Fri, Jul 22, 2005 at 10:04:47AM +0100, Alex Gonzalez wrote:
>>
>>
>>>Our target experienced a kernel panic at startup when trying to access
>>>memory above 512MB.
>>>
>>>Reading the list archives I found this thread with a proposed patch:
>>>
>>>http://www.linux-mips.org/archives/linux-mips/2005-02/msg00115.html
>>>
>>>After applying the patch our target boots OK and appears to be able to
>>>access the whole memory range without problems.
>>>
>>>Any idea why this patch didn't make it to the repository? Is it safe?
>>
>>It is - but according to Ibrahim's posting that you're pointing to it
>>didn't solve his problem.
>>
>>What CPU are you using, btw?
>>
>>  Ralf
