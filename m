Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2006 18:05:36 +0000 (GMT)
Received: from mms1.broadcom.com ([216.31.210.17]:42502 "EHLO
	mms1.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133570AbWBXSF0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Feb 2006 18:05:26 +0000
Received: from 10.10.64.154 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Fri, 24 Feb 2006 10:13:47 -0800
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 B15382B1; Fri, 24 Feb 2006 10:12:32 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id E95392B1; Fri, 24 Feb
 2006 10:12:31 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.3a-GA) with ESMTP
 id CZK71913; Fri, 24 Feb 2006 10:12:26 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 3D73F20501; Fri, 24 Feb 2006 10:12:26 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [RFC] SMP initialization order fixes.
Date:	Fri, 24 Feb 2006 10:12:24 -0800
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D077D6169@NT-SJCA-0750.brcm.ad.broadcom.com>
Thread-Topic: [RFC] SMP initialization order fixes.
Thread-Index: AcY447h90Do7L1A0Se2qd3PT3ANn+wAiczRg
From:	"Mark E Mason" <mark.e.mason@broadcom.com>
To:	"Martin Michlmayr" <tbm@cyrius.com>, linux-mips@linux-mips.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006022406; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230382E34334646344336312E303034362D412D;
 ENG=IBF; TS=20060224181348; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006022406_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6FE1935136K2122892-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.e.mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello,

Odd.  The GIT tip is working for me on the 1480, *but* I'm compiling
with gcc 3.4.3, not gcc 4.*:

Transferring control to the kernel.
Kernel entry point is at 0x80424000
Broadcom SiByte BCM1480 A2 (pass1) @ 700 MHz (SB-1A rev 0)
Board type: SiByte BCM91x80A/B (BigSur)
[CPU1]
[cpu1]
[CPU2]
[cpu2]
[CPU3]
[cpu3]
[4294667.296000] Linux version 2.6.16-rc4-g762ac03f-dirty
(mason@hawaii.localdomain) (gcc version 3.4.3) #3 SMP Thu Feb 23
15:07:00 PST 2006
[4294667.296000] CPU revision is: 01041100
[4294667.296000] FPU revision is: 000f0103
[4294667.296000] swarm setup: M41T81 RTC detected.
[4294667.296000] This kernel optimized for board runs with CFE
[4294667.296000] Determined physical RAM map: 

