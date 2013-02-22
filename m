Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Feb 2013 19:24:50 +0100 (CET)
Received: from aserp1040.oracle.com ([141.146.126.69]:51989 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827583Ab3BVSYoouziF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Feb 2013 19:24:44 +0100
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with ESMTP id r1MINTKq002870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 22 Feb 2013 18:23:30 GMT
Received: from acsmt357.oracle.com (acsmt357.oracle.com [141.146.40.157])
        by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id r1MINRdU002118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 22 Feb 2013 18:23:28 GMT
Received: from abhmt107.oracle.com (abhmt107.oracle.com [141.146.116.59])
        by acsmt357.oracle.com (8.12.11.20060308/8.12.11) with ESMTP id r1MINRNv001337;
        Fri, 22 Feb 2013 12:23:27 -0600
Received: from phenom.dumpdata.com (/50.195.21.189)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Feb 2013 10:23:26 -0800
Received: by phenom.dumpdata.com (Postfix, from userid 1000)
        id 099CB1C3935; Fri, 22 Feb 2013 13:23:22 -0500 (EST)
Date:   Fri, 22 Feb 2013 13:23:21 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Yinghai Lu <yinghai@kernel.org>
Cc:     "H. Peter Anvin" <hpa@linux.intel.com>,
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
        Zachary Amsden <zamsden@gmail.com>, avi@redhat.com,
        linux-mips@linux-mips.org, linux-pm@vger.kernel.org,
        mst@redhat.com, sparclinux@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xensource.com
Subject: Re: [GIT PULL] x86/mm changes for v3.9-rc1
Message-ID: <20130222182321.GA11311@phenom.dumpdata.com>
References: <201302220034.r1M0Y6O8008311@terminus.zytor.com>
 <20130222165531.GA29308@phenom.dumpdata.com>
 <20130222172403.GA17056@phenom.dumpdata.com>
 <CAE9FiQUe86t2Me4uF=oCz5VGqa8AJYrGQHhPA=w_9OP5OSWN=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE9FiQUe86t2Me4uF=oCz5VGqa8AJYrGQHhPA=w_9OP5OSWN=w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Source-IP: ucsinet21.oracle.com [156.151.31.93]
X-archive-position: 35819
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

> > [    0.000000] DMI: MSI MS-7680/H61M-P23 (MS-7680), BIOS V17.0 03/14/2011
> > [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> > [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
> > [    0.000000] No AGP bridge found
> > [    0.000000] e820: last_pfn = 0x23fe00 max_arch_pfn = 0x400000000
> > [    0.000000] e820: lacanning 1 areas for low memory corruption
> > [    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
> > [    0.000000] reserving inaccessible SNB gfx pages
> > [    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
> > [    0.000000]  [mem 0x00000000-0x000fffff] page 4k
> > [    0.000000] init_memory_mapping: [mem 0x1f2000000-0x1f20c3fff]
> > [    0.000000]  [mem 0x1f2000000-0x1f20c3fff] page 4k
> > [    0.000000] BRK [0x01cd2000, 0x01cd2fff] PGTABLE
> > [    0.000000] BRK [0x01cd3000, 0x01cd3fff] PGTABLE
> > [    0.000000] init_memory_mapping: [mem 0x1f0000000-0x1f1ffffff]
> > [    0.000000]  [mem 0x1f0000000-0x1f1ffffff] page 4k
> > [    0.000000] BRK [0x01cd4000, 0x01cd4fff] PGTABLE
> > [    0.000000] BRK [0x01cd5000, 0x01cd5fff] PGTABLE
> > [    0.000000] BRK [0x01cd6000, 0x01cd6fff] PGTABLE
> > [    0.000000] init_memory_mapping: [mem 0x180000000-0x1efffffff]
> > [    0.000000]  [mem 0x180000000-0x1efffffff] page 4k
> > [    0.000000] init_memory_mapping: [mem 0x00100000-0x1fffffff]
> > [    0.000000]  [mem 0x00100000-0x1fffffff] page 4k
> > [    0.000000] init_memory_mapping: [mem 0x20200000-0x3fffffff]
> > [    0.000000]  [mem 0x20200000-0x3fffffff] page 4k
> > [    0.000000] init_memory_mapping: [mem 0x40200000-0xbad7ffff]
> > [    0.000000]  [mem 0x40200000-0xbad7ffff] page 4k
> > [    0.000000] init_memory_mapping: [mem 0xbadf4000-0xbadf5fff]
> > [    0.000000]  [mem 0xbadf4000-0xbadf5fff] page 4k
> > [    0.000000] init_memory_mapping: [mem 0xbae7f000-0xbaffffff]
> > [    0.000000]  [mem 0xbae7f000-0xbaffffff] page 4k
> > [    0.000000] init_memory_mapping: [mem 0x100000000-0x17fffffff]
> > [    0.000000]  [mem 0x100000000-0x17fffffff] page 4k
> > [    0.000000] init_memory_mapping: [mem 0x1f20c4000-0x23fdfffff]
> > [    0.000000]  [mem 0x1f20c4000-0x23fdfffff] page 4k
> 
> so init_memory_mapping are all done.

Not so.
> 
> > (XEN) d0:v0: unhandled page fault (ec=0000)
> > (XEN) Pagetable walk from ffffea000005b2d0:
> > (XEN)  L4[0x1d4] = 0000000000000000 ffffffffffffffff
> > (XEN) domain_crash_sync called from entry.S
> > (XEN) Domain 0 (vcpu#0) crashed on cpu#0:
> > (XEN) ----[ Xen-4.1.5-pre  x86_64  debug=y  Tainted:    C ]----
> > (XEN) CPU:    0
> > (XEN) RIP:    e033:[<ffffffff8103feba>]
> > (XEN) RFLAGS: 0000000000000206   EM: 1   CONTEXT: pv guest
> > (XEN) rax: ffffea0000000000   rbx: 0000000001a0c000   rcx: 0000000080000000
> > (XEN) rdx: 000000000005b2a0   rsi: 0000000001a0c000   rdi: 0000000000000000
> > (XEN) rbp: ffffffff81a01dd8   rsp: ffffffff81a01d90   r8:  0000000000000000
> > (XEN) r9:  0000000010000001   r10: 0000000000000005   r11: 0000000000100000
> > (XEN) r12: 0000000000000000   r13: 0000020000000000   r14: 0000000000000000
> > (XEN) r15: 0000000000100000   cr0: 000000008005003b   cr4: 00000000000026f0
> > (XEN) cr3: 0000000221a0c000   cr2: ffffea000005b2d0
> > (XEN) ds: 0000   es: 0000   fs: 0000   gs: 0000   ss: e02b   cs: e033
> > (XEN) Guest stack trace from rsp=ffffffff81a01d90:
> > (XEN)    0000000080000000 0000000000100000 0000000000000000 ffffffff8103feba
> > (XEN)    000000010000e030 0000000000010006 ffffffff81a01dd8 000000000000e02b
> > (XEN)    0000000000000000 ffffffff81a01e08 ffffffff81042d27 000000023fe00000
> > (XEN)    00000001f20c4000 0000020000000000 00000001acac7000 ffffffff81a01e48
> > (XEN)    ffffffff81ad2d21 0000000000000000 0000000000000028 0000000040004000
> > (XEN)    0000000000000000 0000000000000000 0000000000000000 ffffffff81a01ed8
> > (XEN)    ffffffff81ac293f ffffffff81b46900 0000000000000000 0000000000000000
> > (XEN)    0000000000000000 ffffffff81a01f00 ffffffff8165fbd1 ffffffff00000010
> > (XEN)    ffffffff81a01ee8 ffffffff81a01ea8 0000000000000000 ffffffff81a01ec8
> > (XEN)    ffffffffffffffff ffffffff81b46900 0000000000000000 0000000000000000
> > (XEN)    0000000000000000 ffffffff81a01f28 ffffffff81abcd62 ffffffff96062000
> > (XEN)    ffffffff81cc6000 ffffffff81ccd000 ffffffff81b4f2e0 0000000000000000
> > (XEN)    0000000000000000 0000000000000000 0000000000000000 ffffffff81a01f38
> > (XEN)    ffffffff81abc5f7 ffffffff81a01ff8 ffffffff81abf0c7 0300000100000032
> > (XEN)    0000000000000005 0000000000000000 0000000000000000 0000000000000000
> > (XEN)    0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > (XEN)    0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > (XEN)    0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > (XEN)    0000000000000000 819822831fc9cbf5 000206a700100800 0000000000000001
> > (XEN)    0000000000000000 0000000000000000 0f00000060c0c748 ccccccccccccc305
> > (XEN) Domain 0 crashed: rebooting machine in 5 seconds.
> > (XEN) Resetting with ACPI MEMORY or I/O RESET_REG.
> 
> can we get kernel trace instead?

If you look at the initial one I had posted:

> >> Call Trace:
> >>   [<ffffffff8103feba>] xen_get_user_pgd+0x5a  <--
> >>   [<ffffffff8103feba>] xen_get_user_pgd+0x5a
> >>   [<ffffffff81042d27>] xen_write_cr3+0x77
> >>   [<ffffffff81ad2d21>] init_mem_mapping+0x1f9
> >>   [<ffffffff81ac293f>] setup_arch+0x742
> >>   [<ffffffff81666d71>] printk+0x48
> >>   [<ffffffff81abcd62>] start_kernel+0x90
> >>   [<ffffffff8109416b>] __add_preferred_console.clone.1+0x9b
> >>   [<ffffffff81abc5f7>] x86_64_start_reservations+0x2a
> >>   [<ffffffff81abf0c7>] xen_start_kernel+0x564

The EIP matches with what this stack strace has. So we are still in
init_mem_mapping.
