Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2011 19:09:45 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14594 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491187Ab1ELRJk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 May 2011 19:09:40 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4dcc148e0000>; Thu, 12 May 2011 10:10:38 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 12 May 2011 10:09:36 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 12 May 2011 10:09:36 -0700
Message-ID: <4DCC1450.6060006@caviumnetworks.com>
Date:   Thu, 12 May 2011 10:09:36 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] MIPS: lantiq: Add missing include to mach-easy50712.c
References: <1305145347-32605-1-git-send-email-ddaney@caviumnetworks.com> <1305145347-32605-2-git-send-email-ddaney@caviumnetworks.com> <20110511212538.GB17315@linux-mips.org> <4DCB76E5.3070703@openwrt.org>
In-Reply-To: <4DCB76E5.3070703@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 May 2011 17:09:36.0613 (UTC) FILETIME=[5F0D1150:01CC10C7]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 05/11/2011 10:57 PM, John Crispin wrote:
> On 11/05/11 23:25, Ralf Baechle wrote:
>> Thanks, folded into "MIPS: Lantiq: Add etop board support".
>>
>>    Ralf
>>
>>
>
> Hi,
>
> the include should be in arch/lantiq/devices.h and not the mach-*.c file.
>

It is best to keep the include pushed as far to the leaves of the build 
as possible.  That makes compiling other files that need devices.h faster.

> this got lost int he folding and i thought we fixed it yesterday already .

In any event I think Ralf has it sorted out now.  linux-queue is now 
building for me with no patches.

David Daney
