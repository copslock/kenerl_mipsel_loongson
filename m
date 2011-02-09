Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Feb 2011 13:01:49 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:36853 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491778Ab1BIMBq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Feb 2011 13:01:46 +0100
Received: from duck.linux-mips.net (localhost.localdomain [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p19C2BLp031727;
        Wed, 9 Feb 2011 13:02:12 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p19C292J031723;
        Wed, 9 Feb 2011 13:02:09 +0100
Date:   Wed, 9 Feb 2011 13:02:09 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     maksim.rayskiy@gmail.com
Cc:     linux-mips@linux-mips.org, Maksim Rayskiy <mrayskiy@broadcom.com>
Subject: Re: [PATCH] MIPS: clear idle task mm pointer when hotplugging cpu
Message-ID: <20110209120209.GA21796@linux-mips.org>
References: <1297210687-14589-1-git-send-email-maksim.rayskiy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1297210687-14589-1-git-send-email-maksim.rayskiy@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@duck.linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 08, 2011 at 04:18:07PM -0800, maksim.rayskiy@gmail.com wrote:

> If kernel starts with maxcpus= option which does not bring all
> available cpus online at boot time, idle tasks for offline cpus
> are not created. If later offline cpus are hotplugged through sysfs,
> __cpu_up is called in the context of the user task, and fork_idle
> copies its non-zero mm pointer.  This causes BUG() in per_cpu_trap_init.
> 
> To avoid this, release mm for idle task and reset the pointer after
> fork_idle().

Nice catch, applied.

x86 avoid this problem by forking the idle threads in a worker thread which
also avoids other potencial issues; we probably should take the same
path.

  Ralf
