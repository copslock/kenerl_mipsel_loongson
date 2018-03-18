Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Mar 2018 19:05:26 +0100 (CET)
Received: from zeniv.linux.org.uk ([195.92.253.2]:60258 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994680AbeCRSFTHKJPh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Mar 2018 19:05:19 +0100
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1excgE-0007Zt-RZ; Sun, 18 Mar 2018 18:05:14 +0000
Date:   Sun, 18 Mar 2018 18:05:14 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jiri Slaby <jslaby@suse.com>, x86@kernel.org
Subject: Re: [RFC PATCH 3/6] fs: provide generic compat_sys_p{read,write}64()
 implementations
Message-ID: <20180318180514.GT30522@ZenIV.linux.org.uk>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-4-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180318161056.5377-4-linux@dominikbrodowski.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <viro@ftp.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viro@ZenIV.linux.org.uk
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

On Sun, Mar 18, 2018 at 05:10:53PM +0100, Dominik Brodowski wrote:

> +#ifdef __ARCH_WANT_COMPAT_SYS_PREADWRITE64
> +#if defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +	defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE6(pread64, unsigned int, fd, char __user *, ubuf,
> +		       u32, count, u32, padding, u32, poslo, u32, poshi)
> +#elif defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +	!defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE6(pread64, unsigned int, fd, char __user *, ubuf,
> +		       u32, count, u32, padding, u32, poshi, u32, poslo)
> +#elif !defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +	defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE5(pread64, unsigned int, fd, char __user *, ubuf,
> +		       u32, count, u32, poslo, u32, poshi)
> +#else /* no padding, big endian */
> +COMPAT_SYSCALL_DEFINE5(pread64, unsigned int, fd, char __user *, ubuf,
> +		       u32, count, u32, poshi, u32, poslo)
> +#endif
> +{
> +#ifdef CONFIG_S390
> +	if ((compat_ssize_t) count < 0)
> +		return -EINVAL;
> +#endif /* CONFIG_S390 */
> +	return do_pread64(fd, ubuf, count,
> +			  ((loff_t) (unsigned long) (poshi) << 32) |
> +				(unsigned long) (poslo));
> +}

Egads...  You have 4 ifdefs before you even get to the body.  And good luck
trying to actually keep track of that mess.

They clearly go in 2 pairs, right?  One parameter is "do we have padding"
(== does ABI prohibit passing 64bit value in 4th and 5th words), another
is the order in which the halves of 64bit are passed.  On l-e you have
bits 0..31 in the first one and bits 32..63 in the second; on b-e it's the
other way round.

Only the logics for putting them together into a 64bit value cares which
half is which; insisting on the names of form <something>{hi,lo} gives
you arseloads of similar variants in ifdefs, all for the sake of not
having conditional code in the body.  Or, actually, in the inlined
helper for building that 64bit out of two halves...
