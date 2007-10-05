Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Oct 2007 16:58:14 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:65217 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20024220AbXJEP6E (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 Oct 2007 16:58:04 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id A6724309C66;
	Fri,  5 Oct 2007 15:57:38 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Fri,  5 Oct 2007 15:57:38 +0000 (UTC)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 5 Oct 2007 08:57:25 -0700
Message-ID: <47065EE4.8030402@avtrex.com>
Date:	Fri, 05 Oct 2007 08:57:24 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>,
	linux-mips@linux-mips.org
Subject: Re: kernel bug using 2.6.23-rc9
References: <1191502153.10050.15.camel@scarafaggio> <20071005122543.GB22239@linux-mips.org>
In-Reply-To: <20071005122543.GB22239@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Oct 2007 15:57:25.0814 (UTC) FILETIME=[6C7C5560:01C80768]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Oct 04, 2007 at 02:49:13PM +0200, Giuseppe Sacco wrote:
> 
>> Hi, while testing the latest kernel on SGI O2 I got may kernel bugs like
>> this:
>>
>> Kernel bug detected[#9]:
>> Cpu 0
>> $ 0   : 0000000000000000 ffffffff9001fce0 0000000000000001 0000000000000f18
>> $ 4   : 980000000111b4b8 000000007f955f18 ffffffff80400000 0000000000003fff
>> $ 8   : 00000000000050f1 000000007f955f18 9800000006073d68 9800000006073d60
>> $12   : 0000000000000010 ffffffff80000008 ffffffff80091680 0000000000000000
>> $16   : 980000000111b4b8 980000000768ddd0 000000000000000e 000000007f955f18
>> $20   : 9800000000581908 9800000007898080 9800000006073d68 9800000006073d60
>> $24   : 0000000000478284 000000002ac30580                                  
>> $28   : 9800000006070000 9800000006073cd0 0000000000000000 ffffffff8001b390
>> Hi    : 000000000000f2d3
>> Lo    : 00000000000050f1
>> epc   : ffffffff8001c800 kmap_coherent+0x10/0x118     Tainted: G      D
>> ra    : ffffffff8001b390 __flush_anon_page+0x70/0x90
> 
> Very interesting.  Can you describe me your setup or maybe even come up
> with a test case for this?
> 
Perhaps: 'cat /proc/self/cmdline'

As we were hacking O_DIRECT support into 2.6.15, I found what seems like 
a very similar situation.

It seems that all users of get_user_pages() *except* 
/proc/*/[cmdline|environ] call get_user_pages() with addresses aligned 
on page boundaries.  I am not sure if that is the problem here, but it 
seems similar.

David Daney.
