Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2011 19:56:39 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19273 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491095Ab1AXS4g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jan 2011 19:56:36 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d3dcb910000>; Mon, 24 Jan 2011 10:57:21 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 24 Jan 2011 10:56:32 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 24 Jan 2011 10:56:32 -0800
Message-ID: <4D3DCB5A.6060107@caviumnetworks.com>
Date:   Mon, 24 Jan 2011 10:56:26 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     naveen yadav <yad.naveen@gmail.com>
CC:     linux-mips@linux-mips.org, kernelnewbies@nl.linux.org
Subject: Re: page size change on MIPS
References: <AANLkTik+vpiWR4Xk4Pu+uCHq3XO=BZMGVka8-B9vuQew@mail.gmail.com>
In-Reply-To: <AANLkTik+vpiWR4Xk4Pu+uCHq3XO=BZMGVka8-B9vuQew@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jan 2011 18:56:32.0178 (UTC) FILETIME=[6A699920:01CBBBF8]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 01/24/2011 07:02 AM, naveen yadav wrote:
> Hi All,
>
>
> we are using mips32r2  so I want to know which all pages size it can support?
> When I modify arch/mips/Kconfig.  it boot sucessfully on 16KB page
> size. but hang/not boot crash when change page size to 8KB,32KB and 64
> KB.

I don't think 8KB and 32KB work on most mips32r2 processors.  You would 
have to check the processor manual to be sure.


>
> We are using 2.6.30 kernel.
>
> At Page Size 8KB and 32KB  it hang in unpack_to_rootfs() function of
> init/initramfs.c
>
> 64KB it hangs when execute init  Kernel panic - not syncing: Attempted
> to kill init!

I regularly run 4K, 16K, and 64K page sizes with a Debian rootfs.  If 
you run with a broken uClibc toolchain that doesn't support larger 
pages, it will of course fail.  In this case the problem is with your 
toolchain, not the kernel.

David Daney


>
> config PAGE_SIZE_4KB
>          bool "4kB"
>          help
>           This option select the standard 4kB Linux page size.  On some
>           R3000-family processors this is the only available page size.  Using
>           4kB page size will minimize memory consumption and is therefore
>           recommended for low memory systems.
>
> config PAGE_SIZE_8KB
>          bool "8kB"
>         depends on (EXPERIMENTAL&&  CPU_R8000) || CPU_CAVIUM_OCTEON
>          help
>            Using 8kB page size will result in higher performance kernel at
>            the price of higher memory consumption.  This option is available
>            only on R8000 and cnMIPS processors.  Note that you will need a
>            suitable Linux distribution to support this.
>
> config PAGE_SIZE_16KB
>          bool "16kB"
>         depends on !CPU_R3000&&  !CPU_TX39XX
>          help
>            Using 16kB page size will result in higher performance kernel at
>            the price of higher memory consumption.  This option is available on
>            all non-R3000 family processors.  Note that you will need a suitable
>            Linux distribution to support this.
>
> config PAGE_SIZE_32KB
>          bool "32kB"
>          help
>            Using 32kB page size will result in higher performance kernel at
>            the price of higher memory consumption.  This option is available
>            only on cnMIPS cores.  Note that you will need a suitable Linux
>            distribution to support this.
>
> config PAGE_SIZE_64KB
>          bool "64kB"
>         depends on EXPERIMENTAL&&  !CPU_R3000&&  !CPU_TX39XX
>          help
>            Using 64kB page size will result in higher performance kernel at
>            the price of higher memory consumption.  This option is available on
>            all non-R3000 family processor.  Not that at the time of this
>            writing this option is still high experimental.
>
>
