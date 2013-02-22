Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Feb 2013 18:46:16 +0100 (CET)
Received: from e39.co.us.ibm.com ([32.97.110.160]:58315 "EHLO
        e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827576Ab3BVRqOyOac1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Feb 2013 18:46:14 +0100
Received: from /spool/local
        by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <dave@linux.vnet.ibm.com>;
        Fri, 22 Feb 2013 10:46:07 -0700
Received: from d03dlp02.boulder.ibm.com (9.17.202.178)
        by e39.co.us.ibm.com (192.168.1.139) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Fri, 22 Feb 2013 10:46:05 -0700
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
        by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id D82123E40040;
        Fri, 22 Feb 2013 10:45:55 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
        by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r1MHiVjW154482;
        Fri, 22 Feb 2013 10:46:04 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
        by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r1MHdDhE032706;
        Fri, 22 Feb 2013 10:39:27 -0700
Received: from kernel.stglabs.ibm.com (kernel.stglabs.ibm.com [9.114.214.19])
        by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id r1MHd9qx031972;
        Fri, 22 Feb 2013 10:39:09 -0700
Received: from [9.65.132.22] (sig-9-65-132-22.mts.ibm.com [9.65.132.22])
        by kernel.stglabs.ibm.com (Postfix) with SMTP id 712E924028D;
        Fri, 22 Feb 2013 09:30:30 -0800 (PST)
Message-ID: <5127AB34.8090406@linux.vnet.ibm.com>
Date:   Fri, 22 Feb 2013 09:30:28 -0800
From:   Dave Hansen <dave@linux.vnet.ibm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC:     "H. Peter Anvin" <hpa@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rjw@sisk.pl>, stable@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Borislav Petkov <bp@suse.de>, Christoph Lameter <cl@linux.com>,
        Daniel J Blueman <daniel@numascale-asia.com>,
        Eric Biederman <ebiederm@xmission.com>,
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
        =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Zachary Amsden <zamsden@gmail.com>, avi@redhat.com,
        linux-mips@linux-mips.org, linux-pm@vger.kernel.org,
        mst@redhat.com, sparclinux@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xensource.com
Subject: Re: [GIT PULL] x86/mm changes for v3.9-rc1
References: <201302220034.r1M0Y6O8008311@terminus.zytor.com> <20130222165531.GA29308@phenom.dumpdata.com>
In-Reply-To: <20130222165531.GA29308@phenom.dumpdata.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 13022217-3620-0000-0000-0000015836C2
X-archive-position: 35814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave@linux.vnet.ibm.com
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

On 02/22/2013 08:55 AM, Konrad Rzeszutek Wilk wrote:
> On Thu, Feb 21, 2013 at 04:34:06PM -0800, H. Peter Anvin wrote:
>> Hi Linus,
>>
>> This is a huge set of several partly interrelated (and concurrently
>> developed) changes, which is why the branch history is messier than
>> one would like.
>>
>> The *really* big items are two humonguous patchsets mostly developed
>> by Yinghai Lu at my request, which completely revamps the way we
>> create initial page tables.  In particular, rather than estimating how
>> much memory we will need for page tables and then build them into that
>> memory -- a calculation that has shown to be incredibly fragile -- we
>> now build them (on 64 bits) with the aid of a "pseudo-linear mode" --
>> a #PF handler which creates temporary page tables on demand.
>>
>> This has several advantages:
>>
>> 1. It makes it much easier to support things that need access to
>>    data very early (a followon patchset uses this to load microcode
>>    way early in the kernel startup).
>>
>> 2. It allows the kernel and all the kernel data objects to be invoked
>>    from above the 4 GB limit.  This allows kdump to work on very large
>>    systems.
>>
>> 3. It greatly reduces the difference between Xen and native (Xen's
>>    equivalent of the #PF handler are the temporary page tables created
>>    by the domain builder), eliminating a bunch of fragile hooks.
>>
>> The patch series also gets us a bit closer to W^X.
>>
>> Additional work in this pull is the 64-bit get_user() work which you
>> were also involved with, and a bunch of cleanups/speedups to
>> __phys_addr()/__pa().
> 
> Looking at figuring out which of the patches in the branch did this, but
> with this merge I am getting a crash with a very simple PV guest (booted with
> one 1G):
> 
> Call Trace:
>   [<ffffffff8103feba>] xen_get_user_pgd+0x5a  <--
>   [<ffffffff8103feba>] xen_get_user_pgd+0x5a 
>   [<ffffffff81042d27>] xen_write_cr3+0x77 
>   [<ffffffff81ad2d21>] init_mem_mapping+0x1f9 
>   [<ffffffff81ac293f>] setup_arch+0x742 
>   [<ffffffff81666d71>] printk+0x48 
>   [<ffffffff81abcd62>] start_kernel+0x90 
>   [<ffffffff8109416b>] __add_preferred_console.clone.1+0x9b 
>   [<ffffffff81abc5f7>] x86_64_start_reservations+0x2a 
>   [<ffffffff81abf0c7>] xen_start_kernel+0x564 

Do you have CONFIG_DEBUG_VIRTUAL on?

You're probably hitting the new BUG_ON() in __phys_addr().  It's
intended to detect places where someone is doing a __pa()/__phys_addr()
on an address that's outside the kernel's identity mapping.

There are a lot of __pa() calls around there, but from the looks of it,
it's this code:

static pgd_t *xen_get_user_pgd(pgd_t *pgd)
{
...
        if (offset < pgd_index(USER_LIMIT)) {
                struct page *page = virt_to_page(pgd_page);

I'm a bit fuzzy on exactly what the code is trying to do here.  It could
mean either that the identity mapping isn't set up enough yet, or that
__pa() is getting called on a bogus address.

I'm especially fuzzy on why we'd be calling anything that's looking at
userspace pagetables (xen_get_user_pgd() ??) this early in boot.
