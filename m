Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 02:01:01 +0200 (CEST)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:49384 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993946AbeC1AAweSik2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 02:00:52 +0200
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1f0yVt-0002bx-00; Wed, 28 Mar 2018 00:00:25 +0000
Date:   Tue, 27 Mar 2018 20:00:25 -0400
From:   Rich Felker <dalias@libc.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Ilya Smith <blackzert@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Richard Henderson <rth@twiddle.net>, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        nyc@holomorphy.com, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve Capper <steve.capper@arm.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Rik van Riel <riel@redhat.com>, nitin.m.gupta@oracle.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-sh <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
Message-ID: <20180328000025.GM1436@brightrain.aerifal.cx>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
 <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
 <20180326084650.GC5652@dhcp22.suse.cz>
 <01A133F4-27DF-4AE2-80D6-B0368BF758CD@gmail.com>
 <20180327072432.GY5652@dhcp22.suse.cz>
 <0549F29C-12FC-4401-9E85-A430BC11DA78@gmail.com>
 <CAGXu5j+XXufprMaJ9GbHxD3mZ7iqUuu60-tTMC6wo2x1puYzMQ@mail.gmail.com>
 <20180327234904.GA27734@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327234904.GA27734@bombadil.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dalias@aerifal.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63271
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

On Tue, Mar 27, 2018 at 04:49:04PM -0700, Matthew Wilcox wrote:
> On Tue, Mar 27, 2018 at 03:53:53PM -0700, Kees Cook wrote:
> > I agree: pushing this off to libc leaves a lot of things unprotected.
> > I think this should live in the kernel. The question I have is about
> > making it maintainable/readable/etc.
> > 
> > The state-of-the-art for ASLR is moving to finer granularity (over
> > just base-address offset), so I'd really like to see this supported in
> > the kernel. We'll be getting there for other things in the future, and
> > I'd like to have a working production example for researchers to
> > study, etc.
> 
> One thing we need is to limit the fragmentation of this approach.
> Even on 64-bit systems, we can easily get into a situation where there isn't
> space to map a contiguous terabyte.

The default limit of only 65536 VMAs will also quickly come into play
if consecutive anon mmaps don't get merged. Of course this can be
raised, but it has significant resource and performance (fork) costs.

Rich
