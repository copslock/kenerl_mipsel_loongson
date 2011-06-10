Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2011 21:00:14 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16138 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491037Ab1FJTAJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jun 2011 21:00:09 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4df269f80000>; Fri, 10 Jun 2011 12:01:12 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 10 Jun 2011 12:00:07 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 10 Jun 2011 12:00:07 -0700
Message-ID: <4DF269B1.2020407@caviumnetworks.com>
Date:   Fri, 10 Jun 2011 12:00:01 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     David VomLehn <dvomlehn@cisco.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        linux-mips@linux-mips.org, Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        "Dezhong Diao (dediao)" <dediao@cisco.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Converting MIPS to Device Tree
References: <20110606010753.GA16202@linux-mips.org> <BANLkTik1mRWTcX8WgO5s6mFrUGYwBRmSow@mail.gmail.com> <20110607230218.GA23552@dvomlehn-lnx2.corp.sa.net> <4DEEB2A8.8050302@caviumnetworks.com> <20110610185745.GA3536@linux-mips.org>
In-Reply-To: <20110610185745.GA3536@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jun 2011 19:00:07.0143 (UTC) FILETIME=[9D226770:01CC27A0]
X-archive-position: 30324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9499

On 06/10/2011 11:57 AM, Ralf Baechle wrote:
> On Tue, Jun 07, 2011 at 04:22:16PM -0700, David Daney wrote:
>
>>> use a parameter like "devtree=<virtual-address>" on the command line, passed
>>> in any way the bootloader likes.
>>
>> Some  u-boots for non-mips platforms pass it in the environment of
>> the bootm protocol.
>>
>> I would say to pass the pointer to the DTB in the environment, but
>> not all platforms (like powertv) have an environment.  So I guess
>> the command line has to do.
>
> 3 steps:
>
>    1) Use command line argument for DT
>    2) Iff 1) fails, use DT specified by environment

I'm OK with this as long as we can define 'the environment' to include 
what I am currently doing on Octeon.


>    3) Iff 1) and 2) fail, use builtin DTB.
>
>> Also I think we should pass the physical address of the DTB, not the
>> virtual address.  It would be the kernel's responsibility to figure
>> out what the virtual address is.
>
> I like the basic idea - but ...  Most firmware will only use KSEG0 / XKPHYS
> mappings so there should be no aliasing issue but still there could be
> conflicting cache modes.  So we should also specify that firmware should
> writeback and invalidate the DTB from caches.
>
>    Ralf
>
