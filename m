Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Apr 2012 21:10:00 +0200 (CEST)
Received: from dns0.mips.com ([12.201.5.70]:47457 "EHLO dns0.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903711Ab2DJTJx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 10 Apr 2012 21:09:53 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns0.mips.com (8.13.8/8.13.8) with ESMTP id q3AJ9jhV032615;
        Tue, 10 Apr 2012 12:09:46 -0700
Received: from [192.168.65.146] (192.168.65.146) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Tue, 10 Apr 2012
 12:09:42 -0700
Message-ID: <4F848576.6040204@mips.com>
Date:   Tue, 10 Apr 2012 12:09:42 -0700
From:   Leonid Yegoshin <yegoshin@mips.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     "Steven J. Hill" <sjhill@mips.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>
Subject: Re: [PATCH] Add MIPS64R2 core support.
References: <1333987461-822-1-git-send-email-sjhill@mips.com> <4F841E48.7000104@mvista.com>
In-Reply-To: <4F841E48.7000104@mvista.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: b36H6rxNrzKebnGTX7SyUQ==
X-archive-position: 32926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yegoshin@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/10/2012 04:49 AM, Sergei Shtylyov wrote:
> From: "Steven J. Hill"<sjhill@mips.com>
>
>>
>> +config 64BIT_PHYS_ADDR
>> +    bool "Kernel supports 64 bit physical addresses" if EXPERIMENTAL
>> +    depends on 64BIT
>
>    This option is selected on 32-bit CPUs like Alchemy, which has 
> 36-bit physical address. It will cause a warning about unmet

Just verified - selected Alchemy and DB1000 board and got

# CONFIG_64BIT is not set
CONFIG_64BIT_PHYS_ADDR=y
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_PHYS_ADDR_T_64BIT=y

???

I also want to say that NetLogic Microsystems web site indicates that 
some of Alchemy CPU has only 14 bit DDR/SDRAM address, for exam - Au1550 
(http://www.netlogicmicro.com/Products/Alchemy/Au1550.asp) but 
arch/mips/configs/db1550_defconfig (and pb1550) choses 64BIT_PHYS_ADDR 
too.  Seems like something wrong here.

- Leonid.
