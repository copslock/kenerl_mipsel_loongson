Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Oct 2008 17:20:53 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:21528 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21492895AbYJNQUv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Oct 2008 17:20:51 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B48f4c6d80000>; Tue, 14 Oct 2008 12:20:40 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 14 Oct 2008 09:20:38 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 14 Oct 2008 09:20:38 -0700
Message-ID: <48F4C6D5.3000100@caviumnetworks.com>
Date:	Tue, 14 Oct 2008 09:20:37 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Align .data.cacheline_aligned based on	MIPS_L1_CACHE_SHIFT
References: <48F3DB6D.9020108@caviumnetworks.com> <20081014090757.GC30880@linux-mips.org>
In-Reply-To: <20081014090757.GC30880@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Oct 2008 16:20:38.0038 (UTC) FILETIME=[CB391B60:01C92E18]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Oct 13, 2008 at 04:36:13PM -0700, David Daney wrote:
> 
>> Align .data.cacheline_aligned based on the MIPS_L1_CACHE_SHIFT
>> configuration variable.
>>
>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>> Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
> 
> Thanks, applied already yesterday as you may have noticed,
> 

Actually I didn't.  When I look at:

http://www.linux-mips.org/git?p=linux.git;a=summary

I don't see it.  Am I looking in the wrong place?

David Daney
