Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jun 2011 18:53:51 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:2859 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491158Ab1FUQxq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jun 2011 18:53:46 +0200
X-TM-IMSS-Message-ID: <19290458000ac807@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 19290458000ac807 ; Tue, 21 Jun 2011 09:52:40 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 21 Jun 2011 09:54:50 -0700
Date:   Tue, 21 Jun 2011 22:26:30 +0530
From:   "Jayachandran C." <jayachandranc@netlogicmicro.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, binutils@sourceware.org
Subject: Re: XLR Linux/MIPS kernel build error
Message-ID: <20110621165628.GA5769@jayachandranc.netlogicmicro.com>
References: <20110621144340.GA11931@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110621144340.GA11931@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 21 Jun 2011 16:54:50.0484 (UTC) FILETIME=[EF668340:01CC3033]
X-archive-position: 30479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17344

On Tue, Jun 21, 2011 at 03:43:40PM +0100, Ralf Baechle wrote:
> I'm getting a build error with gcc 4.6.0 and binutils 2.21:
> 
> [...]
>   AS      arch/mips/kernel/entry.o
>   AS      arch/mips/kernel/genex.o
> /home/ralf/src/linux/upstream-linus/arch/mips/kernel/genex.S: Assembler messages:
> /home/ralf/src/linux/upstream-linus/arch/mips/kernel/genex.S:524: Internal error!
> Assertion failure in append_insn at ../../gas/config/tc-mips.c line 2867.
> Please report this bug.
> make[4]: *** [arch/mips/kernel/genex.o] Error 1
> make[3]: *** [arch/mips/kernel] Error 2
> make[2]: *** [arch/mips] Error 2
> make[1]: *** [sub-make] Error 2
> make: *** [all] Error 2
> make: Leaving directory `/home/ralf/src/linux/obj/nlm_xlr-build'
> 
> Not sure what's blowin up there and I haven't had a chance to try other
> binutils versions yet.  Is this something known?  None of the other MIPS
> kernel defconfigs is encountering this issue.

I have not used this GCC/binutils combination yet.  But I have had success with the
code sourcery toolchain (needs minor patch to add -march=xlr cflags):

gcc version 4.5.2 (Sourcery G++ Lite 2011.03-53) 
GNU ld (Sourcery G++ Lite 2011.03-53) 2.20.51.20100809

JC.
