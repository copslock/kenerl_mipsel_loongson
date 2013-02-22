Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Feb 2013 17:22:43 +0100 (CET)
Received: from mail-vb0-f45.google.com ([209.85.212.45]:38578 "EHLO
        mail-vb0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827568Ab3BVQWlyj6mg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Feb 2013 17:22:41 +0100
Received: by mail-vb0-f45.google.com with SMTP id p1so503309vbi.4
        for <multiple recipients>; Fri, 22 Feb 2013 08:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=1/z2HptjR302a24hbbwFqasOppfSVXf9++eQRkTCQfg=;
        b=VbcTdscRO9XJN17mD+K8OqTtO2yVQqfFd5nOrFjVjk3nInRZmQyqmTCbIIXCN4Is0E
         IDz4nCF4IzcYIErIlNgIRLaqg0js/lw9L1ATQZm8g+jeLE5GH2x9QHrgxFTLWV8Qev6V
         Tx3vxudvwdz/ggsrqkGLvrknejVhIIR5RyhRWMdAAAiImEBspdDqko3EYLP/4SdmRBAr
         9ipR5Z03g62NMAubLBz0sQGfQlonZt6O6JOYYXRoqF4U8dBYHu7nVyrszNsv8WfzRD1+
         hesGos+W54+1//rJd2uS//6yNyndHplo/c3qNiDku8mDskOU43/nz1prNSEn/GVVgBRy
         3w1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=1/z2HptjR302a24hbbwFqasOppfSVXf9++eQRkTCQfg=;
        b=ZHHGAMIgdbc7cqAoTBRpCP0MBYTYP4K+2SiGCeMGuyz0aco812PBFwC71UMfU8V038
         u7m4sC9TR0D9ciBvfNnaaSn+XxVDQHF8HHCIvZlLIo0zry+YVEAQ6Q0n7aFGyTffYjSJ
         YsT9Z5IIaPSnTGKJDZTgDB0qacX/fqfieVP3g=
MIME-Version: 1.0
X-Received: by 10.52.179.3 with SMTP id dc3mr2901372vdc.74.1361550150480; Fri,
 22 Feb 2013 08:22:30 -0800 (PST)
Received: by 10.220.145.131 with HTTP; Fri, 22 Feb 2013 08:22:30 -0800 (PST)
In-Reply-To: <201302220034.r1M0Y6O8008311@terminus.zytor.com>
References: <201302220034.r1M0Y6O8008311@terminus.zytor.com>
Date:   Fri, 22 Feb 2013 08:22:30 -0800
X-Google-Sender-Auth: nbH_-pnQ2K1dUI4spHtJjNaHXAE
Message-ID: <CA+55aFy=tW2X4O-qKLh_YQjSFX7aBaBme4uy8kxawn1koKdt-g@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm changes for v3.9-rc1
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     "H. Peter Anvin" <hpa@linux.intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
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
Content-Type: text/plain; charset=UTF-8
X-archive-position: 35806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
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

On Thu, Feb 21, 2013 at 4:34 PM, H. Peter Anvin <hpa@linux.intel.com> wrote:
>
> This is a huge set of several partly interrelated (and concurrently
> developed) changes, which is why the branch history is messier than
> one would like.
>
> The *really* big items are two humonguous patchsets mostly developed
> by Yinghai Lu at my request, which completely revamps the way we
> create initial page tables.

Ugh. So I've tried to walk through this, and it's painful. If this
results in problems, we're going to be *so* screwed. Is it bisectable?

I also don't understand how "early_idt_handler" could *possibly* work.
In particular, it seems to rely on the trap number being set up in the
stack frame:

        cmpl $14,72(%rsp)       # Page fault?

but that's not even *true*. Why? Because we export both the
early_idt_handlers[] array (that sets up the trap number and makes the
stack frame be reliable) and the single early_idt_handler function
(that relies on the trap number and the reliable stack frame), AND
AFAIK WE USE THE LATTER!

See x86_64_start_kernel():

        for (i = 0; i < NUM_EXCEPTION_VECTORS; i++) {
#ifdef CONFIG_EARLY_PRINTK
                set_intr_gate(i, &early_idt_handlers[i]);
#else
                set_intr_gate(i, early_idt_handler);
#endif
        }

so unless you have CONFIG_EARLY_PRINTK, the interrupt gate will point
to that raw early_idt_handler function that doesn't *work* on its own,
afaik.

Btw, it's not just the page fault index testing that is wrong. The whole

        cmpl $__KERNEL_CS,96(%rsp)
        jne 11f

also relies on the stack frame being set up the same way for all
exceptions - which again is only true if we ran through the
early_idt_handlers[] prologue that added the extra stack entry.

How does this even work for me? I don't have EARLY_PRINTK enabled.

What am I missing?

                Linus
