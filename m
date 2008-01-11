Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jan 2008 17:50:05 +0000 (GMT)
Received: from fig.raritan.com ([12.144.63.197]:10958 "EHLO fig.raritan.com")
	by ftp.linux-mips.org with ESMTP id S28579406AbYAKRt5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Jan 2008 17:49:57 +0000
Received: from [10.0.0.150] ([74.46.20.65]) by fig.raritan.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 11 Jan 2008 12:49:50 -0500
Message-ID: <4787AC3D.2020604@raritan.com>
Date:	Fri, 11 Jan 2008 12:49:49 -0500
From:	Gregor Waltz <gregor.waltz@raritan.com>
User-Agent: Thunderbird 1.5.0.10 (X11/20070403)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
References: <477E6296.7090605@raritan.com>	<20080104172136.GD22809@networkno.de>	<477E7DAE.2080005@raritan.com> <20080106.000725.75184768.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080106.000725.75184768.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jan 2008 17:49:50.0891 (UTC) FILETIME=[5D58E7B0:01C8547A]
Return-Path: <Gregor.Waltz@raritan.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregor.waltz@raritan.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Fri, 04 Jan 2008 13:40:46 -0500, Gregor Waltz <gregor.waltz@raritan.com> wrote:
>   
>> sendRRQ vmlinux.bin
>> load linux length 0x34408a
>> Checking CRC on downloaded RAM image
>>  /
>> CRC Check passed
>> Image Started At Address 0x80020000.
>> Image Length = 3424394 (0x34408a).
>> Exception! EPC=80056eb4 CAUSE=30000008(TLBL)
>> 80056eb4 8ce4000c lw      a0,12(a3)                         # 0xc
>>     
>
> Are you loading an ELF binary or a raw binary image?  If your loader
> does not handle ELF headers, you should do some trick to start running
> your kernel at correct address.
>
> If you were using 2.6.23, CONFIG_BOOT_RAW might help you.
>
> But it seems CONFIG_BOOT_RAW is broken on current git again.  It will
> be an another story... :-<
>   

I tried setting CONFIG_BOOT_RAW to y in .config, but that did not help.
Are there any other tricks for loading an ELF image?
Is there any way to verify that ELF is the issue?
I will do some research on ELF and loaders.


It took me many trials and some research to build the following tools 
for MIPS:
binutils-2.18
gcc-4.2.2
glibc-2.7

I include "ARCH=mips CROSS_COMPILE=mipsel-linux-gnu-" with each call of 
make when working on the kernel. I did mrproper after unarchiving and I 
used vmlinux followed by vmlinux.bin as build targets.

I built linux-2.6.23.9 with the above, but the results are still the 
same and the EPC is not in System.map.
My problem does not appear to be a matter of tool versions.

Exception! EPC=8005625c CAUSE=30000008(TLBL)
8005625c 8e020098 lw      v0,152(s0)                        # 0x98

I presume that 8e020098 is the full instruction, so I have tried 
searching for it in vmlinux.bin. The first occurrence is around 0x869b, 
which is more than 32k into the file. There is also nearly 1k worth of 
zero padding at the start of vmlinux.bin.



Does anybody have any other suggestions for getting down to the bottom 
of this problem?

Thank you
