Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Aug 2017 22:37:16 +0200 (CEST)
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:32369 "EHLO
        ste-ftg-msa2.bahnhof.se" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23995101AbdHDUhJlt0Rl convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Aug 2017 22:37:09 +0200
Received: from localhost (localhost [127.0.0.1])
        by ste-ftg-msa2.bahnhof.se (Postfix) with ESMTP id 2C94C3F59B;
        Fri,  4 Aug 2017 22:37:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-ftg-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9CBqlvijrLG8; Fri,  4 Aug 2017 22:37:02 +0200 (CEST)
Received: from [10.0.1.7] (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-ftg-msa2.bahnhof.se (Postfix) with ESMTPA id 932793F58D;
        Fri,  4 Aug 2017 22:36:58 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: Update PS2 R5900 to kernel 4.x?
From:   Fredrik Noring <noring@nocrew.org>
In-Reply-To: <77bec1a2-7e2b-3012-a909-b5ec1fe24178@gentoo.org>
Date:   Fri, 4 Aug 2017 22:36:57 +0200
Cc:     linux-mips@linux-mips.org
Content-Transfer-Encoding: 8BIT
Message-Id: <639ED764-8BFC-43CB-8042-230E2B808ED7@nocrew.org>
References: <A4F10467-06DE-4880-B740-10B32CAC9208@nocrew.org>
 <0d0fdd50-929f-da92-dd35-88f2878da8c2@gentoo.org>
 <64C2A7A5-46FD-406C-9B51-5F45AEBA70F0@nocrew.org>
 <b0356404-42b6-6e8b-e15b-57cf98b7d6e6@gentoo.org>
 <2CA3040B-8EB9-456C-A4DE-BFE0D097971C@nocrew.org>
 <77bec1a2-7e2b-3012-a909-b5ec1fe24178@gentoo.org>
To:     Joshua Kinard <kumba@gentoo.org>
X-Mailer: Apple Mail (2.3259)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59375
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


> 4 aug. 2017 kl. 16:13 skrev Joshua Kinard <kumba@gentoo.org>:
> 
> Digging back into the Linux/MIPS git repo, it looks like this commit is part of
> a branch that Viro was working on and there's one more commit by Viro that
> comes after it, 50150d2bb903 ("mips: switch to generic sys_fork() and
> sys_clone()").  So you might try to apply that change after 64b3122df48b, then
> apply the three changes by Ralf in the same branch as well.  The branch merges
> back into the main/master branch after that.

I’ve tried Al’s following commit and Ralf’s commits (except the whitespace
cleanup change which conflicts a lot), but unfortunately it still crashes in
the same way. The top commits of

    https://github.com/frno7/linux/tree/ps2-v3.9-rc1-memory-fault

are

    1: abb12d2 mips: switch to generic sys_fork() ... [cp of 50150d2b]
    2: a17178c mips: take the "zero newsp means inherit ... [cp of 64b3122d]
    3: 3de638d Experimental update for Playstation 2
    4: 974fdb3 mips: no magic arguments for sysm_pipe()
       ...
       12890d0 MIPS: sysmips: Rewrite to use SYSCALL_DEFINE3().
       f2ace93 MIPS: sysmips: Use unreachable().

where (4) is part of v3.9-rc1, (3) is the PS2 patch (which boots to Busybox),
and (2) and (1) are Al’s patches cherry-picked and adapted for (3) by removing
_sysn32_clone and replacing {sysn32_clone,sys_fork} with __sys_{clone,fork} in
arch/mips/kernel/scall32-n32.S (updates that seem obvious). So there are some
further adaptions that need to be done but I’m not sure what these could be.

Al’s changes touch MIPS register 29, perhaps the PS2 patch assumes something
about it that becomes invalid?

> It appears the busybox init didn't like the changes to _sys_fork in
> 64b3122df48b, and is thus crashing, which causes the kernel to panic due to PID
> 1 dying.  Usually, the first thing init does after loading is fork off a call
> to the shell/interpreter to start parsing the startup scripts, or process
> /etc/inittab to load up what's specified in the runlevels.  That means the
> "Memory fault" messages are not coming from the kernel, but from userland.

Is it possible to print detailed memory fault backtraces in a simple way?

Fredrik
