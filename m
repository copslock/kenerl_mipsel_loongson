Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Nov 2015 17:25:33 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:52694 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012270AbbKLQZbqN2dP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Nov 2015 17:25:31 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id tACGPU6v022469;
        Thu, 12 Nov 2015 17:25:30 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id tACGPUOf022468;
        Thu, 12 Nov 2015 17:25:30 +0100
Date:   Thu, 12 Nov 2015 17:25:30 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Nikola Veljkovic <Nikola.Veljkovic@imgtec.com>
Cc:     Markos Chandras <Markos.Chandras@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Chris Dearman <Chris.Dearman@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        Miodrag Dinic <Miodrag.Dinic@imgtec.com>,
        Petar Jovanovic <Petar.Jovanovic@imgtec.com>,
        Lazar Trsic <Lazar.Trsic@imgtec.com>
Subject: Re: [PATCH] MIPS: personality syscall discrepancy on mips64-o32/n32
Message-ID: <20151112162529.GF29184@linux-mips.org>
References: <19CDB9880DBFC241860D925D8FAA94A00342EAB8@BADAG02.ba.imgtec.org>
 <20150818125605.GA25978@mchandras-linux.le.imgtec.org>
 <19CDB9880DBFC241860D925D8FAA94A00342F48A@BADAG02.ba.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19CDB9880DBFC241860D925D8FAA94A00342F48A@BADAG02.ba.imgtec.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thu, Aug 20, 2015 at 02:46:26PM +0000, Nikola Veljkovic wrote:

>  > I am not sure what the implication will be to userland with that change...
> I could not find any code that explicitly checks for PER_LINUX[32]. Of course,
> I might be missing something. Any suspects?

The one thing where it really matters is the architecture return value
for uname, try "uname -m".  On a 32 bit kernel this will return "mips",
on a 64 bit kernel "mips64".  This will break some software that expects
to identify MIPS by "mips".  There's a small tool to set this personality
flag, see ftp://ftp.linux-mips.org/pub/linux/mips/mips32/ for a year 2000
vintage source and binary rpm.  Or also the more modern setarch(1) utility.

>  > I presume you also need to fix the n32 case and then completely remove the 
>  > sys_32_personality syscall from linux32.c. 
> New patch below removes the syscall.
> 
>  > Moreover, I think you also need to fix the arch/mips/include/asm/elf.h
>  > code to set LINUX32 for O32 and n32 (for both 32b and 64b kernels.)
> Other archs (arm, intel) do not do that, so I think we should follow, and set 
> PER_LINUX, but let userspace change this if it wants to. On the kernel side this
> only affects uname. From the discussion [1] it seems like the right way to go.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/114506.html

x86 and ARM maybe but not SPARC64 which uses the exactly same code,
see arch/sparc/kernel/sys_sparc_64.c function sparc64_personality() and
from which this function and the mips32 utility which was named sparc32
in a former live, were taken.

The PER_LINUX32 -> PER_LINUX translation of the return value is for antique
programs that expect to see PER_LINUX as the return value.

> Tested changing only o32 on Android, there were no regressions:

For anything that changes an established ABI - in this case for about 15 or
16 years I'm going to be conservative at changing such an ABI.  Also Sparc64
and PowerPC are using the exactly same wrapper.

Anyway, can you tell me more about the Android issue?

  Ralf
