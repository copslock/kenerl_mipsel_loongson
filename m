Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Feb 2010 18:37:20 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3534 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492052Ab0BERhN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Feb 2010 18:37:13 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b6c574d0000>; Fri, 05 Feb 2010 09:37:17 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 5 Feb 2010 09:36:22 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 5 Feb 2010 09:36:22 -0800
Message-ID: <4B6C5714.3080603@caviumnetworks.com>
Date:   Fri, 05 Feb 2010 09:36:20 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Muthu Kumaran <muthukumaranbe@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Switch FPU emulator trap to BREAK instruction
References: <4101f55c1002050005t1d7e1b09qe988e39932dfc411@mail.gmail.com>
In-Reply-To: <4101f55c1002050005t1d7e1b09qe988e39932dfc411@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Feb 2010 17:36:22.0298 (UTC) FILETIME=[BBAE67A0:01CAA689]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Muthu Kumaran wrote:
> I am using 2.6.18 linux version on MIPS32 core. One of the application
> is using intensive floating point operations. This hardware doesn't
> have FPU and also the application is not compiled for software
> floating point support.
> Hence, it is using the floating point emulation.
> 
> While running that application, On a timer interrupt there is a normal
> integer div instruction which gives wrong result in the HI register.
> 
> However, when I applied the following patch, this problem disappeared.
> 
> http://kerneltrap.org/mailarchive/git-commits-head/2008/10/30/3873324
> 
> When I looked into the patch, handling of invalid instruction
> exception is moved from trap to break.

Incorrect analysis.  It was changed from an Adress Error (ADE) exception 
to a BREAK.


> There is no other behavioural change in this patch. I really don't
> understand the need for this patch, May I ask someone to explain the
> background information behind this patch? Is this for any known issue?
> 

The change log states the reason.  FPU emulator delay slot emulation was 
failing on some systems.


David Daney
