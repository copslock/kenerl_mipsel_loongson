Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Feb 2013 17:57:46 +0100 (CET)
Received: from aserp1040.oracle.com ([141.146.126.69]:36373 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827565Ab3BVQ5phCrFS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Feb 2013 17:57:45 +0100
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with ESMTP id r1MGteJ5029018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 22 Feb 2013 16:55:41 GMT
Received: from acsmt357.oracle.com (acsmt357.oracle.com [141.146.40.157])
        by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id r1MGtb0U026898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 22 Feb 2013 16:55:38 GMT
Received: from abhmt115.oracle.com (abhmt115.oracle.com [141.146.116.67])
        by acsmt357.oracle.com (8.12.11.20060308/8.12.11) with ESMTP id r1MGtaWE031325;
        Fri, 22 Feb 2013 10:55:36 -0600
Received: from phenom.dumpdata.com (/50.195.21.189)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Feb 2013 08:55:35 -0800
Received: by phenom.dumpdata.com (Postfix, from userid 1000)
        id 2B90E1C3935; Fri, 22 Feb 2013 11:55:31 -0500 (EST)
Date:   Fri, 22 Feb 2013 11:55:31 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     "H. Peter Anvin" <hpa@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
        Dave Hansen <dave@linux.vnet.ibm.com>,
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
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Zachary Amsden <zamsden@gmail.com>, avi@redhat.com,
        linux-mips@linux-mips.org, linux-pm@vger.kernel.org,
        mst@redhat.com, sparclinux@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xensource.com
Subject: Re: [GIT PULL] x86/mm changes for v3.9-rc1
Message-ID: <20130222165531.GA29308@phenom.dumpdata.com>
References: <201302220034.r1M0Y6O8008311@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201302220034.r1M0Y6O8008311@terminus.zytor.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Source-IP: ucsinet21.oracle.com [156.151.31.93]
X-archive-position: 35807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: konrad.wilk@oracle.com
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

On Thu, Feb 21, 2013 at 04:34:06PM -0800, H. Peter Anvin wrote:
> Hi Linus,
> 
> This is a huge set of several partly interrelated (and concurrently
> developed) changes, which is why the branch history is messier than
> one would like.
> 
> The *really* big items are two humonguous patchsets mostly developed
> by Yinghai Lu at my request, which completely revamps the way we
> create initial page tables.  In particular, rather than estimating how
> much memory we will need for page tables and then build them into that
> memory -- a calculation that has shown to be incredibly fragile -- we
> now build them (on 64 bits) with the aid of a "pseudo-linear mode" --
> a #PF handler which creates temporary page tables on demand.
> 
> This has several advantages:
> 
> 1. It makes it much easier to support things that need access to
>    data very early (a followon patchset uses this to load microcode
>    way early in the kernel startup).
> 
> 2. It allows the kernel and all the kernel data objects to be invoked
>    from above the 4 GB limit.  This allows kdump to work on very large
>    systems.
> 
> 3. It greatly reduces the difference between Xen and native (Xen's
>    equivalent of the #PF handler are the temporary page tables created
>    by the domain builder), eliminating a bunch of fragile hooks.
> 
> The patch series also gets us a bit closer to W^X.
> 
> Additional work in this pull is the 64-bit get_user() work which you
> were also involved with, and a bunch of cleanups/speedups to
> __phys_addr()/__pa().

Looking at figuring out which of the patches in the branch did this, but
with this merge I am getting a crash with a very simple PV guest (booted with
one 1G):

Call Trace:
  [<ffffffff8103feba>] xen_get_user_pgd+0x5a  <--
  [<ffffffff8103feba>] xen_get_user_pgd+0x5a 
  [<ffffffff81042d27>] xen_write_cr3+0x77 
  [<ffffffff81ad2d21>] init_mem_mapping+0x1f9 
  [<ffffffff81ac293f>] setup_arch+0x742 
  [<ffffffff81666d71>] printk+0x48 
  [<ffffffff81abcd62>] start_kernel+0x90 
  [<ffffffff8109416b>] __add_preferred_console.clone.1+0x9b 
  [<ffffffff81abc5f7>] x86_64_start_reservations+0x2a 
  [<ffffffff81abf0c7>] xen_start_kernel+0x564 

And the hypervisor says:
(XEN) d7:v0: unhandled page fault (ec=0000)
(XEN) Pagetable walk from ffffea000005b2d0:
(XEN)  L4[0x1d4] = 0000000000000000 ffffffffffffffff
(XEN) domain_crash_sync called from entry.S
(XEN) Domain 7 (vcpu#0) crashed on cpu#3:
(XEN) ----[ Xen-4.2.0  x86_64  debug=n  Not tainted ]----
(XEN) CPU:    3
(XEN) RIP:    e033:[<ffffffff8103feba>]
(XEN) RFLAGS: 0000000000000206   EM: 1   CONTEXT: pv guest
(XEN) rax: ffffea0000000000   rbx: 0000000001a0c000   rcx: 0000000080000000
(XEN) rdx: 000000000005b2a0   rsi: 0000000001a0c000   rdi: 0000000000000000
(XEN) rbp: ffffffff81a01dd8   rsp: ffffffff81a01d90   r8:  0000000000000000
(XEN) r9:  0000000010000001   r10: 0000000000000000   r11: 0000000000000000
(XEN) r12: 0000000000000000   r13: 0000001000000000   r14: 0000000000000000
(XEN) r15: 0000000000100000   cr0: 000000008005003b   cr4: 00000000000406f0
(XEN) cr3: 0000000411165000   cr2: ffffea000005b2d0
(XEN) ds: 0000   es: 0000   fs: 0000   gs: 0000   ss: e02b   cs: e033
(XEN) Guest stack trace from rsp=ffffffff81a01d90:
(XEN)    0000000080000000 0000000000000000 0000000000000000 ffffffff8103feba
(XEN)    000000010000e030 0000000000010006 ffffffff81a01dd8 000000000000e02b


What is bizzare is that I do recall testing this (and Stefano also did it).
So I am not sure what has altered.
