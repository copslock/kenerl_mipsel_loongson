Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2018 09:24:52 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:50847 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992829AbeC0HYot8iTD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Mar 2018 09:24:44 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1629AAFE8;
        Tue, 27 Mar 2018 07:24:38 +0000 (UTC)
Date:   Tue, 27 Mar 2018 09:24:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Ilya Smith <blackzert@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com,
        linux@armlinux.org.uk, tony.luck@intel.com, fenghua.yu@intel.com,
        ralf@linux-mips.org, jejb@parisc-linux.org,
        Helge Deller <deller@gmx.de>, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        nyc@holomorphy.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        gregkh@linuxfoundation.org, deepa.kernel@gmail.com,
        Hugh Dickins <hughd@google.com>, kstewart@linuxfoundation.org,
        pombredanne@nexb.com, Andrew Morton <akpm@linux-foundation.org>,
        steve.capper@arm.com, punit.agrawal@arm.com,
        aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
        Kees Cook <keescook@chromium.org>, bhsharma@redhat.com,
        riel@redhat.com, nitin.m.gupta@oracle.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, ross.zwisler@linux.intel.com,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
Message-ID: <20180327072432.GY5652@dhcp22.suse.cz>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
 <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
 <20180326084650.GC5652@dhcp22.suse.cz>
 <01A133F4-27DF-4AE2-80D6-B0368BF758CD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01A133F4-27DF-4AE2-80D6-B0368BF758CD@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <mhocko@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mhocko@kernel.org
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

On Mon 26-03-18 22:45:31, Ilya Smith wrote:
> 
> > On 26 Mar 2018, at 11:46, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > On Fri 23-03-18 20:55:49, Ilya Smith wrote:
> >> 
> >>> On 23 Mar 2018, at 15:48, Matthew Wilcox <willy@infradead.org> wrote:
> >>> 
> >>> On Thu, Mar 22, 2018 at 07:36:36PM +0300, Ilya Smith wrote:
> >>>> Current implementation doesn't randomize address returned by mmap.
> >>>> All the entropy ends with choosing mmap_base_addr at the process
> >>>> creation. After that mmap build very predictable layout of address
> >>>> space. It allows to bypass ASLR in many cases. This patch make
> >>>> randomization of address on any mmap call.
> >>> 
> >>> Why should this be done in the kernel rather than libc?  libc is perfectly
> >>> capable of specifying random numbers in the first argument of mmap.
> >> Well, there is following reasons:
> >> 1. It should be done in any libc implementation, what is not possible IMO;
> > 
> > Is this really so helpful?
> 
> Yes, ASLR is one of very important mitigation techniques which are really used 
> to protect applications. If there is no ASLR, it is very easy to exploit 
> vulnerable application and compromise the system. We can’t just fix all the 
> vulnerabilities right now, thats why we have mitigations - techniques which are 
> makes exploitation more hard or impossible in some cases.
> 
> Thats why it is helpful.

I am not questioning ASLR in general. I am asking whether we really need
per mmap ASLR in general. I can imagine that some environments want to
pay the additional price and other side effects, but considering this
can be achieved by libc, why to add more code to the kernel?

> > 
> >> 2. User mode is not that layer which should be responsible for choosing
> >> random address or handling entropy;
> > 
> > Why?
> 
> Because of the following reasons:
> 1. To get random address you should have entropy. These entropy shouldn’t be 
> exposed to attacker anyhow, the best case is to get it from kernel. So this is
> a syscall.

/dev/[u]random is not sufficient?

> 2. You should have memory map of your process to prevent remapping or big
> fragmentation. Kernel already has this map.

/proc/self/maps?

> You will got another one in libc.
> And any non-libc user of mmap (via syscall, etc) will make hole in your map.
> This one also decrease performance cause you any way call syscall_mmap 
> which will try to find some address for you in worst case, but after you already
> did some computing on it.

I do not understand. a) you should be prepared to pay an additional
price for an additional security measures and b) how would anybody punch
a hole into your mapping? 

> 3. The more memory you use in userland for these proposal, the easier for
> attacker to leak it or use in exploitation techniques.

This is true in general, isn't it? I fail to see how kernel chosen and
user chosen ranges would make any difference.

> 4. It is so easy to fix Kernel function and so hard to support memory
> management from userspace.

Well, on the other hand the new layout mode will add a maintenance
burden on the kernel and will have to be maintained for ever because it
is a user visible ABI.

> >> 3. Memory fragmentation is unpredictable in this case
> >> 
> >> Off course user mode could use random ‘hint’ address, but kernel may
> >> discard this address if it is occupied for example and allocate just before
> >> closest vma. So this solution doesn’t give that much security like 
> >> randomization address inside kernel.
> > 
> > The userspace can use the new MAP_FIXED_NOREPLACE to probe for the
> > address range atomically and chose a different range on failure.
> > 
> 
> This algorithm should track current memory. If he doesn’t he may cause
> infinite loop while trying to choose memory. And each iteration increase time
> needed on allocation new memory, what is not preferred by any libc library
> developer.

Well, I am pretty sure userspace can implement proper free ranges
tracking...

-- 
Michal Hocko
SUSE Labs
