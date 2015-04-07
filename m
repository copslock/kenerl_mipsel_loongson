Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Apr 2015 12:06:56 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:44522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008936AbbDGKGyr8Ebe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Apr 2015 12:06:54 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (Postfix) with ESMTPS id 0225231F063;
        Tue,  7 Apr 2015 10:06:51 +0000 (UTC)
Received: from tranklukator.brq.redhat.com (dhcp-1-208.brq.redhat.com [10.34.1.208])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id t37A6m5O030459;
        Tue, 7 Apr 2015 06:06:49 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Tue,  7 Apr 2015 12:06:58 +0200 (CEST)
Date:   Tue, 7 Apr 2015 12:06:54 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     yury.norov@gmail.com, rth@twiddle.net, ink@jurassic.park.msu.ru,
        akpm@linux-foundation.org, davem@davemloft.net
Cc:     klimov.linux@gmail.com, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH] signal: optimize 'sigaction' call path
Message-ID: <20150407100654.GA32743@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oleg@redhat.com
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

> There is a set of syscalls in the kernel about 'sigaction'.
> All they end up with calling the helper 'do_sigaction',
> so the generic scheme is:
>
> - copy user data to kernel;
> - 'do_sigaction';
> - copy kernel data to user.
>
> 'do_sigaction' checks 'signum' parameter before doing its main job.
> If this check fails syscall fails immediately, as well. But at this
> stage first copy is already done. And so there's a potential chance
> having it useless. It may affect performance significantly if user
> data was, say, swapped, and a fault was handled to obtain it.

Only if the signal number is wrong? So why do we care?

> In this patch, 'signum' sanity check is moved out of 'do_sigaction'
> to a small function 'user_signal'. So we can call it before any copying.
...
>  arch/alpha/kernel/signal.c       | 19 +++++++-------
>  arch/mips/kernel/signal.c        | 10 +++++---
>  arch/mips/kernel/signal32.c      | 10 +++++---
>  arch/sparc/kernel/sys_sparc32.c  | 10 ++++----
>  arch/sparc/kernel/sys_sparc_32.c | 10 ++++----
>  arch/sparc/kernel/sys_sparc_64.c | 10 ++++----
>  include/linux/sched.h            |  2 +-
>  include/linux/signal.h           |  5 ++++
>  kernel/signal.c                  | 54 +++++++++++++++++++++-------------------
>  9 files changed, 71 insertions(+), 59 deletions(-)

And this blows the source and compiled code. Not too much, but this
change should be justified somehow.

And to me this patch doesn't look like a cleanup, imho this sanity
check makes more sense in one place.

Oleg.
