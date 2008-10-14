Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Oct 2008 17:15:18 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:6673 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21491996AbYJNQPP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Oct 2008 17:15:15 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B48f4c5830000>; Tue, 14 Oct 2008 12:14:59 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 14 Oct 2008 09:14:57 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 14 Oct 2008 09:14:57 -0700
Message-ID: <48F4C580.5030702@caviumnetworks.com>
Date:	Tue, 14 Oct 2008 09:14:56 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org,
	"Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: Rewrite cpu_to_name so it has one statement per
 line.
References: <48F38CBE.20303@caviumnetworks.com> <20081014090109.GB30880@linux-mips.org>
In-Reply-To: <20081014090109.GB30880@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Oct 2008 16:14:57.0009 (UTC) FILETIME=[FFF43610:01C92E17]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Oct 13, 2008 at 11:00:30AM -0700, David Daney wrote:
> 
>> Rewrite cpu_to_name so it has one statement per line.
>>
>> Future changes can now pass checkpatch.pl
> 
> It's been one of those changes where I found the Linux coding style in my
> opinion at least, not to be optimal.  My plan was to rewrite it like below
> incomplete patch for ages.  What do you think?
> 
>   Ralf
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
> index 744cd8f..6d0f891 100644
> --- a/arch/mips/include/asm/cpu-info.h
> +++ b/arch/mips/include/asm/cpu-info.h
> @@ -75,6 +75,7 @@ struct cpuinfo_mips {
>  	unsigned int		watch_reg_use_cnt; /* Usable by ptrace */
>  #define NUM_WATCH_REGS 4
>  	u16			watch_reg_masks[NUM_WATCH_REGS];
> +	const char		*name;
>  } __attribute__((aligned(SMP_CACHE_BYTES)));
>  

It increases the size of the cpuinfo_mips structure by sizeof(char *)
for data that is only ever used in /proc/cpuinfo, also it goes against
my sense of data normalization.  So I think the current method of
looking it up on demand is fine.

I am not enamored with my patch as it doubles the number of lines in
the function.  So we will defer to you and follow which ever style you
decide is best.

David Daney
