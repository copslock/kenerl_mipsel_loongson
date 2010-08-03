Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Aug 2010 22:11:28 +0200 (CEST)
Received: from mail1.adax.com ([208.201.231.104]:23307 "EHLO mail1.adax.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492081Ab0HCULX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Aug 2010 22:11:23 +0200
Received: from static-151-204-189-187.pskn.east.verizon.net (static-151-204-189-187.pskn.east.verizon.net [151.204.189.187])
        by mail1.adax.com (Postfix) with ESMTP id 81F70120C48;
        Tue,  3 Aug 2010 13:11:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by static-151-204-189-187.pskn.east.verizon.net (Postfix) with ESMTP id B48D5201EA;
        Tue,  3 Aug 2010 16:11:11 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at
        static-151-204-189-187.pskn.east.verizon.net
Received: from static-151-204-189-187.pskn.east.verizon.net ([127.0.0.1])
        by localhost (static-151-204-189-187.pskn.east.verizon.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4kR5oRwNlE2G; Tue,  3 Aug 2010 16:11:06 -0400 (EDT)
Received: from [192.168.1.76] (jr001327.mtl-nj.adax [192.168.1.76])
        by static-151-204-189-187.pskn.east.verizon.net (Postfix) with ESMTPS id 45613201DD;
        Tue,  3 Aug 2010 16:11:06 -0400 (EDT)
Message-ID: <4C5877F1.2010004@adax.com>
Date:   Tue, 03 Aug 2010 16:11:29 -0400
From:   Jan Rovins <janr@adax.com>
Organization: Adax Inc.
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     Ryan_D_Phillips@Dell.com, linux-mips@linux-mips.org
Subject: Re: mips, eglibc, and toolchain compilation error
References: <017987BD9AB15445B9968338EC889BB107D3ECEC72@AUSX7MCPS301.AMER.DELL.COM> <4C586A94.2030409@caviumnetworks.com>
In-Reply-To: <4C586A94.2030409@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <janr@adax.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: janr@adax.com
Precedence: bulk
X-list: linux-mips

Looks like a similar problim is documented here:
http://www.mail-archive.com/openembedded-devel@lists.openembedded.org/msg00090.html

(their solution was to rebuild GCC without the  -fno-omit-frame-pointer option)

Jan



David Daney wrote:
> Which version of Binutils?
>
> If it is up to date, I don't know what the problem is.
>
> You would have to look at the exact commands being passed to the 
> linker as well as look at the objects involved.
>
> David Daney
>
>
> On 08/03/2010 12:07 PM, Ryan_D_Phillips@Dell.com wrote:
>> Hi All,
>>
>> I'm trying to get openembedded to build me a 32bit MIPS toolchain 
>> using EGLIBC. GCC 4.4.4 seems to compile ok, but when I get to eglibc 
>> 2.10 and 2.11 the compiler spits this error:
>>
>> | 
>> /home/rphillips/sdk/build-dell-tor-angstrom/tmp/work/mips-angstrom-linux/eglibc-2.11-r11.6/build-mips-angstrom-linux/libc_pic.os: 
>> In function `_mcount':
>> | (.debug_macinfo+0x5d7a7a8): relocation truncated to fit: 
>> R_MIPS_HI16 against `_gp_disp'
>> | collect2: ld returned 1 exit status
>> | make[1]: *** 
>> [/home/rphillips/sdk/build-dell-tor-angstrom/tmp/work/mips-angstrom-linux/eglibc-2.11-r11.6/build-mips-angstrom-linux/libc.so] 
>> Error 1
>> | make[1]: Leaving directory 
>> `/home/rphillips/sdk/build-dell-tor-angstrom/tmp/work/mips-angstrom-linux/eglibc-2.11-r11.6/eglibc-2_11/libc' 
>>
>> | make: *** [all] Error 2
>> | FATAL: oe_runmake failed
>> NOTE: Task failed: 
>> /home/rphillips/sdk/build-dell-tor-angstrom/tmp/work/mips-angstrom-linux/eglibc-2.11-r11.6/temp/log.do_compile.10164 
>>
>> ERROR: TaskFailed event exception, aborting
>> ERROR: Build of 
>> /home/rphillips/work/mips/sdk/openembedded/recipes/eglibc/eglibc_2.11.bb 
>> do_compile failed
>> ERROR: Task 9 
>> (/home/rphillips/work/mips/sdk/openembedded/recipes/eglibc/eglibc_2.11.bb, 
>> do_compile) failed
>> NOTE: Tasks Summary: Attempted 475 tasks of which 159 didn't need to 
>> be rerun and 1 failed.
>> ERROR: 
>> '/home/rphillips/work/mips/sdk/openembedded/recipes/eglibc/eglibc_2.11.bb' 
>> failed
>>
>> It appears the Debian MIPS stack uses EGLIBC and GCC 4 successfully. 
>> Does anyone know what the problem is, and how I can fix it?
>>
>> Google has been of limited use for this error.
>>
>> Regards,
>> Ryan Phillips
>>
>>
>
