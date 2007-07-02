Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jul 2007 14:12:01 +0100 (BST)
Received: from post2.wesleyan.edu ([129.133.6.128]:34729 "EHLO
	post2.wesleyan.edu") by ftp.linux-mips.org with ESMTP
	id S20022726AbXGBNL6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 2 Jul 2007 14:11:58 +0100
Received: from pony1.wesleyan.edu (pony1.wesleyan.edu [129.133.6.192])
	by courier2.wesleyan.edu (8.13.6/8.13.6) with ESMTP id l62D8cT9029208
	for <linux-mips@linux-mips.org>; Mon, 2 Jul 2007 09:08:42 -0400
Received: (from apache@localhost)
	by pony1.wesleyan.edu (8.12.11.20060308/8.12.11/Submit) id l62D8XGg006901;
	Mon, 2 Jul 2007 09:08:33 -0400
Received: from 70.107.91.207
        (SquirrelMail authenticated user sknauert)
        by webmail.wesleyan.edu with HTTP;
        Mon, 2 Jul 2007 09:08:33 -0400 (EDT)
Message-ID: <50447.70.107.91.207.1183381713.squirrel@webmail.wesleyan.edu>
In-Reply-To: <468825BE.6090001@gmx.net>
References: <4687DCE2.8070302@gentoo.org> <468825BE.6090001@gmx.net>
Date:	Mon, 2 Jul 2007 09:08:33 -0400 (EDT)
Subject: Re: O2 RM7000 Issues
From:	sknauert@wesleyan.edu
To:	"Linux MIPS List" <linux-mips@linux-mips.org>
User-Agent: SquirrelMail/1.4.9a
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Wesleyan-MailScanner-Information: Please contact the ISP for more information
X-Wesleyan-MailScanner:	Found to be clean
X-Originating-IP: 129.133.6.192
X-MailScanner-From: sknauert@wesleyan.edu
Return-Path: <sknauert@wesleyan.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sknauert@wesleyan.edu
Precedence: bulk
X-list: linux-mips

I have one of the 600 Mhz RM7000s, i.e. no tertiary cache since the module
was originally a 300 Mhz RM5200. However, mine hasn't given any problems
with Debian or Gentoo.

What kernel and target are you compiling for? I'm using 2.6.21.3 compiled
for R5K. All my userspace is compiled for R5K too. I'll compile a new
kernel for RM7000 and see if I have any issue then poke around to see what
kernel code gets changed. I'm not 100% sure, but I didn't think it was
that much so my gut reaction is this might be a gcc issue since the RM7000
isn't a common processor.

> Ah, finally someone else got a hold of these things :-)
> Still got mine unused at all.
> Not done much linux at al for the past few years, but always interested
> to see how things might work out for either R5K or RM7K O2's.
>
> Tom
>
>
> Kumba wrote:
>>
>> So I finally managed to get my hands on one of those super-rare RM7000
>> CPU's for the SGI O2, and, as expected, there are some problems.
>>
>> For the most part, the system will boot into userland, but it seems
>> userland isn't at all very happy.  It seems bash is the unhappiest
>> customer so far (or rather, the only userland program I've seen fail
>> repeatedly).  Running the Gentoo init scripts at startup, several
>> scripts will terminate will a variety of messages, from Trace/breakpoint
>> traps, to bus errors to illegal instructions. However, in the init
>> scripts, they happen at specific points; usually when booting our
>> network startup scripts (neth.eth0, net.lo), and usually on an exit()
>> function in the script.  Our emerge process, while python at heart,
>> seems to fail sporadically on the bash sections (parsing the ebuild
>> code) as well.
>>
>> I've got a feeling this is likely a problem in the kernel more than it
>> is a problem in the userland, but the question is how to go about
>> determining which and where.  The RM7K's are pretty rare, so I imagine
>> there's probably a few undiscovered quirks in the code (notably the SC
>> code in arch/mips/mm/sc-rm7k.c).  Not to mention, we can't even use the
>> 1MB tertiary cache these things have.
>>
>> For reference, system info:
>>
>>  > hinv
>>                    System: IP32
>>                 Processor: 350 Mhz RM7000, with FPU
>>      Primary I-cache size: 16 Kbytes
>>      Primary D-cache size: 16 Kbytes
>>      Secondary cache size: 256 Kbytes
>>        Ternary cache size: 1024 Kbytes
>>               Memory size: 512 Mbytes
>>                  Graphics: CRM, Rev C
>>                     Audio: A3 version 1
>>                 SCSI Disk: scsi(0)disk(2)
>>                 SCSI Disk: scsi(0)disk(3)
>>                SCSI CDROM: scsi(0)cdrom(4)
>>
>>
>> # cat /proc/cpuinfo
>> system type             : SGI O2
>> processor               : 0
>> cpu model               : RM7000 V3.3  FPU V2.0
>> BogoMIPS                : 350.20
>> byteorder               : big endian
>> wait instruction        : yes
>> microsecond timers      : yes
>> tlb_entries             : 48
>> extra interrupt vector  : no
>> hardware watchpoint     : no
>> ASEs implemented        :
>> VCED exceptions         : not available
>> VCEI exceptions         : not available
>>
>>
>>
>>
>>
>> And errors (from various points in the execution and multiple reboots):
>>
>>  * Starting eth0
>> /sbin/runscript.sh: line 428:  2475 Illegal instruction     ( function
>> exit ()
>>
>>  * Starting lo
>> /sbin/runscript.sh: line 428:  1464 Illegal instruction     ( function
>> exit ()
>>
>>
>>  * Starting eth0
>> /etc/init.d/net.eth0: line 248:  1650 Bus error               ( u=0;
>> module_load_minimum "${MODULES[i]}" || u=1; if [[ ${u} == 0 ]]; then
>>
>> /sbin/runscript.sh: line 428:  2779 Bus error               ( function
>> exit ()
>> {
>>
>>  * Stopping syslog-ng
>> ...                                                 [ ok ]
>> /lib/rcscripts/sh/rc-services.sh: line 444:  4093 Illegal
>> instruction     ( "/etc/init.d/${service}" stop )
>>
>> /lib/rcscripts/sh/rc-services.sh: line 384:  1095 Trace/breakpoint trap
>> "/etc/init.d/${service}" start
>>
>>
>>
>> So if anyone's got some old rm7k patches sitting around they want
>> tested, or spots where to look/debug options to turn on, let me know.
>> I'll try switching back to an RM5200 and rebuild bash with -g and make
>> sure gdb is installed, them change back to the RM7000 to try and capture
>> some asm call or something that's causing these exit() failures in bash
>> (which seem to be the primary symptom)
>>
>>
>> Cheers,
>>
>>
>> --Kumba
>>
>
>
>
