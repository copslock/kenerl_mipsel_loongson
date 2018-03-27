Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 01:59:48 +0200 (CEST)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:49334 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993928AbeC0X7lQl3A2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 01:59:41 +0200
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1f0yUO-0002bn-00; Tue, 27 Mar 2018 23:58:52 +0000
Date:   Tue, 27 Mar 2018 19:58:52 -0400
From:   Rich Felker <dalias@libc.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ilya Smith <blackzert@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com,
        linux@armlinux.org.uk, tony.luck@intel.com, fenghua.yu@intel.com,
        ralf@linux-mips.org, jejb@parisc-linux.org,
        Helge Deller <deller@gmx.de>, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, nyc@holomorphy.com,
        viro@zeniv.linux.org.uk, arnd@arndb.de, gregkh@linuxfoundation.org,
        deepa.kernel@gmail.com, Hugh Dickins <hughd@google.com>,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20180327235852.GL1436@brightrain.aerifal.cx>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
 <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
 <20180326084650.GC5652@dhcp22.suse.cz>
 <01A133F4-27DF-4AE2-80D6-B0368BF758CD@gmail.com>
 <20180327072432.GY5652@dhcp22.suse.cz>
 <0549F29C-12FC-4401-9E85-A430BC11DA78@gmail.com>
 <20180327221635.GA3790@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180327221635.GA3790@thunk.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dalias@aerifal.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dalias@libc.org
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

On Tue, Mar 27, 2018 at 06:16:35PM -0400, Theodore Y. Ts'o wrote:
> On Tue, Mar 27, 2018 at 04:51:08PM +0300, Ilya Smith wrote:
> > > /dev/[u]random is not sufficient?
> > 
> > Using /dev/[u]random makes 3 syscalls - open, read, close. This is a performance
> > issue.
> 
> You may want to take a look at the getrandom(2) system call, which is
> the recommended way getting secure random numbers from the kernel.

Yes, while opening /dev/urandom is not acceptable due to needing an
fd, getrandom and existing fallbacks for it have this covered if
needed.

> > > Well, I am pretty sure userspace can implement proper free ranges
> > > tracking…
> > 
> > I think we need to know what libc developers will say on implementing ASLR in 
> > user-mode. I am pretty sure they will say ‘nether’ or ‘some-day’. And problem 
> > of ASLR will stay forever.
> 
> Why can't you send patches to the libc developers?

I can tell you right now that any patch submitted for musl that
depended on trying to duplicate knowledge of the entire virtual
address space layout in userspace as part of mmap would be rejected,
and I would recommend glibc do the same.

Not only does it vastly increase complexity; it also has all sorts of
failure modes (fd exhastion, etc.) which would either introduce new
and unwanted ways for mmap to fail, or would force fallback to the
normal (no extra randomization) strategy under conditions an attacker
could potentially control, defeating the whole purpose. It would also
potentially make it easier for an attacker to examine the vm layout
for attacks, since it would be recorded in userspace.

There's also the issue of preserving AS-safety of mmap. POSIX does not
actually require mmap to be AS-safe, and on musl munmap is not fully
AS-safe anyway because of some obscure issues it compensates for, but
we may be able to make it AS-safe (this is a low-priority open issue).
If mmap were manipulating data structures representing the vm space in
userspace, though, the only way to make it anywhere near AS-safe would
be to block all signals and take a lock every time mmap or munmap is
called. This would significantly increase the cost of each call,
especially now that meltdown/spectre mitigations have greatly
increased the overhead of each syscall.

Overall, asking userspace to take a lead role in management of process
vm space is a radical change in the split of what user and kernel are
responsible for, and it really does not make sense as part of a
dubious hardening measure. Something this big would need to be really
well-motivated.

Rich
