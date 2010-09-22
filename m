Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Sep 2010 14:32:25 +0200 (CEST)
Received: from arkanian.console-pimps.org ([212.110.184.194]:56507 "EHLO
        arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491197Ab0IVMcW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Sep 2010 14:32:22 +0200
Received: by arkanian.console-pimps.org (Postfix, from userid 1000)
        id 0B8C04432D; Wed, 22 Sep 2010 13:32:22 +0100 (BST)
Date:   Wed, 22 Sep 2010 13:32:22 +0100
From:   Matt Fleming <matt@console-pimps.org>
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com
Subject: Re: [PATCH v6 7/7] MIPS: define local_xchg from xchg_local to
        atomic_long_xchg
Message-ID: <20100922123221.GA16333@console-pimps.org>
References: <1276058130-25851-1-git-send-email-dengcheng.zhu@gmail.com> <1276058130-25851-8-git-send-email-dengcheng.zhu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1276058130-25851-8-git-send-email-dengcheng.zhu@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 27792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt@console-pimps.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 17192

On Wed, Jun 09, 2010 at 12:35:30PM +0800, Deng-Cheng Zhu wrote:
> Perf-events is now using local_t helper functions internally. There is a
> use of local_xchg(). On MIPS, this is defined to xchg_local() which is
> missing in asm/system.h. This patch re-defines local_xchg() in asm/local.h
> to atomic_long_xchg(). Then Perf-events can pass the build.
> 
> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>

Is this a separate issue from the rest of this patch series? In any
event, it's probably worth moving this earlier in the patch series so
as not to break bisect.
