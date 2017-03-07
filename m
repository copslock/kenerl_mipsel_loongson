Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Mar 2017 08:45:06 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:34462
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990720AbdCGHo71HzdW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Mar 2017 08:44:59 +0100
Received: by mail-wm0-x243.google.com with SMTP id u132so9271983wmg.1;
        Mon, 06 Mar 2017 23:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kkVJbLOfzXP4t7sDfxLa7kVB51eV5UGIDWkSVwge4vc=;
        b=SPKF1tPoKEoNVf+VClD9KYUkZ26kFzR80pi9IMzMs5w6tAZzMia/UucO8FVvhaHojK
         nQwI4iWW+QRZ744/gch+UCfzH8tYRTk69TxxX4Rng5egE5Y8LUMi8UBVt5A4VisMw+SW
         vRZkwG/1YK9oweLKSRb/9rByC4GlrdL6brtDuh451BZQhctASWySc+yO2xplZuKaJPiK
         wEZw8aBDznpuJt790ARbYltEwru/+LAfiy7YTq6MVnfUrGo5OssWo786bQR5A/bBGEj0
         grdB7xMJ3QOi4r62KlgQpPmB7DVfOUua/ipVnjPzh/3feaNum6g5Y5AZQYMExblUpX4j
         0WVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kkVJbLOfzXP4t7sDfxLa7kVB51eV5UGIDWkSVwge4vc=;
        b=Oxo71bdD3Aqb4E0pVW1OhAqbfq/qtZGtcajbK4MuWpbznRvi+26DFbrNA1F4szRt4G
         3PTwJcvXguVTJKi/brfXYXUVgyTLpfAtDhA55T9q4nX0nstWSCNNQHlvwA06SmOOS6l/
         1a3DeIJHU6YakBp7SXb//AnG/NxKz7kmIODZY9AGRI+pQLJoEY+3l5mvyIu0VIfZuX2H
         nWRNe4UqJM/IMnn8yAJ3Px/xWSl73i4ik8G516lzjhyn3R9R361llWZZAEDKJ/xoMTGQ
         YhzIGMXIPiZEC5xt+H/xP82I8cgfMe1z5+rReNeNLmuvU5r5WBP9DnYVCNt68tbWMINv
         3ZNg==
X-Gm-Message-State: AMke39lL9tSHUxQ9PXJPuUkZX/ZU84RDal6sdsLpVMCOAIvMPf+s0Km1YVsUlKlATX3m3Q==
X-Received: by 10.28.136.13 with SMTP id k13mr16940999wmd.94.1488872694226;
        Mon, 06 Mar 2017 23:44:54 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 61sm29873254wrs.29.2017.03.06.23.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Mar 2017 23:44:53 -0800 (PST)
Date:   Tue, 7 Mar 2017 08:44:51 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Include asm/ptrace.h now linux/sched.h doesn't
Message-ID: <20170307074451.GB24782@gmail.com>
References: <0cd2d2c571afea9658428ee251ae5d3325bfe01b.1488587471.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cd2d2c571afea9658428ee251ae5d3325bfe01b.1488587471.git-series.james.hogan@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
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


* James Hogan <james.hogan@imgtec.com> wrote:

> Use of the task_pt_regs() based macros in MIPS' asm/processor.h for
> accessing the user context on the kernel stack need the definition of
> struct pt_regs from asm/ptrace.h. __own_fpu() in asm/fpu.h uses these
> macros but implicitly depended on linux/sched.h to include asm/ptrace.h.
> 
> Since commit f780d89a0e82 ("sched/headers: Remove <asm/ptrace.h> from
> <linux/sched.h>") however linux/sched.h no longer includes asm/ptrace.h,
> so include it explicitly from asm/fpu.h where it is needed instead.
> 
> This fixes build errors such as:
> 
> ./arch/mips/include/asm/fpu.h: In function '__own_fpu':
> ./arch/mips/include/asm/processor.h:385:31: error: invalid application of 'sizeof' to incomplete type 'struct pt_regs'
>      THREAD_SIZE - 32 - sizeof(struct pt_regs))
>                                ^
> 
> Fixes: f780d89a0e82 ("sched/headers: Remove <asm/ptrace.h> from <linux/sched.h>")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: linux-mips@linux-mips.org

My build tests missed this bug, thanks James!

Acked-by: Ingo Molnar <mingo@kernel.org>

	Ingo
