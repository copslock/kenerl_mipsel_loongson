Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Jul 2007 23:08:14 +0100 (BST)
Received: from mail.gmx.net ([213.165.64.20]:54430 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S20022546AbXGAWIM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 1 Jul 2007 23:08:12 +0100
Received: (qmail invoked by alias); 01 Jul 2007 22:08:06 -0000
Received: from 53545F91.cable.casema.nl (EHLO [192.168.1.250]) [83.84.95.145]
  by mail.gmx.net (mp040) with SMTP; 02 Jul 2007 00:08:06 +0200
X-Authenticated: #11016536
X-Provags-ID: V01U2FsdGVkX1+y4u4J3USy8umZkX0UDDcK5bqCzym0lKsBLt3cVx
	hauODqbDJ9/ojd
Message-ID: <468825BE.6090001@gmx.net>
Date:	Mon, 02 Jul 2007 00:07:58 +0200
From:	freshy98 <freshy98@gmx.net>
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
MIME-Version: 1.0
To:	Kumba <kumba@gentoo.org>
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: O2 RM7000 Issues
References: <4687DCE2.8070302@gentoo.org>
In-Reply-To: <4687DCE2.8070302@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Return-Path: <freshy98@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freshy98@gmx.net
Precedence: bulk
X-list: linux-mips

Ah, finally someone else got a hold of these things :-)
Still got mine unused at all.
Not done much linux at al for the past few years, but always interested 
to see how things might work out for either R5K or RM7K O2's.

Tom


Kumba wrote:
> 
> So I finally managed to get my hands on one of those super-rare RM7000 
> CPU's for the SGI O2, and, as expected, there are some problems.
> 
> For the most part, the system will boot into userland, but it seems 
> userland isn't at all very happy.  It seems bash is the unhappiest 
> customer so far (or rather, the only userland program I've seen fail 
> repeatedly).  Running the Gentoo init scripts at startup, several 
> scripts will terminate will a variety of messages, from Trace/breakpoint 
> traps, to bus errors to illegal instructions. However, in the init 
> scripts, they happen at specific points; usually when booting our 
> network startup scripts (neth.eth0, net.lo), and usually on an exit() 
> function in the script.  Our emerge process, while python at heart, 
> seems to fail sporadically on the bash sections (parsing the ebuild 
> code) as well.
> 
> I've got a feeling this is likely a problem in the kernel more than it 
> is a problem in the userland, but the question is how to go about 
> determining which and where.  The RM7K's are pretty rare, so I imagine 
> there's probably a few undiscovered quirks in the code (notably the SC 
> code in arch/mips/mm/sc-rm7k.c).  Not to mention, we can't even use the 
> 1MB tertiary cache these things have.
> 
> For reference, system info:
> 
>  > hinv
>                    System: IP32
>                 Processor: 350 Mhz RM7000, with FPU
>      Primary I-cache size: 16 Kbytes
>      Primary D-cache size: 16 Kbytes
>      Secondary cache size: 256 Kbytes
>        Ternary cache size: 1024 Kbytes
>               Memory size: 512 Mbytes
>                  Graphics: CRM, Rev C
>                     Audio: A3 version 1
>                 SCSI Disk: scsi(0)disk(2)
>                 SCSI Disk: scsi(0)disk(3)
>                SCSI CDROM: scsi(0)cdrom(4)
> 
> 
> # cat /proc/cpuinfo
> system type             : SGI O2
> processor               : 0
> cpu model               : RM7000 V3.3  FPU V2.0
> BogoMIPS                : 350.20
> byteorder               : big endian
> wait instruction        : yes
> microsecond timers      : yes
> tlb_entries             : 48
> extra interrupt vector  : no
> hardware watchpoint     : no
> ASEs implemented        :
> VCED exceptions         : not available
> VCEI exceptions         : not available
> 
> 
> 
> 
> 
> And errors (from various points in the execution and multiple reboots):
> 
>  * Starting eth0
> /sbin/runscript.sh: line 428:  2475 Illegal instruction     ( function 
> exit ()
> 
>  * Starting lo
> /sbin/runscript.sh: line 428:  1464 Illegal instruction     ( function 
> exit ()
> 
> 
>  * Starting eth0
> /etc/init.d/net.eth0: line 248:  1650 Bus error               ( u=0; 
> module_load_minimum "${MODULES[i]}" || u=1; if [[ ${u} == 0 ]]; then
> 
> /sbin/runscript.sh: line 428:  2779 Bus error               ( function 
> exit ()
> {
> 
>  * Stopping syslog-ng 
> ...                                                 [ ok ]
> /lib/rcscripts/sh/rc-services.sh: line 444:  4093 Illegal 
> instruction     ( "/etc/init.d/${service}" stop )
> 
> /lib/rcscripts/sh/rc-services.sh: line 384:  1095 Trace/breakpoint trap 
> "/etc/init.d/${service}" start
> 
> 
> 
> So if anyone's got some old rm7k patches sitting around they want 
> tested, or spots where to look/debug options to turn on, let me know.  
> I'll try switching back to an RM5200 and rebuild bash with -g and make 
> sure gdb is installed, them change back to the RM7000 to try and capture 
> some asm call or something that's causing these exit() failures in bash 
> (which seem to be the primary symptom)
> 
> 
> Cheers,
> 
> 
> --Kumba
> 
