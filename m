Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 14:12:09 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:63376 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S22293485AbYJXNMC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2008 14:12:02 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m9ODBnFi015754;
	Fri, 24 Oct 2008 06:11:49 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 24 Oct 2008 06:11:48 -0700
Received: from [128.224.146.65] ([128.224.146.65]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 24 Oct 2008 06:11:48 -0700
Message-ID: <4901C993.6050304@windriver.com>
Date:	Fri, 24 Oct 2008 09:11:47 -0400
From:	Paul Gortmaker <paul.gortmaker@windriver.com>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC:	ddaney@caviumnetworks.com, linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 28/37] Cavium OCTEON FPU EMU exception as TLB exception
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com> <1224809821-5532-29-git-send-email-ddaney@caviumnetworks.com> <4901A5E3.3090702@ru.mvista.com>
In-Reply-To: <4901A5E3.3090702@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2008 13:11:48.0826 (UTC) FILETIME=[129E0BA0:01C935DA]
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
Precedence: bulk
X-list: linux-mips

Sergei Shtylyov wrote:
> Hello.
>
> ddaney@caviumnetworks.com wrote:
>
>
>
>> +    extern int do_dsemulret(struct pt_regs *);
>>   
>
>   Won't this cause a warning about the declaration amidst of code? You 
> should be able to put it in this function's declaration block 
> painlessly...

Yep, I gave David the heads up on this yesterday as well, so I'm
sure he'll squirrel it away in a more appropriate place and resend.

Thanks,
Paul.
>
> WBR. Sergei
>
>
