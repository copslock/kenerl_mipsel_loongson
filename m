Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Sep 2010 11:26:18 +0200 (CEST)
Received: from mx2.mail.elte.hu ([157.181.151.9]:56167 "EHLO mx2.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491151Ab0I3J0P (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Sep 2010 11:26:15 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx2.mail.elte.hu with esmtp (Exim)
        id 1P1FP1-0004oU-Tn
        from <mingo@elte.hu>; Thu, 30 Sep 2010 11:26:14 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id C33353E2312; Thu, 30 Sep 2010 11:26:06 +0200 (CEST)
Date:   Thu, 30 Sep 2010 11:26:08 +0200
From:   Ingo Molnar <mingo@elte.hu>
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, acme@redhat.com,
        jamie.iles@picochip.com
Subject: Re: [PATCH v7 6/6] MIPS: add support for hardware performance events
 (mipsxx)
Message-ID: <20100930092608.GA6059@elte.hu>
References: <1285837760-10362-1-git-send-email-dengcheng.zhu@gmail.com>
 <1285837760-10362-7-git-send-email-dengcheng.zhu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1285837760-10362-7-git-send-email-dengcheng.zhu@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx2.mail.elte.hu: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: 0.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.5 required=5.9 tests=BAYES_40 autolearn=no SpamAssassin version=3.2.5
        0.5 BAYES_40               BODY: Bayesian spam probability is 20 to 40%
        [score: 0.3780]
X-archive-position: 27902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 24034


* Deng-Cheng Zhu <dengcheng.zhu@gmail.com> wrote:

> To test the functionality of Perf-event, you may want to compile the 
> tool "perf" for your MIPS platform. You can refer to the following 
> URL: 
> http://www.linux-mips.org/archives/linux-mips/2010-04/msg00158.html
> 
> Please note: Before that patch is accepted, you can choose a 
> "specific" rmb() which is suitable for your platform -- an example is 
> provided in the description of that patch.
> 
> You also need to customize the CFLAGS and LDFLAGS in 
> tools/perf/Makefile for your libs, includes, etc.

Mind submitting this patch to the perf maintainers as well, so that by 
the time MIPS kernel-side support hits mainline the tools/perf/ side 
will be usable 'out of box' ?

Thanks,

	Ingo
