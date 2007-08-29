Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2007 05:07:26 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:40619 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20021563AbXH2EHR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Aug 2007 05:07:17 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 9F0BD309DAD;
	Wed, 29 Aug 2007 04:07:12 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Wed, 29 Aug 2007 04:07:12 +0000 (UTC)
Received: from [192.168.7.235] ([192.168.7.235]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 28 Aug 2007 21:07:11 -0700
Message-ID: <46D4F0EF.5030009@avtrex.com>
Date:	Tue, 28 Aug 2007 21:07:11 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20070719)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, jschmidt@avtrex.com, sfrancis@avtrex.com
Subject: Re: O_DIRECT file access and cache aliasing...
References: <46D4C61C.6010008@avtrex.com> <20070829.115949.75427319.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20070829.115949.75427319.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Aug 2007 04:07:11.0107 (UTC) FILETIME=[12DB5530:01C7E9F2]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Tue, 28 Aug 2007 18:04:28 -0700, David Daney <ddaney@avtrex.com> wrote:
>   
>> When we write files that were opened with O_DIRECT set, we observe that 
>> there are many 16 byte chunks of data in the files that contain all 
>> zeros instead of the correct data.
>>
>> My understanding is that the cache is virtually indexed.  So I think 
>> what is happening is that when data is written to memory by a user 
>> application that does an O_DIRECT write, the IDE driver is given a list 
>> of pages to transfer to the disk.  The driver then does a 
>> dma_cache_wback() on the KSEG0 address of the pages before initiating 
>> the DMA operation.  Since the KSEG0 address and the USEG address of the 
>> physical memory are different, the data is never flushed to memory 
>> resulting in incorrect data being written to disk.
>>     
>
> I think get_user_pages() should flush user data for O_DIRECT.
>
> The get_user_pages() uses flush_anon_page() to do it, and MIPS
> flush_anon_page() was added on Mar 2007.  Does your kernel have this
> fix?
>   
I doubt it.  We are currently using 2.6.15.

We will look at either moving to a recent kernel or back-porting the 
patch you mention.

Thanks for the help,
David Daney
