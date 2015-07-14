Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 16:42:52 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:41827 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009861AbbGNOmuvdP8F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Jul 2015 16:42:50 +0200
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (Postfix) with ESMTPS id 699132B9DC5;
        Tue, 14 Jul 2015 14:42:49 +0000 (UTC)
Received: from horse.redhat.com (dhcp-25-235.bos.redhat.com [10.18.25.235])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t6EEgmQM030643;
        Tue, 14 Jul 2015 10:42:49 -0400
Received: by horse.redhat.com (Postfix, from userid 10451)
        id AA3A820220E; Tue, 14 Jul 2015 10:42:48 -0400 (EDT)
Date:   Tue, 14 Jul 2015 10:42:48 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>,
        linux-sh@vger.kernel.org, linux-s390@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Daniel Walker <dwalker@fifo99.com>,
        linuxppc-dev@lists.ozlabs.org, linux-metag@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] kexec: Change the timing of callbacks related to
 "crash_kexec_post_notifiers" boot option
Message-ID: <20150714144248.GC10792@redhat.com>
References: <20150710113331.4368.10495.stgit@softrs>
 <20150710113331.4368.77050.stgit@softrs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150710113331.4368.77050.stgit@softrs>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <vgoyal@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vgoyal@redhat.com
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

On Fri, Jul 10, 2015 at 08:33:31PM +0900, Hidehiro Kawai wrote:
> This patch fixes problems reported by Daniel Walker
> (https://lkml.org/lkml/2015/6/24/44), and also replaces the bug fix
> commits 5375b70 and f45d85f.
> 
> If "crash_kexec_post_notifiers" boot option is specified,
> other cpus are stopped by smp_send_stop() before entering
> crash_kexec(), while usually machine_crash_shutdown() called by
> crash_kexec() does that.  This behavior change leads two problems.
> 
>  Problem 1:
>  Some function in the crash_kexec() path depend on other cpus being
>  still online.  If other cpus have been offlined already, they
>  doesn't work properly.
> 
>   Example:
>    panic()
>     crash_kexec()
>      machine_crash_shutdown()
>       octeon_generic_shutdown() // shutdown watchdog for ONLINE cpus
>      machine_kexec()
> 
>  Problem 2:
>  Most of architectures stop other cpus in the machine_crash_shutdown()
>  path and save register information at the same time.  However, if
>  smp_send_stop() is called before that, we can't save the register
>  information.
> 
> To solve these problems, this patch changes the timing of calling
> the callbacks instead of changing the timing of crash_kexec() if
> crash_kexec_post_notifiers boot option is specified.
> 
>  Before:
>   if (!crash_kexec_post_notifiers)
>       crash_kexec()
> 
>   smp_send_stop()
>   atomic_notifier_call_chain()
>   kmsg_dump()
> 
>   if (crash_kexec_post_notifiers)
>       crash_kexec()
> 
>  After:
>   crash_kexec()
>       machine_crash_shutdown()
>       if (crash_kexec_post_notifiers) {
>           atomic_notifier_call_chain()
>           kmsg_dump()
>       }
>       machine_kexec()
> 
>   smp_send_stop()
>   if (!crash_kexec_post_notifiers) {
>       atomic_notifier_call_chain()
>       kmsg_dump()
>   }
> 

I think this new code flow looks bad. Now we are calling kmsg_dump()
and atomic_notifier_call_chain() from inside the crash_kexec() as well
as from inside panic(). This is bad.

So basic problem seems to be that cpus need to be stopped once (with
or without panic notifiers. So why don't we look into desiginig a 
function which stops cpus, saves register states first and then does
rest of the processing.

Something like.

stop_cpus_save_register_state;

if (!crash_kexec_post_notifiers)
	crash_kexec()

atomic_notifier_call_chain()
kmsg_dump()

Here crash_kexec() will have to be modified and it will assume that cpus
have already been stopped and register states have already been saved.

IOW, is there a reason that we can't get rid of smp_send_stop() and
use the mechanism crash_kexec() is using to stop cpus after panic()?

Thanks
Vivek
