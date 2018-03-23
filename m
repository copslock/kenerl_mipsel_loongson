Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 20:06:49 +0100 (CET)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:56942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990498AbeCWTGlZKlm2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2018 20:06:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AFxcHieAc63yNfeQtW686kN7BToGXJsCLV/8x6Z1168=; b=RhzzrjMIjZqJjapYC5y62lfX+
        kSMZVeG0wGcptMTL82smxMmkhJMH/FDeckgOFL1tSXiB/1LQIlxP8o2EFQ2Osy5Y5U7rlg3uo45Md
        DLhc1QFE4+GMid8DeMHErgFHWqCYdvOq3CEvPbC0dGCxQpBNZZuiue7cNNiK4B/l11lkfV6G/EjhB
        UZvf5QZ2ZmbXMd4FLFG8p+mYawep254u0dSDO5EInBzy/lLSwwyPtTdh5Rz++B5Wovs6POgKXagM2
        +ctVAfob4MI3bfOBkqsHw2oZqr/mKjnU5ksje0SGXQBcjiItmjzkajU2wfxiavzAIL1qVEXbY2Rd6
        Fm4v3BZew==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ezS14-0006Kg-Rr; Fri, 23 Mar 2018 19:06:18 +0000
Date:   Fri, 23 Mar 2018 12:06:18 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Rich Felker <dalias@libc.org>
Cc:     Ilya Smith <blackzert@gmail.com>, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com,
        linux@armlinux.org.uk, tony.luck@intel.com, fenghua.yu@intel.com,
        jhogan@kernel.org, ralf@linux-mips.org, jejb@parisc-linux.org,
        deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, nyc@holomorphy.com,
        viro@zeniv.linux.org.uk, arnd@arndb.de, gregkh@linuxfoundation.org,
        deepa.kernel@gmail.com, mhocko@suse.com, hughd@google.com,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        akpm@linux-foundation.org, steve.capper@arm.com,
        punit.agrawal@arm.com, paul.burton@mips.com,
        aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
        keescook@chromium.org, bhsharma@redhat.com, riel@redhat.com,
        nitin.m.gupta@oracle.com, kirill.shutemov@linux.intel.com,
        dan.j.williams@intel.com, jack@suse.cz,
        ross.zwisler@linux.intel.com, jglisse@redhat.com,
        aarcange@redhat.com, oleg@redhat.com, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
Message-ID: <20180323190618.GA23763@bombadil.infradead.org>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
 <20180323180024.GB1436@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323180024.GB1436@brightrain.aerifal.cx>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <willy@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: willy@infradead.org
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

On Fri, Mar 23, 2018 at 02:00:24PM -0400, Rich Felker wrote:
> On Fri, Mar 23, 2018 at 05:48:06AM -0700, Matthew Wilcox wrote:
> > On Thu, Mar 22, 2018 at 07:36:36PM +0300, Ilya Smith wrote:
> > > Current implementation doesn't randomize address returned by mmap.
> > > All the entropy ends with choosing mmap_base_addr at the process
> > > creation. After that mmap build very predictable layout of address
> > > space. It allows to bypass ASLR in many cases. This patch make
> > > randomization of address on any mmap call.
> > 
> > Why should this be done in the kernel rather than libc?  libc is perfectly
> > capable of specifying random numbers in the first argument of mmap.
> 
> Generally libc does not have a view of the current vm maps, and thus
> in passing "random numbers", they would have to be uniform across the
> whole vm space and thus non-uniform once the kernel rounds up to avoid
> existing mappings.

I'm aware that you're the musl author, but glibc somehow manages to
provide etext, edata and end, demonstrating that it does know where at
least some of the memory map lies.  Virtually everything after that is
brought into the address space via mmap, which at least glibc intercepts,
so it's entirely possible for a security-conscious libc to know where
other things are in the memory map.  Not to mention that what we're
primarily talking about here are libraries which are dynamically linked
and are loaded by ld.so before calling main(); not dlopen() or even
regular user mmaps.

> Also this would impose requirements that libc be
> aware of the kernel's use of the virtual address space and what's
> available to userspace -- for example, on 32-bit archs whether 2GB,
> 3GB, or full 4GB (for 32-bit-user-on-64-bit-kernel) is available, and
> on 64-bit archs where fewer than the full 64 bits are actually valid
> in addresses, what the actual usable pointer size is. There is
> currently no clean way of conveying this information to userspace.

Huh, I thought libc was aware of this.  Also, I'd expect a libc-based
implementation to restrict itself to, eg, only loading libraries in
the bottom 1GB to avoid applications who want to map huge things from
running out of unfragmented address space.
