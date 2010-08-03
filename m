Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Aug 2010 22:19:33 +0200 (CEST)
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:50123 "EHLO
        ausc60ps301.us.dell.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493173Ab0HCUT3 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Aug 2010 22:19:29 +0200
X-Loopcount0: from 10.166.62.177
From:   <Ryan_D_Phillips@Dell.com>
To:     <janr@adax.com>, <ddaney@caviumnetworks.com>
CC:     <linux-mips@linux-mips.org>
Date:   Tue, 3 Aug 2010 15:18:17 -0500
Subject: RE: mips, eglibc, and toolchain compilation error
Thread-Topic: mips, eglibc, and toolchain compilation error
Thread-Index: AcszSAn9YEyRd+ehQHuFjivxFSyQugAANuyQ
Message-ID: <017987BD9AB15445B9968338EC889BB107D3ECEE33@AUSX7MCPS301.AMER.DELL.COM>
References: <017987BD9AB15445B9968338EC889BB107D3ECEC72@AUSX7MCPS301.AMER.DELL.COM>
 <4C586A94.2030409@caviumnetworks.com> <4C5877F1.2010004@adax.com>
In-Reply-To: <4C5877F1.2010004@adax.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginalArrivalTime: 03 Aug 2010 20:18:19.0383 (UTC) FILETIME=[03752870:01CB3349]
Return-Path: <Ryan_D_Phillips@Dell.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Ryan_D_Phillips@Dell.com
Precedence: bulk
X-list: linux-mips

Thanks Jan. I will try this.

David: For reference the binutils version is 2.20.1.

Regards,
Ryan

-----Original Message-----
From: Jan Rovins [mailto:janr@adax.com] 
Sent: Tuesday, August 03, 2010 3:11 PM
To: David Daney
Cc: Phillips, Ryan D; linux-mips@linux-mips.org
Subject: Re: mips, eglibc, and toolchain compilation error

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
