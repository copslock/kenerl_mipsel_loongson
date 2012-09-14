Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2012 07:52:25 +0200 (CEST)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:40373 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1902232Ab2INFwU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2012 07:52:20 +0200
Received: by wibhq4 with SMTP id hq4so6531909wib.6
        for <linux-mips@linux-mips.org>; Thu, 13 Sep 2012 22:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=57kZAxsiknS2yBA4t4cu4WY0PQZtEhBHxwZo45hIggE=;
        b=SJWZor8taemVr9WIEBCRJQGbEcBN+FQ2/J38H0mjlkXa/Tg3evjJs7u4yvbhtokUWF
         Jf4RW4IuFu6cyMGHV/sVbDWbfv8s/10uLWL7la32I9b0jDllm0RyoU4EnEfW0NbEzedW
         SGbfmhekl3wjvK8PCN9KTLrSt9fGbpdVHILqhZb2TInx+peIU46vrVsDmJFa3cbdi+4K
         YSE6zO4bPnPBELfLnw7Ft0g2kahYPE5hZRVHbSdCenT2N2bqWQ7QSBwOGPcwltNGuivj
         YUYBaJnqAwDTAdzb8myXT4ZeLypqASNZqg/34gN8XQhpBehz4VBgJwmdmYx5hS+Phhm1
         01eQ==
Received: by 10.180.106.130 with SMTP id gu2mr3408162wib.20.1347601934811;
        Thu, 13 Sep 2012 22:52:14 -0700 (PDT)
Received: from gmail.com (2E6BC28D.catv.pool.telekom.hu. [46.107.194.141])
        by mx.google.com with ESMTPS id t8sm17198353wiy.3.2012.09.13.22.52.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 13 Sep 2012 22:52:13 -0700 (PDT)
Date:   Fri, 14 Sep 2012 07:52:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Alex Shi <alex.shu@intel.com>,
        Jan Beulich <jbeulich@novell.com>,
        Robert Richter <robert.richter@amd.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v4 0/8] Avoid cache trashing on clearing huge/gigantic
 page
Message-ID: <20120914055210.GC9043@gmail.com>
References: <1345470757-12005-1-git-send-email-kirill.shutemov@linux.intel.com>
 <20120913160506.d394392a.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120913160506.d394392a.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34498
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
Return-Path: <linux-mips-bounce@linux-mips.org>


* Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 20 Aug 2012 16:52:29 +0300
> "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> 
> > Clearing a 2MB huge page will typically blow away several levels of CPU
> > caches.  To avoid this only cache clear the 4K area around the fault
> > address and use a cache avoiding clears for the rest of the 2MB area.
> > 
> > This patchset implements cache avoiding version of clear_page only for
> > x86. If an architecture wants to provide cache avoiding version of
> > clear_page it should to define ARCH_HAS_USER_NOCACHE to 1 and implement
> > clear_page_nocache() and clear_user_highpage_nocache().
> 
> Patchset looks nice to me, but the changelogs are terribly 
> short of performance measurements.  For this sort of change I 
> do think it is important that pretty exhaustive testing be 
> performed, and that the results (or a readable summary of 
> them) be shown.  And that testing should be designed to probe 
> for slowdowns, not just the speedups!

That is my general impression as well.

Firstly, doing before/after "perf stat --repeat 3 ..." runs 
showing a statistically significant effect on a workload that is 
expected to win from this, and on a workload expected to be 
hurting from this would go a long way towards convincing me.

Secondly, if you can find some user-space simulation of the 
intended positive (and negative) effects then a 'perf bench' 
testcase designed to show weakness of any such approach, running 
the very kernel assembly code in user-space would also be rather 
useful.

See:

comet:~/tip> git grep x86 tools/perf/bench/ | grep inclu
tools/perf/bench/mem-memcpy-arch.h:#include "mem-memcpy-x86-64-asm-def.h"
tools/perf/bench/mem-memcpy-x86-64-asm.S:#include "../../../arch/x86/lib/memcpy_64.S"
tools/perf/bench/mem-memcpy.c:#include "mem-memcpy-x86-64-asm-def.h"
tools/perf/bench/mem-memset-arch.h:#include "mem-memset-x86-64-asm-def.h"
tools/perf/bench/mem-memset-x86-64-asm.S:#include "../../../arch/x86/lib/memset_64.S"
tools/perf/bench/mem-memset.c:#include "mem-memset-x86-64-asm-def.h"

that code uses the kernel-side assembly code and runs it in 
user-space.

Although obviously clearing pages on page faults needs some care 
to properly simulate in user-space.

Without repeatable hard numbers such code just gets into the 
kernel and bitrots there as new CPU generations come in - a few 
years down the line the original decisions often degrade to pure 
noise. We've been there, we've done that, we don't want to 
repeat it.

Thanks,

	Ingo
