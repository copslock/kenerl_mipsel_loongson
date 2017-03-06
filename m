Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Mar 2017 20:01:30 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:43439 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993009AbdCFTBTfYS9H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Mar 2017 20:01:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2HiSOPbB7XR3q3Fr015WIwA4j3g2eR6HS4NFvRruugw=; b=1h0ZNJpDSX0TiQ5ULNPm4F0ZPY
        xuB3YlFC+57LdFgZ+vWr+y7KgirO0mkwUI1CpvP+3BVT3L8Nu8LEm48l1S+5hTVUHqUt+GCsAG4Tx
        4IUCHkRuRTquQyMj6aBfAGjCa1EWrFA12N92MKj0/9YAndW0FN3mmr9QvMYEuOausBVZJjo4rRsCM
        /pa45cEXY/vvNWi8BOZ/b1sUnxDhqKAnjRLPRZN376K8qOxzY7F8woEiE9pVGKoifzZaiJ5qaD1us
        l2e0flHO/7T+zbdpUV8geHYsdFc13NSF7bHPBDEuipZpGXpo/ABO446dGPTbh0Lw5odTMknK65u+5
        i28dgOEQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:55592 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.87)
        (envelope-from <linux@roeck-us.net>)
        id 1ckxsf-000fqJ-K9; Mon, 06 Mar 2017 19:01:14 +0000
Date:   Mon, 6 Mar 2017 11:01:11 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] MIPS: Fix build breakage caused by header file changes
Message-ID: <20170306190111.GA5546@roeck-us.net>
References: <1488779600-23004-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1488779600-23004-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Sun, Mar 05, 2017 at 09:53:20PM -0800, Guenter Roeck wrote:
> Since commit f3ac60671954 ("sched/headers: Move task-stack related
> APIs from <linux/sched.h> to <linux/sched/task_stack.h>") and commit
> f780d89a0e82 ("sched/headers: Remove <asm/ptrace.h> from
> <linux/sched.h>"), various mips builds fail as follows.
> 
> arch/mips/kernel/smp-mt.c: In function ‘vsmp_boot_secondary’:
> arch/mips/include/asm/processor.h:384:41: error:
> 	implicit declaration of function ‘task_stack_page’
> 
> In file included from
> 	/opt/buildbot/slave/hwmon-testing/build/arch/mips/kernel/pm.c:
> arch/mips/include/asm/fpu.h: In function '__own_fpu':
> arch/mips/include/asm/processor.h:385:31: error:
> 	invalid application of 'sizeof' to incomplete type 'struct pt_regs'
> 
> arch/mips/netlogic/common/smp.c: In function 'nlm_boot_secondary':
> arch/mips/netlogic/common/smp.c:157:2: error:
> 	implicit declaration of function 'task_stack_page'
> 
> arch/mips/cavium-octeon/cpu.c: In function 'cnmips_cu2_call':
> arch/mips/include/asm/processor.h:386:36: error:
> 	implicit declaration of function 'task_stack_page'
> 
> Fixes: f3ac60671954 ("sched/headers: Move task-stack related APIs ...")
> Fixes: f780d89a0e82 ("sched/headers: Remove <asm/ptrace.h> from ...")
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: More files needed a fix.

Sigh. More breakage found. v3 coming.

Guenter
