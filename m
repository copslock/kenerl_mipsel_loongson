Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jul 2003 21:18:19 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:46094 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225208AbTG1USQ>;
	Mon, 28 Jul 2003 21:18:16 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.11.6/8.11.6) with ESMTP id h6SKI8Z02215;
	Mon, 28 Jul 2003 16:18:08 -0400
Received: from mx.hsv.redhat.com (IDENT:root@spot.hsv.redhat.com [172.16.16.7])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id h6SKI7I14165;
	Mon, 28 Jul 2003 16:18:07 -0400
Received: from redhat.com (slurm.hsv.redhat.com [172.16.16.102])
	by mx.hsv.redhat.com (8.11.6/8.11.0) with ESMTP id h6SKI7m20687;
	Mon, 28 Jul 2003 15:18:07 -0500
Message-ID: <3F25857E.1080209@redhat.com>
Date: Mon, 28 Jul 2003 15:20:14 -0500
From: Louis Hamilton <hamilton@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: William Jhun <wjhun@Oswego.EDU>
CC: linux-mips@linux-mips.org
Subject: Re: [patch] Mips64 Ocelot-C and Jaguar ATX platform support
References: <Pine.SOL.4.30.0307281503540.7737-100000@rocky.oswego.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <hamilton@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hamilton@redhat.com
Precedence: bulk
X-list: linux-mips

Will,

William Jhun wrote:

>Louis,
>
>Using Ralf's pre-packaged mips64 gcc 2.95.4 / binutils 2.13.2.1 .rpm, I
>wasn't able to get this to build without having CPU-specific gcc opts
>(patch below, please verify what flags are appropriate). Also, shouldn't
>
Arggh.. my (different) build environment meant messing with options in my
arch/mips64/Makefile  (like using "-march=rm9000" instead of 
"-mcpu=r8000 -mips4").
The CFLAGS change below looks fine.
Btw, an ifdef for CONFIG_CPU_RM7000 will be required too, using the
same CFLAGS options as the rm9000.

>
>define_bool CONFIG_BOOT_ELF32 y
>
>be in the config-shared.in in the jaguar section? 
>
yes

>
>
>At this point (with latest linux_2_4 tree), I can boot the kernel but get
>a hang after mounting NFS root via the gt64340 eth0. If I can find a
>serial cable for the second port, I might try to step with kgdb...
>
>Thanks,
>Will
>
thanks

>
>Index: arch/mips64/Makefile
>===================================================================
>RCS file: /home/cvs/linux/arch/mips64/Makefile,v
>retrieving revision 1.22.2.34
>diff -U3 -r1.22.2.34 Makefile
>--- arch/mips64/Makefile        5 Jul 2003 13:17:04 -0000       1.22.2.34
>+++ arch/mips64/Makefile        28 Jul 2003 18:37:47 -0000
>@@ -79,6 +79,9 @@
> #CFLAGS                += -mips64      # Should be used then we get a
>MIPS64 compiler
> CFLAGS         += -mcpu=r8000 -mips4
> endif
>+ifdef CONFIG_CPU_RM9000
>+GCCFLAGS       += -mcpu=r8000 -mips4
>+endif
>
> #
> # We unconditionally build the math emulator
>
>On Wed, 23 Jul 2003, Louis Hamilton wrote:
>
>>Ralf,
>>
>>Here is 64-bit support for both the RM7000-based Ocelot-C and
>>RM9000-based Jaguar ATX platforms.
>>Since the port was 2.4.21 based, this patch submission is for the 2.4 tree.
>>This patch supersedes the Ocelot-C patch I sent earlier, since it
>>encompasses both platforms.
>>
>>Notes the board support lives under arch/mips/momentum.
>>Also, CONFIG_BOARD_SCACHE and CONFIG_RM7000_CPU_SCACHE are utilized and
>>integrated into each platform's default configuration files.
>>As in the first patch, drivers/net/mv64340_eth.{c,h} is added to provide
>>ethernet support.
>>
>>If it looks ok, please check changes into the tree.
>>
>>Regards,
>>Louis
>>
>>Louis Hamilton
>>Red Hat, Inc.
>>
>>
