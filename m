Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 May 2017 23:13:04 +0200 (CEST)
Received: from Galois.linutronix.de ([IPv6:2a01:7a0:2:106d:700::1]:43481 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993982AbdEVVM4HtLkr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 May 2017 23:12:56 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1dCuc1-00015I-TW; Mon, 22 May 2017 23:11:34 +0200
Date:   Mon, 22 May 2017 23:11:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Will Deacon <will.deacon@arm.com>
cc:     Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/1] futex: remove duplicated code
In-Reply-To: <20170515131644.GA3605@arm.com>
Message-ID: <alpine.DEB.2.20.1705222259580.2407@nanos>
References: <20170515130742.18357-1-jslaby@suse.cz> <20170515131644.GA3605@arm.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Mon, 15 May 2017, Will Deacon wrote:
> Hi Jiri,
> 
> On Mon, May 15, 2017 at 03:07:42PM +0200, Jiri Slaby wrote:
> > There is code duplicated over all architecture's headers for
> > futex_atomic_op_inuser. Namely op decoding, access_ok check for uaddr,
> > and comparison of the result.
> > 
> > Remove this duplication and leave up to the arches only the needed
> > assembly which is now in arch_futex_atomic_op_inuser.
> > 
> > Note that s390 removed access_ok check in d12a29703 ("s390/uaccess:
> > remove pointless access_ok() checks") as access_ok there returns true.
> > We introduce it back to the helper for the sake of simplicity (it gets
> > optimized away anyway).
> 
> Whilst I think this is a good idea, the code in question actually results
> in undefined behaviour per the C spec and is reported by UBSAN. See my
> patch fixing arm64 here (which I'd forgotten about):
> 
> https://www.spinics.net/lists/linux-arch/msg38564.html
> 
> But, as stated in the thread above, I think we should go a step further
> and remove FUTEX_OP_{OR,ANDN,XOR,OPARG_SHIFT} altogether. They don't
> appear to be used by userspace, and this whole thing is a total mess.

You wish. The constants are not used, but FUTEX_WAKE_OP _IS_ used by
glibc. They only have one argument it seems:

   #define FUTEX_OP_CLEAR_WAKE_IF_GT_ONE      ((4 << 24) | 1)

but I'm pretty sure that there is enough (probably horrible) code (think
java) out there using FUTEX_WAKE_OP for whatever (non)sensical reasons in
any available combination.

Thanks,

	tglx
