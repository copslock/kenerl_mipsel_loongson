Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Mar 2017 14:08:19 +0100 (CET)
Received: from pandora.armlinux.org.uk ([IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6]:57926
        "EHLO pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990522AbdCDNIL201tM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Mar 2017 14:08:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=armlinux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=oveH2gO74WZptAa3+CnoPbxuVdRNwrMLxnvaThBLFMs=;
        b=dSBysVZsY5C27ceUL3AwTFpFWBJU5Ihk9Wgy4Bzk2S/vODp7z+VteJoOR/3xtC0h9Sthud0VFZiL0GnyG27hDZDgsMnY7YiyzztBB7UhnytIWiwH39rYjcMdEV5sRZVhQ2tFtFEbA13r5qxFn4VmluVU3t54t1h6KTepeJnnvNI=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:36416)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ck9Ni-0000bk-Or; Sat, 04 Mar 2017 13:05:55 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1ck9Ne-00029C-MP; Sat, 04 Mar 2017 13:05:50 +0000
Date:   Sat, 4 Mar 2017 13:05:50 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [PATCH 1/3] futex: remove duplicated code
Message-ID: <20170304130550.GT21222@n2100.armlinux.org.uk>
References: <20170303122712.13353-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170303122712.13353-1-jslaby@suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@armlinux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@armlinux.org.uk
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

On Fri, Mar 03, 2017 at 01:27:10PM +0100, Jiri Slaby wrote:
> diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
> index 6795368ad023..cc414382dab4 100644
> --- a/arch/arm/include/asm/futex.h
> +++ b/arch/arm/include/asm/futex.h
> @@ -128,20 +128,10 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>  #endif /* !SMP */
>  
>  static inline int
> -futex_atomic_op_inuser (int encoded_op, u32 __user *uaddr)
> +arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
>  {
> -	int op = (encoded_op >> 28) & 7;
> -	int cmp = (encoded_op >> 24) & 15;
> -	int oparg = (encoded_op << 8) >> 20;
> -	int cmparg = (encoded_op << 20) >> 20;
>  	int oldval = 0, ret, tmp;
>  
> -	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
> -		oparg = 1 << oparg;
> -
> -	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
> -		return -EFAULT;
> -
>  #ifndef CONFIG_SMP
>  	preempt_disable();
>  #endif
> @@ -172,17 +162,9 @@ futex_atomic_op_inuser (int encoded_op, u32 __user *uaddr)
>  	preempt_enable();
>  #endif
>  
> -	if (!ret) {
> -		switch (cmp) {
> -		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
> -		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
> -		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
> -		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
> -		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
> -		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
> -		default: ret = -ENOSYS;
> -		}
> -	}
> +	if (!ret)
> +		*oval = oldval;
> +
>  	return ret;
>  }
>  
> diff --git a/kernel/futex.c b/kernel/futex.c
> index b687cb22301c..c5ff9850952f 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -1457,6 +1457,42 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
>  	return ret;
>  }
>  
> +static int futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
> +{
> +	int op = (encoded_op >> 28) & 7;
> +	int cmp = (encoded_op >> 24) & 15;
> +	int oparg = (encoded_op << 8) >> 20;
> +	int cmparg = (encoded_op << 20) >> 20;

Hmm.  oparg and cmparg look like they're doing these shifts to get sign
extension of the 12-bit values by assuming that "int" is 32-bit -
probably worth a comment, or for safety, they should be "s32" so it's
not dependent on the bit-width of "int".

> +	int oldval, ret;
> +
> +	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
> +		oparg = 1 << oparg;

I guess it doesn't matter that oparg can be >= the bit size of oparg
(so large values produce an undefined result) as it's no different
from userspace trying to do the same with large shifts.

> +
> +	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
> +		return -EFAULT;
> +
> +	ret = arch_futex_atomic_op_inuser(op, oparg, &oldval, uaddr);
> +	if (ret)
> +		return ret;
> +
> +	switch (cmp) {
> +	case FUTEX_OP_CMP_EQ:
> +		return oldval == cmparg;
> +	case FUTEX_OP_CMP_NE:
> +		return oldval != cmparg;
> +	case FUTEX_OP_CMP_LT:
> +		return oldval < cmparg;
> +	case FUTEX_OP_CMP_GE:
> +		return oldval >= cmparg;
> +	case FUTEX_OP_CMP_LE:
> +		return oldval <= cmparg;
> +	case FUTEX_OP_CMP_GT:
> +		return oldval > cmparg;
> +	default:
> +		return -ENOSYS;
> +	}
> +}
> +
>  /*
>   * Wake up all waiters hashed on the physical page that is mapped
>   * to this virtual address:

As it's no worse than our existing code, for the above,

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
