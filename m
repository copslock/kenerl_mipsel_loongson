Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Oct 2008 19:25:48 +0100 (BST)
Received: from sj-iport-2.cisco.com ([171.71.176.71]:6538 "EHLO
	sj-iport-2.cisco.com") by ftp.linux-mips.org with ESMTP
	id S21503436AbYJNSZp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Oct 2008 19:25:45 +0100
X-IronPort-AV: E=Sophos;i="4.33,410,1220227200"; 
   d="scan'208";a="95103422"
Received: from sj-dkim-2.cisco.com ([171.71.179.186])
  by sj-iport-2.cisco.com with ESMTP; 14 Oct 2008 18:25:36 +0000
Received: from sj-core-5.cisco.com (sj-core-5.cisco.com [171.71.177.238])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id m9EIPaC6022092;
	Tue, 14 Oct 2008 11:25:36 -0700
Received: from sausatlsmtp2.sciatl.com ([192.133.217.159])
	by sj-core-5.cisco.com (8.13.8/8.13.8) with ESMTP id m9EIPa9L012985;
	Tue, 14 Oct 2008 18:25:36 GMT
Received: from default.com ([192.133.217.159]) by sausatlsmtp2.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 14 Oct 2008 14:25:35 -0400
Received: from sausatlbhs02.corp.sa.net ([192.133.216.42]) by sausatlsmtp2.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 14 Oct 2008 14:25:34 -0400
Received: from [127.0.0.1] ([64.101.20.200]) by sausatlbhs02.corp.sa.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 14 Oct 2008 14:25:33 -0400
Message-ID: <48F4E40F.1090808@cisco.com>
Date:	Tue, 14 Oct 2008 11:25:19 -0700
From:	David VomLehn <dvomlehn@cisco.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	"Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: Rewrite cpu_to_name so it has one statement per
 line.
References: <48F38CBE.20303@caviumnetworks.com> <20081014090109.GB30880@linux-mips.org> <48F4C580.5030702@caviumnetworks.com>
In-Reply-To: <48F4C580.5030702@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Oct 2008 18:25:33.0254 (UTC) FILETIME=[3EB84E60:01C92E2A]
X-ST-MF-Message-Resent:	10/14/2008 14:25
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=2727; t=1224008736; x=1224872736;
	c=relaxed/simple; s=sjdkim2002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[PATCH]=20MIPS=3A=20Rewrite=20cpu_to_na
	me=20so=20it=20has=20one=20statement=20per=0A=20line.
	|Sender:=20;
	bh=Hy6bNr9oItqRkK2yZ1YoS3Oom3uVDqJ3dC8Oo2Jl6Lc=;
	b=eQhx2fw3hA5onwAHASSWmoxRAB74qdYDFxZva0xegHAfu8mGFkOShALk7c
	I8bnBoiWx/0sSEPKxbqIIu4+PZFFLz7CuPZ7jwsvjfJmTOShjAK33J3BnZIQ
	osFU6FfkQK;
Authentication-Results:	sj-dkim-2; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> Ralf Baechle wrote:
>> On Mon, Oct 13, 2008 at 11:00:30AM -0700, David Daney wrote:
>>
>>> Rewrite cpu_to_name so it has one statement per line.
>>>
>>> Future changes can now pass checkpatch.pl
>>
>> It's been one of those changes where I found the Linux coding style in my
>> opinion at least, not to be optimal.  My plan was to rewrite it like 
>> below
>> incomplete patch for ages.  What do you think?
>>
>>   Ralf
>>
>> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>>
>> diff --git a/arch/mips/include/asm/cpu-info.h 
>> b/arch/mips/include/asm/cpu-info.h
>> index 744cd8f..6d0f891 100644
>> --- a/arch/mips/include/asm/cpu-info.h
>> +++ b/arch/mips/include/asm/cpu-info.h
>> @@ -75,6 +75,7 @@ struct cpuinfo_mips {
>>      unsigned int        watch_reg_use_cnt; /* Usable by ptrace */
>>  #define NUM_WATCH_REGS 4
>>      u16            watch_reg_masks[NUM_WATCH_REGS];
>> +    const char        *name;
>>  } __attribute__((aligned(SMP_CACHE_BYTES)));
>>  
> 
> It increases the size of the cpuinfo_mips structure by sizeof(char *)
> for data that is only ever used in /proc/cpuinfo, also it goes against
> my sense of data normalization.  So I think the current method of
> looking it up on demand is fine.
> 
> I am not enamored with my patch as it doubles the number of lines in
> the function.  So we will defer to you and follow which ever style you
> decide is best.
> 
> David Daney

This is a pretty trivial issue, but I would note that the /proc/cpuinfo code is 
not a performance critical path. Thus, adding redundant data isn't worth it. If 
we really care about checkpatch and, even in this case, I kinda do, we could 
shrink the code by doing a linear scan of a table that contains the CPU type and 
the name. If you really care about code and data size *and* want it fast you 
could demand that the CPU types be sequentially numbered values, possibly enums, 
that you use to index into a table of CPU names.

Okay, I'm done beating this dead horse...

David VomLehn






     - - - - -                              Cisco                            - - - - -         
This e-mail and any attachments may contain information which is confidential, 
proprietary, privileged or otherwise protected by law. The information is solely 
intended for the named addressee (or a person responsible for delivering it to 
the addressee). If you are not the intended recipient of this message, you are 
not authorized to read, print, retain, copy or disseminate this message or any 
part of it. If you have received this e-mail in error, please notify the sender 
immediately by return e-mail and delete it from your computer.
