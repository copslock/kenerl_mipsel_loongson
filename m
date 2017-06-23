Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2017 09:53:07 +0200 (CEST)
Received: from Galois.linutronix.de ([IPv6:2a01:7a0:2:106d:700::1]:51948 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991786AbdFWHw7HTcax (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jun 2017 09:52:59 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1dOJMM-000864-Ll; Fri, 23 Jun 2017 09:50:30 +0200
Date:   Fri, 23 Jun 2017 09:51:23 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
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
In-Reply-To: <20170621115318.2781-1-jslaby@suse.cz>
Message-ID: <alpine.DEB.2.20.1706230017520.2221@nanos>
References: <20170621115318.2781-1-jslaby@suse.cz>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58762
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

On Wed, 21 Jun 2017, Jiri Slaby wrote:
> diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
> index f32b42e8725d..5bb2fd4674e7 100644
> --- a/arch/arm64/include/asm/futex.h
> +++ b/arch/arm64/include/asm/futex.h
> @@ -48,20 +48,10 @@ do {									\
>  } while (0)
>  
>  static inline int
> -futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)

That unsigned int seems to be a change from the arm64 tree in next. It's
not upstream and it'll cause a (easy to resolve) conflict.

> +static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
> +{
> +	int op = (encoded_op >> 28) & 7;
> +	int cmp = (encoded_op >> 24) & 15;
> +	int oparg = (int)(encoded_op << 8) >> 20;
> +	int cmparg = (int)(encoded_op << 20) >> 20;

So this is really bad. We have implicit and explicit type casting to
int. And while we are at it can we please stop proliferating the existing
mess.

'op' and 'cmp' definitly can be unsigned int. There is no reason to cast
them to int.

oparg, cmparg and oldval are more interesting.

The logic here is "documented" in uapi/linux/futex.h

/* FUTEX_WAKE_OP will perform atomically
   int oldval = *(int *)UADDR2;
   *(int *)UADDR2 = oldval OP OPARG;
   if (oldval CMP CMPARG)
       wake UADDR2;  */

Now the FUTEX_OP macro which is supposed to compose the encoded_up does:

#define FUTEX_OP(op, oparg, cmp, cmparg) \
  (((op & 0xf) << 28) | ((cmp & 0xf) << 24)             \
   | ((oparg & 0xfff) << 12) | (cmparg & 0xfff))

Of course this all is not typed, undocumented and completely ill
defined.

> +	int oparg = (int)(encoded_op << 8) >> 20;
> +	int cmparg = (int)(encoded_op << 20) >> 20;

So in fact we sign expand the 12 bits of oparg and cmparg. Really
intuitive.

Yes, we probably can't change that anymore, but at least we should make it
very explicit and add a comment to that effect.

Thanks,

	tglx
