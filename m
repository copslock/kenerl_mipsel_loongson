Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jan 2011 16:45:19 +0100 (CET)
Received: from blu0-omc4-s21.blu0.hotmail.com ([65.55.111.160]:63191 "EHLO
        blu0-omc4-s21.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491038Ab1AGPpQ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Jan 2011 16:45:16 +0100
Received: from BLU124-W4 ([65.55.111.137]) by blu0-omc4-s21.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 7 Jan 2011 07:45:06 -0800
Message-ID: <BLU124-W490D65550F59FC3E0B692A60B0@phx.gbl>
X-Originating-IP: [72.22.182.66]
From:   Erich Mierzejewski <mierz@hotmail.com>
To:     <linux-mips@linux-mips.org>
Subject: [kernel oops] Cavium Octeon, linux 2.6.27
Date:   Fri, 7 Jan 2011 10:45:06 -0500
Importance: Normal
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginalArrivalTime: 07 Jan 2011 15:45:06.0845 (UTC) FILETIME=[DB991CD0:01CBAE81]
Return-Path: <mierz@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mierz@hotmail.com
Precedence: bulk
X-list: linux-mips


I am facing an intermittent Oops on Cavium-Octeon CN56xx.  The oops is related to networking, and typically includes TIPC (virtually all inter-node comms is using TIPC).  It takes about 2-3 hours of running a directed TIPC client/server test to invoke the oops.  

The signature varies, but typically includes either sock_sendmsg or sock_poll.   Here's an example captured from syslog with sock_poll.   

Feb  5 11:18:42 mpc_1_1 kernel: CPU 2 Unable to handle kernel paging request at virtual address ffffffffc016f970, epc == ffffffff813e8ec4, ra == ffffffff81235658
Feb  5 11:18:44 mpc_1_1 kernel: Oops[#1]:
Feb  5 11:18:44 mpc_1_1 kernel: Cpu 3
Feb  5 11:18:44 mpc_1_1 kernel: $ 0   : 0000000000000000 0000000000000001 ffffffffc016f930 a8000000e9e2aa00
Feb  5 11:18:44 mpc_1_1 kernel: $ 4   : a8000000e92f8600 0000000000000000 0000000000000000 00000000000003e8
Feb  5 11:18:44 mpc_1_1 kernel: $ 8   : 0000000000416248 00000000004186e8 000000007fdba9e0 000000000040243c
Feb  5 11:18:44 mpc_1_1 kernel: $12   : 0000000000000000 ffffffffc0000008 ffffffff81235400 ffffffff89a0a600
Feb  5 11:18:44 mpc_1_1 kernel: $16   : a8000000bc9ec700 a8000000bc9ec718 0000000000000000 a8000000e92f8000
Feb  5 11:18:44 mpc_1_1 kernel: $20   : 0000000000000001 000000007fdba9b0 a8000000e92f8070 0000000000000000
Feb  5 11:18:44 mpc_1_1 kernel: $24   : 0000000000000400 0000000038fbd038                        
Feb  5 11:18:44 mpc_1_1 kernel: $28   : a8000000b9d64000 a8000000b9d67dc0 a8000000e92f9300 ffffffff81235658
Feb  5 11:18:44 mpc_1_1 kernel: Hi    : 0000000000007d7f
Feb  5 11:18:44 mpc_1_1 kernel: Lo    : df3b645a1cac9d39
Feb  5 11:18:44 mpc_1_1 kernel: epc   : ffffffff813e8ec4 sock_poll+0xc/0x18
Feb  5 11:18:44 mpc_1_1 kernel: Not tainted
Feb  5 11:18:44 mpc_1_1 kernel: ra    : ffffffff81235658 SyS_epoll_wait+0x258/0x560
Feb  5 11:18:44 mpc_1_1 kernel: Status: 1000cce3    KX SX UX KERNEL EXL IE
Feb  5 11:18:44 mpc_1_1 kernel: Cause : 00800008
Feb  5 11:18:44 mpc_1_1 kernel: BadVA : ffffffffc016f970
Feb  5 11:18:44 mpc_1_1 kernel: PrId  : 000d0409 (Cavium Octeon)
Feb  5 11:18:44 mpc_1_1 kernel: Modules linked in: usbcore bonding i2c_dev x_tables ip6_tables ip_tables ipv6 libcrc32c sctp spioc binfmt_misc jazz_mod iptable_filter tunnel4 sit ipmi_msghandler ipmi_serial ipmi_serial_terminal_mode ipmi_devintf ipmi_watchdog tipc dti si5326 mt29f
Feb  5 11:18:44 mpc_1_1 kernel: Process tipcServer_mpc (pid: 8226, threadinfo=a8000000b9d64000, task=a8000000bca5e900, tls=000000002ad009a0)
Feb  5 11:18:44 mpc_1_1 kernel: Stack : a8000000b9d67dc0 a8000000b9d67dc0 0000000000000001 0000000000000000
Feb  5 11:18:44 mpc_1_1 kernel: 0000000000000081 0000000000416234 0000000000000001 000000000041e060
Feb  5 11:18:44 mpc_1_1 kernel: a8000000e92f8010 a8000000e92f8030 a8000000e92f8050 a8000000e92f8060
Feb  5 11:18:44 mpc_1_1 kernel: 00000000000000fa a8000000e92f8040 0000000000404db8 0000000000401220
Feb  5 11:18:44 mpc_1_1 kernel: 00000000004b0000 00000000004e8450 00000000004e05f8 00000000004e8450
Feb  5 11:18:44 mpc_1_1 kernel: 0000000000000000 00000000004ed948 000000007fdba968 ffffffff8114732c
Feb  5 11:18:44 mpc_1_1 kernel: 0000000000000000 ffffffff81103be4 000000000000109a 000000002acf9530
Feb  5 11:18:44 mpc_1_1 kernel: 0000000000000003 000000007fdba9b0 0000000000000001 00000000000003e8
Feb  5 11:18:44 mpc_1_1 kernel: 0000000000000001 00000000203d2025 0000000025252525 ffffffff81010100
Feb  5 11:18:44 mpc_1_1 kernel: 0000000000000000 0000000000000010 ffffffff813eaf18 ffffffff89a0a600
Feb  5 11:18:44 mpc_1_1 kernel: ...
Feb  5 11:18:44 mpc_1_1 kernel: Call Trace:
Feb  5 11:18:44 mpc_1_1 kernel: [<ffffffff813e8ec4>] sock_poll+0xc/0x18
Feb  5 11:18:44 mpc_1_1 kernel: [<ffffffff81235658>] SyS_epoll_wait+0x258/0x560
Feb  5 11:18:44 mpc_1_1 kernel: [<ffffffff8114732c>] handle_sys+0x12c/0x148
Feb  5 11:18:44 mpc_1_1 kernel:
Feb  5 11:18:44 mpc_1_1 kernel:
Feb  5 11:18:44 mpc_1_1 kernel: Code: dc830098  00a0302d  dc620010 <dc590040> 03200008  0060282d  dc830098  00a0302d  dc620010
Feb  5 11:18:44 mpc_1_1 kernel: TIPC: Resetting link <1.1.11:bond0-1.1.101:bond0>, requested by peer
Feb  5 11:18:44 mpc_1_1 kernel: TIPC: Lost link <1.1.11:bond0-1.1.101:bond0> on network plane A
Feb  5 11:18:44 mpc_1_1 kernel: TIPC: Lost contact with <1.1.101>
Feb  5 11:18:44 mpc_1_1 kernel: TIPC: Established link <1.1.11:bond0-1.1.101:bond0> on network plane A


Looking at the disassembly of sock_poll, it can be seen that the error occurs when dereferencing ops->poll to store the function pointer in register t9.  

0000000000000048 <sock_poll>:
        struct socket *sock;

        /*
         *      We can't return errors to poll, so it's either yes or no.
         */
        sock = file->private_data;
      48:       dc830098        ld      v1,152(a0)
        return sock->ops->poll(file, sock, wait);
      4c:       00a0302d        move    a2,a1
      50:       dc620010        ld      v0,16(v1)
      54:       dc590040        ld      t9,64(v0)
      58:       03200008        jr      t9
      5c:       0060282d        move    a1,v1

The register file corroborates BadVA to (64)v0, with v0 holding a value of ffffffffc016f930.  

I originally thought this address _was_ bad because all of the kernel code addresses are in the range ffffffff81xxxxxx.  Then it occurred that modules might be loaded at a different address, so checking a live system:

/tmp> grep ffffffffc016f930 /proc/kallsyms
ffffffffc016f930 r msg_ops      [tipc]
/tmp>

Based on this, it seems that sock->ops is valid and correct, and my original assumption about corrupt address was wrong.  I'm left to conclude that the virtual address is correct, but page mapping operation is failing for some other reason.  

Strangely, the mapping fails only intermittently/temporarily.  I conclude this because only one of many processes using TIPC will oops out, while others continue unaffected.  This can be seen in the syslog above in the last 4 lines, as a TIPC link moves from Resetting->Lost->Established. 

Some other (less important?) details:
TIPC is the only protocol loaded as a module. 
Kernel is 64 bit, but userspace is O32 due to some old 3rd party libraries.  
Typically, the processes running TIPC have their core mask set to 0x000F, to limit them to cores 0-3.  I'm repeating the tests with all processes running only on core 0 to see if SMP might be a factor.  


What might be going on here?  Could a page mapping fail even if the VA has a physical mapping in the page table?  Could TIPC module be at fault (how)?  What else can I look at to track down what might be happening?  

Best regards, 

-Erich

 		 	   		  
From wuzhangjin@gmail.com Fri Jan  7 18:10:06 2011
Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jan 2011 18:10:10 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:50545 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490991Ab1AGRKG convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Jan 2011 18:10:06 +0100
Received: by wyf22 with SMTP id 22so17501876wyf.36
        for <multiple recipients>; Fri, 07 Jan 2011 09:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9xnbrlf9LM+qdRt7HEFbJvP/KZQadpWooDrf9PDG7II=;
        b=sjoUXsKEG6aMaGT4qG6uQqhxwuDe6QfOdl7kAD4kv2kzYiNWmOkENesuD8eSXNyQPB
         C55M+oAV+UcPtPDW0wtVNSiDhRywCJ501qn8Ij64eC56cKZ1WgPZYBCoTYwVv/t8JRS8
         RHazWxP/sTPboViOSQblrAgVeMwQId831OneI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mZTeHX2alWFg6nzZ26Qe1udHojzYL084qDw/27VpYrB6ypSJJ1mp+6MAD6FvUkbopX
         iOwGhyKYol6F9HQZLHJNPub5RwL0RGTJRUTJDUizJhSDi9X+sPkVUNtvAyMyJN0T3yUk
         M0hoBKQVTNvKdzOJAnehpWypmds87qGc91P5c=
MIME-Version: 1.0
Received: by 10.216.180.76 with SMTP id i54mr1989532wem.33.1294419816630; Fri,
 07 Jan 2011 09:03:36 -0800 (PST)
Received: by 10.216.93.137 with HTTP; Fri, 7 Jan 2011 09:03:36 -0800 (PST)
In-Reply-To: <4D2665CF.2080703@am.sony.com>
References: <4D2665CF.2080703@am.sony.com>
Date:   Sat, 8 Jan 2011 01:03:36 +0800
Message-ID: <AANLkTimTYox05y2_O8Tt+Ox1XCBVUmL-jFjtWZrPjTj7@mail.gmail.com>
Subject: Re: [Celinux-dev] Proposal: fastboot parameter cache for Linux
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Tim Bird <tim.bird@am.sony.com>
Cc:     CE Linux Developers List <celinux-dev@tree.celinuxforum.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Tim

This is really a wonderful idea, I have thought something similar
today, except caching the parameters in some place, we may be possible
to ask gcc to re-compile the kernel with these parameters(or we can
call them 'run time statistic data') and eliminate some of the
unnecessary branches and calling paths.

To record the persistent parameters at run-time, we may be possible to
mark those parameters as __runtime_fixed and put them into one section
__runtime_fixed_param, once running the kernel, those parameters can
be dumped out with a standard interface(/proc or /sys?), some of them
can be stored in some place and the others can be used to re-compile
the kernel.

For the persistent parameters, the variables marked as __read_mostly
can the candidates, but may be not most of them. so, this may need the
kernel developers carefully mark the variables as __runtime_fixed to
get better optimization.

For the re-compiling stuff, the MIPS specific cpu-feature-overrides.h
strategy is really a good example, lots of macros have been defined in
a common cpu-features.h, e.g.:

#ifndef current_cpu_type
#define current_cpu_type()      current_cpu_data.cputype
#endif

If no static definition of current_cpu_type defined in the board's
cpu-feature-overrides.h, the probed value will be used and the probing
is necessary, otherwise, the related branches and calling paths will
be optimized by the compiler. As a result, both of the boot time and
kernel image size will be saved.

Currently, in mainline linux-MIPS, this cpu-feature-overrides.h is
added by users manually, but why not provide an interface to dump them
out? yup, we can, I added a new kernel config and allow users to dump
the macros for cpu-feature-overrides.h automatically via the
traditional /proc/cpuinfo interface:
http://dev.lemote.com/cgit/linux-loongson-community.git/commit/?h=tiny36&id=56ab52376298dee38aeb27d065c1a20ef94739c3

But perhaps we can take one step ahead, that is we can mark more
run-time-persistent variables as __runtime_fixed(is this name okay?)
and dump them out, cache them for kernel to avoid probing or
re-compile the kernel with them for further optimization.

BTW, I will send a proposal about "Linux-Tiny for MIPS", I have
already done some work on it, that is:

http://dev.lemote.com/cgit/linux-loongson-community.git/log/?h=tiny36

I have forward ported most of the Linux-tiny patches from 2.6.23 to
2.6.36, has made --gc-sections -ffunction-sections -fdata-sections
work on MIPS, and also, some MIPS specific size & boot time reducing
methods has been applied: allow the software or hardware fpu support
be configurable, add more macros in cpu-features.h and allow the users
to dump out the macros and get a cpu-feature-overrides.h
automatically.  The next step is trying to make -fwhole-program -flto
work instead of the old -fwhole-program -combine(gcc doesn't work well
with __attribute__((externally_visible))).

Best Regards,
Wu Zhangjin

On Fri, Jan 7, 2011 at 9:01 AM, Tim Bird <tim.bird@am.sony.com> wrote:
> Fastboot parameter cache for Linux
>
> ; Summary: Fastboot parameter cache for Linux
>
> ; Proposer: Tim Bird
>
> == Description ==
> This proposal would be the creation and mainlining of a fastboot
> parameter cache for the Linux kernel.
>
> The purpose of this cache would be to store values which are
> detected in one boot of the Linux kernel, so they can be
> quickly accessed and used on subsequent boots of the kernel,
> to reduce kernel initialization time (specifically, to avoid
> unneeded probing for non-changing hardware.)
>
> The idea would be to provide an internal facility (API)
> inside the kernel that drivers could use to query for
> hardware parameters, prior to probing.  If a value is found,
> then the probe can be avoided.  If not, then probing is
> done as usual.  It would be important to have a very unintrusive and
> easy-to-use API for this.
>
> The mechanism would need to support a method of persistently storing
> the values for future kernel invocations (for example, by storing
> them in persistent memory, in a device tree, passing them on the
> kernel command line, or attaching them to the kernel boot image)
>
> This can be seen as a generalization of the way probing/autodetection
> is avoided by using a command line parameter for loops_per_jiffy.
>
> Andrew Murray proposed this under the name "boot cache", in August, 2010
> to the kernel mailing list.
>
> == Related work ==
> * See Andrew Murray's talk at ELC Europe 2010 - The Right Approach to Minimal Boot Times
> ** http://elinux.org/images/f/f7/RightApproachMinimalBootTimes.pdf
> * See [[Preset LPJ]] for a description of how preset loops_per_jiffy works
> * Andrew Murray's RFC and discussion on LKML:
> ** See https://lkml.org/lkml/2010/8/31/347
>
> == Scope ==
> The mechanism could probably be developed in 4 to 8 weeks.  Mainlining it
> might take 4 to 6 additional weeks.
>
> == Contractor Candidates ==
>
> == Comments ==
>
> [[Category:Project proposals 2011]]
>
> _______________________________________________
> Celinux-dev mailing list
> Celinux-dev@tree.celinuxforum.org
> http://tree.celinuxforum.org/mailman/listinfo/celinux-dev
>
