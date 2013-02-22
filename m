Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Feb 2013 18:35:38 +0100 (CET)
Received: from terminus.zytor.com ([198.137.202.10]:41284 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827586Ab3BVRfhef9Oy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Feb 2013 18:35:37 +0100
Received: from tazenda.hos.anvin.org ([IPv6:2601:9:3340:26:e269:95ff:fe35:9f3c])
        (authenticated bits=0)
        by mail.zytor.com (8.14.5/8.14.5) with ESMTP id r1MHVWRV012019
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
        Fri, 22 Feb 2013 09:31:32 -0800
Message-ID: <5127AB6F.3060806@zytor.com>
Date:   Fri, 22 Feb 2013 09:31:27 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "H. Peter Anvin" <hpa@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Rafael J. Wysocki" <rjw@sisk.pl>, stable <stable@vger.kernel.org>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Borislav Petkov <bp@suse.de>, Christoph Lameter <cl@linux.com>,
        Daniel J Blueman <daniel@numascale-asia.com>,
        Dave Hansen <dave@linux.vnet.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Gleb Natapov <gleb@redhat.com>,
        Gokul Caushik <caushik1@gmail.com>,
        "H. J. Lu" <hjl.tools@gmail.com>, Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@elte.hu>, Ingo Molnar <mingo@kernel.org>,
        Jacob Shin <jacob.shin@amd.com>,
        Jamie Lokier <jamie@shareable.org>,
        Jarkko Sakkinen <jarkko.sakkinen@intel.com>,
        Jeremy Fitzhardinge <jeremy@goop.org>,
        Joe Millenbach <jmillenbach@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Lee Schermerhorn <Lee.Schermerhorn@hp.com>,
        Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matt Fleming <matt.fleming@intel.com>,
        Mel Gorman <mgorman@suse.de>, Paul Turner <pjt@google.com>,
        Pavel Machek <pavel@ucw.cz>, Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rik van Riel <riel@redhat.com>,
        Rob Landley <rob@landley.net>,
        Russell King <linux@arm.linux.org.uk>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Shuah Khan <shuah.khan@hp.com>,
        Shuah Khan <shuahkhan@gmail.com>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Zachary Amsden <zamsden@gmail.com>,
        Avi Kivity <avi@redhat.com>,
        linux-mips <linux-mips@linux-mips.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, sparclinux@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        "Xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
Subject: Re: [GIT PULL] x86/mm changes for v3.9-rc1
References: <201302220034.r1M0Y6O8008311@terminus.zytor.com> <CA+55aFy=tW2X4O-qKLh_YQjSFX7aBaBme4uy8kxawn1koKdt-g@mail.gmail.com>
In-Reply-To: <CA+55aFy=tW2X4O-qKLh_YQjSFX7aBaBme4uy8kxawn1koKdt-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 02/22/2013 08:22 AM, Linus Torvalds wrote:
>
> Ugh. So I've tried to walk through this, and it's painful. If this
> results in problems, we're going to be *so* screwed. Is it bisectable?
>

I can't tell you for sure that it is bisectable at every point.  There 
are definite bisection points in there, though, as this is several 
pieces of work from two kernel cycles that were independently tested.

> I also don't understand how "early_idt_handler" could *possibly* work.
> In particular, it seems to rely on the trap number being set up in the
> stack frame:
>
>          cmpl $14,72(%rsp)       # Page fault?
>
> but that's not even *true*. Why? Because we export both the
> early_idt_handlers[] array (that sets up the trap number and makes the
> stack frame be reliable) and the single early_idt_handler function
> (that relies on the trap number and the reliable stack frame), AND
> AFAIK WE USE THE LATTER!
>
> See x86_64_start_kernel():
>
>          for (i = 0; i < NUM_EXCEPTION_VECTORS; i++) {
> #ifdef CONFIG_EARLY_PRINTK
>                  set_intr_gate(i, &early_idt_handlers[i]);
> #else
>                  set_intr_gate(i, early_idt_handler);
> #endif
>          }
>
> so unless you have CONFIG_EARLY_PRINTK, the interrupt gate will point
> to that raw early_idt_handler function that doesn't *work* on its own,
> afaik.
>

This is a (pre-existing!) bug that absolutely needs to be fixed, which 
ought to break other things too (early use of *msr_safe for example, or 
anything else that relies on an early exception entry, which there 
aren't a lot of so far).  The fix is simple and obvious.
But you're right... what the heck is going on here?

My own testing would probably not have caught this, as I consider 
EARLY_PRINTK a must have, but Ingo's test machines definitely would have.

> Btw, it's not just the page fault index testing that is wrong. The whole
>
>          cmpl $__KERNEL_CS,96(%rsp)
>          jne 11f
>
> also relies on the stack frame being set up the same way for all
> exceptions - which again is only true if we ran through the
> early_idt_handlers[] prologue that added the extra stack entry.
>
> How does this even work for me? I don't have EARLY_PRINTK enabled.
>
> What am I missing?

I just ran a simulation without EARLY_PRINTK, presumably based on the 
memory layout, we can apparently go through the entire bootup sequence 
without actually ever taking an early trap.  It is a bug, though, and it 
is a bug even without this patchset.  I will submit a fix.  However, the 
Xen "we tested this, this worked, now it doesn't" worries me a lot.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
