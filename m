Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2014 17:16:56 +0200 (CEST)
Received: from forward18.mail.yandex.net ([95.108.253.143]:46984 "EHLO
        forward18.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009616AbaIWPQxnATuF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Sep 2014 17:16:53 +0200
Received: from web24g.yandex.ru (web24g.yandex.ru [95.108.253.233])
        by forward18.mail.yandex.net (Yandex) with ESMTP id 6DD5017822B1;
        Tue, 23 Sep 2014 19:16:46 +0400 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        by web24g.yandex.ru (Yandex) with ESMTP id EB9F358E055B;
        Tue, 23 Sep 2014 19:16:44 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1411485405; bh=znHaVa9Vc/yWkEWZmpD7l9ooSJTI4jcX1xNa4V/y1VE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date;
        b=MLRMnqLjKeTxPqmzfuHdkN3fYbwKAPUlpf6DipKznZQQSLVQFki5S2v9/ir08RoXN
         5jlxR7N6ZUu30zyKdBm27eCWweKJtH+4qxFU6il0SNTij6a03YqURflyX3iLQhG8ut
         SQlxCxriQYgWOlaxh4iMo2HGsAqBYtXR3gbd5iGE=
Received: from swsoft-msk-nat.sw.ru (swsoft-msk-nat.sw.ru [195.214.232.10]) by web24g.yandex.ru with HTTP;
        Tue, 23 Sep 2014 19:16:44 +0400
From:   Kirill Tkhai <tkhai@yandex.ru>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kirill Tkhai <ktkhai@parallels.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
In-Reply-To: <20140923150641.GH3312@worktop.programming.kicks-ass.net>
References: <20140922183612.11015.64200.stgit@localhost>
         <20140922183618.11015.95007.stgit@localhost> <20140923150641.GH3312@worktop.programming.kicks-ass.net>
Subject: Re: [RFC][PATCH] sched,mips,ia64: Remove __ARCH_WANT_UNLOCKED_CTXSW
MIME-Version: 1.0
Message-Id: <32571411485404@web24g.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 23 Sep 2014 19:16:44 +0400
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=koi8-r
Return-Path: <tkhai@yandex.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tkhai@yandex.ru
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

23.09.2014, 19:06, "Peter Zijlstra" <peterz@infradead.org>:
> On Mon, Sep 22, 2014 at 10:36:18PM +0400, Kirill Tkhai wrote:
>> šFrom: Kirill Tkhai <ktkhai@parallels.com>
>>
>> šArchitectures, which define __ARCH_WANT_UNLOCKED_CTXSW,
>> šmay pull a task when it's in the middle of schedule().
>>
>> šCPU1(task1 calls schedule) šššššššššššCPU2
>> š... ššššššššššššššššššššššššššššššššššschedule()
>> š... šššššššššššššššššššššššššššššššššššššidle_balance()
>> š... ššššššššššššššššššššššššššššššššššššššššload_balance()
>> š... ššššššššššššššššššššššššššššššššššššššššššš...
>> šschedule() šššššššššššššššššššššššššššššššššššš...
>> ššššprepare_lock_switch() šššššššššššššššššššššš...
>> šššššššraw_spin_unlock(&rq1->lock) ššššššššššššš...
>> ššššššš... šššššššššššššššššššššššššššššššššššššraw_spin_lock(&rq1->lock)
>> ššššššš... ššššššššššššššššššššššššššššššššššššššššdetach_tasks();
>> ššššššš... šššššššššššššššššššššššššššššššššššššššššššcan_migrate_task(task1)
>> ššššššš... ššššššššššššššššššššššššššššššššššššššššattach_tasks(); <--- move task1 to rq2
>> ššššššš... šššššššššššššššššššššššššššššššššššššraw_spin_unlock(&rq1->lock)
>> ššššššš... šššššššššššššššššššššššššššššššcontext_switch() <--- switch to task1's stack
>> ššššššš... ššššššššššššššššššššššššššššššš...
>> šššš(using task1's stack) šššššššššššššššš(using task1's stack)
>> šššš... šššššššššššššššššššššššššššššššššš...
>> ššššcontext_switch() ššššššššššššššššššššš...
>>
>> šParallel use of a single stack is not a good idea.
>
> Indeed it is, but how about we do this instead?

Completely agree, looks good for me.

> ---
> Subject: sched,mips,ia64: Remove __ARCH_WANT_UNLOCKED_CTXSW
>
> Kirill found that there's a subtle race in the
> __ARCH_WANT_UNLOCKED_CTXSW code, and instead of fixing it, remove the
> entire exception because neither arch that uses it seems to actually
> still require it.
>
> Boot tested on mips64el (qemu) only.
>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Kirill Tkhai <ktkhai@parallels.com> (one more review of ia64 part)
