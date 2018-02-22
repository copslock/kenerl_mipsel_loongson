Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Feb 2018 18:05:13 +0100 (CET)
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:58633 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994577AbeBVRFDBkJxL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Feb 2018 18:05:03 +0100
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 3D5033F4EC;
        Thu, 22 Feb 2018 18:04:54 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BZYG8-cMA5_b; Thu, 22 Feb 2018 18:04:38 +0100 (CET)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 359663F3F2;
        Thu, 22 Feb 2018 18:04:31 +0100 (CET)
Date:   Thu, 22 Feb 2018 18:04:28 +0100
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>,
        linux-mips@linux-mips.org
Subject: Re: [RFC v2] MIPS: R5900: Workaround exception NOP execution bug
 (FLX05)
Message-ID: <20180222170426.GA2310@localhost.localdomain>
References: <20180211075608.GC2222@localhost.localdomain>
 <alpine.DEB.2.00.1802111239380.3553@tp.orcam.me.uk>
 <20180215191502.GA2736@localhost.localdomain>
 <alpine.DEB.2.00.1802151934180.3553@tp.orcam.me.uk>
 <20180217111644.GA2496@localhost.localdomain>
 <alpine.DEB.2.00.1802171141260.3553@tp.orcam.me.uk>
 <20180217133815.GB2496@localhost.localdomain>
 <alpine.DEB.2.00.1802171418120.3553@tp.orcam.me.uk>
 <20180217200432.GE2496@localhost.localdomain>
 <alpine.DEB.2.00.1802201335420.3553@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1802201335420.3553@tp.orcam.me.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

Hi Maciej,

>  The likely cause is my development GDB builds use `--enable-targets=all' 
> and your GDB configuration probably does not include secondary targets.  
> Still I find it wrong that an incorrect BFD target is chosen, and then 
> that an override does not work either (and especially that accessing 
> memory in a core file seems completely broken in recent GDB versions).

Please let me know if anything more is needed to reproduce the problem.

>  Hmm, I have mixed feelings about it as RDHWR is not an R5900 instruction.  
> Likewise we don't disassemble it, and neither we do LL, SC, SYNC, etc. say 
> with `mips:3000' even though Linux will emulate them.  I feel this kind of 
> stuff does not belong to instruction aliases either (compare `objdump' 
> disassembly of any serious program with and without `-M no-aliases').
> 
>  I do recognize value for users here though, so perhaps an extra `-M' 
> option would be due here, such as `-M linux-emulation' or suchlike, to 
> cover all emulated instructions.  I'll think about it.  Please file an 
> enhancement request in sourceware.org Bugzilla if it's something you are 
> keen having (feel free to cc me; I'm <macro@linux-mips.org> there).

Sure, I think it would be a helpful feature:

https://sourceware.org/bugzilla/show_bug.cgi?id=22877

Fredrik
