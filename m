Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jul 2017 12:20:07 +0200 (CEST)
Received: from Galois.linutronix.de ([IPv6:2a01:7a0:2:106d:700::1]:35853 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992028AbdGCKTzcAzfg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Jul 2017 12:19:55 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1dRyPv-0008IM-9w; Mon, 03 Jul 2017 12:17:19 +0200
Date:   Mon, 3 Jul 2017 12:18:28 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Will Deacon <will.deacon@arm.com>, mingo@redhat.com,
        peterz@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
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
Subject: Re: [PATCH 1/1] futex: remove duplicated code and fix UB
In-Reply-To: <80af8d81-4522-de2d-8289-1ab46565505a@suse.cz>
Message-ID: <alpine.DEB.2.20.1707031211120.2188@nanos>
References: <20170621115318.2781-1-jslaby@suse.cz> <alpine.DEB.2.20.1706230017520.2221@nanos> <80af8d81-4522-de2d-8289-1ab46565505a@suse.cz>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58983
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

On Mon, 26 Jun 2017, Jiri Slaby wrote:
> On 06/23/2017, 09:51 AM, Thomas Gleixner wrote:
> > On Wed, 21 Jun 2017, Jiri Slaby wrote:
> >> diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
> >> index f32b42e8725d..5bb2fd4674e7 100644
> >> --- a/arch/arm64/include/asm/futex.h
> >> +++ b/arch/arm64/include/asm/futex.h
> >> @@ -48,20 +48,10 @@ do {									\
> >>  } while (0)
> >>  
> >>  static inline int
> >> -futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
> > 
> > That unsigned int seems to be a change from the arm64 tree in next. It's
> > not upstream and it'll cause a (easy to resolve) conflict.
> 
> Ugh, I thought the arm64 is in upstream already. Note that this patch
> just takes what is in this arm64 fix and makes it effective for all
> architectures. So I will wait with v2 until it merges upstream.

Ok.

> > Yes, we probably can't change that anymore, but at least we should make it
> > very explicit and add a comment to that effect.
> 
> Something like this or do you want a comment yet?
>         unsigned int op =         (encoded_op & 0x70000000) >> 28;
>         unsigned int cmp =        (encoded_op & 0x0f000000) >> 24;
>         int oparg = sign_extend32((encoded_op & 0x00fff000) >> 12, 12);
>         int cmparg = sign_extend32(encoded_op & 0x00000fff, 12);

Yes, that makes sense.

There is also the issue with the shift. See this thread for further
reference:

  http://lkml.kernel.org/r/alpine.DEB.2.20.1706282353190.1890@nanos

The gist is:

  "Anything using a shift value < 0 or > 31 will get crap as a
   result. Rightfully so because it's just undefined.

   Yes I know that the insanity of user space is unlimited, but anything
   attempting this is so broken that we cannot break it further by making
   that shift arg unsigned and actually limit it to 0-31"

So we should make that case explicit as well.

        if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28)) {
		if (oparg < 0 || oparg > 31)
			return -EINVAL;
                oparg = 1 << oparg;
	}

Thanks,

	tglx
