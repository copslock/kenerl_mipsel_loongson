Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Feb 2013 18:36:52 +0100 (CET)
Received: from terminus.zytor.com ([198.137.202.10]:41315 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827576Ab3BVRgvE1y8r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Feb 2013 18:36:51 +0100
Received: from tazenda.hos.anvin.org ([IPv6:2601:9:3340:26:e269:95ff:fe35:9f3c])
        (authenticated bits=0)
        by mail.zytor.com (8.14.5/8.14.5) with ESMTP id r1MHXdwS012535
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
        Fri, 22 Feb 2013 09:33:39 -0800
Message-ID: <5127ABEE.8080303@zytor.com>
Date:   Fri, 22 Feb 2013 09:33:34 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Dave Hansen <dave@linux.vnet.ibm.com>
CC:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
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
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Zachary Amsden <zamsden@gmail.com>, avi@redhat.com,
        linux-mips@linux-mips.org, linux-pm@vger.kernel.org,
        mst@redhat.com, sparclinux@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xensource.com
Subject: Re: [GIT PULL] x86/mm changes for v3.9-rc1
References: <201302220034.r1M0Y6O8008311@terminus.zytor.com> <20130222165531.GA29308@phenom.dumpdata.com> <5127AB34.8090406@linux.vnet.ibm.com>
In-Reply-To: <5127AB34.8090406@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35812
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

On 02/22/2013 09:30 AM, Dave Hansen wrote:
>
> Do you have CONFIG_DEBUG_VIRTUAL on?
>
> You're probably hitting the new BUG_ON() in __phys_addr().  It's
> intended to detect places where someone is doing a __pa()/__phys_addr()
> on an address that's outside the kernel's identity mapping.
>
> There are a lot of __pa() calls around there, but from the looks of it,
> it's this code:
>
> static pgd_t *xen_get_user_pgd(pgd_t *pgd)
> {
> ...
>          if (offset < pgd_index(USER_LIMIT)) {
>                  struct page *page = virt_to_page(pgd_page);
>
> I'm a bit fuzzy on exactly what the code is trying to do here.  It could
> mean either that the identity mapping isn't set up enough yet, or that
> __pa() is getting called on a bogus address.
>
> I'm especially fuzzy on why we'd be calling anything that's looking at
> userspace pagetables (xen_get_user_pgd() ??) this early in boot.
>

Ah yes, of course.

This is unrelated to the early page table setups, which is why it didn't 
trip in Konrad's earlier testing.

This debugging bits has already found real bugs in the kernel, and this 
might be another.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
