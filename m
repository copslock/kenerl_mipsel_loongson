Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2010 18:20:13 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3776 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492105Ab0BHRUJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2010 18:20:09 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b7047b80000>; Mon, 08 Feb 2010 09:19:57 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 8 Feb 2010 09:19:43 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 8 Feb 2010 09:19:43 -0800
Message-ID: <4B7047AD.4010206@caviumnetworks.com>
Date:   Mon, 08 Feb 2010 09:19:41 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 3/4] MIPS: Add TLBP to uasm.
References: <4B6CA90C.1000609@caviumnetworks.com> <1265412431-28526-3-git-send-email-ddaney@caviumnetworks.com> <4B6FEE4A.6090504@ru.mvista.com>
In-Reply-To: <4B6FEE4A.6090504@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Feb 2010 17:19:43.0469 (UTC) FILETIME=[E79271D0:01CAA8E2]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Sergei Shtylyov wrote:
> Hello.
> 
> David Daney wrote:
> 
>> The soon to follow Read Inhibit/eXecute Inhibit patch needs TLBP
>>   
> 
>  But you're adding TLBR support, not TLBP?
> 

Right.

I am making more changes to this patch set and will correct that.

Thanks,
David Daney
