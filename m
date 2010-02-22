Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2010 22:24:58 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1741 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492324Ab0BVVYz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Feb 2010 22:24:55 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b82f6300000>; Mon, 22 Feb 2010 13:25:04 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 22 Feb 2010 13:24:32 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 22 Feb 2010 13:24:32 -0800
Message-ID: <4B82F610.8070105@caviumnetworks.com>
Date:   Mon, 22 Feb 2010 13:24:32 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Thunderbird/3.0.1
MIME-Version: 1.0
To:     Andreas Barth <aba@not.so.argh.org>
CC:     linux-mips@linux-mips.org
Subject: Re: Problems and workarounds while building octeon kernels
References: <20100220175125.GQ27216@mails.so.argh.org>
In-Reply-To: <20100220175125.GQ27216@mails.so.argh.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Feb 2010 21:24:32.0340 (UTC) FILETIME=[6C9AC940:01CAB405]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 02/20/2010 09:51 AM, Andreas Barth wrote:
> Hi,
>
> I tried to build an recent linux 2.6.33-rc something in an unstable
> Debian chroot. I had the following issues (plus workarounds / fixes) -
> please don't hesitate to ask me if you have further questions.
>

I have a questions:

* Were you able to produce a *bootable* kernel after your workarounds?

* What did your make invocation look like?

The reason I ask it that you are using a compiler that defaults to 
little-endian and 32-bit.  Unless you did something to override these 
defaults, I would be surprised if you obtained something bootable.

David Daney


>
> error:
> arch/mips/cavium-octeon/built-in.o: In function `prom_init':
> (.init.text+0x974): undefined reference to `early_serial_setup'
> arch/mips/cavium-octeon/built-in.o: In function `prom_init':
> (.init.text+0x974): relocation truncated to fit: R_MIPS_26 against `early_serial_setup'
> arch/mips/cavium-octeon/built-in.o: In function `flash_init':
>
> fix: enabled configuration for serial console support
>
>
> error:
> flash_setup.c:(.init.text+0x12dc): undefined reference to `simple_map_init'
> flash_setup.c:(.init.text+0x12dc): relocation truncated to fit: R_MIPS_26 against `simple_map_init'
> flash_setup.c:(.init.text+0x12ec): undefined reference to `do_map_probe'
> flash_setup.c:(.init.text+0x12ec): relocation truncated to fit: R_MIPS_26 against `do_map_probe'
> flash_setup.c:(.init.text+0x1314): undefined reference to `parse_mtd_partitions'
> flash_setup.c:(.init.text+0x1314): relocation truncated to fit: R_MIPS_26 against `parse_mtd_partitions'
> flash_setup.c:(.init.text+0x1330): undefined reference to `add_mtd_partitions'
> flash_setup.c:(.init.text+0x1330): relocation truncated to fit: R_MIPS_26 against `add_mtd_partitions'
> flash_setup.c:(.init.text+0x1340): undefined reference to `add_mtd_device'
> flash_setup.c:(.init.text+0x1340): relocation truncated to fit: R_MIPS_26 against `add_mtd_device'
>
> fix: set drivers/mtd to y (instead of m)
>
>
>
> error:
> arch/mips/cavium-octeon/built-in.o: In function `sched_clock':
> (.text.sched_clock+0x24): undefined reference to `__lshrti3'
> arch/mips/cavium-octeon/built-in.o: In function `sched_clock':
> (.text.sched_clock+0x24): relocation truncated to fit: R_MIPS_26 against `__lshrti3'
>
> workaround: in arch/mips/cavium-octeon/csrc-octeon.c
> #if (__GNUC__<  4) || ((__GNUC__ == 4)&&  (__GNUC_MINOR__<= 3))
> replaced by something that always uses "the ugly way"
>
>
> ERROR: "i8253_lock" [drivers/input/misc/pcspkr.ko] undefined!
> fix: disable pc speaker support
>
>
> Cheers,
> Andi
>
>
