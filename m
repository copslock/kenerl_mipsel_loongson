Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 20:36:33 +0100 (CET)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:49080 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990423AbeCWTg0Q1yb4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2018 20:36:26 +0100
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1ezSTb-0001Ha-00; Fri, 23 Mar 2018 19:35:47 +0000
Date:   Fri, 23 Mar 2018 15:35:47 -0400
From:   Rich Felker <dalias@libc.org>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20180323193547.GD1436@brightrain.aerifal.cx>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
 <20180323180024.GB1436@brightrain.aerifal.cx>
 <20180323190618.GA23763@bombadil.infradead.org>
 <20180323191621.GC1436@brightrain.aerifal.cx>
 <20180323192952.GB23763@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323192952.GB23763@bombadil.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dalias@aerifal.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63179
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

On Fri, Mar 23, 2018 at 12:29:52PM -0700, Matthew Wilcox wrote:
> On Fri, Mar 23, 2018 at 03:16:21PM -0400, Rich Felker wrote:
> > > Huh, I thought libc was aware of this.  Also, I'd expect a libc-based
> > > implementation to restrict itself to, eg, only loading libraries in
> > > the bottom 1GB to avoid applications who want to map huge things from
> > > running out of unfragmented address space.
> > 
> > That seems like a rather arbitrary expectation and I'm not sure why
> > you'd expect it to result in less fragmentation rather than more. For
> > example if it started from 1GB and worked down, you'd immediately
> > reduce the contiguous free space from ~3GB to ~2GB, and if it started
> > from the bottom and worked up, brk would immediately become
> > unavailable, increasing mmap pressure elsewhere.
> 
> By *not* limiting yourself to the bottom 1GB, you'll almost immediately
> fragment the address space even worse.  Just looking at 'ls' as a
> hopefully-good example of a typical app, it maps:
> 
> 	linux-vdso.so.1 (0x00007ffef5eef000)
> 	libselinux.so.1 => /lib/x86_64-linux-gnu/libselinux.so.1 (0x00007fb3657f5000)
> 	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fb36543b000)
> 	libpcre.so.3 => /lib/x86_64-linux-gnu/libpcre.so.3 (0x00007fb3651c9000)
> 	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007fb364fc5000)
> 	/lib64/ld-linux-x86-64.so.2 (0x00007fb365c3f000)
> 	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007fb364da7000)
> 
> The VDSO wouldn't move, but look at the distribution of mapping 6 things
> into a 3GB address space in random locations.  What are the odds you have
> a contiguous 1GB chunk of address space?  If you restrict yourself to the
> bottom 1GB before running out of room and falling back to a sequential
> allocation, you'll prevent a lot of fragmentation.

Oh, you're talking about "with random locations" case. Randomizing
each map just hopelessly fragments things no matter what you do on
32-bit. If you reduce the space over which you randomize to the point
where it's not fragmenting/killing your available vm space, there are
so few degrees of freedom left that it's trivial to brute-force. Maybe
"libs randomized in low 1GB, everything else near-sequential in high
addresses" works half decently, but I have a hard time believing you
can get any ASLR that's significantly better than snake oil in a
32-bit address space, and you certainly do pay a high price in total
available vm space.

Rich
