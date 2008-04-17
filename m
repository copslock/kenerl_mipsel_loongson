Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2008 14:37:27 +0100 (BST)
Received: from dns0.mips.com ([63.167.95.198]:17907 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20021417AbYDQNhY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 17 Apr 2008 14:37:24 +0100
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id m3HDaIFm003633;
	Thu, 17 Apr 2008 06:36:18 -0700 (PDT)
Received: from [127.0.0.1] (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id m3HDbES0017774;
	Thu, 17 Apr 2008 06:37:15 -0700 (PDT)
Message-ID: <480752B8.9040601@mips.com>
Date:	Thu, 17 Apr 2008 15:38:00 +0200
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: Patches for 34K APRP
References: <4805FFE6.5080903@mips.com> <20080417124319.GA31453@linux-mips.org>
In-Reply-To: <20080417124319.GA31453@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Wed, Apr 16, 2008 at 03:32:22PM +0200, Kevin D. Kissell wrote:
>
>   
>>  arch/mips/kernel/setup.c |    4 ++++
>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
>> index f8a535a..a6a0d62 100644
>> --- a/arch/mips/kernel/setup.c
>> +++ b/arch/mips/kernel/setup.c
>> @@ -336,6 +336,10 @@ static void __init bootmem_init(void)
>>  #endif
>>  		max_low_pfn = PFN_DOWN(HIGHMEM_START);
>>  	}
>> +	/*
>> +	 * Propagate final value of max_low_pfn to max_pfn
>> +	 */
>> +	max_pfn = max_low_pfn;
>>     
>
> That will be incorrect for systems with highmem.  So I think the right
> fix is to replace all references to max_pfn in vpe.c with max_low_pfn.
>   
Which will still be incorrect for systems with highmem, right?  The reason
I propose fixing max_pfn instead of just hacking vpe.c is that, as per my
email of a couple of weeks ago, there are other, architecture independent,
bits of code in the 2.6.24 kernel where max_pfn is assumed to be sane,
and the value of zero may result in otherwise inexplicable Bad Things
happening.  So even if you want to change vpe.c to use max_low_pfn
instead of max_pfn, I believe that we really want that patch to setup.c
until such time as we've verified that the kernel is max_pfn-free.

          Regards,

          Kevin K.
