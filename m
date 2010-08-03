Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Aug 2010 21:14:33 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1917 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493163Ab0HCTOa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Aug 2010 21:14:30 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c586ab10000>; Tue, 03 Aug 2010 12:14:57 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 3 Aug 2010 12:14:28 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 3 Aug 2010 12:14:28 -0700
Message-ID: <4C586A94.2030409@caviumnetworks.com>
Date:   Tue, 03 Aug 2010 12:14:28 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Ryan_D_Phillips@Dell.com
CC:     linux-mips@linux-mips.org
Subject: Re: mips, eglibc, and toolchain compilation error
References: <017987BD9AB15445B9968338EC889BB107D3ECEC72@AUSX7MCPS301.AMER.DELL.COM>
In-Reply-To: <017987BD9AB15445B9968338EC889BB107D3ECEC72@AUSX7MCPS301.AMER.DELL.COM>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Aug 2010 19:14:28.0708 (UTC) FILETIME=[18328A40:01CB3340]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Which version of Binutils?

If it is up to date, I don't know what the problem is.

You would have to look at the exact commands being passed to the linker 
as well as look at the objects involved.

David Daney


On 08/03/2010 12:07 PM, Ryan_D_Phillips@Dell.com wrote:
> Hi All,
>
> I'm trying to get openembedded to build me a 32bit MIPS toolchain using EGLIBC. GCC 4.4.4 seems to compile ok, but when I get to eglibc 2.10 and 2.11 the compiler spits this error:
>
> | /home/rphillips/sdk/build-dell-tor-angstrom/tmp/work/mips-angstrom-linux/eglibc-2.11-r11.6/build-mips-angstrom-linux/libc_pic.os: In function `_mcount':
> | (.debug_macinfo+0x5d7a7a8): relocation truncated to fit: R_MIPS_HI16 against `_gp_disp'
> | collect2: ld returned 1 exit status
> | make[1]: *** [/home/rphillips/sdk/build-dell-tor-angstrom/tmp/work/mips-angstrom-linux/eglibc-2.11-r11.6/build-mips-angstrom-linux/libc.so] Error 1
> | make[1]: Leaving directory `/home/rphillips/sdk/build-dell-tor-angstrom/tmp/work/mips-angstrom-linux/eglibc-2.11-r11.6/eglibc-2_11/libc'
> | make: *** [all] Error 2
> | FATAL: oe_runmake failed
> NOTE: Task failed: /home/rphillips/sdk/build-dell-tor-angstrom/tmp/work/mips-angstrom-linux/eglibc-2.11-r11.6/temp/log.do_compile.10164
> ERROR: TaskFailed event exception, aborting
> ERROR: Build of /home/rphillips/work/mips/sdk/openembedded/recipes/eglibc/eglibc_2.11.bb do_compile failed
> ERROR: Task 9 (/home/rphillips/work/mips/sdk/openembedded/recipes/eglibc/eglibc_2.11.bb, do_compile) failed
> NOTE: Tasks Summary: Attempted 475 tasks of which 159 didn't need to be rerun and 1 failed.
> ERROR: '/home/rphillips/work/mips/sdk/openembedded/recipes/eglibc/eglibc_2.11.bb' failed
>
> It appears the Debian MIPS stack uses EGLIBC and GCC 4 successfully. Does anyone know what the problem is, and how I can fix it?
>
> Google has been of limited use for this error.
>
> Regards,
> Ryan Phillips
>
>
