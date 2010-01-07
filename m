Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2010 21:58:06 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1817 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492768Ab0AGU5j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2010 21:57:39 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b464abd0005>; Thu, 07 Jan 2010 12:57:33 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 7 Jan 2010 12:52:08 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 7 Jan 2010 12:52:08 -0800
Message-ID: <4B464977.2090801@caviumnetworks.com>
Date:   Thu, 07 Jan 2010 12:52:07 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH 1/7] MIPS: Octeon: Fix EIO handling.
References: <4B463005.8060505@caviumnetworks.com> <1262891106-32146-1-git-send-email-ddaney@caviumnetworks.com> <4B4645EE.5050302@ru.mvista.com>
In-Reply-To: <4B4645EE.5050302@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jan 2010 20:52:08.0441 (UTC) FILETIME=[46F2D690:01CA8FDB]
X-archive-position: 25544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 5237

Sergei Shtylyov wrote:
> Hello.
> 
> David Daney wrote:
> 
>> If an interrupt handler disables interrupts, the EOI function will
>> just reenable them.  This will put us in an endless loop when the
>> upcoming Ethernet driver patches are applied.
>>
>> Only reenable the interrupt on EOI if it is not IRQ_DISABLED.  This
>> requires that the EIO function be separate from the ENABLE function.
>> We also rename the ACK functions to correspond with their function.
>>
>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>>   
> 
>   I guess the subject should read "EIO", not "EIO"...
> 

Indeed.  The compiler didn't catch that one.

Perhaps Ralf can fix it if he merges it, otherwise I can resubmit with 
corrected spelling.

David Daney
