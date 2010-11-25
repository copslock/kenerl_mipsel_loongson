Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Nov 2010 08:18:16 +0100 (CET)
Received: from canuck.infradead.org ([134.117.69.58]:44966 "EHLO
        canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1490963Ab0KYHSL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Nov 2010 08:18:11 +0100
Received: from f199130.upc-f.chello.nl ([80.56.199.130] helo=laptop)
        by canuck.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
        id 1PLW5f-0008Kb-U9; Thu, 25 Nov 2010 07:18:00 +0000
Received: by laptop (Postfix, from userid 1000)
        id 83FAF10327613; Thu, 25 Nov 2010 08:01:09 +0100 (CET)
Subject: Re: [PATCH 2/5] MIPS/Perf-events: Work with the new PMU interface
From:   Peter Zijlstra <a.p.zijlstra@chello.nl>
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     ralf@linux-mips.org, fweisbec@gmail.com, will.deacon@arm.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com
In-Reply-To: <1290063401-25440-3-git-send-email-dengcheng.zhu@gmail.com>
References: <1290063401-25440-1-git-send-email-dengcheng.zhu@gmail.com>
         <1290063401-25440-3-git-send-email-dengcheng.zhu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date:   Thu, 25 Nov 2010 08:01:09 +0100
Message-ID: <1290668469.2072.550.camel@laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Return-Path: <a.p.zijlstra@chello.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.p.zijlstra@chello.nl
Precedence: bulk
X-list: linux-mips

On Thu, 2010-11-18 at 14:56 +0800, Deng-Cheng Zhu wrote:
> 
> This is the MIPS part of the following commits by Peter Zijlstra:
> 
> a4eaf7f14675cb512d69f0c928055e73d0c6d252
>         perf: Rework the PMU methods
> 33696fc0d141bbbcb12f75b69608ea83282e3117
>         perf: Per PMU disable
> 24cd7f54a0d47e1d5b3de29e2456bfbd2d8447b7
>         perf: Reduce perf_disable() usage
> b0a873ebbf87bf38bf70b5e39a7cadc96099fa13
>         perf: Register PMU implementations
> 51b0fe39549a04858001922919ab355dee9bdfcf
>         perf: Deconstify struct pmu
> 
> 
I'll not ACK this as I've no clue how the MIPS PMU(s) work, but the
shape looks ok :-)
