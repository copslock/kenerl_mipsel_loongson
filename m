Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 15:09:40 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:35963 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994686AbeBTOJdT4n9d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Feb 2018 15:09:33 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 20 Feb 2018 14:09:21 +0000
Received: from [10.20.78.55] (10.20.78.55) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Tue, 20 Feb 2018 06:09:20 -0800
Date:   Tue, 20 Feb 2018 14:09:09 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>,
        <linux-mips@linux-mips.org>
Subject: Re: [RFC v2] MIPS: R5900: Workaround exception NOP execution bug
 (FLX05)
In-Reply-To: <20180217200432.GE2496@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1802201335420.3553@tp.orcam.me.uk>
References: <20180129202715.GA4817@localhost.localdomain> <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk> <20180211075608.GC2222@localhost.localdomain> <alpine.DEB.2.00.1802111239380.3553@tp.orcam.me.uk> <20180215191502.GA2736@localhost.localdomain>
 <alpine.DEB.2.00.1802151934180.3553@tp.orcam.me.uk> <20180217111644.GA2496@localhost.localdomain> <alpine.DEB.2.00.1802171141260.3553@tp.orcam.me.uk> <20180217133815.GB2496@localhost.localdomain> <alpine.DEB.2.00.1802171418120.3553@tp.orcam.me.uk>
 <20180217200432.GE2496@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1519135760-452060-19049-311526-14
X-BESS-VER: 2018.2.1-r1802152107
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190221
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

Hi Fredrik,

> > Notice the different BFD target, `elf32-tradlittlemips-freebsd'.  You're 
> > supposed to be able to override it with `set gnutarget', but that doesn't 
> > seem to impress GDB, e.g.:
> > 
> > (gdb) show gnutarget
> > The current BFD target is "auto".
> > (gdb) set gnutarget elf32-tradlittlemips
> > (gdb) show gnutarget
> > The current BFD target is "elf32-tradlittlemips".
> > (gdb) info files
> > Local core dump file:
> >         `/home/mjr/src/kcore', file type elf32-tradlittlemips-freebsd.
> >         0xffffffffc0000000 - 0xfffffffffff94000 is load1
> >         0xffffffff80000000 - 0xffffffff90000000 is load2
> > (gdb)
> > 
> > I'll see if I can track down what is going on here.
> 
> Thank you for taking a closer look at GDB!

 You are welcome, however it's my duty as a MIPS/GDB port maintainer.

> However, I don't observe the
> "freebsd" BFD target with a cross-GDB version 8.1 (via v9fs in this case):

 The likely cause is my development GDB builds use `--enable-targets=all' 
and your GDB configuration probably does not include secondary targets.  
Still I find it wrong that an incorrect BFD target is chosen, and then 
that an override does not work either (and especially that accessing 
memory in a core file seems completely broken in recent GDB versions).

> By the way, what about presenting misaligned SQ instructions like
> 
> 	# mipsel-linux-gdb -q busybox
> 	Reading symbols from busybox...(no debugging symbols found)...done.
> 	(gdb) set architecture mips:5900
> 	The target architecture is assumed to be mips:5900
> 	(gdb) x /i 0x4036b0
> 	   0x4036b0:	sq	v1,-6085(zero)
> 
> as RDHWR, which is the interpretation with Linux?

 Hmm, I have mixed feelings about it as RDHWR is not an R5900 instruction.  
Likewise we don't disassemble it, and neither we do LL, SC, SYNC, etc. say 
with `mips:3000' even though Linux will emulate them.  I feel this kind of 
stuff does not belong to instruction aliases either (compare `objdump' 
disassembly of any serious program with and without `-M no-aliases').

 I do recognize value for users here though, so perhaps an extra `-M' 
option would be due here, such as `-M linux-emulation' or suchlike, to 
cover all emulated instructions.  I'll think about it.  Please file an 
enhancement request in sourceware.org Bugzilla if it's something you are 
keen having (feel free to cc me; I'm <macro@linux-mips.org> there).

  Maciej