/Mark 

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Martin 
> Michlmayr
> Sent: Thursday, February 23, 2006 5:42 PM
> To: linux-mips@linux-mips.org
> Subject: Re: [RFC] SMP initialization order fixes.
> 
> * Stuart Anderson <anderson@netsweng.com> [2006-02-22 16:41]:
> > >RM9000 & BCM1250 users for testing.  This really needs to be fixed 
> > >for 2.6.16.
> > I'm not sure if this is the specific fix or not, but I can 
> report that 
> > git as of today (approx 2pm est) is working better than is 
> has since 
> > 2.6.14 for me on a bcm1480.
> 
> Strange, I get the following oops during boot with latest git:
> 
> 
> CFE> ifconfig eth0 -auto; boot -elf 192.168.1.1:/srv/tftp/mips/bigsur
> Device eth0:  hwaddr 00-02-4C-F5-2C-3C, ipaddr 192.168.1.146, 
> mask 255.255.255.0
>         gateway 192.168.1.1, nameserver 131.111.8.42, domain 
> cyrius.com Loader:elf Filesys:tftp Dev:eth0 
> File:192.168.1.1:/srv/tftp/mips/bigsur Options:(null)
> Loading: 0xffffffff80100000/3248680
> eth0: Link speed: 100BaseT FDX[J
> 0xffffffff80419228/286248 Entry at 0x803e9000 Closing network.
> Starting program at 0x803e9000
> [RUN!]
> Broadcom SiByte BCM1480 A3 (pass1) @ 700 MHz (SB-1A rev 0) 
> Board type: SiByte BCM91x80A/B (BigSur) [CPU1] [cpu1] [CPU2] 
> [cpu2] [CPU3] [cpu3] Linux version 2.6.16-rc4-Helix64-smp 
> (tbm@deprecation) (gcc version 4.0.3 20051201 (prerelease) 
> (Debian 4.0.2-5)) #2 SMP Fri Feb 24 01:36:35 GMT 2006 CPU 
> revision is: 01041100 FPU revision is: 000f0103 swarm setup: 
> M41T81 RTC detected.
> This kernel optimized for board runs with CFE Determined 
> physical RAM map:
>  memory: 000000000fe7ae00 @ 0000000000000000 (usable)
>  memory: 000000001ffffe00 @ 0000000080000000 (usable)
>  memory: 000000000ffffe00 @ 00000000c0000000 (usable)
>  memory: 000000003ffffe00 @ 0000000140000000 (usable) 
> Detected 3 available secondary CPU(s) Built 1 zonelists 
> Kernel command line: root=/dev/hda2 Primary instruction cache 
> 32kB, 4-way, linesize 32 bytes.
> Primary data cache 32kB, 4-way, linesize 32 bytes.
> Synthesized TLB refill handler (35 instructions).
> Synthesized TLB load handler fastpath (49 instructions).
> Synthesized TLB store handler fastpath (49 instructions).
> Synthesized TLB modify handler fastpath (48 instructions).
> PID hash table entries: 4096 (order: 12, 131072 bytes) Dentry 
> cache hash table entries: 1048576 (order: 11, 8388608 bytes) 
> Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
> Memory: 1991780k/2095580k available (2437k kernel code, 
> 103096k reserved, 539k data, 196k init, 0k highmem) 
> Mount-cache hash table entries: 256 Checking for 'wait' 
> instruction...  unavailable.
> Checking for the multiply/shift bug... no.
> Checking for the daddi bug... no.
> Checking for the daddiu bug... no.
> CPU revision is: 03041100
> FPU revision is: 000f0103
> CPU 0 Unable to handle kernel paging request at virtual 
> address 0000008b3cb03e00, epc == ffffffff8010b37c, ra == 
> ffffffff8010b2fc Primary instruction cache 32kB, 4-way, 
> linesize 32 bytes.
> Primary data cache 32kB, 4-way, linesize 32 bytes.
> Synthesized TLB refill handler (35 instructions).
> Oops[#1]:
> Cpu 0
> $ 0   : 0000000000000000 0000000000000001 0000000003333333 
> 0000008b3cb03e00
> $ 4   : ffffffff8041be00 0000000000000001 0000000000000000 
> ffffffff8041c588
> $ 8   : 0000000014001fe1 ffffffff8fefcae0 ffffffff803e9108 
> 0000000000000000
> $12   : ffffffffffffffff ffffffff8026f7e8 ffffffff80420000 
> ffffffff80420000
> $16   : 0000000000000001 0000000000000001 0000000000000001 
> ffffffff8041c5c0
> $20   : ffffffff80430000 0000000000000000 0000000000000000 
> 0000000000000000
> $24   : ffffffff80430000 ffffffff8fe7dfd4                     
>              
> $28   : ffffffff9fff8000 a80000009fffbf30 0000000000000000 
> ffffffff8010b2fc
> Hi    : 0000000000000000
> Lo    : 0000000000000024
> epc   : ffffffff8010b37c __cpu_up+0xb4/0x168     Not tainted
> ra    : ffffffff8010b2fc __cpu_up+0x34/0x168
> Status: 14001fe3    KX SX UX KERNEL EXL IE 
> Cause : 00808008
> BadVA : 0000008b3cb03e00
> PrId  : 01041100
> Process swapper (pid: 1, threadinfo=a80000009fff8000, 
> task=a80000000fe79848) Stack : 0000000000000001 
> 0000000000000001 ffffffff8015eccc ffffffff8015ecb8
>         0000000000000001 ffffffff80420000 ffffffff80420000 
> ffffffff803a0000
>         0000000000000000 ffffffff80100e78 0000000000000000 
> 0000000000000000
>         0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
>         0000000000000000 0000000000000000 0000000000000000 
> ffffffff80104c80
>         0000000000000000 ffffffff80104c70 0000000000000000 
> 0000000000000000
>         0000000000000000 0000000000000000 Call Trace:
>  [<ffffffff8015eccc>] cpu_up+0xfc/0x190
>  [<ffffffff8015ecb8>] cpu_up+0xe8/0x190
>  [<ffffffff80100e78>] init+0x9c8/0x9f0
>  [<ffffffff80104c80>] kernel_thread_helper+0x10/0x18  
> [<ffffffff80104c70>] kernel_thread_helper+0x0/0x18
> 
> 
> Code: 0062182d  3c020333  34423333 <dc640000> 000214b8  
> 3442cccd  00021478  6446995c  00c4001d 
> Kernel panic - not syncing: Attempted to kill init!
>  <0>Rebooting in 5 seconds..261.63 BogoMIPS (lpj=130816)
> Passing control back to CFE...
> 
> -- 
> Martin Michlmayr
> http://www.cyrius.com/
> 
> 
> 
