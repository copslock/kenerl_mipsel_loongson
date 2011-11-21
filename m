Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 19:16:20 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18976 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903796Ab1KUSQL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2011 19:16:11 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4eca95be0001>; Mon, 21 Nov 2011 10:17:34 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 21 Nov 2011 10:16:09 -0800
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 21 Nov 2011 10:16:08 -0800
Message-ID: <4ECA9568.2000601@caviumnetworks.com>
Date:   Mon, 21 Nov 2011 10:16:08 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     David Daney <ddaney.cavm@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: Get rid of some #ifdefery in arch/mips/mm/tlb-r4k.c
References: <1321651809-23395-1-git-send-email-ddaney.cavm@gmail.com> <4ECA2869.2000404@mvista.com>
In-Reply-To: <4ECA2869.2000404@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Nov 2011 18:16:08.0962 (UTC) FILETIME=[A466EE20:01CCA879]
X-archive-position: 31891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17602

On 11/21/2011 02:31 AM, Sergei Shtylyov wrote:
> Hello.
>
> On 19-11-2011 1:30, David Daney wrote:
>
>> From: David Daney<david.daney@cavium.com>
>
>> In the case of !CONFIG_HUGETLB_PAGE, in linux/hugetlb.h we have this
>> definition:
>
>      Missed it?

Indeed, I could swear that I put '#define pmd_huge(x)	0' in that commit 
log, but it is not there.  The string was even still highlighted in my 
editor.  At this point I blame the 'git commit' command for erasing that 
line.

David Daney

>
>> The other huge page constants in the if(pmd_huge()) block are likewise
>> defined, so we can get rid of the #ifdef CONFIG_HUGETLB_PAGE an let
>> the compiler optimize this block away instead.  Doing this the code
>> has a much cleaner appearance.
>
>> Signed-off-by: David Daney<david.daney@cavium.com>
>
> WBR, Sergei
>
