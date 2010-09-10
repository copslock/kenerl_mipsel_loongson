Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Sep 2010 21:11:50 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14176 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491127Ab0IJTLq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Sep 2010 21:11:46 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c8a5b8e0000>; Fri, 10 Sep 2010 09:23:42 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 10 Sep 2010 09:23:08 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 10 Sep 2010 09:23:08 -0700
Message-ID: <4C8A5B6C.5080405@caviumnetworks.com>
Date:   Fri, 10 Sep 2010 09:23:08 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100720 Fedora/3.0.6-1.fc12 Thunderbird/3.0.6
MIME-Version: 1.0
To:     Greg Ungerer <gerg@snapgear.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: fix start of free memory when using initrd
References: <201009080550.o885ohjD014188@goober.internal.moreton.com.au> <4C891863.1080602@caviumnetworks.com> <4C89CBDA.1030309@snapgear.com>
In-Reply-To: <4C89CBDA.1030309@snapgear.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Sep 2010 16:23:08.0583 (UTC) FILETIME=[74767370:01CB5104]
X-archive-position: 27744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 8672

On 09/09/2010 11:10 PM, Greg Ungerer wrote:
>
> Hi David,
>
> David Daney wrote:
[...]
>> We have the attached patch (plus a few more hacks), I don't think it
>> is universally safe to change the calculation of reserved_end.
>> Although the patch has some code formatting problems you might
>> consider using it as a starting point.>
> I don't use the Cavium u-boot boot loader on this. (And don't use any
> of the named blocks, or other data struct passing from the boot loader
> to the kernel). So the patch is not really useful for me.
>
> But I am interested, why do you think it is not safe to change
> reserved_end?

For Octeon it is probably safe, but there is a reason that this complex 
logic for restricting the usable memory ranges exists.  Other targets 
require it, so great care must be taken not to break the non-octeon targets.

>
> There is the possible overlap of the kernels bootmem setup data
> that is not checked (which sparc does for example). But otherwise
> what problems do you see here?
>

I lack the imagination necessary to come up with a failing scenario, but 
I am also paranoid, so I see danger everywhere.

David Daney
